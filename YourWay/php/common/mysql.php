<?php
    // Conectar a la base de datos
    function Connect($a){
        $c = new mysqli($a['host'], $a['username'], $a['password'], $a['database']);
        return $c;
    }


    // Inserts, Deletes y Updates
    function Execute($sql, $c){
        $return = mysqli_query($c, $sql);
    }

    // Selects
    function ExecuteQuery($sql, $c){
        $salida = array();
        $c->query("set names utf8");
        $resultado = $c->query($sql);
        $salida = $resultado->fetch_all(MYSQLI_ASSOC);
        echo json_encode($salida);
        $c->close();
    }

    function Close($c) 
    {
      $c->close();
      unset ($c);
    }

?>