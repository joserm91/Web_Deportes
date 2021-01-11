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

/**
 *
 * @author Ramos-PC
 */
public class ServletFiltroUsers extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession();
        RequestDispatcher rd;
        String username = request.getParameter("username");
        ArrayList<Pedido> pedidosTramitadosUsiario = null;
        if (username != null) {

            pedidosTramitadosUsiario = DB.pedidosTramitadosDeUnUsuario(username);
            
           
            
            sesion.setAttribute("pedidosTramitadosUsiario", pedidosTramitadosUsiario);
            rd = request.getRequestDispatcher("pedidosPorUsuario.jsp");
            rd.forward(request, response);

        }

    }

}
