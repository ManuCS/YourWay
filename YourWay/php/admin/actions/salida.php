<?php

    include "../../common/config.php";
    include "../../common/mysql.php";

    $database = $config['database'];
    $c = Connect($database);
    $salida = array();

    $linea = $_GET['linea'];

    $c->query("set names utf8");

    // Selecciono las líneas, con sus paradas ordenadas
    $sql = "SELECT S.hora, S.dia from salida S, linea L where S.id_linea = L.id AND L.id = $linea";

    $rows = $c->query($sql);

    $salida = $rows->fetch_all(MYSQLI_ASSOC);
    echo json_encode($salida);

    $c->close();
?>