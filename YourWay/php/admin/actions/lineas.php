<?php

    include "../../common/config.php";
    include "../../common/mysql.php";

    $database = $config['database'];
    $c = Connect($database);
    $salida = array();

    $c->query("set names utf8");

    // Selecciono las líneas, con sus paradas ordenadas
    $sql = "SELECT numero, nombre FROM linea;";

    $rows = $c->query($sql);

    $salida = $rows->fetch_all(MYSQLI_ASSOC);
    echo json_encode($salida);

    $c->close();
?>