<?php 

class Stock {

    public function __construct(){

    }

    /**
     * retourne la liste des marchandises en stock
     * 
     * @param 
     * 
     * @return array
     */
    public function getItemsStock(){
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT idMateriel, marque, modele, caracteristiques, prix ';
        $sql .= 'FROM '.PFX.'inventaire ';
        $sql .= 'ORDER BY marque, modele, caracteristiques ';
        $requete = $connexion->prepare($sql);

        $liste = array();

        $resultat = $requete->execute();

        if ($resultat){
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            while ($ligne = $requete->fetch()){
                $idMateriel = $ligne['idMateriel'];
                $liste[$idMateriel] = $ligne;
            }
        }

        Application::DeconnexionPDO($connexion);

        return $liste;
    }

/**
 * retourne les caractéristiques de l'item $idItemStock de l'inventaire
 * 
 * @param int $idItemStock
 * 
 * @return array
 */
public function getOneItemStock($idMateriel){
    $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
    $sql = 'SELECT idMateriel, marque, modele, caracteristiques, prix ';
    $sql .= 'FROM '.PFX.'inventaire ';
    $sql .= 'WHERE idMateriel = :idMateriel ';
    $requete = $connexion->prepare($sql);

    $requete->bindParam(':idMateriel', $idMateriel, PDO::PARAM_INT);

    $item = array();
    $resultat = $requete->execute();

    if ($resultat){
        $requete->setFetchMode(PDO::FETCH_ASSOC);
        $item = $requete->fetch();
    }

    Application::DeconnexionPDO($connexion);

    return $item;
}

/**
 * Enregistre un item dans le stock
 * 
 * @param array $form
 * 
 * @return int
 */
public function saveItemStock($form){
    $idMateriel = isset($form['idMateriel']) ? $form['idMateriel'] : Null;
    $marque = isset($form['marque']) ? $form['marque'] : Null;
    $modele = isset($form['modele']) ? $form['modele'] : Null;
    $caracteristiques = isset($form['caracteristiques']) ? $form['caracteristiques'] : Null;
    $prix = isset($form['prix']) ? $form['prix'] : Null;

    $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
    if ($idMateriel == Null) {
        // c'est un nouvel item
        $sql = 'INSERT INTO '.PFX.'inventaire ';
        $sql .= 'SET marque = :marque, modele = :modele, caracteristiques = :caracteristiques, ';
        $sql .= 'prix = :prix ';
    }
    else {
        // c'est une édition
        $sql = 'UPDATE '.PFX.'inventaire ';
        $sql .= 'SET marque = :marque, modele = :modele, caracteristiques = :caracteristiques, ';
        $sql .= 'prix = :prix ';
        $sql .= 'WHERE idMateriel = :idMateriel ';
    }
    $requete = $connexion->prepare($sql);

    if ($idMateriel != Null)
        $requete->bindParam(':idMateriel', $idMateriel, PDO::PARAM_INT);
    
    $requete->bindParam(':marque', $marque, PDO::PARAM_STR, 30);
    $requete->bindParam(':modele', $modele, PDO::PARAM_STR, 30);
    $requete->bindParam(':caracteristiques', $caracteristiques, PDO::PARAM_STR, 40);
    $requete->bindParam(':prix', $prix, PDO::PARAM_INT);

    $nb = 0;
    $resultat = $requete->execute();

    if ($resultat) {
        $nb = $requete->rowCount();
    }
    if ($idMateriel == Null)
        $idMateriel = $connexion->lastInsertId();

    Application::DeconnexionPDO($connexion);

    return json_encode(array('nb' => $nb, 'idMateriel' => $idMateriel));
}

/**
 * Suppression d'un item dans l'inventaire
 * 
 * @param int $idMateriel
 * 
 * @return int
 */
public function delItemStock($idMateriel) {
    $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
    $sql = 'DELETE FROM '.PFX.'inventaire ';
    $sql .= 'WHERE idMateriel = :idMateriel ';
    $requete = $connexion->prepare($sql);

    $requete->bindParam(':idMateriel', $idMateriel, PDO::PARAM_INT);

    $resultat = $requete->execute();

    $nb = $requete->rowCount();

    Application::DeconnexionPDO($connexion);

    return $nb;
}

}
