<?php

class User
{
    private $mail;
    private $identite;            // données personnelles
    private $applicationName;

    // --------------------------------------------
    // fonction constructeur
    public function __construct($mail, $md5passwd)
    {
        if (isset($mail)) {
            $this->mail = $mail;
            $this->applicationName = APPLICATION;
            $this->identite = $this->getIdentite($mail, $md5passwd);
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
    public function getIdentite($mail, $md5passwd)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT civilite, nom, prenom, telephone, gsm, users.mail, adresse, cpost, ';
        $sql .= 'commune, users.droits ';
        $sql .= 'FROM '.PFX.'users AS users ';
        $sql .= 'JOIN '.PFX.'passwd AS pwd ON pwd.mail = users.mail ';
        $sql .= 'WHERE users.mail = :mail AND pwd.md5passwd = :md5passwd ';

        $requete = $connexion->prepare($sql);

        $requete->bindParam(':mail', $mail, PDO::PARAM_STR, 100);
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
    public function getListeUsers($droits)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT idUser, civilite, nom, prenom, telephone, gsm, mail, adresse, ';
        $sql .= 'cpost, commune, droits ';
        $sql .= 'FROM '.PFX.'users ';
        $sql .= 'WHERE droits = :droits ';
        $sql .= 'ORDER BY nom, prenom, mail ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':droits', $droits, PDO::PARAM_STR, 6);

        $resultat = $requete->execute();
        $liste = array();
        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            while ($ligne = $requete->fetch()) {
                $idUser = $ligne['idUser'];
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
    public function getDataUser($idUser)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT idUser, civilite, nom, prenom, telephone, gsm, mail, adresse, ';
        $sql .= 'cpost, commune, droits ';
        $sql .= 'FROM '.PFX.'users ';
        $sql .= 'WHERE idUser = :idUser ';
        $requete = $connexion->prepare($sql);

        $data = null;
        $requete->bindParam(':idUser', $idUser, PDO::PARAM_INT);

        $resultat = $requete->execute();
        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            $data = $requete->fetch();
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
    public function saveUser($form, $droits = 'client')
    {
        $idUser = isset($form['idUser']) ? $form['idUser'] : null;
        $civilite = isset($form['civilite']) ? $form['civilite'] : null;
        $nom = isset($form['nom']) ? $form['nom'] : null;
        $prenom = isset($form['prenom']) ? $form['prenom'] : null;

        $telephone = isset($form['telephone']) ? $form['telephone'] : null;
        $gsm = isset($form['gsm']) ? $form['gsm'] : null;
        $mail = isset($form['mail']) ? $form['mail'] : null;

        $adresse = isset($form['adresse']) ? $form['adresse'] : null;
        $commune = isset($form['commune']) ? $form['commune'] : null;
        $cpost = isset($form['cpost']) ? $form['cpost'] : null;

        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'INSERT INTO '.PFX.'users ';
        $sql .= 'SET civilite = :civilite, idUser = :idUser, nom = :nom, prenom = :prenom, ';
        $sql .= 'telephone = :telephone, gsm = :gsm, mail = :mail, ';
        $sql .= 'adresse = :adresse, commune = :commune, cpost = :cpost, ';
        $sql .= 'droits = :droits ';
        $sql .= 'ON DUPLICATE KEY UPDATE ';
        $sql .= 'civilite = :civilite, nom = :nom, prenom = :prenom, ';
        $sql .= 'telephone = :telephone, gsm = :gsm, mail = :mail, ';
        $sql .= 'adresse = :adresse, commune = :commune, cpost = :cpost, ';
        $sql .= 'droits = :droits ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':idUser', $idUser, PDO::PARAM_INT);
        $requete->bindParam(':civilite', $civilite, PDO::PARAM_STR, 1);
        $requete->bindParam(':nom', $nom, PDO::PARAM_STR, 60);
        $requete->bindParam(':prenom', $prenom, PDO::PARAM_STR, 60);
        $requete->bindParam(':telephone', $telephone, PDO::PARAM_STR, 15);
        $requete->bindParam(':gsm', $gsm, PDO::PARAM_STR, 15);
        $requete->bindParam(':mail', $mail, PDO::PARAM_STR, 100);
        $requete->bindParam(':adresse', $adresse, PDO::PARAM_STR, 100);
        $requete->bindParam(':commune', $commune, PDO::PARAM_STR, 50);
        $requete->bindParam(':cpost', $cpost, PDO::PARAM_STR, 6);
        $requete->bindParam(':droits', $droits, PDO::PARAM_STR, 6);

        $resultat = $requete->execute();

        $nb = $requete->rowCount();
        $idUser = ($idUser == Null) ? $connexion->lastInsertId() : $idUser;

        Application::DeconnexionPDO($connexion);

        return json_encode(array('nb' => $nb, 'idUser' => $idUser));
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
        $sql = 'SELECT numeroBon, idUser, typeMateriel, marque, modele, ox, ';
        $sql .= 'dateEntree, dateSortie, benevole, probleme, etat, devis, ';
        $sql .= 'remarque, apayer, termine ';
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
     * renvoie le contenu du bon de réparation $numeroBon 
     *
     * @param int $numeroBon
     *
     * @return array
     */

     public function getData4Bon($numeroBon)
     {
         $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
         $sql = 'SELECT numeroBon, idUser, typeMateriel, marque, modele, ox, ';
         $sql .= 'dateEntree, dateSortie, benevole, probleme, etat, devis, ';
         $sql .= 'remarque, apayer, termine ';
         $sql .= 'FROM '.PFX.'bonsReparation ';
         $sql .= 'WHERE numeroBon = :numeroBon ';
         $requete = $connexion->prepare($sql);
 
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
        $idUser = isset($form['idUser']) ? $form['idUser'] : null;
        $numeroBon = isset($form['numeroBon']) ? $form['numeroBon'] : null;

        $typeMateriel = isset($form['typeMateriel']) ? $form['typeMateriel'] : null;
        $marque = isset($form['marque']) ? $form['marque'] : null;
        $modele = isset($form['modele']) ? $form['modele'] : null;

        $dateEntree = ($form['dateEntree'] != '') ? $form['dateEntree'] : null;
        $benevole = isset($form['benevole']) ? $form['benevole'] : null;
        $ox = isset($form['ox']) ? $form['ox'] : null;

        $probleme = isset($form['probleme']) ? $form['probleme'] : null;
        $etat = isset($form['etat']) ? $form['etat'] : null;
        $devis = isset($form['devis']) ? $form['devis'] : null;
        $remarque = isset($form['remarque']) ? $form['remarque'] : null;
        $dateSortie = ($form['dateSortie'] != '') ? $form['dateSortie'] : null;
        $apayer = isset($form['apayer']) ? $form['apayer'] : null;

        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        if ($numeroBon == null) {
            $sql = 'INSERT INTO '.PFX.'bonsReparation ';
            $sql .= 'SET idUser = :idUser, typeMateriel = :typeMateriel, marque = :marque, modele = :modele, ox = :ox, ';
            $sql .= 'dateEntree = :dateEntree, benevole = :benevole, probleme = :probleme, etat = :etat, devis = :devis, ';
            $sql .= 'remarque = :remarque, dateSortie = :dateSortie, apayer = :apayer ';
        } else {
            $sql = 'UPDATE '.PFX.'bonsReparation ';
            $sql .= 'SET idUser = :idUser, typeMateriel = :typeMateriel, marque = :marque, modele = :modele, ox = :ox, ';
            $sql .= 'dateEntree = :dateEntree, benevole = :benevole, probleme = :probleme, etat = :etat, devis = :devis, ';
            $sql .= 'remarque = :remarque, dateSortie = :dateSortie, apayer = :apayer ';
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
        $requete->bindParam(':probleme', $probleme, PDO::PARAM_STR);
        $requete->bindParam(':etat', $etat, PDO::PARAM_STR);
        $requete->bindParam(':devis', $devis, PDO::PARAM_STR);
        $requete->bindParam(':remarque', $remarque, PDO::PARAM_STR);
        $requete->bindParam(':dateSortie', $dateSortie, PDO::PARAM_STR, 10);
        $requete->bindParam(':apayer', $apayer, PDO::PARAM_INT);
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
        $sql = 'SELECT numeroBon, idUser, type.type, marque, modele, ox, ';
        $sql .= 'dateEntree, dateSortie, benevole, probleme, etat, devis, remarque, apayer, termine ';
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
     * suppression de l'utilisateur $idUser de la base de données
     * 
     * @param int $idUser
     * 
     * @return int
     */
    public function delUser($idUser){
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'DELETE FROM '.PFX.'users ';
        $sql .= 'WHERE idUser = :idUser ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':idUser', $idUser, PDO::PARAM_INT);

        $resultat = $requete->execute();

        $n = 0;
        if ($resultat)
            $n = $requete->rowCount();

        Application::DeconnexionPDO($connexion);

        return $n;
    }

    /**
     * recherche le nombre de dépendances sur les bons de réparations pour l'utilisateur $idUser
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

}
