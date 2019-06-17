<?php 
    //Inicio la sesión
    session_start();
    //Si no hay una sesión creada / no se ha loggeado, devuelvo a la página principal
    if(!isset($_SESSION['user'])){
        header('location: ../../../index.html');
    }

    //Si pulso logout, finalizo la sesión y redirecciono a la página principal
    if(isset($_POST['logout'])){
        unset($_SESSION['user']);
        session_destroy($_SESSION['user']);
        header('location: ../../../');
    }
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>YourWay</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> 

    <link rel="stylesheet" href="../../../assets/css/style.css" media="all">
    <link rel="stylesheet" href="../../../assets/css/main.css" media="all">
	<link rel="stylesheet" href="../../../assets/css/bootstrap.css" media="all">
    <link rel="stylesheet" href="../../../assets/fontawesome/css/all.css">

    <script src="../../../assets/js/jquery-3.4.1.min.js"></script>
    
    <script>
        $(document).ready(function(){
            let user = "<?php echo $_SESSION['user']?>";
            $(".login .user .name").text(user);

            GetConductores();

        });

        function GetConductores(){
            $.ajax({
                url: "../../../php/admin/actions/conductores.php",
                method: "GET",
                dataType: "json",
                error: function (error) { alert("Error en su petición: " + error) },
                success: function (data) {
                    let conductores = data;
                    SetConductores(conductores);
                }
            });
        }

        function SetConductores(conductores){
            let text = "";

            for(let i = 0; i < conductores.length; i++){
                text += `<tr>`;
                text += `<td>${conductores[i].nombre}</td>`;
                text += `<td>${conductores[i].user}</td>`;
                text += `<td>${conductores[i].dni}</td>`;
                text += `<td>${conductores[i].correo}</td>`;
                text += `<td>
                            <table>
                                <tr>
                                    <th>Bus</th>
                                    <th>Fecha inicio</th>
                                    <th>Fecha Fin</th>
                                </tr>
                                <tr>
                                    <td>${conductores[i].matricula}</td>
                                    <td>${conductores[i].fecha_inicio}</td>`
                                    if(conductores[i].fecha_fin === null){
                                        text+= "<td>-</td>";
                                    }
                                    else{
                                        text += `<td>${conductores[i].fecha_fin}</td>`;
                                    }

                        text += `</tr>
                            </table></td>`;
            }
            $("table.conductores").append(text);
        }


    </script>
</head>

<body>


    
<header class="cmp-header">
    <div class="logo">
         <a href="#"><img alt="YourWay" src="../../../assets/img/logo/YourWay.png"></a>
    </div>
    <div class="login">
        <span class="user">
            <i class="fal fa-user-crown"></i>
            <span class="name">Manuel</span>
            <form method='post'>
                <input name='logout' type='submit' value='Cerrar sesión'>
            </form>
        </span>
    </div>
</header>


<section class="cmp-admin-content">
    <h2>Conductores</h2>
    <table class="conductores">
        <tr class="cabecera">
            <th>Conductor</th>
            <th>Usuario</th>
            <th>DNI</th>
            <th>Email</th>
            <th>Autobuses</th>
        </tr>
        <!-- <tr>
            <td>Pepe</td>
            <td>Pepin</td>
            <td>16738490D</td>
            <td>pepe@bus.com</td>
            <td>
                <table>
                    <tr>
                        <th>Bus</th>
                        <th>Fecha inicio</th>
                        <th>Fecha Fin</th>
                    </tr>
                    <tr>
                        <td>Bus</td>
                        <td>28/05/10</td>
                        <td>29/05/10</td>
                    </tr>
                </table>
            </td>
        </tr> -->
    </table>
</section>





</body>

</html>