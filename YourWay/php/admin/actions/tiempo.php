<?php

    include "../../common/config.php";
    include "../../common/mysql.php";

    $database = $config['database'];
    $c = Connect($database);
    $salida = array();

    $linea = $_GET['linea'];

    $c->query("set names utf8");

    // Selecciono las líneas, con sus paradas ordenadas
    $sql = "SELECT L.numero, L.nombre linea, P.nombre parada, LA.hora_llegada, LA.autobus_matricula
    FROM linea_autobus LA 
    INNER JOIN LINEA L on LA.linea_id = L.id 
    INNER JOIN parada P ON LA.num_parada = P.id 
    WHERE L.id = $linea ORDER BY LA.hora_llegada;";

    $rows = $c->query($sql);

    $salida = $rows->fetch_all(MYSQLI_ASSOC);
    echo json_encode($salida);

    $c->close();
?>