<?php

    include "../../common/config.php";
    include "../../common/mysql.php";

    $database = $config['database'];
    $c = Connect($database);

    $nombre = $_POST['nombre'];
    $pass = md5($_POST['password']);
    $user = $_POST['user'];
    $dni = $_POST['dni'];
    $email = $_POST['email'];
    
    $sql = "INSERT INTO conductor(dni, nombre, user, pass, correo) VALUES('$dni', '$nombre', '$user', $pass, '$email');
    ";    
    $c->query($sql);
    echo "200";  

?>