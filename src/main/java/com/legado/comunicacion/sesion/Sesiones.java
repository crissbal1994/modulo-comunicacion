package com.legado.comunicacion.sesion;

import java.util.ArrayList;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Paola
 */
public class Sesiones implements HttpSessionListener{
    
    public static int contar;
    public static ArrayList<String> usuarios = new ArrayList<String>();

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        contar++;
        se.getSession().setAttribute("id_usuario", "Invitado");
        se.getSession().setAttribute("nuevo", "1");
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        contar--;
        if(!se.getSession().getAttribute("id_usuario").toString().equals("Invitado")){
            String nombre = se.getSession().getAttribute("id_usuario").toString();
            this.eliminarUser(nombre);
        }
    
    }
    
   public static void comprobarUsuario(String nombre){
        if(!existeUsuario(nombre) && !nombre.equals("Invitado")){
            usuarios.add(nombre);
        }
    }
    
    public static boolean existeUsuario(String nombre){
        for(String s:usuarios){
            if(s.equals(nombre)){
                return true;
            }
        }
        return false;
    }
    
    public static void eliminarUser(String nombre){
        
                usuarios.remove(nombre);
       
    }
}
