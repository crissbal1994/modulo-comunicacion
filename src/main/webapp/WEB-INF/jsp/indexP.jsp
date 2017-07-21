<%-- 
    Document   : index.jsp
    Created on : Jul 2, 2017, 10:06:38 AM
    Author     : helio
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.legado.comunicacion.sesion.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Chat Legado</title>
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.8.19.custom.min.js"></script>
<script type="text/javascript" src="js/jquery.scrollTo.js"></script>

<script type="text/javascript" src="webjars/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript" >
/**
 * 
 */

	var x = $(document);
	x.ready(inicializar);
	var idGroup=${id_grupo};
	var idUser=${id_usuario};
	//window.onload = function() {
	  //cargarMensajes();
	//};
	function inicializar(){
		<%String us=request.getParameter("id_usuario");
		request.getSession().setAttribute("id_usuario",us);
		request.getSession().setAttribute("nuevo","1");
		%>
                cargarMensajes();
              //  verUsersOnline();
                x = $("#enviarMSJ");
                x.click(enviarMensaje);
                x = $("#txtMensaje");
                x.keypress(enviarMSJ);
                
    }
	var datos=null;
	
	function cargarMensajes(){
		//obtener de puerto 9092
		$.get("/get_miembros?",{id_grupo: idGroup},obtenerNombres)
		var x = $("#ventanaConversacionInt");
        //x.load("/get_miembros?",{id_grupo: idGroup},obtenerNombres, function(){irAlUltimo();
         //   setTimeout("cargarMensajes()",1000);
         //});
		x.load("/ultimoMSJ?id=1", function(){irAlUltimo();
        								setTimeout("cargarMensajes()",1000);  });
		
	}
		
	function obtenerNombres(data){
		datos=data;
		$.get("/getMessages?",{id_grupo: idGroup},callback)
	}
	
	
	/**
     * Funcion para eliminar los elementos
     * Tiene que recibir el elemento pulsado
     */
    function eliminar(elemento)
    {
        var id=elemento.parentNode.getAttribute("id");
        node=document.getElementById(id);
        node.parentNode.removeChild(node);
    }
	
	function callback(data){
		
		<%String tipo=request.getSession().getAttribute("nuevo").toString();
		if(tipo=="1"){%>
		for ( var i = 0; i < data.length; i++) {
    		var date = new Date();
    		date.setTime(data[i].enviado);
    		var formatted = date.getFullYear() + "-" + 
    	      ("0" + (date.getMonth() + 1)).slice(-2) + "-" + 
    	      ("0" + date.getDate()).slice(-2) + " " + date.getHours() + ":" + 
    	      date.getMinutes(); 
    	      if(!document.getElementById(data[i].idMensaje)){
			var li=document.createElement('li');
            li.id=data[i].idMensaje;
            
          //OBTENER NOMBRES DE SERVICIO
            for ( var j = 0; j < datos.length; j++) {
            	if (datos[j].idUsuario==data[i].emisor){
            		data[i].emisor=datos[j].alias
            	}
            }
            //=======================================
            
            li.innerHTML="<li> <h2><b>"+formatted+" </b> "+data[i].emisor+": <sub> "+data[i].mensaje+"</subb></h2> </li>";
            document.getElementById("mensajes").appendChild(li);
            document.getElementById(data[i].idMensaje).value="";}
            
		}
		<%
		//Para que no cargue todos los mensajes en la siguiente actualizacion
		request.getSession().setAttribute("nuevo","0");
		} 
		
		else{%>
		var i=data.length-1;
	//	for ( var i = 0; i < data.length; i++) {
    		var date = new Date();
    		date.setTime(data[i].enviado);
    		var formatted = date.getFullYear() + "-" + 
    	      ("0" + (date.getMonth() + 1)).slice(-2) + "-" + 
    	      ("0" + date.getDate()).slice(-2) + " " + date.getHours() + ":" + 
    	      date.getMinutes(); 
			var li=document.createElement('li');
            li.id=data[i].idMensaje;
            
          //OBTENER NOMBRES DE SERVICIO
          var j=datos.length-1;
          //  for ( var j = 0; j < datos.length; j++) {
            	if (datos[j].idUsuario==data[i].emisor){
            		data[i].emisor=datos[j].alias
            	}
         //   }
            //=======================================
            
            li.innerHTML="<li> <h2><b>"+formatted+" </b> "+data[i].emisor+": <sub> "+data[i].mensaje+"</sub></h2> </li>";
            document.getElementById("mensajes").appendChild(li);
            document.getElementById(data[i].idMensaje).value="";
            
            
		
		<%}%>
    	
    	
    	
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
        	function enviarMSJ(event){
                if(event.which == 13){
                    enviarMensaje();
                    event.preventDefault();
                    
                }
            }
        	function enviarMensaje() {
        		
        	    var $messageInput = $('#txtMensaje');
        	    //Manejo de Sesion
        	    <% //String user = request.getSession().getAttribute("userId").toString();%>
        	    var message = {
        	    		mensaje: $messageInput.val(), 
        	    		idGrupo: idGroup, 
        	    		emisor: idUser
        	    };
        	    $.ajax({
      			  type: "POST",
      			  url:"/addMessage",
      			  headers:{
	    				'Accept': 'application/json',
	    				'Content-Type': 'application/json'
	    		  },
	    		  data:JSON.stringify(message),
      			  beforeSend: inicioCargaMSJ,
      			  success:llegadaMSJ,
      			  error:problemasMSJ
      			}); 
        	//    $messageInput.val('');
        	 //   post('/addMessage',message);
        	    
        	}
        	function irAlUltimo(){
                var x = $("#ventanaConversacionInt");
               // x.scrollTo("#ultimo",0);
            }
        	function problemasMSJ(){
                alert("Su sesion se ha cerrado en este chat");
            }
        	function inicioCargaMSJ(){
                var x = $("#ventanaConversacionInt");
                x.append("<img src='img/ajaxMsj.gif' id='imgLoad' style='display:block;'>");
                irAlUltimo();
            }
            
            function llegadaMSJ(datos){
                var x = $("#ventanaConversacionInt");
                cargarMensajes();
            }
</script>

<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrap-theme.css">
<link rel="stylesheet" href="css/estilos.css">
</head>
<%
Sesiones.comprobarUsuario(request.getSession().getAttribute("id_usuario").toString());
%>
<body>
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
					<form class="navbar-form" role="search">
						<div class="form-group">
							<input type="text" class="form-control bordered"
								placeholder="Correo">
						</div>
						<br>
						<button type="submit" class="btn btn-default bordered">Agregar</button>
					</form>

					<!--se dibuja la lista de integrantes-->
					<div class="scroll scrollable scroll-bar vertical">
						<ul class="list-unstyled">
							<li>
								<h3>Paola Cardenas</h3>
							</li>
							<li>
								<h3>Cristina Balcazar</h3>
							</li>
							<li>
								<h3>Franklin Bernal</h3>
							</li>
							<li>
								<h3>Jose Moyano</h3>
							</li>
							<li>
								<h3>Boris Cabrera</h3>
							</li>
							<li>
								<h3>Gabriel Loja</h3>
							</li>
						</ul>
					</div>
				</aside>
			</div>
			<!-- col-xs-12 col-sm-5 col-md-4 col-lg-3 -->
			<div  class="col-xs-12 col-sm-7 col-md-8 col-lg-9">
				<div class="row" >
					<section class="chat">
						<div id="ventanaConversacionInt" class="scroll scrollable scroll-bar vertical">
							<ul class="list-unstyled text-right " id="mensajes">
								<li>
									
								</li>
							</ul>
						</div>
					</section>
				</div>
				<div class="row">
					<section class="actions">
						<div class="col-xs-8 col-sm-10 col-md-10 col-lg-10">
							<div class="actions-text">
								<form>
									<section id="enviarMensaje" class="col-xs-9 col-sm-10 col-md-10 col-lg-10 actions-text-imput">
										<% if(!request.getSession().getAttribute("id_usuario").equals("Invitado")){ %>
									
									<input id="txtMensaje" type="text" name="" value="" required placeholder="Escriba su mensaje...">
									    <% }else{ %>
									    <input id="txtMensaje" type="text" name="" value="" required placeholder="Usted NO puede enviar mensajes aqui...">
									  
									    <% } %>
									 </section>
									<div class="col-xs-3 col-sm-2 col-md-2 col-lg-2">
										<button onclick="enviarMensaje();" type="button"
											class="btn btn-default bordered">
											<img src="img/icono_enviar.png" alt="boton-enviar"
												class="bordered-actions">
										</button>
									</div>
								</form>
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
		<% /*<script src="js/script.js"></script>
		<script src="js/bootstrap.js"></script>
		<script src="js/npm.js"></script>
		<script src="js/angular.min.js"></script>*/%>
	</div>

</body>
</html>
