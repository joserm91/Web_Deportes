/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import dao.DB;
import java.io.IOException;

import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Pedido;

/**
 *
 * @author Ramos-PC
 */
public class ServletControlProductos extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idProducto = request.getParameter("productoSeleccionado");
        
        HttpSession sesion = request.getSession();
        RequestDispatcher rd;
       
            int idProd = Integer.parseInt(idProducto);
            ArrayList<Pedido> listaPedidosContenedores = DB.buscarPedidosContenedores(idProd);
           sesion.setAttribute("listaProductosDB", null);
            sesion.setAttribute("listaProductosDB", listaPedidosContenedores);
           
            rd = request.getRequestDispatcher("pedidosPorProducto.jsp"); 
           
            rd.forward(request, response);
        

    }

}
