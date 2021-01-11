/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import dao.DB;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
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
public class ServletFiltroFechas extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rd;
        HttpSession sesion = request.getSession();

        String fecha1 = request.getParameter("fecha1");
        String fecha2 = request.getParameter("fecha2");
        ArrayList<Pedido> lista = null;

        if (fecha1 != null && fecha2 != null) {

            lista = DB.pedidosTramitadosPorFecha(fecha1, fecha2);

            sesion.setAttribute("listaPorFechas", lista);
            rd = request.getRequestDispatcher("pedidosPorFecha.jsp");
            rd.forward(request, response);
        }

    }

}
