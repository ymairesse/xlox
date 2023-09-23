<?php

class Application
{
    public function __construct()
    {
        self::lireConstantes();
        // sorties PHP en français
        setlocale(LC_ALL, 'fr_FR.utf8');
    }

    /**
     * relire les constantes de l'application
     *
     * @param
     *
     * @return array : constantes globales
     */
    public static function lireConstantes()
    {
        // lecture des paramètres généraux dans le fichier .ini, y compris la constante "PFX"
        $constantes = parse_ini_file(INSTALL_DIR.'/config.ini');

        foreach ($constantes as $key => $value) {
            define("$key", $value);
        }

        // lecture dans la table PFX."config" de la BD
        $connexion = self::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT parametre, valeur ';
        $sql .= 'FROM '.PFX.'config ';
        $requete = $connexion->prepare($sql);

        $resultat = $requete->execute();
        if ($resultat) {
            while ($ligne = $requete->fetch()) {
                $key = $ligne['parametre'];
                $valeur = $ligne['valeur'];
                define("$key", $valeur);
            }
        } else {
            die('config table not present');
        }
        self::DeconnexionPDO($connexion);
    }


    /**
     * afficher proprement le contenu d'une variable précisée
     * le programme est éventuellement interrompu si demandé.
     *
     * @param :    $data n'importe quel tableau ou variable
     * @param bool $die  : si l'on souhaite interrompre le programme avec le dump
     *
     * @return string
     */
    public static function afficher($data, $die = false)
    {
        if (func_num_args() > 0) {
            $data = func_get_args();
        }

        foreach ($data as $wtf => $unData) {
            echo '<pre>';
            var_export($unData);
            echo '</pre>';
        }
        if ($die == true) {
            die();
        }
    }
    public static function afficherSilent($data, $die = false)
    {
        foreach ($data as $wtf => $unData) {
            echo '<!-- ';
            echo '<pre>';
            var_export($unData);
            echo '</pre>';
            echo ' -->';
        }
        if ($die == true) {
            die();
        }
    }

    /**
     * Connexion à la base de données précisée.
     *
     * @param string PARAM_HOST : serveur hôte
     * @param string PARAM_BD : nom de la base de données
     * @param string PARAM_USER : nom d'utilisateur
     * @param string PARAM_PWD : mot de passe
     *
     * @return 
     */
    public static function connectPDO($host, $bd, $user, $mdp)
    {
        try {
            // indiquer que les requêtes sont transmises en UTF8
            // INDISPENSABLE POUR EVITER LES PROBLEMES DE CARACTERES ACCENTUES
            $connexion = new PDO(
                'mysql:host='.$host.';dbname='.$bd,
                $user,
                $mdp,
                array(PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8')
            );
        } catch (Exception $e) {
            $date = date('d/m/Y H:i:s');
            echo "<style type='text/css'>";
            echo '.erreurBD {width: 500px; margin-left: auto; margin-right: auto; border: 1px solid red; padding: 1em;}';
            echo '.erreurBD .erreur {color: green; font-weight: bold}';
            echo '</style>';

            echo "<div class='erreurBD'>";
            echo '<h3>A&iuml;e, a&iuml;e, a&iuml;e... Caramba...</h3>';
            echo "<p>Une erreur est survenue lors de l'ouverture de la base de donn&eacute;es.<br>";
            echo "Si vous &ecirc;tes l'administrateur et que vous tentez d'installer le logiciel, veuillez v&eacute;rifier le fichier config.inc.php </p>";
            echo "<p>Si le probl&egrave;me se produit durant l'utilisation r&eacute;guli&egrave;re du programme, essayez de rafra&icirc;chir la page (<span style='color: red;'>touche F5</span>)<br>";
            echo "Dans ce cas, <strong>vous n'&ecirc;tes pour rien dans l'apparition du souci</strong>: le serveur de base de donn&eacute;es est sans doute trop sollicit&eacute;...</p>";
            echo "<p>Veuillez rapporter le message d'erreur ci-dessous &agrave; l'administrateur du syst&egrave;me.</p>";
            echo "<p class='erreur'>Le $date, le serveur dit: ".$e->getMessage().'</p>';
            echo '</div>';
            die();
        }

        return $connexion;
    }

    /**
     * Déconnecte la base de données.
     *
     * @param $connexion
     */
    public static function DeconnexionPDO($connexion)
    {
        $connexion = null;
    }

   /**
     * convertir les dates au format usuel jj/mm/AAAA en YY-mm-dd pour MySQL.
     *
     * @param string $date date au format usuel
     *
     * @return string date au format MySQL
     */
    public static function dateMysql($date)
    {
        $dateArray = explode('/', $date);
        $sqlArray = array_reverse($dateArray);
        $date = implode('-', $sqlArray);

        return $date;
    }

    /**
     * convertir les date au format MySQL vers le format usuel.
     *
     * @param string $date date au format MySQL
     *
     * @return string date au format usuel français
     */
    public static function datePHP($dateMysql)
    {
        $dateArray = explode('-', $dateMysql);
        $phpArray = array_reverse($dateArray);
        $date = implode('/', $phpArray);

        return $date;
    }


    /**
     * renvoie les informations d'identification réseau
     *
     * @param void
     *
     * @return array ip, hostname, date, heure
     */
    public function getNetid() {
        $data = array();
        $data['ip'] = $_SERVER['REMOTE_ADDR'];
        $data['hostname'] = gethostbyaddr($_SERVER['REMOTE_ADDR']);
        $data['date'] = date('d/m/Y');
        $data['heure'] = date('H:i');

        return $data;
    }


    /**
       * recherche les données d'identité d'un utilisateur dont on fournit l'adresse mail
       *
       * @param string $mail
       *
       * @return array
       */
    public function getInfoUser($mail)
    {
        $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
        $sql = 'SELECT nom, prenom, mail, statut ';
        $sql .= 'FROM users ';
        $sql .= 'WHERE mail = :mail ';
        $requete = $connexion->prepare($sql);

        $requete->bindParam(':mail', $mail, PDO::PARAM_STR, 60);
        $ligne = array();
        $resultat = $requete->execute();
        if ($resultat) {
            $requete->setFetchMode(PDO::FETCH_ASSOC);
            $ligne = $requete->fetch();
        }

        Application::deconnexionPDO($connexion);

        return $ligne;
    }


     /**
      * enregistre les données "user" admin dans la BD
      *
      * @param string $nom
      * @param string $mail
      * @param string $md5Passwd
      *
      * @return boolean
      */
     public function saveUser($nom, $prenom, $mail, $md5Passwd, $passwd)
     {
         $connexion = Application::connectPDO(SERVEUR, BASE, NOM, MDP);
         $sql = 'INSERT INTO users ';
         $sql .= 'SET nom = :nom, prenom = :prenom, mail = :mail, md5passwd = :md5Passwd, ';
         $sql .= 'passwd = :passwd ';
         $requete = $connexion->prepare($sql);

         $requete->bindParam(':mail', $mail, PDO::PARAM_STR, 60);
         $requete->bindParam(':nom', $nom, PDO::PARAM_STR, 40);
         $requete->bindParam(':prenom', $prenom, PDO::PARAM_STR, 40);
         $requete->bindParam(':md5Passwd', $md5Passwd, PDO::PARAM_STR, 40);
         $requete->bindParam(':passwd', $passwd, PDO::PARAM_STR, 9);

         $resultat = $requete->execute();

         Application::deconnexionPDO($connexion);

         return $resultat;
     }


     /**
      * fixe un captcha sous forme de lettres et chiffres
      *
      * @param int $nbSignes : nombre de signes souhaités
      *
      * @return string : la captcha
      */
      public function getLettersCaptcha($nbSignes){
        // caractères utilisables
        $pioche = 'ABCDEFGHIJKLMNPQRSTUVWXYZ123456789';

        $count = 0;
        $captcha = '';
        while ($count < $nbSignes) {
            $captcha .= substr($pioche, mt_rand(0, strlen($pioche)-1), 1);
            $count++;
            }

        return $captcha;
    }


}
