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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Pedido;
import modelo.Usuario;

/**
 *
 * @author Ramos-PC
 */
public class ServletFinalizarPedido extends HttpServlet {
    

  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        HttpSession sesion = request.getSession();
        RequestDispatcher rd;
        int idpedido = Integer.parseInt(request.getParameter("idp"));
        double total = Double.parseDouble(request.getParameter("total"));
        if (DB.finalizarPedido(idpedido,total)) {
            
            Usuario user=(Usuario)sesion.getAttribute("usuario");
            Pedido nuevoPedido = DB.abrirNuevoPedido(user);
            sesion.setAttribute("pedido", nuevoPedido);
            rd = request.getRequestDispatcher("carrito.jsp");
            rd.forward(request, response);
            
        }
        
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

   

}
