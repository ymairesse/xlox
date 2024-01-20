<?php

class User
{
    private $mail;
    private $identite;            // données personnelles
    private $applicationName;
    private $identifiant;

    // --------------------------------------------
    // fonction constructeur
    public function __construct($identifiant, $md5passwd)
    {
        if (isset($identifiant)) {
            $this->identifiant = $identifiant;
            $this->applicationName = APPLICATION;
            $this->identite = $this->getIdentite($identifiant, $md5passwd);
        }
    }


    /**
     * retourne toutes les informations de la table des utilisateurs pour l'utilisateur admin actif.
     *
     * @param string $mail
     * @param string $md5passwd
     *
     * @return array
     */
    public function getIdentite($identifiant, $md5passwd)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT * ';
        $sql .= 'FROM ' . PFX . 'users ';
        $sql .= 'WHERE (mail = :identifiant OR pseudo = :identifiant) AND md5passwd = :md5passwd ';

        $requete = $connexion->prepare($sql);

        $requete->bindParam(':identifiant', $identifiant, PDO::PARAM_STR, 100);
        $requete->bindParam(':md5passwd', $md5passwd, PDO::PARAM_STR, 40);

        $resultat = $requete->execute();
        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            $this->identite = $requete->fetch();
        }
        Application::DeconnexionPDO($connexion);

        return $this->identite;
    }

    /**
     * retourne nom, prénom et mail de l'utilisateur actif
     *
     * @param
     *
     * @return array
     */
    public function getUser()
    {
        return ($this->identite);
    }

    public function getCivNomPrenom(){
        $user = $this->identite;
        $civilite = $user['civilite'];
        $nom = $user['nom'];
        $prenom = $user['prenom'];
        switch ($civilite) {
            case 'M': $civ = 'Monsieur';
            break;
            case 'F': $civ = 'Madame';
            break;
            default : $civ = 'M./Mme';
        }
        return printf('%s %s %s', $civ, $nom, $prenom);
    }

    /**
     * Enregistrer le mot de passe $passwd pour l'utilisateur d'adresse mail $mail
     *
     * @param string $passwd
     * @param string $mail
     *
     * @return int
     */
    public function savePasswd($passwd, $mail)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'UPDATE ' . PFX . 'users ';
        $sql .= 'SET md5passwd = :md5passwd ';
        $sql .= 'WHERE mail = :mail ';
        $requete = $connexion->prepare($sql);

        $md5passwd = md5($passwd);

        $requete->bindParam(':mail', $mail, PDO::PARAM_STR, 60);
        $requete->bindParam(':md5passwd', $md5passwd, PDO::PARAM_STR, 32);

        $resultat = $requete->execute();

        $nb = $requete->rowCount();

        Application::DeconnexionPDO($connexion);

        return $nb;
    }
    /**
     * renvoie la liste de tous les utilisateurs qui ont les droits $droits
     *
     * @param array $droits (type array('root', 'oxfam')) ou array('client')
     *
     * @return array
     */
    public function getListeUsers($droits, $sort = 'alphaAsc')
    {
        $lesDroits = '"' . implode('","', $droits) . '"';
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT idUser, nom, prenom, dateAcces, droits ';
        $sql .= 'FROM ' . PFX . 'users ';
        $sql .= 'WHERE droits IN (' . $lesDroits . ') ';

        switch ($sort) {
            case 'alphaAsc':
                $sql .= 'ORDER BY TRIM(nom) ASC, prenom, mail ';
                break;
            case 'alphaDesc':
                $sql .= 'ORDER BY TRIM(nom) DESC, prenom, mail ';
                break;
            case 'parDate':
                $sql .= 'ORDER BY dateAcces DESC, TRIM(nom), prenom, mail ';
                break;
        }

        $requete = $connexion->prepare($sql);

        $resultat = $requete->execute();
        $liste = array();
        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            while ($ligne = $requete->fetch()) {
                $idUser = $ligne['idUser'];
                $dateHeure = explode(' ', $ligne['dateAcces']);
                $ligne['date'] = Application::datePHP($dateHeure[0]);
                $ligne['heure'] = substr($dateHeure[1], 0, 5);
                $liste[$idUser] = $ligne;
            }
        }

        Application::DeconnexionPDO($connexion);

        return $liste;
    }

    /**
     * renvoie la liste de tous les clients qui ont un travail en cours
     * $travailTermine = false
     * l'ordre est donné par le paramètre $sort
     *
     * @param boolean $travailTermine ($false)
     * @param string $sort
     *
     * @return array
     */
    public function getListeClientsTravail($travailTermine = 1, $sort = 'alphaAsc')
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT DISTINCT users.idUser, numeroBon, nom, prenom, mail, dateAcces ';
        $sql .= 'FROM ' . PFX . 'users AS users ';
        $sql .= 'LEFT JOIN ' . PFX . 'bonsReparation AS reparation ON reparation.idUser = users.idUser ';
        $sql .= 'WHERE droits = "client" AND reparation.termine = :travailTermine ';
        switch ($sort) {
            case 'alphaAsc':
                $sql .= 'ORDER BY nom ASC, prenom, mail ';
                break;
            case 'alphaDesc':
                $sql .= 'ORDER BY nom DESC, prenom, mail ';
                break;
            case 'parDate':
                $sql .= 'ORDER BY dateAcces DESC, nom, prenom, mail ';
                break;
        }
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':travailTermine', $travailTermine, PDO::PARAM_INT);

        $resultat = $requete->execute();
        $liste = array();
        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            while ($ligne = $requete->fetch()) {
                $idUser = $ligne['idUser'];
                $dateHeure = explode(' ', $ligne['dateAcces']);
                $ligne['date'] = Application::datePHP($dateHeure[0]);
                $ligne['heure'] = substr($dateHeure[1], 0, 5);
                $numeroBon = $ligne['numeroBon'];
                if (!isset($liste[$idUser])) {
                    $liste[$idUser] = $ligne;
                }
                $liste[$idUser]['numerosBons'][] = $numeroBon;
            }
        }

        Application::DeconnexionPDO($connexion);

        return $liste;

    }

    /**
     * renvoie la fiche perso de l'utilisateur dont on donne le $idUser
     *
     * @param string $mail
     *
     * @return array
     */
    public function getDataUser($idUser, $droits = null)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT * ';
        $sql .= 'FROM ' . PFX . 'users ';
        $sql .= 'WHERE idUser = :idUser ';
        if ($droits != null) {
            $sql .= 'AND droits = :droits ';
        }
        $requete = $connexion->prepare($sql);

        $data = null;
        $requete->bindParam(':idUser', $idUser, PDO::PARAM_INT);
        if ($droits != null) {
            $requete->bindParam(':droits', $droits, PDO::PARAM_STR, 6);
        }

        $resultat = $requete->execute();
        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            $data = $requete->fetch();
            if ($data != null) {
                $dateAcces = explode(' ', $data['dateAcces']);
                $date  = Application::datePHP($dateAcces[0]);
                $heure = substr($dateAcces[1], 0, 5);
                $data['dateAcces'] = sprintf('%s %s', $date, $heure);
            }
        }

        Application::DeconnexionPDO($connexion);

        return $data;
    }

    /**
     * Enregistre le profil utilisateur présenté dans $form
     *
     * @param array $form
     *
     * @return int
     */
    public function saveUser($form)
    {
        $idUser = isset($form['idUser']) ? $form['idUser'] : null;
        $civilite = isset($form['civilite']) ? $form['civilite'] : null;
        $nom = isset($form['nom']) ? trim($form['nom']) : null;
        $prenom = isset($form['prenom']) ? trim($form['prenom']) : null;

        $telephone = isset($form['telephone']) ? $form['telephone'] : null;
        $gsm = isset($form['gsm']) ? $form['gsm'] : null;
        $mail = isset($form['mail']) ? $form['mail'] : null;
        $pseudo = isset($form['pseudo']) ? trim($form['pseudo']) : null;

        $adresse = isset($form['adresse']) ? $form['adresse'] : null;
        $commune = isset($form['commune']) ? $form['commune'] : null;
        $cpost = isset($form['cpost']) ? $form['cpost'] : null;
        $tva = isset($form['tva']) ? $form['tva'] : null;
        $pwd = (isset($form['pwd']) && $form['pwd'] != '') ? md5($form['pwd']) : null;
        $droits = isset($form['droits']) ? $form['droits'] : 'client';
        $rgpd = isset($form['rgpd']) ? 1 : 0;

        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'INSERT INTO ' . PFX . 'users ';
        $sql .= 'SET civilite = :civilite, idUser = :idUser, nom = :nom, prenom = :prenom, ';
        $sql .= 'telephone = :telephone, gsm = :gsm, mail = :mail, pseudo = :pseudo, ';
        $sql .= 'adresse = :adresse, commune = :commune, cpost = :cpost, tva = :tva, ';
        $sql .= 'droits = :droits, rgpd = :rgpd, dateAcces = :dateAcces ';
        if ($pwd != null) {
            $sql .= ', md5passwd = :pwd ';
        }
        $sql .= 'ON DUPLICATE KEY UPDATE ';
        $sql .= 'civilite = :civilite, nom = :nom, prenom = :prenom, ';
        $sql .= 'telephone = :telephone, gsm = :gsm, mail = :mail, pseudo = :pseudo, ';
        $sql .= 'adresse = :adresse, commune = :commune, cpost = :cpost, tva = :tva, ';
        $sql .= 'droits = :droits, rgpd = :rgpd, dateAcces = :dateAcces ';
        if ($pwd != null) {
            $sql .= ', md5passwd = :pwd ';
        }
        $requete = $connexion->prepare($sql);


        $requete->bindParam(':idUser', $idUser, PDO::PARAM_INT);
        $requete->bindParam(':civilite', $civilite, PDO::PARAM_STR, 1);
        $requete->bindParam(':nom', $nom, PDO::PARAM_STR, 60);
        $requete->bindParam(':prenom', $prenom, PDO::PARAM_STR, 60);
        $requete->bindParam(':telephone', $telephone, PDO::PARAM_STR, 15);
        $requete->bindParam(':gsm', $gsm, PDO::PARAM_STR, 15);
        $requete->bindParam(':mail', $mail, PDO::PARAM_STR, 100);
        $requete->bindParam(':pseudo', $pseudo, PDO::PARAM_STR, 6);
        $requete->bindParam(':adresse', $adresse, PDO::PARAM_STR, 100);
        $requete->bindParam(':commune', $commune, PDO::PARAM_STR, 50);
        $requete->bindParam(':cpost', $cpost, PDO::PARAM_STR, 6);
        $requete->bindParam(':tva', $tva, PDO::PARAM_STR, 12);
        $requete->bindParam(':droits', $droits, PDO::PARAM_STR, 6);
        $requete->bindParam(':rgpd', $rgpd, PDO::PARAM_INT);

        $Now = new DateTime('now', new DateTimeZone('Europe/Brussels'));
        $dateAcces = $Now->format('Y-m-d H:i:s');
        $requete->bindParam(':dateAcces', $dateAcces, PDO::PARAM_STR, 17);
        if ($pwd != null) {
            $requete->bindParam(':pwd', $pwd, PDO::PARAM_STR, 32);
        }

        $resultat = $requete->execute();

        $nb = $requete->rowCount();

        // pour le cas d'un nouveau utilisateur
        $idUser = ($idUser == null) ? $connexion->lastInsertId() : $idUser;

        Application::DeconnexionPDO($connexion);

        return json_encode(array('nb' => $nb, 'idUser' => $idUser));
    }

    public static function autoSaveClient($form)
    {
        $captcha = isset($form['captcha']) ? $form['captcha'] : null;

        // vérification du captcha
        if (($captcha == null) || ($captcha != $_SESSION['oxxl']['captcha'])) {
            return json_encode(array('nb' => 0, 'idUser' => null));
        } else {
            $idUser = isset($form['idUser']) ? $form['idUser'] : null;
            $civilite = $form['civilite'] != '' ? $form['civilite'] : null;
            $nom = isset($form['nom']) ? $form['nom'] : null;
            $prenom = isset($form['prenom']) ? $form['prenom'] : null;

            $telephone = isset($form['telephone']) ? $form['telephone'] : null;
            $gsm = isset($form['gsm']) ? $form['gsm'] : null;
            $mail = isset($form['mail']) ? $form['mail'] : null;
            $pseudo = isset($form['pseudo']) ? $form['pseudo'] : null;

            $adresse = isset($form['adresse']) ? $form['adresse'] : null;
            $commune = isset($form['commune']) ? $form['commune'] : null;
            $cpost = isset($form['cpost']) ? $form['cpost'] : null;
            $tva = isset($form['tva']) ? $form['tva'] : null;
            $pwd = (isset($form['pwd']) && $form['pwd'] != '') ? md5($form['pwd']) : null;
            $droits = isset($form['droits']) ? $form['droits'] : 'client';
            $rgpd = isset($form['rgpd']) ? 1 : 0;

            $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
            $sql = 'INSERT INTO ' . PFX . 'users ';
            $sql .= 'SET civilite = :civilite, idUser = :idUser, nom = :nom, prenom = :prenom, ';
            $sql .= 'telephone = :telephone, gsm = :gsm, mail = :mail, pseudo = :pseudo, ';
            $sql .= 'adresse = :adresse, commune = :commune, cpost = :cpost, tva = :tva, ';
            $sql .= 'droits = :droits, rgpd = :rgpd ';
            if ($pwd != null) {
                $sql .= ', md5passwd = :pwd ';
            }
            $sql .= 'ON DUPLICATE KEY UPDATE ';
            $sql .= 'civilite = :civilite, nom = :nom, prenom = :prenom, ';
            $sql .= 'telephone = :telephone, gsm = :gsm, mail = :mail, pseudo = :pseudo, ';
            $sql .= 'adresse = :adresse, commune = :commune, cpost = :cpost, tva = :tva, ';
            $sql .= 'droits = :droits, rgpd = :rgpd ';
            if ($pwd != null) {
                $sql .= ', md5passwd = :pwd ';
            }
            $requete = $connexion->prepare($sql);

            $requete->bindParam(':idUser', $idUser, PDO::PARAM_INT);
            $requete->bindParam(':civilite', $civilite, PDO::PARAM_STR, 1);
            $requete->bindParam(':nom', $nom, PDO::PARAM_STR, 60);
            $requete->bindParam(':prenom', $prenom, PDO::PARAM_STR, 60);
            $requete->bindParam(':telephone', $telephone, PDO::PARAM_STR, 15);
            $requete->bindParam(':gsm', $gsm, PDO::PARAM_STR, 15);
            $requete->bindParam(':mail', $mail, PDO::PARAM_STR, 100);
            $requete->bindParam(':pseudo', $pseudo, PDO::PARAM_STR, 6);
            $requete->bindParam(':adresse', $adresse, PDO::PARAM_STR, 100);
            $requete->bindParam(':commune', $commune, PDO::PARAM_STR, 50);
            $requete->bindParam(':cpost', $cpost, PDO::PARAM_STR, 6);
            $requete->bindParam(':tva', $tva, PDO::PARAM_STR, 12);
            $requete->bindParam(':droits', $droits, PDO::PARAM_STR, 6);
            $requete->bindParam(':rgpd', $rgpd, PDO::PARAM_INT);

            if ($pwd != null) {
                $requete->bindParam(':pwd', $pwd, PDO::PARAM_STR, 32);
            }

            $resultat = $requete->execute();

            $nb = $requete->rowCount();
            $idUser = ($idUser == null) ? $connexion->lastInsertId() : $idUser;

            Application::DeconnexionPDO($connexion);

            return json_encode(array('nb' => $nb, 'idUser' => $idUser));

        }
    }


    /**
     * renvoie la liste de tous les accessoires possibles dans la BD
     *
     * @param
     *
     * @return array
     */
    public function getAllAccessoires()
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT idAccessoire, accessoire ';
        $sql .= 'FROM ' . PFX . 'accessoires ';
        $sql .= 'ORDER BY accessoire ';
        $requete = $connexion->prepare($sql);

        $liste = array();
        $resultat = $requete->execute();
        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            while ($ligne = $requete->fetch()) {
                $id = $ligne['idAccessoire'];
                $liste[$id] = $ligne['accessoire'];
            }
        }

        Application::DeconnexionPDO($connexion);

        return $liste;
    }

    /**
     * renvoie la liste de tous les types de matériel disponibles
     *
     * @param
     *
     * @return array
     */
    public function getAllMateriel()
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT idTypeMateriel, type ';
        $sql .= 'FROM ' . PFX . 'typeMateriel ';
        $sql .= 'ORDER BY UPPER(type) ';
        $requete = $connexion->prepare($sql);

        $liste = array();
        $resultat = $requete->execute();
        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            while ($ligne = $requete->fetch()) {
                $idTypeMateriel = $ligne['idTypeMateriel'];
                $liste[$idTypeMateriel] = $ligne['type'];
            }
        }

        Application::DeconnexionPDO($connexion);

        return $liste;
    }

    /**
     * suppression de l'utilisateur $idUser de la base de données
     *
     * @param int $idUser
     *
     * @return int
     */
    public function delUser($idUser)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'DELETE FROM ' . PFX . 'users ';
        $sql .= 'WHERE idUser = :idUser ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':idUser', $idUser, PDO::PARAM_INT);

        $resultat = $requete->execute();

        $n = 0;
        if ($resultat) {
            $n = $requete->rowCount();
        }

        Application::DeconnexionPDO($connexion);

        return $n;
    }

}
