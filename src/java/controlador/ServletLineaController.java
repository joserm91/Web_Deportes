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
import modelo.Producto;

/**
 *
 * @author Ramos-PC
 */
public class ServletLineaController extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession();
RequestDispatcher rd;
        int idPedido = Integer.parseInt(request.getParameter("idPedido"));
        int idProducto = Integer.parseInt(request.getParameter("idProducto"));
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));
        String accion = request.getParameter("accion");

        boolean modificada = false;
        if (cantidad == 1 && accion.equals("restar")) {
            accion="eliminar";
        }
        
        switch (accion) {

            case "sumar":
                modificada = DB.modificarLinea(accion, idPedido, idProducto, cantidad);
                break;
            case "restar":
                modificada = DB.modificarLinea(accion, idPedido, idProducto, cantidad);
                break;
            case "eliminar":
                modificada = DB.modificarLinea(accion, idPedido, idProducto, cantidad);
                break;
            default:

                break;

        }

        if (modificada) {
           
            rd = request.getRequestDispatcher("carrito.jsp");
            rd.forward(request, response);
        }
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
