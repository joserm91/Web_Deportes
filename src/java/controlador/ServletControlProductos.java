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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Pedido;
import modelo.Producto;

/**
 *
 * @author Ramos-PC
 */
public class ServletControlProductos extends HttpServlet {

   


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        int idProducto = Integer.parseInt(request.getParameter("productoSeleccionado"));
       
        HttpSession sesion = request.getSession();
        RequestDispatcher rd;
        ArrayList<Pedido>listaPedidosContenedores = DB.buscarPedidosContenedores(idProducto);
        sesion.setAttribute("listaProductosDB", listaPedidosContenedores);
        rd = request.getRequestDispatcher("pedidosPorProducto.jsp");
        rd.forward(request, response);
        
    }


}
