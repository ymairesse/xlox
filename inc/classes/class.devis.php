<?php


class Devis
{

    public function __construct()
    {

    }

    /**
     * charge la liste de tous devis (et leurs détails) pour le client $idClient
     * 
     * @param int $idClient
     * 
     * @return array
     */
    public function getAllDevis4Client($idClient)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT idDevis, idClient, date ';
        $sql .= 'FROM ' . PFX . 'devis ';
        $sql .= 'WHERE idClient = :idClient ';
        $sql .= 'ORDER BY date, idDevis ';
        $requete1 = $connexion->prepare($sql);

        $requete1->bindParam(':idClient', $idClient, PDO::PARAM_INT);

        // $listeDevis triée sur les $date et $idDevis 
        $listeDevis = array();

        $resultat = $requete1->execute();
        if ($resultat) {
            $requete1->setFetchMode(PDO::FETCH_ASSOC);
            while ($ligne = $requete1->fetch()) {
                $idDevis = $ligne['idDevis'];
                $listeDevis[$idDevis] = $ligne;
                $idDevisString = sprintf("%'.03d\n", $idDevis % 500);
                $listeDevis[$idDevis]['ref'] = date('Y').'.'.date('m').'.'.$idDevisString;
            }
        }

        // Ajout des items de marchandise à chaque devis
        if ($listeDevis != Null) {
            $listeidDevis = array_keys($listeDevis);
            $listeidDevisString = '"' . implode('","', $listeidDevis) . '"';

            $sql = 'SELECT idItem, idDevis, materiel, prix, remarque ';
            $sql .= 'FROM ' . PFX . 'devisItems ';
            $sql .= 'WHERE idDevis IN (' . $listeidDevisString . ') ';
            $sql .= 'ORDER BY idItem, idDevis ';
            $requete2 = $connexion->prepare($sql);

            $listeItems = array();
            $resultat = $requete2->execute();

            if ($resultat) {
                $requete2->setFetchMode(PDO::FETCH_ASSOC);
                while ($ligne = $requete2->fetch()) {
                    $idDevis = $ligne['idDevis'];
                    $idItem = $ligne['idItem'];
                    $listeItems[$idDevis][$idItem] = $ligne;
                }
            }

            // coller les items, s'il y en a, aux devis correspondants
            foreach ($listeDevis as $idDevis => $unDevis) {

                if (isset($listeItems[$idDevis])) {
                    $listeDevis[$idDevis]['items'] = $listeItems[$idDevis];
                }
            }
        }

        Application::DeconnexionPDO($connexion);

        return $listeDevis;
    }

    /**
     * recherche le devis $idDevis 
     * 
     * @param int $idDevis
     * 
     * @return array
     */
    public function getDevis($idDevis)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT idDevis, date, idClient ';
        $sql .= 'FROM ' . PFX . 'devis ';
        $sql .= 'WHERE idDevis = :idDevis ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':idDevis', $idDevis, PDO::PARAM_INT);

        $devis = array();
        $resultat = $requete->execute();

        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            $devis = $requete->fetch();
            $idDevisString = sprintf("%'.03d", $idDevis % 500);
            $devis['ref'] = date('Y').'.'.date('m').'.'.$idDevisString;
        }

        Application::DeconnexionPDO($connexion);

        return $devis;
    }

    /**
     * Enregistrer date et numéro de référence d'un devis
     * 
     * @param int $idDevis
     * @param int $idClient
     * @param date $date
     * 
     * @return int
     */
    public function saveDevis($idDevis, $idClient, $date){
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        if ($idDevis == Null) {
            $sql = 'INSERT INTO '.PFX.'devis ';
            $sql .= 'SET idClient = :idClient, date = :date ';
            $requete = $connexion->prepare($sql);

            $requete->bindParam(':idClient', $idClient, PDO::PARAM_INT);
            $requete->bindParam(':date', $date, PDO::PARAM_STR, 10);

        }
        else {
            $sql = 'UPDATE '.PFX.'devis ';
            $sql .= 'SET date = :date ';
            $sql .= 'WHERE idDevis = :idDevis ';
            $requete = $connexion->prepare($sql);

            $requete->bindParam(':idDevis', $idDevis, PDO::PARAM_INT);
            $requete->bindParam(':date', $date, PDO::PARAM_STR, 10);
        }

        $resultat = $requete->execute();

        if ($resultat) {
            if ($idDevis == Null)
                $idDevis = $connexion->lastInsertId();
        }        

        Application::DeconnexionPDO($connexion);    

        return $idDevis;
    }

        
    /**
     * renvoie les différents items pour le devis $idDevis
     * 
     * @param int $idDevis
     * 
     * @return array
     */
    public function getItems4devis($idDevis)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT idItem, idDevis, materiel, prix, remarque ';
        $sql .= 'FROM ' . PFX . 'devisItems ';
        $sql .= 'WHERE idDevis = :idDevis ';
        $sql .= 'ORDER BY idItem ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':idDevis', $idDevis, PDO::PARAM_INT);

        $resultat = $requete->execute();

        $listeItems = array();

        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            while ($ligne = $requete->fetch()) {
                $idItem = $ligne['idItem'];
                $listeItems[$idItem] = $ligne;
            }
        }

        Application::DeconnexionPDO($connexion);

        return $listeItems;
    }

    /**
     * Supprime le devis $idDevis 
     * 
     * @param int $idDevis
     * 
     * @return int
     */
    public function delDevis ($idDevis) {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'DELETE FROM '.PFX.'devis ';;
        $sql .= 'WHERE idDevis = :idDevis ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':idDevis', $idDevis, PDO::PARAM_INT);

        $resultat = $requete->execute();

        $n = 0;
        if ($resultat) 
            $n = $requete->rowCount();

        Application::DeconnexionPDO($connexion);

        return $n;
    }

    /**
     * renvoie le contenu de l'item $idItem d'un devis
     * 
     * @param int $idItem
     * 
     * @return array
     */
    public function getDataItemDevis($idItem)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT idItem, idDevis, materiel, prix, remarque ';
        $sql .= 'FROM ' . PFX . 'devisItems ';
        $sql .= 'WHERE idItem = :idItem ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':idItem', $idItem, PDO::PARAM_INT);

        $dataItem = array();
        $resultat = $requete->execute();

        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            $dataItem = $requete->fetch();
        }

        Application::DeconnexionPDO($connexion);

        return $dataItem;
    }

    /**
     * enregistre le formulaire d'édition d'un item d'un devis
     * et renvoie l'idItem correspondant
     * 
     * @param array $form
     * 
     * @return  int $idItem 
     */
    public function saveDataItemDevis($form)
    {
        $idDevis = isset($form['idDevis']) ? $form['idDevis'] : Null;
        $idItem = isset($form['idItem']) ? $form['idItem'] : Null;
        $materiel = isset($form['materiel']) ? $form['materiel'] : Null;
        $prix = isset($form['prix']) ? $form['prix'] : Null;
        $remarque = isset($form['remarque']) ? $form['remarque'] : Null;

        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        if ($idItem == Null) {
            $sql = 'INSERT INTO ' . PFX . 'devisItems ';
            $sql .= 'SET idDevis = :idDevis, materiel = :materiel, prix = :prix, remarque = :remarque ';
            $requete = $connexion->prepare($sql);
        } else {
            $sql = 'UPDATE ' . PFX . 'devisItems ';
            $sql .= 'SET idDevis = :idDevis, materiel = :materiel, prix = :prix, remarque = :remarque ';
            $sql .= 'WHERE idItem = :idItem ';
            $requete = $connexion->prepare($sql);
            $requete->bindParam(':idItem', $idItem, PDO::PARAM_INT);
        }

        $requete->bindParam(':idDevis', $idDevis, PDO::PARAM_INT);
        $requete->bindParam(':materiel', $materiel, PDO::PARAM_STR, 100);
        $requete->bindParam(':prix', $prix, PDO::PARAM_INT);
        $requete->bindParam(':remarque', $remarque, PDO::PARAM_STR, 100);

        $resultat = $requete->execute();

        if ($idItem == Null) {
            $idItem = $connexion->lastInsertId();
        }

        Application::DeconnexionPDO($connexion);

        return $idItem;
    }

    /**
     * Suppression de l'item $idItem d'un devis
     * 
     * @param int $idItem
     * 
     * @return int
     */
    public function delItemDevis($idItem)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'DELETE FROM ' . PFX . 'devisItems ';
        $sql .= 'WHERE idItem = :idItem ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':idItem', $idItem, PDO::PARAM_INT);

        $resultat = $requete->execute();

        $n = $requete->rowCount();

        Application::DeconnexionPDO($connexion);

        return $n;
    }

    /**
     * recherche les données client pour le devis $idDevis
     * 
     * @param int $idDevis
     * 
     * @return array
     */
    public function getDataClient4devis($idDevis)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT idDevis, idClient, users.* ';
        $sql .= 'FROM ' . PFX . 'devis AS devis ';
        $sql .= 'LEFT JOIN ' . PFX . 'users AS users ON devis.idClient = users.idUser ';
        $sql .= 'WHERE idDevis = :idDevis AND devis.idClient = users.idUser ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':idDevis', $idDevis, PDO::PARAM_INT);

        $dataClient = array();
        $resultat = $requete->execute();
        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            $dataClient = $requete->fetch();
        }

        Application::DeconnexionPDO($connexion);

        return $dataClient;
    }

    /**
     * renvoie la prochiane valeur de $idDevis sur base de la plus grande valeur actuelle
     * 
     * @param
     * 
     * @return int
     */
    public function getNextIdDevis(){
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT MAX(idDevis) AS max ';
        $sql .= 'FROM'. PFX . 'devis ';;
        $requete = $connexion->prepare($sql);

        $resultat = $requete->execute();
        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            $ligne = $requete->fetch();
            $max = $ligne['max'] + 1;
        }
        else $max = 1;

        Application::DeconnexionPDO($connexion);

        return $max;
    }

}