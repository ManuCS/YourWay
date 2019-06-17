<?php
    session_start();

    include "../../common/config.php";
    include "../../common/mysql.php";

    $database = $config['database'];
    $c = Connect($database);
    $salida = array();

    $user = $_POST['user'];
    $pass = md5($_POST['password']);
    $admin = $_POST['admin'];

    $c->query("set names utf8");

    if($admin == "true"){
        $sql = "SELECT useradmin, pass FROM administrador WHERE pass = '$pass' AND useradmin = '$user';";
        $rows = $c->query($sql);
        $salida = $rows->fetch_all(MYSQLI_ASSOC);
        if(sizeof($salida) > 0){
            $_SESSION['user']=$salida[0]['useradmin'];
            echo "success";
        }
        else{
            echo "fail";
        }
    }
    else{
        $sql = "SELECT user, pass FROM conductor WHERE pass = '$pass' AND user = '$user';";
        $rows = $c->query($sql);
        $salida = $rows->fetch_all(MYSQLI_ASSOC);
        if(sizeof($salida) > 0){
            $_SESSION['user']=$salida[0]['user'];
            echo "success";
        }
        else{
            echo "fail";
        }
    }

    $c->close();
?>