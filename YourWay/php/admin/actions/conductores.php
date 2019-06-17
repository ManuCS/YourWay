<?php

include "../../common/config.php";
include "../../common/mysql.php";

$database = $config['database'];
$c = Connect($database);
$salida = array();

$c->query("set names utf8");

// Selecciono las líneas, con sus paradas ordenadas
$sql = "SELECT C.nombre, C.user, C.correo, C.dni, A.matricula, A.numero linea, BC.fecha_inicio, BC.fecha_fin FROM bus_conductor BC
INNER JOIN conductor C on BC.conductor_dni = C.dni
INNER JOIN autobus A on BC.autobus_matricula = A.matricula
ORDER BY BC.fecha_inicio;";

$rows = $c->query($sql);

$salida = $rows->fetch_all(MYSQLI_ASSOC);
echo json_encode($salida);


$c->close();