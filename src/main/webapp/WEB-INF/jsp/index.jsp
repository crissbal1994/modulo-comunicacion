<%-- 
    Document   : index.jsp
    Created on : Jul 2, 2017, 10:06:38 AM
    Author     : helio
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Chat Legado</title>
<script type="text/javascript" src="webjars/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
var x = $(document);
x.ready(inicializar);
var idGroup=${id_grupo};
var idUser=${id_usuario};

function inicializar(){
	<%String us=request.getParameter("id_usuario");
	request.getSession().setAttribute("id_usuario",us);
	request.getSession().setAttribute("nuevo","1");
	%>
    cargarMensajes();
    cargarUsuarios();
	posicionarScroll();           
}

var datos=null;
function cargarMensajes(){
	//obtener de puerto 9092
	$.get("/get_miembros?",{id_grupo: idGroup},obtenerNombres)
	function obtenerNombres(data){
		datos=data;
		$.get("/getMessages?",{id_grupo: idGroup},callback)
	}
	var x = $("#ventanaConversacionInt");
	//x.load("/ultimoMSJ?id=1", function(){irAlUltimo();
	setTimeout("cargarMensajes()",1000);//  });
}

function irAlUltimo(){
	var x = $("#ventanaConversacionInt");
}
   
function callback(data){
   	for ( var i = 0; i < data.length; i++) {
   		var date = new Date();
   		date.setTime(data[i].enviado);
   		var formatted = date.getFullYear() + "-" + 
   	      ("0" + (date.getMonth() + 1)).slice(-2) + "-" + 
   	      ("0" + date.getDate()).slice(-2) + " " + date.getHours() + ":" + 
   	      date.getMinutes(); 
   	      //Solo carga los mensajes que no estan aun;
   	   	if(!document.getElementById(data[i].idMensaje)){
			var nuevoMsj = document.getElementById("myAudio");
			var div=document.createElement('div');
			div.id=data[i].idMensaje;
         	//OBTENER NOMBRES DE SERVICIO
           	for ( var j = 0; j < datos.length; j++) {
           		if (datos[j].idUsuario==data[i].emisor){
	           		if(${id_usuario}===data[i].emisor){
	               		data[i].emisor=datos[j].alias;
	       				div.innerHTML="<div class=\"mensaje-autor  text-right\">"+
	       				"<div class=\"mensaje\">"+
	       				"<div class=\"nombre-autor\">"+data[i].emisor+"</div>"+
	       					"<div class=\"contenido\">"+data[i].mensaje+"</div>"+
	       					"<div class=\"flecha-derecha\"></div>"+
	       				"</div>"+
	       				"<div class=\"fecha\">"+formatted+"</div>"+
	       				"</div>";
	       				nuevoMsj.pause();
	       			}else{
	               		data[i].emisor=datos[j].alias;
	       				div.innerHTML="<div class=\"mensaje-amigo  text-left\">"+
	       				"<div class=\"mensaje\">"+
	       				"<div class=\"nombre-amigo\">"+data[i].emisor+"</div>"+
	       				"<div class=\"flecha-izquierda\"></div>"+
	       				"<div class=\"contenido\">"+data[i].mensaje+"</div>"+
	       				"</div>"+
	       				"<div class=\"fecha\">"+formatted+"</div>"+"</div>"
	       				nuevoMsj.play();
       				}
					document.getElementById("mensajes").appendChild(div);
					document.getElementById(data[i].idMensaje).value="";
           		}
       		}
		}
	}           
}
      	
function post(url,data){
	return $.ajax({
		type:'POST',
		url:url,
		headers:{
			'Accept': 'application/json',
			'Content-Type': 'application/json'
		},
		data:JSON.stringify(data)
	});
}
function enviarMensaje() {
    var $messageInput = $('#messageInput');
    if ($messageInput.val()!=""){
    	var message = {mensaje: $messageInput.val(), idGrupo: idGroup, emisor: idUser};
    	$messageInput.val('');
    	post('/addMessage',message);
    }
}

function cargarEnIntegrantes(evt){
	var email=document.getElementById("email").value;
	$.get("/search_correo?",{correo: email}, correo );
} 
  	
var usuario;
var alias;
function correo(data){
	if(data)
    {
		usuario=data.nombre;
    	alias=data.alias;
		$.get("/add_miembro?",{id_usuario: data.idUsuario,id_grupo:idGroup}, agregarMiembro );
    }else{
    	alert("No existe el usuario");
    }
}

function agregarMiembro(estado){
	if(estado==="ok"){
		var li=document.createElement('li'); //quitar cuando ya esten los servicios
		li.id=alias; //quitar cuando ya esten los servicios
		li.innerHTML="<li> <h4> "+usuario+"</h4> </li>"; //quitar cuando ya esten los servicios
		document.getElementById("listaIntegrantes").appendChild(li); //quitar cuando ya esten los servicios
		document.getElementById("email").value=""; //quitar cuando ya esten los servicios
		alert("Usuario ingresado");
	}else if(estado==="existe"){
		alert("El usuario ya existe en el grupo");
	}else{
		alert("Error al realizar la acción revice los servicios");
	}
}
  	
function cargarUsuarios(){
	$.get("/get_miembros?",{id_grupo: idGroup},cargarIntegrantes);
   	function cargarIntegrantes(data){
         document.getElementById("listaIntegrantes").innerHTML="";
       	for ( var i = 0; i < data.length; i++) {
			var li=document.createElement('li');
            li.id=data[i].alias;
            li.innerHTML="<li> <h4> "+data[i].nombre+"</h4> </li>";
            document.getElementById("listaIntegrantes").appendChild(li);
            document.getElementById("email").value="";
       	}
   	}	
}

function posicionarScroll(){
	var objDiv = document.getElementById("chat");
	objDiv.scrollTop = objDiv.scrollHeight;
}
</script>
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrap-theme.css">
<link rel="stylesheet" href="css/estilos.css">
</head>
<body>
<audio id="myAudio">
  <source src="audio/sonido.mp3" type="audio/mpeg">
</audio>
	<div class="container-fluid">
		<div class="row">
			<header>
				<div class="container-fluid">
					<div class="row img-center-vertical ">
						<div class="col-xs-3 col-sm-2 col-md-1 col-lg-1">
							<img src="img/logo_icono.png" alt="Legado logo" height="55">
						</div>
						<div class="col-xs-1 col-sm-1 col-md-1 col-lg-1">
							<img src="img/logo_nombre.png" alt="Legado nombre" height="35">
						</div>
					</div>
				</div>
			</header>
		</div>

		<div class="row" style="background: #32bebe">
			<div class="col-xs-12 col-sm-5 col-md-4 col-lg-3">
				<aside>
					<!--Aqui se ingresara el nombre del proyecto-->
					<h1>Proyecto XYZ</h1>
					<hr>
					<h4 class="bold">Agregar Integrante</h4>
					<form class = "navbar-form" role = "search">
			          <div class = "form-group">
			            <input id="email" name="email" type = "email" class = "form-control bordered" placeholder = "Correo electrónico" required>    <span id="emailOK"></span>
			          </div>
			          <br>
			          <button id="agregarIntegrante" type="button" class = "btn btn-default bordered" onclick="cargarEnIntegrantes()">Agregar</button>
			        </form>

					<!--se dibuja la lista de integrantes-->
					<div class="scroll scrollable scroll-bar vertical" >
						<ul id="listaIntegrantes" class="list-unstyled">
							<!-- <li> <h4> Paola Cardenas </h4> </li> Aqui va los Integrantes del grupo -->
						</ul>
					</div>
				</aside>
			</div>
			<!-- col-xs-12 col-sm-5 col-md-4 col-lg-3 -->
			<div id="chat" class="col-xs-12 col-sm-7 col-md-8 col-lg-9">
				<div class="row" id="ventanaConversacionInt">
					<section class="chat">
						<div class="scroll scrollable scroll-bar vertical">
							<div id="chat">
								<div id="mensajes">
									<div class="mensaje-amigo text-left">
										<div class="mensaje">
											<div class="nombre-amigo">Juan Andres</div>
											<div class="flecha-izquierda"></div>
											<div class="contenido">
												Hola chicos soy un mensaje
											</div>
										</div>
										<div class="fecha">23:32:12 54:54:23</div>
									</div>
								</div>
							</div>
						</div>
					</section>
				</div>
				<div class="row">
					<section class="actions">
						<div class="col-xs-8 col-sm-10 col-md-10 col-lg-10">
							<div class="actions-text">
								<div
									class="col-xs-9 col-sm-10 col-md-10 col-lg-10 actions-text-imput">
									<input id="messageInput" type="text">
								</div>
								<div class="col-xs-3 col-sm-2 col-md-2 col-lg-2">
									<button id="miboton"  onclick="enviarMensaje();" type="button"	
										class="btn btn-default bordered">
										<img src="img/icono_enviar.png" alt="boton-enviar"
											class="bordered-actions">
									</button>
								</div>
							</div>
						</div>
						<div class="col-xs-2 col-sm-1 col-md-1 col-lg-1 actions-archivo">
							<button type="submit" class="btn bordered">
								<img src="img/icono_archivo.png" alt="boton-archivo"
									class="bordered-actions" />
							</button>
						</div>
						<div class="col-xs-2 col-sm-1 col-md-1 col-lg-1 actions-calendar">
							<button type="submit" class="btn bordered">
								<img src="img/icono_calendario.png" alt="boton-calentario"
									class="bordered-actions" />
							</button>
						</div>
					</section>
				</div>
			</div>
		</div>
		<script src="js/script.js"></script>
		<script src="js/bootstrap.js"></script>
		<script src="js/npm.js"></script>
		<script src="js/angular.min.js"></script>
	</div>
	<!-- <h1>Hello World!</h1>
        <a href="archivos?id_grupo=1&id_usuario=1">Archivos</a> -->
</body>
</html>