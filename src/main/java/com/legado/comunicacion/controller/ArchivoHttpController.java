/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.legado.comunicacion.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.legado.comunicacion.dom.Grupo;
import com.legado.comunicacion.dom.Usuario;

/**
 *
 * @author helio
 */
@Controller
public class ArchivoHttpController {
    @RequestMapping("/chat")
    //RequestParam permite obtener un atributo de la url, debe tener el mismo nombre
    public @ResponseBody ModelAndView redireccion(@RequestParam Long id_grupo, @RequestParam Long id_usuario){
    	RestTemplate restTemplate = new RestTemplate();
    	String url = "http://localhost:9093/get_grupo?id_grupo=" + id_grupo;
        ResponseEntity<Grupo> rp = restTemplate.getForEntity(url, Grupo.class);
		Grupo grupo = rp.getBody();
		
		
    	ModelAndView mv = new ModelAndView();
    	mv.addObject("nombre_grupo",'"'+grupo.getNombre()+'"');
        //Esto carga parámetros en el jsp
        mv.addObject("id_grupo", id_grupo);
        mv.addObject("id_usuario", id_usuario);
        //Esto carga el jsp correspondiente como la vista ante la solicitud del usuario
        mv.setViewName("index");
	return mv;
    }
    
    @RequestMapping("/crear_alerta")
    //RequestParam permite obtener un atributo de la url, debe tener el mismo nombre
    public @ResponseBody ModelAndView hello(@RequestParam Long id_grupo, @RequestParam Long id_usuario, @RequestParam String mensaje){
    	RestTemplate restTemplate = new RestTemplate();
    	String url = "http://localhost:9093/get_grupo?id_grupo=" + id_grupo;
        ResponseEntity<Grupo> rp = restTemplate.getForEntity(url, Grupo.class);
		Grupo grupo = rp.getBody();
    	ModelAndView mv = new ModelAndView();
        //Esto carga el jsp correspondiente como la vista ante la solicitud del usuario
    	mv.addObject("nombre_grupo",'"'+grupo.getNombre()+'"');
        //Esto carga parámetros en el jsp
        mv.addObject("id_grupo", id_grupo);
        mv.addObject("id_usuario", id_usuario);
        mv.addObject("mensaje", mensaje);

    	mv.setViewName("ultimoMSJ");
	return mv;
    }
}
