<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Nuevo Archivo subido</title>
<script type="text/javascript" src="webjars/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
var idGroup=${id_grupo};
var idUser=${id_usuario};
var mensaje=${mensaje};

var x = $(document);
x.ready(notificar);

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
function notificar(){
	
	var message = {mensaje: mensaje, idGrupo: idGroup, emisor: idUser};
	post('/addMessage',message);
	}


</script>
</head>
<body>
<br><br>
<div id="ultimo">

</div>
</body>
</html>