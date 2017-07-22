/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.legado.comunicacion.controller;

import com.legado.comunicacion.Rep.MensajeRep;
import java.util.List;
import com.legado.comunicacion.dom.Mensaje;
import com.legado.comunicacion.dom.Resultado;
import com.legado.comunicacion.dom.Usuario;

import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.data.repository.query.Param;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
/**
 *
 * @author 
 */
@RestController
public class ArchivoRestController {
	@Autowired
	private MensajeRep msgRep;
	private Date date;
    private static final Logger logger = Logger.getLogger(RestController.class.getName());
    //Solicitud del usuario y método
    @RequestMapping(value = "/addMessage", method = RequestMethod.POST)
    public Mensaje agregar(@RequestBody Mensaje m) {
    	System.out.println(m.getMensaje());
    	date = new Date();
    	try {
    		m.setEnviado(date);		   		
    		msgRep.save(m);    		 	  		
		} catch (Exception e){
			e.printStackTrace();
		}
        return m;
    }
    
    
    @RequestMapping(value = "/getMessages", method = RequestMethod.GET)
    public List<Mensaje> obtenerMensaje(@RequestParam Long id_grupo ) {
    	List<Mensaje> mensajes = null;
    	try {
    			mensajes = msgRep.encontrarMensajesPorGrupo(id_grupo);	
    		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return mensajes;
    }
    
  //==========================SERVICIO DE PRUEBA 9092=========================
    @RequestMapping(value = "/get_miembros", method = RequestMethod.GET)
    public List<Usuario> usuariosGrupo(@RequestParam Long id_grupo ) {
    	System.out.println("id de grupo :"+id_grupo);
    	Usuario u = new Usuario();
    	Usuario u1 = new Usuario();
    	Usuario u2 = new Usuario();
    	u.setIdUsuario(1);
    	u.setAlias("Gabriel");
    	u.setCorreo("gabriel.loja@ucuenca.ec");
    	u.setNombre("Gabriel Loja");
    	
    	u1.setIdUsuario(2);
    	u1.setAlias("Jose");
    	u1.setCorreo("jose.moyano@ucuenca.ec");
    	u1.setNombre("Jose Moyano");
  
      	u2.setIdUsuario(3);
    	u2.setAlias("Paola");
    	u2.setCorreo("paola.cardenas@ucuenca.ec");
    	u2.setNombre("Paola Cardenas");
    	List<Usuario> usuarios = new ArrayList<>();
    	usuarios.add(u);
    	usuarios.add(u1);
    	usuarios.add(u2);
    	
        return usuarios;
    }
    //===================================================================
    
  //==================SERVICIO DE PRUEBA 9092 SEARCH USERS===============
    @RequestMapping(value = "/search_correo", method = RequestMethod.GET)
    public Usuario buscarUsuario(@RequestParam String correo ) {
    	 RestTemplate restTemplate = new RestTemplate();
    	 String url = "http://172.16.147.43:9092/search_correo?correo=" + correo;
    	 //Usuario usuario = restTemplate.getForObject(url, Usuario.class);
    	 Usuario usuario=new Usuario() ;
    	 usuario.setIdUsuario(1);
    	 usuario.setAlias("asd");
    	 usuario.setCorreo("asd@asd.com");
    	 usuario.setNombre("asd asdasd ");
    	 return usuario;
    }
  //===================================================================

    
  //==================SERVICIO DE PRUEBA 9092 ADD USERS===============
    @RequestMapping(value = "/add_miembro", method = RequestMethod.GET)
    public String agregarMiembro(@RequestParam Long id_usuario,@RequestParam Long id_grupo  ) {

    	 RestTemplate restTemplate = new RestTemplate();
    	 String url = "172.16.147.43:9092/add_miembro?id_usuario="+id_usuario+"&id_grupo="+id_grupo;
    	// String estado = restTemplate.getForObject(url, String.class); //esta linea devuelve un string de ok,error o existe 
    	 return "ok";
    }
    //===================================================================
    
    @RequestMapping(value = "/crear_alerta", method = RequestMethod.POST)
    public Resultado alerta(@RequestBody Mensaje m   ) {
    	date = new Date();
    	Resultado r = new Resultado();
    	try {
    			m.setEnviado(date);  			
    			msgRep.save(m);
    			r.setEstado(true);
    		} catch (Exception e) {
			// TODO Auto-generated catch block
    			r.setEstado(false);
			e.printStackTrace();
		}
        return r;
    }
    
    @RequestMapping(value = "/error", method = RequestMethod.POST)
    public String error() {
        return "Problemas en la página";
    }
    
    
    
}
