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
<html lang="es">
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
        //Aquí voy a poner los datos reales traídos de la bd
        $(document).ready(function(){
            //funcionalidad de aparecer/desaparecer
            $(".cmp-drivermain .profile ul li").click(function(){
                $(this).children(".hide").slideToggle();
                $(this).find(".down").toggleClass("rotate");
            });

            GetProfile();

            $(".cmp-drivermain .start-route button").click(StartRoute);

        });

        function GetProfile(){
            //Recojo el user
            let usuario = "<?php echo $_SESSION['user']; ?>";
            $.ajax({
                url: "../../../php/admin/actions/conductor.php",
                method: "GET",
                dataType: "json",
                data: {user: usuario},
                error: function (error) { alert("Error en su petición: " + error) },
                success: function (data) {
                    let profile = data;
                    SetProfile(profile);
                }
            });
        }

        let perfil;
        function SetProfile(profile){
            perfil = profile; 
            $(".cmp-header .login .name").text(perfil[0].user);
            $(".cmp-drivermain .profile .name").text(perfil[0].nombre);
            $(".cmp-drivermain .profile .user").text(perfil[0].user);
            $(".cmp-drivermain .profile .email").text(perfil[0].correo);
            $(".cmp-drivermain .profile .dni").text(perfil[0].dni);

            let textBus = "<tr><th>Autobús</th><th>Fecha Inicio</th><th>Fecha Fin</th>";
            let lines = [];
            for(let i = 0; i < perfil.length; i++){
                textBus += "<tr>";
                textBus += `<td>${perfil[i].matricula}</td>`;
                let array = perfil[i].fecha_inicio.split('-');
                textBus+=`<td>${array[2]}-${array[1]}-${array[0]}</td>`;
                if(perfil[i].fecha_fin == null){
                    textBus += "<td>-</td>";
                }
                else{
                    let array2 = perfil[i].fecha_fin.split('-');
                    textBus+=`<td>${array2[2]}-${array2[1]}-${array2[0]}</td>`
                }

                if(lines.indexOf(perfil[i].linea) == -1){
                    lines.push(perfil[i].linea);
                }
            }

            let textLines = "";
            let optionLines = "";
            for(let i = 0; i < lines.length; i++){
                textLines += `<li>Línea ${lines[i]}</li>`;
                optionLines += `<option value='${lines[i]}'>Línea ${lines[i]}</option>`;
            }
            
            $(".cmp-drivermain .profile .buslist .hide").html(textBus);
            $(".cmp-drivermain .profile .linelist .hide").html(textLines);
            $(".cmp-drivermain .start-route #line").html(optionLines);

        }

        let line;
        let matricula;
        function StartRoute(){
            line = parseInt($(".cmp-drivermain .start-route #line").val());
            matricula = perfil[perfil.length - 1].matricula;
            let horaActual = new Date();
            let hora = `${horaActual.getHours()}:${horaActual.getMinutes()}:${horaActual.getSeconds()}`;


            $.ajax({
                url: "../../../php/admin/actions/insertaRuta.php",
                method: "POST",
                data: {linea: line, matricula: matricula, hora: hora, comienza: true},
                error: function (error) { alert("Error en su petición: " + error) },
                success: function (data) {
                    $(".cmp-drivermain .start-route .content").html("<form onsubmit='return false'><button class='btn' onclick='PostParadas()'>Llego a la parada</button><span>Pulsa para registrar la hora de llegada a la parada.</span><button class='btn finish' onclick='FinishRoute()'>Terminar</button><span>Pulsa aquí cuando llegues a la <strong>última parada</strong> para terminar el recorrido.</span></form>");
                    $(".cmp-drivermain .start-route h2").text("¡Que tengas un buen viaje!");
                }
            })
        }

        function PostParadas(){
            let horaActual = new Date();
            let hora = `${horaActual.getHours()}:${horaActual.getMinutes()}:${horaActual.getSeconds()}`;

            $.ajax({
                url: "../../../php/admin/actions/insertaRuta.php",
                method: "POST",
                data: {linea: line, matricula: matricula, hora: hora},
                error: function (error) { alert("Error en su petición: " + error) },
                success: function (data) {
                    alert(data);
                }
            });
        }

        function FinishRoute(){
            let horaActual = new Date();
            let hora = `${horaActual.getHours()}:${horaActual.getMinutes()}:${horaActual.getSeconds()}`;
            $.ajax({
                url: "../../../php/admin/actions/insertaRuta.php",
                method: "POST",
                data: {linea: line, matricula: matricula, hora: hora, termina: true},
                error: function (error) { alert("Error en su petición: " + error) },
                success: function (data) {
                    alert(data);
                    $(".cmp-drivermain .start-route .content").html("<form onsubmit='return false'><label>Elige tu línea de bus: <select name='line' id='line'></select></label><button class='btn' onclick='StartRoute()'>Empieza el recorrido</button><span>¡Que tengas un buen viaje!</span></form>");
                    GetProfile();
                }
            });
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
            <i class="fal fa-bus"></i>
            <span class="name">Manuel</span>
            <form method='post'>
                <input name='logout' type='submit' value='Cerrar sesión'>
            </form>
        </span>
    </div>
</header>

<section class="cmp-drivermain">
    <div class="start-route">
        <h2>¿Empiezas nueva ruta?</h2>
        <div class="content">
            <form onsubmit="return false">
                <label>Elige tu línea de bus:
                    <select name="line" id="line">
                        <!-- <option value="1">Línea 1</option> -->
                    </select>
                </label>

                <button class="btn">Empieza el recorrido</button>
            </form>
            <span>¡Que tengas un buen viaje!</span>
        </div>
    </div>
    <div class="profile">
        <h2>Perfil de conductor</h2>
        <ul>
            <li>Nombre:
                <span class="name"></span>
            </li>
            <li>Usuario:
                <span class="user"></span>
            </li>
            <li>Email:
                <span class="email"></span>
            </li>
            <li>DNI:
                <span class="dni"></span>
            </li>
            <li class="buslist">Autobuses
                <i class="fal fa-chevron-down down"></i>
                <table class="hide">
                    <tr>
                        <th>Autobús</th>
                        <th>Fecha Inicio</th>
                        <th>Fecha Fin</th>
                    </tr>
                </table>
            </li>
            <li class="linelist">Lineas
                <i class="fal fa-chevron-down down"></i>
                <ul class="hide">
                </ul>
            </li>
        </ul>
    </div>
</section>
</body>

</html>