$(document).ready(function () {
    GetLinea();

    //Funciones click para que se muestren las líneas o incidencias.
    $(".wrapper .lines").click(function () {
        $(".content .list").show();
        $(".content .stops-list").hide();
        $(".content .schedule-list").hide();
        $(this).addClass("active");
        $(".wrapper .schedule").removeClass("active");
        $(".wrapper .stops").removeClass("active");

    });
    $(".wrapper .schedule").click(function () {
        $(".content .list").hide();
        $(".content .stops-list").hide();
        $(".content .schedule-list").show();
        $(this).addClass("active");
        $(".wrapper .lines").removeClass("active");
        $(".wrapper .stops").removeClass("active");
    });
    $(".wrapper .stops").click(function () {
        $(".content .list").hide();
        $(".content .stops-list").show();
        $(".content .schedule-list").hide();
        $(this).addClass("active");
        $(".wrapper .schedule").removeClass("active");
        $(".wrapper .lines").removeClass("active");
    });


    //Inicializo el mapa con zoom en Jerez
    var map = L.map('mapid', {
        layers: MQ.mapLayer(),
        center: [36.69, -6.13],
        zoom: 14,
        minZoom: 7,
        attributionControl: true
    });

    L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 17
    }).addTo(map);
});


let salidas;
let salidasNormales = [];
let salidasFestivos = [];
let salidasSabados = [];
//Función que obtiene las paradas de una linea concreta
function GetParadas(linea) {
    let line = parseInt($(linea).attr("class"));
    $.ajax({
        url: "./php/admin/actions/paradas.php",
        method: "GET",
        dataType: "json",
        data: { linea: line },
        error: function (error) { alert("Error en su petición: " + error) },
        success: function (data) {
            let paradas = data;
            //Obtengo la hora a la que sale cada autobús de esa línea
            $.ajax({
                url: "./php/admin/actions/salida.php",
                method: "GET",
                dataType: "json",
                data: { linea: line },
                error: function (error) { alert("Error en su petición: " + error) },
                success: function (data) {
                    salidas = data;

                    for (let i = 0; i < salidas.length; i++) {
                        let array = salidas[i].hora.split(":");
                        let salida = new Date();
                        salida.setHours(array[0]);
                        salida.setMinutes(array[1]);
                        salida.setSeconds(array[2]);

                        if (salidas[i].dia == "n") {
                            salidasNormales.push(salida);
                        }
                        else if (salidas[i].dia == "s") {
                            salidasSabados.push(salida);
                        }
                        else {
                            salidasFestivos.push(salida);
                        }
                    }
                    ShowParadas(paradas);
                }
            });
        }
    });


}



//Muestra las paradas de una linea concreta
function ShowParadas(paradas) {
    let stops = paradas;

    //Elimino el contenedor, porque sino no puedo inicializar un nuevo map
    $("#mapid").remove();
    //Creo de nuevo el contenedor del map
    $(".mainpage").append("<div id='mapid'></div>");

    //Inicializo el map
    var map = L.map('mapid', {
        layers: MQ.mapLayer(),
        center: [36.69, -6.13],
        zoom: 14,
        minZoom: 7,
        attributionControl: true
    });

    L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 18
    }).addTo(map);

    //localizaciones de las paradas
    var locs = [];


    //Pongo las coordenadas de las paradas en locs, en su forma correcta (objeto)
    for (let i = 0; i < stops.length; i++) {
        let coord = { latLng: { lat: stops[i].latitud, lng: stops[i].longitud } };
        locs.push(coord);
    }

    //Direcciones
    var dir = MQ.routing.directions();

    //Creo la ruta
    dir.route({
        // locations: [{ latLng: { lat: 36.70104, lng: -6.13073 } }, ]
        locations: locs
    });


    //Creo el Marker personalizado
    CustomRouteLayer = MQ.Routing.RouteLayer.extend({
        createStopMarker: function (location, stopNumber) {
            var custom_icon,
                marker;

            custom_icon = L.icon({
                iconUrl: 'https://assets.mapquestapi.com/icon/v2/marker-' + stops[0].numero + '-red.png',
                iconSize: [20, 29],
                iconAnchor: [10, 29],
                popupAnchor: [0, -29]
            });

            marker = L.marker(location.latLng, { icon: custom_icon })
                .openPopup()
                .addTo(map);

            //Para cuando pinche en ese marcador se haga zoom sobre él
            marker.on('click', function (e) {
                map.setView(e.latlng, 20);
            });
            return marker;
        }
    });

    // Añado la ruta al map para que se muestre
    map.addLayer(new CustomRouteLayer({
        directions: dir,
        fitBounds: true,
        draggable: false,
        ribbonOptions: {
            draggable: false,
            ribbonDisplay: { color: 'blue', opacity: 0.5 },
        }
    }));


    //Preparo la lista de paradas    
    let listStops = `<h2><div class="lineimage">
        <div class="image"><i class="fal fa-bus"></i></div>
        <span>${stops[0].numero}</span>
    </div>${stops[0].linea}</h2>`;

    let durations = [];
    for (let i = 0; i < stops.length; i++) {
        //this para coger luego la clase y saber cuál es su orden
        listStops += `<li class='${stops[i].orden}'>${stops[i].parada} <span class='time'></span></li>`;
        durations.push(stops[i].duracion);
    }

    //Muestro la lista de paradas
    $(".content .list").hide();
    $(".content .stops-list").show().html(listStops);
    $(".wrapper .stops").addClass("active");
    $(".wrapper .lines").removeClass("active");


    let anteriorPulsada = [];
    $(".content .stops-list li").click(function () {
        if (anteriorPulsada.length > 0) {
            anteriorPulsada[0].removeClass("active");
            anteriorPulsada = [];
            $(this).addClass("active");
            anteriorPulsada.push($(this));
        }
        else {
            $(this).addClass("active");
            anteriorPulsada.push($(this));
        }


        let listClases = $(this).attr("class");
        let clases = listClases.split(" ");
        let orden = parseInt(clases[0]);

        //Busco dentro del objeto stops, la parada que tenga el mismo orden (dentro de la linea) que la clickada
        let parada = stops.find(stops => stops.orden == orden);

        //Guardo el objeto de sus coordenadas
        let latlng = { lat: parada.latitud, lng: parada.longitud };

        //Hago zoom en es parada
        map.setView(latlng, 20);

        $.ajax({
            url: "./php/admin/actions/tiempo.php",
            method: "GET",
            dataType: "json",
            data: { linea: stops[0].numero },
            error: function (error) { alert("Error en su petición: " + error) },
            success: function (data) {
                var llegadas = data;
                //Paso el array de llegadas, el array de horas de salida, array de paradas que hay en esa línea, 
                //y el orden que ocupa la parada pulsada dentro de esa línea
                SetTiempo(llegadas, stops, orden, durations);
            }
        });
    });

}

// Función que establece el tiempo estimado en el que el bus llegará a la parada pulsada.
function SetTiempo(llegadas, stops, orden, durations) {
    let busLoc;
    let bus;
    let busOrder;

    if (llegadas.length > 0) {
        busLoc = { llegada: llegadas[llegadas.length - 1].hora_llegada, parada: llegadas[llegadas.length - 1].parada };
        //Busco dentro del objeto paradas, la parada que coincida con la pulsada
        bus = stops.find(stops => stops.parada === busLoc.parada);
        busOrder = parseInt(bus.orden);
    }

    //Array de cuanto tarda en llegar el bus de una parada a otra.
    let duraciones = durations;
    var durationTimes = [];
    //Pongo las duraciones en formato tiempo
    for (let i = 0; i < duraciones.length; i++) {
        let array = duraciones[i].split(":");
        let duracion = new Date();
        duracion.setHours(array[0]);
        duracion.setMinutes(array[1]);
        duracion.setSeconds(array[2]);
        durationTimes.push(duracion);
    }


    //Hora actual del cliente al pulsar en la parada.
    let horaActual = new Date();

    //Orden que ocupa la parada pulsada dentro de las paradas, para saber qué parada es.
    let order = orden;


    //Inicializo las horas
    let horaSalida = new Date();
    let horaLlegada = new Date();


    //compruebo qué día de la semana es para el horario
    if (horaActual.getDay() < 6) {
        //Si es día entre semana
        if (horaActual.getDay() != 0) {
            for (let i = 0; i < salidasNormales.length; i++) {
                if (salidasNormales[i] > horaActual) {
                    horaSalida.setHours(salidasNormales[i].getHours());
                    horaSalida.setMinutes(salidasNormales[i].getMinutes());
                    horaSalida.setSeconds(salidasNormales[i].getSeconds());
                    break;
                }
            }
        }
        //Domingo
        else {
            for (let i = 0; i < salidasFestivos.length; i++) {
                if (salidasFestivos[i] > horaActual) {
                    horaSalida = salidasFestivos[i];
                    break;
                }
            }
        }
    }
    //Sábado
    else {
        for (let i = 0; i < salidasSabados.length; i++) {
            if (salidasSabados[i] > horaActual) {
                horaSalida = salidasSabados[i];
                break;
            }
        }
    }

    //Establezco el horario al que aproximadamente llegará cada autobús a esta parada en concreto
    //Laborales
    let horario = "<ul><span>Laborales</span>";

    for(let i = 0; i < salidasNormales.length; i++){
        let horas = salidasNormales[i].getHours();
        let minutos = salidasNormales[i].getMinutes();
        
        for (let j = 0; j < order; j++) {
            horas = horas + durationTimes[j].getHours();
            minutos = minutos + durationTimes[j].getMinutes();

            if (minutos > 59) {
                minutos = minutos - 60;
                horas = horas + 1;
            }
        }
        if (minutos < 10 && horas < 10) {
            horario += `<li>0${horas}:0${minutos}</li>`;
        }
        else if (horas >= 10 && minutos < 10) {
            horario += `<li>${horas}:0${minutos}</li>`;
        }
        else if (horas < 10 && minutos >= 10) {
            horario += `<li>0${horas}:${minutos}</li>`;
        } else {
            horario += `<li>${horas}:${minutos}</li>`;
        }
    }
    horario+="</ul>";

    //Sábados
    horario += "<ul><span>Sábados</span>";

    for(let i = 0; i < salidasSabados.length; i++){
        let horas = salidasSabados[i].getHours();
        let minutos = salidasSabados[i].getMinutes();
        
        for (let j = 0; j < order; j++) {
            horas = horas + durationTimes[j].getHours();
            minutos = minutos + durationTimes[j].getMinutes();

            if (minutos > 59) {
                minutos = minutos - 60;
                horas = horas + 1;
            }
        }

        if (minutos < 10 && horas < 10) {
            horario += `<li>0${horas}:0${minutos}</li>`;
        }
        else if (horas >= 10 && minutos < 10) {
            horario += `<li>${horas}:0${minutos}</li>`;
        }
        else if (horas < 10 && minutos >= 10) {
            horario += `<li>0${horas}:${minutos}</li>`;
        } else {
            horario += `<li>${horas}:${minutos}</li>`;
        }
    }
    horario+="</ul>";

    //Festivos
    horario += "<ul><span>Festivos</span>";
    for(let i = 0; i < salidasFestivos.length; i++){
        let horas = salidasFestivos[i].getHours();
        let minutos = salidasFestivos[i].getMinutes();
        
        for (let j = 0; j < order; j++) {
            horas = horas + durationTimes[j].getHours();
            minutos = minutos + durationTimes[j].getMinutes();

            if (minutos > 59) {
                minutos = minutos - 60;
                horas = horas + 1;
            }
        }
        if (minutos < 10 && horas < 10) {
            horario += `<li>0${horas}:0${minutos}</li>`;
        }
        else if (horas >= 10 && minutos < 10) {
            horario += `<li>${horas}:0${minutos}</li>`;
        }
        else if (horas < 10 && minutos >= 10) {
            horario += `<li>0${horas}:${minutos}</li>`;
        } else {
            horario += `<li>${horas}:${minutos}</li>`;
        }
    }
    horario+="</ul>";

    //Lo pongo en la sección de horario del menú principal
    $(".content .schedule-list").html(horario);

    //Si el la última parada del bus es posterior a la mía
    if (busOrder > order || busOrder == undefined) {

        //Obtengo la hora de salida dividida en horas, minutos y segundos para sumarle las duraciones
        let horas = horaSalida.getHours();
        let minutos = horaSalida.getMinutes();
        let segundos = horaSalida.getSeconds();

        //Sumo cuanto tarda aprox el bus en llegar a cada parada hasta 
        //la que se ha pulsado
        for (let i = 0; i < order; i++) {
            horas = horas + durationTimes[i].getHours();
            minutos = minutos + durationTimes[i].getMinutes();
            segundos = segundos + durationTimes[i].getSeconds();

            if (segundos > 59) {
                segundos = segundos - 60;
                minutos = minutos + 1;
            }
            if (minutos > 59) {
                minutos = minutos - 60;
                horas = horas + 1;
            }
        }

        //Pongo formato correcto a las horas
        let time;
        if (minutos < 10 && horas < 10) {
            time = `0${horas}:0${minutos}`;
        }
        else if (horas >= 10 && minutos < 10) {
            time = `${horas}:0${minutos}`;
        }
        else if (horas < 10 && minutos >= 10) {
            time = `0${horas}:${minutos}`;
        } else {
            time = `${horas}:${minutos}`;
        }

        //Hago que solo aparezca la hora del último pulsado y no de los demás        
        $(".stops-list li .time").empty();
        $(".stops-list li.active .time").append(time);
    }
    else {
        //Paso la cadena a hora:min:seg
        let array = busLoc.llegada.split(":");
        horaLlegada.setHours(array[0]);
        horaLlegada.setMinutes(array[1]);
        horaLlegada.setSeconds(array[2]);

        let horas = horaLlegada.getHours();
        let minutos = horaLlegada.getMinutes();
        let segundos = horaLlegada.getSeconds();

        for (let i = busOrder; i < order; i++) {
            horas = horas + durationTimes[i].getHours();
            minutos = minutos + durationTimes[i].getMinutes();
            segundos = segundos + durationTimes[i].getSeconds();

            if (segundos > 59) {
                segundos = segundos - 60;
                minutos = minutos + 1;
            }
            if (minutos > 59) {
                minutos = minutos - 60;
                horas = horas + 1;
            }
        }

        //Pongo formato correcto a las horas
        let time;
        if (minutos < 10 && horas < 10) {
            time = `0${horas}:0${minutos}`;
        }
        else if (horas >= 10 && minutos < 10) {
            time = `${horas}:0${minutos}`;
        }
        else if (horas < 10 && minutos >= 10) {
            time = `0${horas}:${minutos}`;
        } else {
            time = `${horas}:${minutos}`;
        }

        let horaAParada = new Date();
        horaAParada.setHours(horas);
        horaAParada.setMinutes(minutos);
        horaAParada.setSeconds(segundos);

        if (horaAParada < horaActual) {
            let diferencia = horaActual - horaAParada;

            //Si es mayor a 5 minutos, le pongo el siguiente horario
            if (diferencia >= 30000) {
                //Obtengo la hora de salida dividida en horas, minutos y segundos para sumarle las duraciones
                let horas = horaSalida.getHours();
                let minutos = horaSalida.getMinutes();
                let segundos = horaSalida.getSeconds();

                //Sumo cuanto tarda aprox el bus en llegar a cada parada hasta 
                //la que se ha pulsado
                for (let i = 0; i < order; i++) {
                    horas = horas + durationTimes[i].getHours();
                    minutos = minutos + durationTimes[i].getMinutes();
                    segundos = segundos + durationTimes[i].getSeconds();

                    if (segundos > 59) {
                        segundos = segundos - 60;
                        minutos = minutos + 1;
                    }
                    if (minutos > 59) {
                        minutos = minutos - 60;
                        horas = horas + 1;
                    }
                }

                //Pongo formato correcto a las horas
                let timeSiguiente;
                if (minutos < 10 && horas < 10) {
                    timeSiguiente = `0${horas}:0${minutos}`;
                }
                else if (horas >= 10 && minutos < 10) {
                    timeSiguiente = `${horas}:0${minutos}`;
                }
                else if (horas < 10 && minutos >= 10) {
                    timeSiguiente = `0${horas}:${minutos}`;
                } else {
                    timeSiguiente = `${horas}:${minutos}`;
                }

                //Hago que solo aparezca la hora del último pulsado y no de los demás        
                $(".stops-list li .time").empty();
                $(".stops-list li.active .time").append(timeSiguiente).css("color","white");
            }
            else {
                //Hago que solo aparezca la hora del último pulsado y no de los demás
                $(".stops-list li .time").empty();
                $(".stops-list li.active .time").append(time).css("color", "red");
            }
        }
        else {
            //Hago que solo aparezca la hora del último pulsado y no de los demás
            $(".stops-list li .time").empty();
            $(".stops-list li.active .time").append(time).css("color", "white");
        }
    }


}


//Función que realiza la petición AJAX y devuelve las líneas
function GetLinea() {
    $.ajax({
        url: "./php/admin/actions/lineas.php",
        method: "GET",
        dataType: "json",
        error: function (error) { alert("Error en su petición: " + error) },
        success: function (data) {
            var lines = data;
            ShowLines(lines);
        }
    });
}



//Muestra las líneas en el HTML
function ShowLines(lines) {
    let text = "";

    for (let i = 0; i < lines.length; i++) {
        text += `<li class="${lines[i].numero}" onclick='GetParadas(this)'><div class="lineimage">
                    <div class="image"><img src="./assets/img/Icons/bus.svg" alt="urban${lines[i].nombre}"></div>
                    <span>${lines[i].numero}</span>
                </div>
                <span class="linetitle">${lines[i].nombre}</span>
                <span class="time"></span>
                </li>`;
    }

    $(".content .list").html(text);
}


function Hamburguer(hambur){
    hambur.classList.toggle("change");
    $(".content").toggle(500, "swing");
}