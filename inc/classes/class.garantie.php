<?php 

class Garantie {

    public function __construct(){

    }

    /**
     * Liste des bons de garantie pour le client $idClient
     * @param int $idClient
     *
     * @return array
     */
    public function getGaranties4Client($idClient)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT ticketCaisse, idClient, date ';
        $sql .= 'FROM '.PFX.'bonsGarantie ';
        $sql .= 'WHERE idClient = :idClient ';
        $sql .= 'ORDER BY date ';
        $requete1 = $connexion->prepare($sql);

        $requete1->bindParam(':idClient', $idClient, PDO::PARAM_INT);

        // $listeBonsGarantie triée sur les tickets de caisse
        $listeBonsGarantie = array();

        $resultat = $requete1->execute();
        if ($resultat){
            $requete1->setFetchMode(PDO::FETCH_ASSOC);
            while ($ligne = $requete1->fetch()){
                $ticketCaisse = $ligne['ticketCaisse'];
                $listeBonsGarantie[$ticketCaisse] = $ligne;
            }
        }

        // Ajout des items marchandise à chaque ticket de caisse
        if ($listeBonsGarantie != Null) {
            $listeTicketsBons = array_keys($listeBonsGarantie);
            $listeTicketsBonsString = '"'.implode('","', $listeTicketsBons).'"';
    
            $sql = 'SELECT id, ticketCaisse, ox, ref, materiel, prix, remarque ';
            $sql .= 'FROM '.PFX.'bonsGarantieItems ';
            $sql .= 'WHERE ticketCaisse IN ('.$listeTicketsBonsString.') ';
            $sql .= 'ORDER BY id ';
            $requete2 = $connexion->prepare($sql);
    
            $listeItems = array();
            $resultat = $requete2->execute();
    
            if ($resultat) {
                $requete2->setFetchMode(PDO::FETCH_ASSOC);
                while($ligne = $requete2->fetch()){
                    $ticketCaisse = $ligne['ticketCaisse'];
                    $id = $ligne['id'];
                    $listeItems[$ticketCaisse][$id] = $ligne;
                }
            }
            // coller les items garantis aux bons de garantie correspondants
            // s'il y en a
            foreach ($listeBonsGarantie as $ticketCaisse => $unBon){
                if (isset($listeItems[$ticketCaisse])) {
                    $listeBonsGarantie[$ticketCaisse]['items'] = $listeItems[$ticketCaisse];
                }
            }
        }

        // Ajout des conditions particulières pour chaque ticket de caisse
        if ($listeBonsGarantie != Null) {
            $listeTicketsBons = array_keys($listeBonsGarantie);
            $listeTicketsBonsString = '"'.implode('","', $listeTicketsBons).'"';
            $sql = 'SELECT ticketCaisse, texte, typeCondPart ';
            $sql .= 'FROM '.PFX.'bonsGarantieCondPart ';
            $sql .= 'WHERE ticketCaisse IN ('.$listeTicketsBonsString.') ';
            $sql .= 'ORDER BY ticketCaisse ';
            $requete3 = $connexion->prepare($sql);

            $listeCondPart = array();
            $resultat = $requete3->execute();

            if ($resultat) {
                $requete3->setFetchMode(PDO::FETCH_ASSOC);
                while ($ligne = $requete3->fetch()) {
                    // le numéro du ticket de caisse
                    $ticketCaisse = $ligne['ticketCaisse'];
                    $typeCondPart = $ligne['typeCondPart'];
                    $texte = $ligne['texte'];
                    // le texte est au format json comme enregistré dans la BD
                    // Exemple: '{"CPAS":{"commune":"Ixelles","date":"2024-02-13","dossier":"s23q43654","montant":"300","remarque":"0000000"}}';
                    // on le convertit en array PHP
   
                    $texte = json_decode($texte, true);
                    // conversion en array
                    // array (
                    //     'CPAS' => 
                    //     array (
                    //       'commune' => 'Ixelles',
                    //       'date' => '2024-02-13',
                    //       'dossier' => 's23q43654',
                    //       'montant' => '300',
                    //       'remarque' => '0000000',
                    //     ),
                    //   ),
                    // On ne garde finalement pas le type conservé dasn $typeCondPart

                    $texte = $texte[$typeCondPart];
                    // array (
                    //     'commune' => 'Ixelles',
                    //     'date' => '2024-02-13',
                    //     'dossier' => 's23q43654',
                    //     'montant' => '300',
                    //     'remarque' => '0000000',
                    //   ),
                    $listeCondPart[$ticketCaisse] = array(
                        'typeCondPart' => $typeCondPart,
                        'texte' => $texte, 
                    ); 
                }
            }
            // coller les conditions particulières aux bons de garantie
            foreach ($listeBonsGarantie as $ticketCaisse => $unBon){
                if (isset($listeCondPart[$ticketCaisse])) {
                    $listeBonsGarantie[$ticketCaisse]['condPart'] = $listeCondPart[$ticketCaisse];
                }
            }

        }

        Application::DeconnexionPDO($connexion);

        return $listeBonsGarantie;
    }

    /**
     * retourne les bons de garantie anonymes
     * 
     * @param  
     * @return array
     */
    public function getGarantiesAnonymes(){
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT date, ticketCaisse ';
        $sql .= 'FROM '.PFX.'bonsGarantie ';
        $sql .= 'WHERE idClient IS NULL ';
        $sql .= 'ORDER BY date DESC, ticketCaisse ASC ';
        $requete = $connexion->prepare($sql);

        $liste = array();

        $resultat = $requete->execute();
        if ($resultat){
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            while ($ligne = $requete->fetch()){
                $ticketCaisse = $ligne['ticketCaisse'];
                $liste[$ticketCaisse] = $ligne;
            }
        }

        Application::DeconnexionPDO($connexion);

        return $liste;
    }

    /**
     * renvoie les caractéristiques du bon de garantie pour le $ticketCaisse
     * 
     * @param int $ticketCaisse
     * 
     * @return array
     */
    public function getDataGarantie($ticketCaisse){
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT date, idClient, ticketCaisse ';
        $sql .= 'FROM '.PFX.'bonsGarantie ';
        $sql .= 'WHERE ticketCaisse = :ticketCaisse ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':ticketCaisse', $ticketCaisse, PDO::PARAM_STR, 10);

        $resultat = $requete->execute();
        
        $ligne = array();
        if ($resultat){
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            $ligne = $requete->fetch();
        }

        Application::DeconnexionPDO($connexion);

        return $ligne;
    }

    /**
     * renvoie les informations "client" pour la garantie ticketCaisse
     * 
     * @param int ticketCaisse
     * 
     * @return array
     */
    public function getDataClient4garantie($ticketCaisse){
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT date, idClient, ticketCaisse, users.* ';
        $sql .= 'FROM '.PFX.'bonsGarantie AS bons ';
        $sql .= 'JOIN '.PFX.'users AS users ON users.idUser = bons.idClient ';
        $sql .= 'WHERE ticketCaisse = :ticketCaisse ';

        $requete = $connexion->prepare($sql);

        $requete->bindParam(':ticketCaisse', $ticketCaisse, PDO::PARAM_INT);

        $ligne = array();
        $resultat = $requete->execute();
        
        if ($resultat){
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            $ligne = $requete->fetch();
            }

        Application::DeconnexionPDO($connexion);

        return $ligne;
    }

    /**
     * Enregistre les paramètes essentiels d'un bon de garantie
     * issus du formulaire idoine
     * 
     * @param array $form
     * 
     * @return int : numéro du bon de garantie
     */
    public function saveDataBonGarantie($form){
        $idClient = isset($form['idClient']) ? $form['idClient'] : Null;
        $ticketCaisse = isset($form['ticketCaisse']) ? $form['ticketCaisse'] : Null;
        $dateGarantie = isset($form['dateGarantie']) ? $form['dateGarantie'] : Null;

        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        if ($idClient != Null) {
            // c'est une garantie nominative
            $sql = 'INSERT INTO '.PFX.'bonsGarantie ';
            $sql .= 'SET idClient = :idClient, ticketCaisse = :ticketCaisse, date = :dateGarantie ';
            $sql .= 'ON DUPLICATE KEY update date = :dateGarantie ';
        }
        else {
            // c'est une garantie anonyme
            $sql = 'INSERT INTO '.PFX.'bonsGarantie ';
            $sql .= 'SET ticketCaisse = :ticketCaisse, date = :dateGarantie ';
            $sql .= 'ON DUPLICATE KEY update date = :dateGarantie ';
        }
        $requete = $connexion->prepare($sql);

        if ($idClient != Null)
            $requete->bindParam(':idClient', $idClient, PDO::PARAM_INT);
        $requete->bindParam(':ticketCaisse', $ticketCaisse, PDO::PARAM_STR, 10);
        $requete->bindParam(':dateGarantie', $dateGarantie, PDO::PARAM_STR, 10);

        $resultat = $requete->execute();

        if($resultat){
            $ticketCaisse = ($ticketCaisse == null) ? $connexion->lastInsertId() : $ticketCaisse;
        }
        $rows = $requete->rowCount();
        
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);

        return json_encode(array('ticketCaisse' => $ticketCaisse, 'rows' => $rows));

    }

    /**
     * Vérifie si le ticket $ticketCaisse est déjà attribué au client $idClient
     * 
     * @param string $ticketCaisse
     * @param int $idClient
     * 
     * @return bool
     */
    public function checkTicket4client($ticketCaisse){
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT * FROM '.PFX.'bonsGarantie ';
        $sql .= 'WHERE ticketCaisse = :ticketCaisse ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':ticketCaisse', $ticketCaisse, PDO::PARAM_STR, 10);

        $ligne = Null;
        $resultat = $requete->execute();

        if ($resultat){
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            $ligne = $requete->fetch();
            }

        Application::DeconnexionPDO($connexion);

        return $ligne != Null;
    }

  /**
   * Suppression d'un item d'un bon de garantie
   * 
   * @param int $idItem
   * 
   * @return int : le nombre de suppressions dans la base de données
   */
  public function delItemGarantie($idItem) {
    $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
    $sql = 'DELETE FROM '.PFX.'bonsGarantieItems ';
    $sql .= 'WHERE id = :idItem ';
    $requete = $connexion->prepare($sql);

    $requete->bindParam(':idItem', $idItem, PDO::PARAM_INT);

    $resultat = $requete->execute();

    $n = 0;
    if ($resultat) {
        $n = $requete->rowCount();
    }

    Application::DeconnexionPDO($connexion);

    return $n;
  }

  /**
   * retourne les détails de l'item unique $idItem
   * 
   * @param int $idItem
   * 
   * @return array
   */
  public function getDataItemGarantie($idItem){
    $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
    $sql = 'SELECT id, ox, ref, materiel, prix, remarque ';
    $sql .= 'FROM '.PFX.'bonsGarantieItems ';
    $sql .= 'WHERE id = :idItem ';
    $requete = $connexion->prepare($sql);

    $requete->bindParam(':idItem', $idItem, PDO::PARAM_INT);

    $ligne = Null;
    $resultat = $requete->execute();
    if ($resultat) {
        $requete->setFetchMode(PDO::FETCH_ASSOC);
        $ligne = $requete->fetch();
    }

    Application::DeconnexionPDO($connexion);

    return $ligne;
  }

  /**
   * enregistre le formulaire d'édition d'un item d'une garantie
   * et renvoie l'idItem correspondant
   * 
   * @param array $form
   * 
   * @return  int $idItem 
   */
  public function saveDataItemGarantie($form){
    $ticketCaisse = isset($form['ticketCaisse']) ? $form['ticketCaisse'] : Null;
    $idItem = isset($form['idItem']) ? $form['idItem'] : Null;
    $ox = isset($form['ox']) ? $form['ox'] : Null;
    $ref = isset($form['ref']) ? $form['ref'] : Null;
    $materiel = isset($form['materiel']) ? $form['materiel'] : Null;
    $prix = isset($form['prix']) ? $form['prix'] : Null;
    $remarque = isset($form['remarque']) ? $form['remarque'] : Null;

    $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
    if ($idItem == Null) {
        $sql = 'INSERT INTO '.PFX.'bonsGarantieItems ';
        $sql .= 'SET ticketCaisse = :ticketCaisse, ox = :ox, ref = :ref, materiel = :materiel, prix = :prix, ';
        $sql .= 'remarque = :remarque ';
        $requete = $connexion->prepare($sql);
    }
    else {
        $sql = 'UPDATE '.PFX.'bonsGarantieItems ';
        $sql .= 'SET ticketCaisse = :ticketCaisse, ox = :ox, ref = :ref, materiel = :materiel, prix = :prix, ';
        $sql .= 'remarque = :remarque ';
        $sql .= 'WHERE id = :idItem ';
        $requete = $connexion->prepare($sql);
        $requete->bindParam(':idItem', $idItem, PDO::PARAM_INT);
    }
    
    $requete->bindParam(':ticketCaisse', $ticketCaisse, PDO::PARAM_STR, 10);
    $requete->bindParam(':ox', $ox, PDO::PARAM_STR, 8);
    $requete->bindParam(':ref', $ref, PDO::PARAM_STR, 30);
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
   * Effacement du bon de garantie $ticketCaisse
   * 
   * @param string $ticketCaisse
   * 
   * @return int : nombre d'effacements (1 ou 0)
   */
  public function delBonGarantie($ticketCaisse){
    $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
    $sql = 'DELETE FROM '.PFX.'bonsGarantie ';
    $sql .= 'WHERE ticketCaisse = :ticketCaisse ';
    $requete = $connexion->prepare($sql);

    $requete->bindParam(':ticketCaisse', $ticketCaisse, PDO::PARAM_STR, 10);

    $resultat = $requete->execute();

    $nb = 0;
    if ($resultat){
        $nb = $requete->rowCount();
    }

    Application::DeconnexionPDO($connexion);

    return $nb;
  }

  /**
   * Effacement de tous les bons de garantie imputés au client $idClient
   * 
   * @param int $idClient
   * 
   * @return int
   */
  public function delAllGaranties4client($idClient) {
    $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
    $sql = 'DELETE FROM '.PFX.'bonsGarantie ';
    $sql .= 'WHERE idClient = :idClient ';
    $requete = $connexion->prepare($sql);

    $requete->bindParam(':idClient', $idClient, PDO::PARAM_INT);

    $resultat = $requete->execute();

    $n = $requete->rowCount();

    Application::DeconnexionPDO($connexion);

    return $n;
  }

  /**
   * retourne la liste de tous les items présents dans le bon de garantie $idBonGarantie
   * 
   * @param int $idBonGarantie
   * 
   * @return array
   */
  public function getItems4ticketCaisse($ticketCaisse) {
    $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
    $sql = 'SELECT id, ox, ref, materiel, prix, remarque ';
    $sql .= 'FROM '.PFX.'bonsGarantieItems ';
    $sql .= 'WHERE ticketCaisse = :ticketCaisse ';
    $sql .= 'ORDER BY id ';
    $requete = $connexion->prepare($sql);

    $requete->bindParam(':ticketCaisse', $ticketCaisse, PDO::PARAM_STR, 10);

    $listeItems = array();
    $resultat = $requete->execute();
    if ($resultat) {
        $requete->setFetchMode(PDO::FETCH_ASSOC);
        while ($ligne = $requete->fetch()) {
            $id = $ligne['id'];
            $listeItems[$id] = $ligne;
        }
    }

    Application::DeconnexionPDO($connexion);

    return $listeItems;
  }

  /**
   * retourne la liste des marchandises disponibles dans la table ox_inventaire
   * 
   * @param 
   * 
   * @return array
   */
  public function getListeMarchandise(){
    $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
    $sql = 'SELECT idMateriel, marque, modele, caracteristiques, prix ';
    $sql .= 'FROM '.PFX.'inventaire ';
    $sql .= 'ORDER BY marque, modele, prix ';
    $requete = $connexion->prepare($sql);

    $liste = array();
    $resultat = $requete->execute();

    if ($resultat){
        $requete->setFetchMode(PDO::FETCH_ASSOC);
        while ($ligne = $requete->fetch()){
            $id = $ligne['idMateriel'];
            $liste[$id] = $ligne;
        }
    }

    Application::DeconnexionPDO($connexion);

    return $liste;
  }

  /**
   * renvoie les caractéristiques de la marchandise $idMateriel dans ox_inventaire
   * 
   * @param int $idMateriel
   * 
   * @return array
   */
  public function getMateriel4id($idMateriel){
    $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
    $sql = 'SELECT idMateriel, marque, modele, caracteristiques, prix ';
    $sql .= 'FROM '.PFX.'inventaire ';
    $sql .= 'WHERE idMateriel = :idMateriel ';
    $requete = $connexion->prepare($sql);

    $materiel = array();

    $requete->bindParam(':idMateriel', $idMateriel, PDO::PARAM_INT);

    $resultat = $requete->execute();
    if ($resultat) {
        $requete->setFetchMode(PDO::FETCH_ASSOC);
        $materiel = $requete->fetch();
    }

    Application::DeconnexionPDO($connexion);

    return $materiel;
  }

  /**
   * renvoie le texte des conditions particulières pour le ticket de caisse $ticketCaisse
   * 
   * @param string $ticketCaisse
   * @param string $typeCondPart
   * 
   * @return string
   */
  public function getConditionsPart($ticketCaisse) {
    $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
    $sql = 'SELECT ticketCaisse, texte, typeCondPart ';
    $sql .= 'FROM '.PFX.'bonsGarantieCondPart  ';
    $sql .= 'WHERE ticketCaisse = :ticketCaisse ';
    $requete = $connexion->prepare($sql);

    $requete->bindParam(':ticketCaisse', $ticketCaisse, PDO::PARAM_STR, 10);

    // initialisation -------------------------------
    $condPart = array('ticketCaisse' => $ticketCaisse, 'texte' => '', 'typeCondPart' => '');

    $resultat = $requete->execute();
    if ($resultat) {
        $requete->setFetchMode(PDO::FETCH_ASSOC);
        $condPart = $requete->fetch();
    }

    Application::DeconnexionPDO($connexion);

    return $condPart;
  }

  /**
   * Enregistre le $texte des conditions particulières pour le ticket $ticketCaisse
   * 
   * @param string $ticketCaisse
   * @param string $texte
   * 
   * @return int (nombre d'insertions)
   */
  public function saveConditionsPart($ticketCaisse, $typeCondPart, $texte){
    $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
    $sql = 'INSERT INTO '.PFX.'bonsGarantieCondPart ';
    $sql .= 'SET ticketCaisse = :ticketCaisse, typeCondPart = :typeCondPart, texte = :texte ';
    $sql .= 'ON DUPLICATE KEY UPDATE texte = :texte, typeCondPart = :typeCondPart ';
    $requete = $connexion->prepare($sql);

    $requete->bindParam(':ticketCaisse', $ticketCaisse, PDO::PARAM_STR, 10);
    $requete->bindParam(':typeCondPart', $typeCondPart, PDO::PARAM_STR);
    $requete->bindParam(':texte', $texte, PDO::PARAM_STR);

    $resultat = $requete->execute();

    $rows = $requete->rowCount();

    Application::DeconnexionPDO($connexion);

    return $rows;
  }

  /**
   * Effacement de la condition particulière de vente du $ticketCaisse
   * 
   * @param string $tickeCaisse
   * 
   * @return int
   */
  public function delConditionPart($ticketCaisse){
    $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
    $sql = 'DELETE FROM '.PFX.'bonsGarantieCondPart ';
    $sql .= 'WHERE ticketCaisse = :ticketCaisse ';
    $requete = $connexion->prepare($sql);

    $requete->bindParam(':ticketCaisse', $ticketCaisse, PDO::PARAM_STR, 10);

    $resultat = $requete->execute();

    $nb = $requete->rowCount();

    Application::DeconnexionPDO($connexion);

    return $nb;
  }

}