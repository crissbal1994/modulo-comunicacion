/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.legado.comunicacion.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author helio
 */
@Controller
public class ArchivoHttpController {
    @RequestMapping("/chat")
    //RequestParam permite obtener un atributo de la url, debe tener el mismo nombre
    public @ResponseBody ModelAndView redireccion(@RequestParam Long id_grupo, @RequestParam Long id_usuario){
        ModelAndView mv = new ModelAndView();
        //Esto carga parámetros en el jsp
        mv.addObject("id_grupo", id_grupo);
        mv.addObject("id_usuario", id_usuario);
        //Esto carga el jsp correspondiente como la vista ante la solicitud del usuario
        mv.setViewName("index");
	return mv;
    }
}
