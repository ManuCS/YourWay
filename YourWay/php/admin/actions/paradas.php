<?php

include "../../common/config.php";
include "../../common/mysql.php";

$database = $config['database'];
$c = Connect($database);
$salida = array();

$linea = $_GET['linea'];

$c->query("set names utf8");

// Selecciono las líneas, con sus paradas ordenadas
$sql = "SELECT L.numero, L.nombre linea, P.nombre parada, P.latitud, P.longitud, LP.orden, LP.duracion FROM linea_parada LP 
        INNER JOIN LINEA L on LP.linea_id = L.id INNER JOIN parada P ON LP.parada_id = P.id WHERE L.id = $linea ORDER BY LP.orden";

$rows = $c->query($sql);

$salida = $rows->fetch_all(MYSQLI_ASSOC);
echo json_encode($salida);

$c->close();
