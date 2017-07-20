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
    	Usuario u = new Usuario();
    	Usuario u1 = new Usuario();
    	u.setIdUsuario(1);
    	u.setAlias("Josue");
    	u.setCorreo("josue@hotmail.com");
    	u.setNombre("Josue Perez");
    	
    	u1.setIdUsuario(2);
    	u1.setAlias("Pedro2");
    	u1.setCorreo("josue2@hotmail.com");
    	u1.setNombre("Pedro Paez ");
    	
    	List<Usuario> usuarios = new ArrayList<>();
    	usuarios.add(u);
    	usuarios.add(u1);
    	
        return usuarios;
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
