<?php

class NewClient
{
    public function __construct() {}

    public static function autoSaveClient($form)
    {
        // $captcha = isset($form['captcha']) ? strtoupper($form['captcha']) : null;

        // // vérification du captcha
        // if (($captcha == null) || ($captcha != $_SESSION['oxxl']['captcha'])) {
        //     return json_encode(array('nb' => 0, 'idUser' => null, 'erreur' => 'Captcha'));
        // } else {

            $idUser = isset($form['idUser']) ? $form['idUser'] : null;
            $civilite = isset($form['civilite']) ? $form['civilite'] : null;
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
            $sql .= 'SET civilite = :civilite, nom = :nom, prenom = :prenom, ';
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
            $requete->bindParam(':civilite', $civilite, PDO::PARAM_STR);
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
