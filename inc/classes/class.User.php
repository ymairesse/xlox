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
        $sql .= 'FROM '.PFX.'users ';
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
        $sql = 'UPDATE '.PFX.'users ';
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
     * @param string $droits
     *
     * @return array
     */
    public function getListeUsers($droits, $sort = 'alphaAsc')
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT idUser, nom, prenom, dateAcces, droits ';
        $sql .= 'FROM '.PFX.'users ';
        // ? à la place des différentes options
        $lesDroits = join(',', array_fill(0, count($droits), '?'));
        $sql .= 'WHERE droits IN ('.$lesDroits.') ';

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

        $resultat = $requete->execute($droits);
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
     * renvoie la fiche perso de l'utilisateur dont on donne l'adresse $mail
     *
     * @param string $mail
     *
     * @return array
     */
    public function getDataUser($idUser, $droits = null)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT * ';
        $sql .= 'FROM '.PFX.'users ';
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
            $dateAcces = explode(' ', $data['dateAcces']);
            $date  = Application::datePHP($dateAcces[0]);
            $heure = substr($dateAcces[1], 0, 5);
            $data['dateAcces'] = sprintf('%s %s', $date, $heure);
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
        $civilite = isset($form['civilite'] ) ? $form['civilite'] : null;
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
        $sql = 'INSERT INTO '.PFX.'users ';
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
            $sql = 'INSERT INTO '.PFX.'users ';
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
     * renvoie le contenu du bon de réparation $numeroBon du client $idUser
     *
     * @param int $numeroBon
     * @param int $idUser
     *
     * @return array
     */

    public function getDataBon($idUser, $numeroBon)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT * ';
        $sql .= 'FROM '.PFX.'bonsReparation ';
        $sql .= 'WHERE idUser = :idUser AND numeroBon = :numeroBon ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':idUser', $idUser, PDO::PARAM_INT);
        $requete->bindParam(':numeroBon', $numeroBon, PDO::PARAM_INT);

        $resultat = $requete->execute();

        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            $dataBon = $requete->fetch();
        }

        Application::DeconnexionPDO($connexion);

        return $dataBon;
    }

    /**
     * Enregistrement des données d'un bon depuis le formulaire $form
     *
     * @param array $form
     *
     * @return int
     */
    public function saveDataBon($form)
    {
        $idUser = isset($form['idClient']) ? $form['idClient'] : null;
        $numeroBon = isset($form['numeroBon']) ? $form['numeroBon'] : null;

        $typeMateriel = isset($form['typeMateriel']) ? $form['typeMateriel'] : null;
        $marque = isset($form['marque']) ? $form['marque'] : null;
        $modele = isset($form['modele']) ? $form['modele'] : null;

        $dateEntree = ($form['dateEntree'] != '') ? $form['dateEntree'] : null;
        $benevole = isset($form['benevole']) ? $form['benevole'] : null;
        $ox = isset($form['ox']) ? $form['ox'] : null;
        $mdp = isset($form['mdp']) ? $form['mdp'] : null;
        $data = isset($form['data']) ? $form['data'] : null;

        $probleme = isset($form['probleme']) ? $form['probleme'] : null;
        $etat = isset($form['etat']) ? $form['etat'] : null;
        $devis = isset($form['devis']) ? $form['devis'] : null;
        $remarque = isset($form['remarque']) ? $form['remarque'] : null;
        $termine = isset($form['termine']) ? $form['termine'] : null;
        $dateSortie = ($form['dateSortie'] != '') ? $form['dateSortie'] : null;
        $apayer = isset($form['apayer']) ? $form['apayer'] : null;
        $garantie = isset($form['garantie']) ? $form['garantie'] : null;

        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        if ($numeroBon == null) {
            $sql = 'INSERT INTO '.PFX.'bonsReparation ';
            $sql .= 'SET idUser = :idUser, typeMateriel = :typeMateriel, marque = :marque, modele = :modele, ox = :ox, ';
            $sql .= 'dateEntree = :dateEntree, benevole = :benevole, mdp = :mdp, probleme = :probleme, etat = :etat, devis = :devis, ';
            $sql .= 'data = :data, remarque = :remarque, termine = :termine, dateSortie = :dateSortie, apayer = :apayer, garantie = :garantie ';
        } else {
            $sql = 'UPDATE '.PFX.'bonsReparation ';
            $sql .= 'SET idUser = :idUser, typeMateriel = :typeMateriel, marque = :marque, modele = :modele, ox = :ox, ';
            $sql .= 'dateEntree = :dateEntree, benevole = :benevole, mdp = :mdp, probleme = :probleme, etat = :etat, devis = :devis, ';
            $sql .= 'data = :data, remarque = :remarque, termine = :termine, dateSortie = :dateSortie, apayer = :apayer, garantie = :garantie ';
            $sql .= 'WHERE numeroBon = :numeroBon ';
        }
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':idUser', $idUser, PDO::PARAM_INT);
        $requete->bindParam(':typeMateriel', $typeMateriel, PDO::PARAM_INT);
        $requete->bindParam(':marque', $marque, PDO::PARAM_STR, 50);
        $requete->bindParam(':modele', $modele, PDO::PARAM_STR, 50);
        $requete->bindParam(':dateEntree', $dateEntree, PDO::PARAM_STR, 10);
        $requete->bindParam(':ox', $ox, PDO::PARAM_STR, 7);
        $requete->bindParam(':benevole', $benevole, PDO::PARAM_STR, 100);
        $requete->bindParam(':mdp', $mdp, PDO::PARAM_STR, 40);
        $requete->bindParam(':probleme', $probleme, PDO::PARAM_STR);
        $requete->bindParam(':etat', $etat, PDO::PARAM_STR);
        $requete->bindParam(':devis', $devis, PDO::PARAM_STR);
        $requete->bindParam(':data', $data, PDO::PARAM_INT);
        $requete->bindParam(':remarque', $remarque, PDO::PARAM_STR);
        $requete->bindParam(':termine', $termine, PDO::PARAM_INT);
        $requete->bindParam(':dateSortie', $dateSortie, PDO::PARAM_STR, 10);
        $requete->bindParam(':apayer', $apayer, PDO::PARAM_INT);
        $requete->bindParam(':garantie', $garantie, PDO::PARAM_INT);
        if ($numeroBon != null) {
            $requete->bindParam(':numeroBon', $numeroBon, PDO::PARAM_INT);
        }

        $resultat = $requete->execute();
        $nb = $requete->rowCount();

        if ($numeroBon == null) {
            $numeroBon = $connexion->lastInsertId();
        }

        // enregistrement de la liste des accessoires fournis par le client
        $listeAccessoires = isset($form['accessoires']) ? $form['accessoires'] : null;

        // nettoyage de la liste actuelle
        $sql = 'DELETE FROM '.PFX.'bonsAccessoires ';
        $sql .= 'WHERE numeroBon = :numeroBon ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':numeroBon', $numeroBon, PDO::PARAM_INT);
        $resultat = $requete->execute();

        // remise en place éventuelle des "accessoires" du formulaire
        if ($listeAccessoires != null) {
            $sql = 'INSERT INTO '.PFX.'bonsAccessoires ';
            $sql .= 'SET numeroBon = :numeroBon, idAccessoire = :idAccessoire ';
            $requete = $connexion->prepare($sql);

            $requete->bindParam(':numeroBon', $numeroBon, PDO::PARAM_INT);

            foreach ($listeAccessoires as $wtf => $idAccessoire) {
                $requete->bindParam(':idAccessoire', $idAccessoire, PDO::PARAM_INT);
                $resultat = $requete->execute();
            }
        }

        Application::DeconnexionPDO($connexion);

        return $numeroBon;
    }

    /**
    * renvoie les bons de réparation dont on donne la liste $listeNumerosBons
    *
    * @param int $idUser
    *
    * @return array
    */
    public function getListeBonsReparation($idClient)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        // $sql = 'SELECT numeroBon, idUser, type.type, marque, modele, ox, data, ';
        // $sql .= 'dateEntree, dateSortie, benevole, mdp, data, probleme, etat, devis, remarque, apayer, termine ';
        $sql = 'SELECT * ';
        $sql .= 'FROM '.PFX.'bonsReparation ';
        $sql .= 'JOIN '.PFX.'typeMateriel AS type ON typeMateriel = type.idTypeMateriel ';
        $sql .= 'WHERE idUser = :idClient ';
        $sql .= 'ORDER BY dateEntree ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':idClient', $idClient, PDO::PARAM_INT);

        $resultat = $requete->execute();
        $liste = array();
        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            while ($ligne = $requete->fetch()) {
                $numeroBon = $ligne['numeroBon'];
                $liste[$numeroBon] = $ligne;
            }
        }

        Application::DeconnexionPDO($connexion);

        return $liste;
    }

    /**
     * renvoie tous les types de matériels disponibles en réparation
     *
     * @param
     *
     * @return array
     */
    public function getTypeMateriel()
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT idTypeMateriel, type ';
        $sql .= 'FROM '.PFX.'typeMateriel ';
        $sql .= 'ORDER BY type ';
        $requete = $connexion->prepare($sql);

        $liste = array();
        $resultat = $requete->execute();
        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            while ($ligne = $requete->fetch()) {
                $id = $ligne['idTypeMateriel'];
                $liste[$id] = $ligne['type'];
            }
        }

        Application::DeconnexionPDO($connexion);

        return $liste;
    }

    /**
     * Enregistre le nouveau type de matériel $type ou le type $idMatos
     *
     * @param string $type
     * @param int $idMatos
     *
     * @return int $idMatos
     */
    public function saveMatos($idMatos, $type)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        if ($idMatos == null) {
            $sql = 'INSERT INTO '.PFX.'typeMateriel ';
            $sql .= 'SET type = :type ';
        } else {
            $sql = 'UPDATE '.PFX.'typeMateriel ';
            $sql .= 'SET type = :type ';
            $sql .= 'WHERE idTypeMateriel = :idMatos ';
        }
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':type', $type, PDO::PARAM_STR, 50);
        if ($idMatos != null) {
            $requete->bindParam(':idMatos', $idMatos, PDO::PARAM_INT);
        }

        $resultat = $requete->execute();

        if ($idMatos == null) {
            $idMatos = $connexion->lastInsertId();
        }

        Application::DeconnexionPDO($connexion);

        return $idMatos;
    }

    /**
     * Enregistre un nouveau type d'accessoire ou enregistre l'édition de l'accessoire $idAccessoire
     *
     * @param int $idAccessoire
     * @param string $accessoire
     *
     * @return int
     */
    public function saveAccessoire($idAccessoire, $accessoire)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        if ($idAccessoire == null) {
            $sql = 'INSERT INTO '.PFX.'accessoires ';
            $sql .= 'SET accessoire = :accessoire ';
        } else {
            $sql = 'UPDATE '.PFX.'accessoires ';
            $sql .= 'SET acessoire = :accessoire ';
            $sql .= 'WHERE idAccessoire = :idAccessoire ';
        }
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':accessoire', $accessoire, PDO::PARAM_STR, 30);
        if ($idAccessoire != null) {
            $requete->bindParam(':idAccessoire', $idAccessoire, PDO::PARAM_INT);
        }

        $resultat = $requete->execute();

        if ($idAccessoire == null) {
            $idAccessoire = $connexion->lastInsertId();
        }

        Application::DeconnexionPDO($connexion);

        return $idAccessoire;
    }



    /**
     * renvoie la liste des accessoires laissés pour le numéro du bon $numeroBon
     *
     * @param array $listeBons
     *
     * @return array
     */
    public function getAccessoires4bon($numeroBon)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT numeroBon, macc.idAccessoire, accessoire ';
        $sql .= 'FROM '.PFX.'bonsAccessoires AS macc ';
        $sql .= 'JOIN '.PFX.'accessoires AS acc ON acc.idAccessoire = macc.idAccessoire ';
        $sql .= 'WHERE numeroBon = :numeroBon ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':numeroBon', $numeroBon, PDO::PARAM_INT);

        $liste = array();
        $resultat = $requete->execute();
        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            while ($ligne = $requete->fetch()) {
                $numeroBon = $ligne['numeroBon'];
                $idAccessoire = $ligne['idAccessoire'];
                $liste[$idAccessoire] = $ligne['accessoire'];
            }
        }

        Application::DeconnexionPDO($connexion);

        return $liste;
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
        $sql .= 'FROM '.PFX.'accessoires ';
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
        $sql .= 'FROM '.PFX.'typeMateriel ';
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
     * Suppression définitive du bon $numeroBon du client $idUser
     *
     * @param int $idUser
     * @param int $numeroBon
     *
     * @return int
     */
    public function deleteBon($idUser, $numeroBon)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'DELETE FROM '.PFX.'bonsReparation ';
        $sql .= 'WHERE numeroBon = :numeroBon AND idUser = :idUser';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':numeroBon', $numeroBon, PDO::PARAM_INT);
        $requete->bindParam(':idUser', $idUser, PDO::PARAM_INT);

        $resultat = $requete->execute();

        $nb = $requete->rowCount();

        Application::DeconnexionPDO($connexion);

        return $nb;
    }

    /**
     * Enregistre une nouvelle mention pour probleme ou solution dans un bon de réparation
     *
     * @param int $idMention
     * @param string $mention
     * @param string $type
     * @param int $idUser
     *
     * @return array
     */
    public function saveMentionBon($idMention, $mention, $type, $idUser)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        // C'est une nouvelle mention
        if ($idMention == null) {
            $sql = 'INSERT INTO '.PFX.'mentionsTravail ';
            $sql .= 'SET idUser = :idUser, type = :type, texte = :mention ';
        } else {
            // Il s'agit d'une suppression
            if (trim($mention) == '') {
                $sql = 'DELETE FROM '.PFX.'mentionsTravail ';
                $sql .= 'WHERE idMention = :idMention ';
            } else {
                // c'est une édition
                $sql = 'UPDATE '.PFX.'mentionsTravail ';
                $sql .= 'SET idUser = :idUser, type = :type, texte = :mention ';
                $sql .= 'WHERE idMention = :idMention ';
            }
        }
        $requete = $connexion->prepare($sql);

        // C'est une nouvelle mention
        if ($idMention == null) {
            $requete->bindParam(':idUser', $idUser, PDO::PARAM_INT);
            $requete->bindParam(':mention', $mention, PDO::PARAM_STR, 100);
            $requete->bindParam(':type', $type, PDO::PARAM_STR, 8);
        } else {
            // Il s'agit d'une suppression
            if (trim($mention) == '') {
                $requete->bindParam(':idMention', $idMention, PDO::PARAM_INT);
            } else {
                // C'est une édition
                $requete->bindParam(':idMention', $idMention, PDO::PARAM_INT);
                $requete->bindParam(':idUser', $idUser, PDO::PARAM_INT);
                $requete->bindParam(':mention', $mention, PDO::PARAM_STR, 100);
                $requete->bindParam(':type', $type, PDO::PARAM_STR, 8);
            }
        }

        $resultat = $requete->execute();

        $nb = $requete->rowCount();

        Application::DeconnexionPDO($connexion);

        return $nb;
    }

    /** renvoie les mentions pour probleme ou solution dans un bon de réparation
     *
     * @param string $type
     *
     * @return array
     */
    public function getMentionsBon($type)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT idMention, type, texte, mentions.idUser, users.prenom ';
        $sql .= 'FROM '.PFX.'mentionsTravail AS mentions ';
        $sql .= 'JOIN '.PFX.'users AS users ON users.idUser = mentions.idUser ';
        $sql .= 'WHERE type = :type ';
        $sql .= 'ORDER BY prenom, texte ';

        $requete = $connexion->prepare($sql);

        $requete->bindParam(':type', $type, PDO::PARAM_STR, 8);

        $listeMentions = array();
        $resultat = $requete->execute();
        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            while($ligne = $requete->fetch()) {
                $idMention = $ligne['idMention'];
                $listeMentions[$idMention] = $ligne;
            }
        }

        Application::DeconnexionPDO($connexion);

        return $listeMentions;
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
        $sql = 'DELETE FROM '.PFX.'users ';
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

    /**
     * recherche les informations "client" pour le bon de réparation $numeroBon
     *
     * @param int $numeroBon
     *
     * @return array
     */
    public function getClient4bon($numeroBon)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT users.* ';
        $sql .= 'FROM '.PFX.'bonsReparation AS bons ';
        $sql .= 'JOIN '.PFX.'users AS users ON users.idUser = bons.idUser ';
        $sql .= 'WHERE bons.numeroBon = :numeroBon ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':numeroBon', $numeroBon, PDO::PARAM_INT);

        $client = array();
        $resultat = $requete->execute();
        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            $client = $requete->fetch();
        }

        Application::DeconnexionPDO($connexion);

        return $client;
    }

    /**
     * recherche le nombre de dépendances sur les bons de réparations pour l'utilisateur $idUser
     * afin de ne pas supprimer un utilisateur avec des actions en attente
     *
     * @param int $idUser
     *
     * @return bool
     */
    public function getDependancesBons($idUser)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT COUNT(*) AS compte ';
        $sql .= 'FROM '.PFX.'bonsReparation ';
        $sql .= 'WHERE idUser = :idUser ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':idUser', $idUser, PDO::PARAM_INT);

        $resultat = $requete->execute();
        $compte = 0;
        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            $ligne = $requete->fetch();
            $compte = $ligne['compte'];
        }

        Application::DeconnexionPDO($connexion);

        return $compte;
    }

    /**
    * renvoie le nombre de mentions d'avancement pour tous les bons
    *
    * @param
    *
    * @return array
    */
    public function getNbAvancements4bons()
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT numeroBon, count(idAvancement) AS nb ';
        $sql .= 'FROM '.PFX.'bonsAvancement ';
        $sql .= 'GROUP BY numeroBon ';
        $requete = $connexion->prepare($sql);

        $listeAvancements = array();
        $resultat = $requete->execute();
        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            while ($ligne = $requete->fetch()) {
                $numeroBon = $ligne['numeroBon'];
                $listeAvancements[$numeroBon] = $ligne['nb'];
            }
        }

        Application::DeconnexionPDO($connexion);

        return $listeAvancements;
    }

    /**
     * Recherche la liste des avancements du travail pour le client $idUser pour la bon $numeroBon
     *
     * @param int $numeroBon
     *
     * @return array
     */
    public function getAvancements($numeroBon)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT * ';
        $sql .= 'FROM '.PFX.'bonsAvancement AS avancement ';
        $sql .= 'WHERE numeroBon = :numeroBon ';
        $sql .= 'ORDER BY date ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':numeroBon', $numeroBon, PDO::PARAM_INT);

        $avancements = array();
        $resultat = $requete->execute();
        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            while ($ligne = $requete->fetch()) {
                $idAvancement = $ligne['idAvancement'];
                $laDate = Application::datePHP(substr($ligne['date'], 0, 10));
                $heure = substr($ligne['date'], 11, 5);
                $ligne['date'] = $laDate;
                $ligne['heure'] = $heure;
                $avancements[$idAvancement] = $ligne;
            }
        }

        Application::DeconnexionPDO($connexion);

        return $avancements;
    }

    /**
     * Enregistrement d'une nouvelle étape dans l'avancement du travail
     *
     * @param int $numeroBon
     * @param string $texte
     * @param string $benevole
     *
     * @return int
     */
    public function saveAvancement($numeroBon, $texte, $benevole, $interaction)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'INSERT INTO '.PFX.'bonsAvancement ';
        $sql .= 'SET numeroBon = :numeroBon, texte = :texte, benevole = :benevole, interactionClient = :interaction ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':numeroBon', $numeroBon, PDO::PARAM_INT);
        $requete->bindParam(':texte', $texte, PDO::PARAM_STR, 200);
        $requete->bindParam(':benevole', $benevole, PDO::PARAM_STR, 60);
        $requete->bindParam(':interaction', $interaction, PDO::PARAM_STR, 10);

        $resultat = $requete->execute();

        $n = $requete->rowCount();

        Application::DeconnexionPDO($connexion);

        return $n;
    }

    /**
     * Barre la phase d'avancement $idAvancement du bon $numeroBon
     *
     * @param int $idAvancement
     * @param int $numeroBon
     * @param string $benevole : prénom du bénévole
     *
     * @return int
     */
    public function strikeAvancement($numeroBon, $idAvancement, $benevole)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'UPDATE '.PFX.'bonsAvancement ';
        $sql .= 'SET barre = NOT(barre), barrePar = :benevole ';
        $sql .= 'WHERE numeroBon = :numeroBon AND idAvancement = :idAvancement ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':numeroBon', $numeroBon, PDO::PARAM_INT);
        $requete->bindParam(':idAvancement', $idAvancement, PDO::PARAM_INT);
        $requete->bindParam(':benevole', $benevole, PDO::PARAM_STR, 60);

        $resultat = $requete->execute();

        $n = $requete->rowCount();

        Application::DeconnexionPDO($connexion);

        return $n;
    }

    /**
     * Supprime une mention d'avancement $idAvancement pour le bon $numeroBon
     *
     * @param int $idAvancement
     *
     * @return int
     */

    public function delAvancement($idAvancement)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'DELETE FROM '.PFX.'bonsAvancement ';
        $sql .= 'WHERE idAvancement = :idAvancement ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':idAvancement', $idAvancement, PDO::PARAM_INT);

        $requete->execute();

        $n = $requete->rowCount();

        Application::DeconnexionPDO($connexion);

        return $n;
    }

    /**
     * recherche la valeur actuelle du token "Client"
     *
     * @param
     *
     * @return string
     */
    public function getToken()
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT token FROM '.PFX.'token ';
        $requete = $connexion->prepare($sql);

        $token = '';
        $resultat = $requete->execute();
        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            $ligne = $requete->fetch();
            $token = $ligne['token'];
        }

        Application::DeconnexionPDO($connexion);

        if ($token == '') {
            $token = $this->renewToken();
        }

        return $token;
    }

    /**
     * renouvelle la valeur du token "Client"
     *
     * @param
     *
     * @return string
     */
    public function renewToken()
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'TRUNCATE '.PFX.'token ';
        $requete = $connexion->prepare($sql);
        $resultat = $requete->execute();

        $token = rand(0, 9999);
        $token = str_pad($token, 4, '0', STR_PAD_LEFT);
        $sql = 'INSERT INTO '.PFX.'token ';
        $sql .= 'SET token = :token ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':token', $token, PDO::PARAM_STR, 4);

        $resultat = $requete->execute();

        Application::DeconnexionPDO($connexion);

        return $token;
    }


}
