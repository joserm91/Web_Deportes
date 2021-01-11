/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import dao.DB;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Ramos-PC
 */
public class ServletRegistro extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    ServletContext contexto = request.getServletContext();
        RequestDispatcher rd;
        String usuario = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String password_confirm = request.getParameter("confirm-password");
        String erroresDeRegistro = "";
        String registroCorrecto = "";

        String data[] = {usuario, password, email, password_confirm};

        if (compruebaVacio(data)) {
            String usernameRepetido = "";
            String emailRepetido = "";
            usernameRepetido = DB.usuarioRepetido(usuario, password, email);
            emailRepetido = DB.emailRepetido(usuario, password, email);

            if (usernameRepetido.equals("repe")) {
                erroresDeRegistro = "* El Username ya existe.";
                contexto.setAttribute("erroresDeRegistro", erroresDeRegistro);
                rd = request.getRequestDispatcher("/registroError.jsp");
                rd.forward(request, response);
            } else if (emailRepetido.equals("repe")) {
                erroresDeRegistro = "* Ya hay un usuario registrado con ese Email.";
                contexto.setAttribute("erroresDeRegistro", erroresDeRegistro);
                rd = request.getRequestDispatcher("/registroError.jsp");
                rd.forward(request, response);
            } else if (!password.equals(password_confirm)) {
                erroresDeRegistro = "* Las contraseñas no coinciden.";
                contexto.setAttribute("erroresDeRegistro", erroresDeRegistro);
                rd = request.getRequestDispatcher("/registroError.jsp");
                rd.forward(request, response);
            } else {

                String rol = "usuario";
                if (DB.registro(usuario, password, email, rol)) {

                    registroCorrecto = "Usuario registrado con éxito. Ahora puede iniciar sesión.";
                    contexto.setAttribute("registroCorrecto", registroCorrecto);
                    rd = request.getRequestDispatcher("/index.jsp");
                    rd.forward(request, response);
                }

            }

        } else {
            erroresDeRegistro = "* Todos los campos son obligatorios";
            contexto.setAttribute("erroresDeRegistro", erroresDeRegistro);
            rd = request.getRequestDispatcher("/registroError.jsp");
            rd.forward(request, response);

        }

    }
    //------------------------------- FIN REGISTRO -----------------------------------------//

    private boolean compruebaVacio(String[] data) {
        for (int i = 0; i < data.length; i++) {
            if (data[i] == null || data[i].isEmpty()) {
                
                return false;
            }
        }
        return true;
    }

}
