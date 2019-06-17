<?php

    include "../../common/config.php";
    include "../../common/mysql.php";

    $database = $config['database'];
    $c = Connect($database);

    $linea = $_POST['linea'];
    $matricula = $_POST['matricula'];
    $hora = $_POST['hora'];

    if(isset($_POST['comienza'])){
        $sql = "INSERT INTO linea_autobus(linea_id, autobus_matricula, hora_llegada, num_parada) VALUES($linea, '$matricula', '$hora', 1);";    
        $c->query($sql);
        echo "200";
    }
    else{
        $parada = $c->query("SELECT num_parada parada FROM `linea_autobus` WHERE hora_llegada = (SELECT MAX(hora_llegada) FROM linea_autobus WHERE linea_id = $linea)");
        $siguiente = $parada->fetch_all(MYSQLI_ASSOC);
        
        $paradasLinea = $c->query("SELECT COUNT(linea_id) numLineas FROM linea_parada WHERE linea_id = $linea;");
        $paradasTotal = $paradasLinea->fetch_all(MYSQLI_ASSOC);
        $paradaActual = $siguiente[0]['parada'];
        $numParadas = $paradasTotal[0]['numLineas'];

        if(isset($_POST['termina'])){
            $sql = "INSERT INTO linea_autobus(linea_id, autobus_matricula, hora_llegada, num_parada) VALUES($linea, '$matricula', '$hora', $numParadas);";    
            $c->query($sql);
            echo "¡Buen trabajo!";            
        }
        else{
            if($paradaActual < $numParadas - 1){
                $paradaActual = $paradaActual + 1;
                $sql = "INSERT INTO linea_autobus(linea_id, autobus_matricula, hora_llegada, num_parada) VALUES($linea, '$matricula', '$hora', $paradaActual);";    
                $c->query($sql);
                echo $paradaActual." de ".$numParadas;
            }
            else{
                if(isset($_POST['termina'])){
                    $sql = "INSERT INTO linea_autobus(linea_id, autobus_matricula, hora_llegada, num_parada) VALUES($linea, '$matricula', '$hora', $numParadas);";    
                    $c->query($sql);
                    echo "¡Buen trabajo!";            
                }
                else{
                    echo "Hora no registrada. Es la última parada, pulsa TERMINAR.";
                }
            }
        }
    }
?>