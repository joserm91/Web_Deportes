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
import modelo.LineaDePedido;
import modelo.Pedido;
import modelo.Producto;
import modelo.Usuario;

/**
 *
 * @author Ramos-PC
 */
public class ServletCarrito extends HttpServlet {
 private ArrayList<Producto> cesta = new ArrayList<Producto>();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
  System.out.println("------------------------");
        ServletContext contexto = request.getServletContext();
        HttpSession sesion = request.getSession();
        RequestDispatcher rd;
       Usuario user=(Usuario)sesion.getAttribute("usuario");
       
       
        int idproducto = Integer.parseInt(request.getParameter("idproducto"));
        Pedido pedido = (Pedido) sesion.getAttribute("pedido");
        
       
        
        Producto elegido = DB.addToCesta(idproducto,user.getIdusuario(),pedido.getIdpedidos());
       
        cesta = (ArrayList<Producto>)sesion.getAttribute("cesta");
        cesta.add(elegido);
        sesion.setAttribute("cesta", cesta);
        System.out.println(elegido);
       
        System.out.println("------------------------");
        
        
        
        String pathInfo = request.getParameter("pathInfo");   
        rd = request.getRequestDispatcher("/"+pathInfo);
        rd.forward(request, response);
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      
    }

}
