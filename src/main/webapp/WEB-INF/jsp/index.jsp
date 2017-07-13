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
  		<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
  		<link rel="stylesheet"  href="css/bootstrap.css">
  		<link rel="stylesheet"  href="css/bootstrap-theme.css">
  		<link rel="stylesheet" href="css/estilos.css">
    </head>
    <body>
<div class="container-fluid">
  <div class="row">
    <header>
      <div class="container-fluid" >
        <div class="row img-center-vertical " >
          <div class="col-xs-3 col-sm-2 col-md-1 col-lg-1">
            <img src="img/logo_icono.png" alt="Legado logo"  height="55" >
          </div>
          <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1">
            <img src="img/logo_nombre.png" alt="Legado nombre"  height="35"  >
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
      <h4 class="bold" >Agregar Integrante</h4>
        <form class = "navbar-form" role = "search">
          <div class = "form-group">
            <input type = "text" class = "form-control bordered" placeholder = "Correo">
          </div>
          <br>
          <button type = "submit" class = "btn btn-default bordered">Agregar</button>
        </form>  
      
      <!--se dibuja la lista de integrantes-->
      <div class="scroll scrollable scroll-bar vertical" >
        <ul class="list-unstyled">
          <li> <h3> Paola Cardenas </h3> </li>
          <li> <h3> Cristina Balcazar </h3> </li>
          <li> <h3> Franklin Bernal </h3> </li>
          <li> <h3> Jose Moyano </h3> </li>
          <li> <h3> Boris Cabrera </h3> </li>
          <li> <h3> Gabriel Loja </h3> </li>
        </ul>
      </div>
    </aside>  
  </div>
  <!-- col-xs-12 col-sm-5 col-md-4 col-lg-3 -->
    <div class="col-xs-12 col-sm-7 col-md-8 col-lg-9" >
      <div class="row">
        <section class="chat">
            <div class="scroll scrollable scroll-bar vertical" >
              <ul class="list-unstyled text-right " id="mensajes">
                <li> <h4>Hola mundo !</h4> </li>
              </ul>
            </div>
        </section>
      </div>
        <div class="row">
                    <section class="actions">
              <div class="col-xs-8 col-sm-10 col-md-10 col-lg-10">
                <div class="actions-text">
                  <div class="col-xs-9 col-sm-10 col-md-10 col-lg-10">
                    <input id="mensaje" type="text" name="" value="" placeholder="">
                  </div>
                  <div id="enviar_mensaje" class="col-xs-3 col-sm-2 col-md-2 col-lg-2">
                    <button type = "submit" class = "btn btn-default bordered"> <img src="img/icono_enviar.png" alt="boton-enviar" class="bordered-actions"></button>
                  </div>  
                </div>
              </div>
              <div class="col-xs-2 col-sm-1 col-md-1 col-lg-1 actions-archivo">
                    <button type = "submit" class = "btn bordered"> <img src="img/icono_archivo.png" alt="boton-archivo" class="bordered-actions"></button>
              </div>
              <div class="col-xs-2 col-sm-1 col-md-1 col-lg-1 actions-calendar">
                    <button type = "submit" class = "btn bordered"> <img src="img/icono_calendario.png" alt="boton-calentario" class="bordered-actions"></button>
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
