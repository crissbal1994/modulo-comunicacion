/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.legado.comunicacion.controller;

import com.legado.comunicacion.Rep.MensajeRep;
import java.util.List;

import com.legado.comunicacion.dom.Grupo;
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
import org.springframework.http.ResponseEntity;
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
    //Solicitud del usuario y método
    @RequestMapping(value = "/addMessage", method = RequestMethod.POST)
    public Mensaje agregar(@RequestBody Mensaje m) {
    	System.out.println("Nuevo msg"+m.getMensaje());
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
    			
    			//Conversion de id a nombres
    			RestTemplate restTemplate = new RestTemplate();
    	        String url = "http://172.16.147.151:9092/get_miembros?id_grupo=" + id_grupo;
    	        ResponseEntity<Usuario[]> rp = restTemplate.getForEntity(url, Usuario[].class);
    			Usuario[] usuarios = rp.getBody();
    			
    			
    			
    			for (int j = 0; j < mensajes.size(); j++) {
    				for (int i = 0; i < usuarios.length; i++) {
    					
    					if (usuarios[i].getId_usuario()==mensajes.get(j).getEmisor()){
    						
    						mensajes.get(j).setMensaje(mensajes.get(j).getMensaje()+","+usuarios[i].getAlias());
    					}
    				}
				}
    			
    		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return mensajes;
    }
    
  //==========================SERVICIO DE PRUEBA 9092=========================
    @RequestMapping(value = "/get_grupo", method = RequestMethod.GET)
    	public Grupo grupo(@RequestParam Long id_grupo){
    		Grupo g = new Grupo();
    		g.setNombre("Deber WEB");
    		return g;
    	}
    
    @RequestMapping(value = "/get_miembros", method = RequestMethod.GET)
    public Usuario[] usuariosGrupo(@RequestParam Long id_grupo ) {
    	RestTemplate restTemplate = new RestTemplate();
        String url = "http://172.16.147.151:9092/get_miembros?id_grupo=" + id_grupo;
        ResponseEntity<Usuario[]> rp = restTemplate.getForEntity(url, Usuario[].class);
		Usuario[] usuarios = rp.getBody();
    	
        return usuarios;
    }
    //===================================================================
    
  //==================SERVICIO DE PRUEBA 9092 SEARCH USERS===============
    @RequestMapping(value = "/search_correo", method = RequestMethod.GET)
    public Usuario buscarUsuario(@RequestParam String correo ) {
    	 RestTemplate restTemplate = new RestTemplate();
    	 String url = "http://172.16.147.108:9091/search_correo?correo=" + correo;
    	 Usuario usuario = restTemplate.getForObject(url, Usuario.class);
    	 
    	 return usuario;
    }
  //===================================================================

    
  //==================SERVICIO DE PRUEBA 9092 ADD USERS===============
    @RequestMapping(value = "/add_miembro", method = RequestMethod.GET)
    public String agregarMiembro(@RequestParam Long id_usuario,@RequestParam Long id_grupo  ) {

    	 RestTemplate restTemplate = new RestTemplate();
    	 String url = "172.16.147.151:9092/add_miembro?id_usuario="+id_usuario+"&id_grupo="+id_grupo;
    	 String estado = restTemplate.getForObject(url, String.class); //esta linea devuelve un string de ok,error o existe 
    	 return estado;
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
