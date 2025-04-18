<?php
// parametres de connexion
$url = "https://raw.githubusercontent.com/dominionboy/disquaire/main/disquaire.sql"; //lien raw vers code sql

$localFile = "fichier_local.sql"; // création d'un fichier qui contiendra la base qui sera download depuis github
$host = "localhost";
$port = 3306;  //regarder sur MAMP quel est le port mysql et le mettre ici
$user = "root";
$pass = "root";
$db = "disquaire_db"; // nom de la base du projet sur votre mamp

// telechargement du fichier disquaire.sql depui github
file_put_contents($localFile, file_get_contents($url));

//bloc d'execution frero
$mysqlPath = "C:\\MAMP\\bin\\mysql\\bin\\mysql.exe"; // chemin vers fichier executable my sql
$cmd = "\"$mysqlPath\" -h $host -P $port -u $user -p$pass $db < $localFile";

exec($cmd . " 2>&1", $output, $return_var); // execution et recup des erreurs

if ($return_var === 0) {
    echo "✅ Base de données '$db' mise à jour.";
} else {
    echo "❌ Une erreur est survenue : <br>";
    echo "<pre>" . htmlspecialchars(implode("\n", $output)) . "</pre>"; // sors les erreurs
}

?>