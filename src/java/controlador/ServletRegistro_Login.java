/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import dao.DB;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Pedido;
import modelo.Producto;
import modelo.Usuario;

/**
 *
 * @author Ramos-PC
 */
public class ServletRegistro_Login extends HttpServlet {

    private ArrayList<Producto> cesta = new ArrayList<Producto>();

    //------------------------------- LOGIN -----------------------------------------//
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ServletContext contexto = request.getServletContext();
        RequestDispatcher rd;
        HttpSession sesion = request.getSession();
        String erroresEnLogin = "";
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rol = "";

        if ((username != null && !username.isEmpty()) && (password != null && !password.isEmpty())) {

            if (DB.usuarioExiste(username, password)) {

                Usuario user = DB.confirmaRol(username, password);
                System.out.println(user);
                rol = user.getRol();
                if (rol.equals("admin")) {
                    //GO TO ADMIN HTML
                    sesion.setAttribute("admin", user);
                    rd = request.getRequestDispatcher("/vistaAdmin.jsp");
                    rd.forward(request, response);
                } else if (rol.equals("usuario")) {
                    //GO TO USER HTML
                    sesion.setAttribute("usuario", user);
                     sesion.setAttribute("reproducciones", "0");
                    Pedido pedido = DB.TienePedidoSinPagar(user);

                    if (pedido != null) {

                        sesion.setAttribute("pedido", pedido);
                        cesta = DB.currentCesta(pedido.getIdpedidos());
                        sesion.setAttribute("cesta", cesta);

                    } else {
                        int idPedido = 0;
                        pedido = DB.abrirNuevoPedido(user);
                        sesion.setAttribute("pedido", pedido);
                        sesion.setAttribute("cesta", cesta);
                    }

                    rd = request.getRequestDispatcher("/novedades.jsp");
                    rd.forward(request, response);

                }

            } else {

                //USUARIO NO EXISTE
                erroresEnLogin = "* El usuario no existe o la contraseña es erronea.";
                contexto.setAttribute("erroresEnLogin", erroresEnLogin);
                rd = request.getRequestDispatcher("/indexError.jsp");
                rd.forward(request, response);

            }

        } else {

            //CAMPOS VACIOS
            erroresEnLogin = "* Campos vacios, introduzca un usuario y su contraseña para continuar.";
            contexto.setAttribute("erroresEnLogin", erroresEnLogin);
            rd = request.getRequestDispatcher("/indexError.jsp");
            rd.forward(request, response);
        }

    }

    //------------------------------- FIN LOGIN -----------------------------------------//
    //------------------------------- REGISTRO -----------------------------------------//
    //REGISTRO
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
