<%@page import="modelo.BestCliente"%>
<%@page import="modelo.BestCliente"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="modelo.LineaDePedido"%>
<%@page import="modelo.Pedido"%>
<%@page import="modelo.Usuario"%>
<%@page import="dao.DB"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.Producto"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- https://www.javatpoint.com/php-pagination ----- PAGINACIÓN ---->
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
            />
        <meta name="description" content="" />
        <meta name="author" content="" />

        <title>Top 3</title>

        <!-- Bootstrap core CSS -->
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />

        <!-- Custom styles for this template -->
        <link href="css/simple-sidebar.css" rel="stylesheet" />
        <link rel="stylesheet" href="css/index.css" />
    </head>
    <%
        HttpSession sesion = request.getSession();
        Usuario user = (Usuario) sesion.getAttribute("admin");
        RequestDispatcher rd;
        if (user == null) {
            String faltaLog = "* No se ha iniciado sesión.";
            request.getServletContext().setAttribute("faltaLog", faltaLog);
            String erroresEnLogin = "";
            request.getServletContext().setAttribute("erroresEnLogin", erroresEnLogin);
            rd = request.getRequestDispatcher("indexError.jsp");
            rd.forward(request, response);
        }

        DecimalFormat df = new DecimalFormat("#.00");
        ArrayList<BestCliente> lista = DB.mejoresClientes();


    %>
    <body>
        <div class="d-flex" id="wrapper">
            <!-- Sidebar -->
            <div class="bg-white border-right" id="sidebar-wrapper">
                <div class="sidebar-heading text-center">
                    <img src="imagenes/admin.png" width="60px" alt="" srcset="" />
                </div>
                <div class="list-group list-group-flush">
                    <a
                        href="#"
                        class="list-group-item list-group-item-action bg-white"
                        >#</a
                    >
                    <a
                        href="vistaAdmin.jsp"
                        class="list-group-item list-group-item-action bg-white"
                        >Pedidos Tramitados</a
                    >
                    <a
                        href="topVentas.jsp"
                        class="list-group-item list-group-item-action bg-white"
                        >Top ventas</a
                    >
                    <a
                        href="mejoresClientes.jsp"
                        class="list-group-item list-group-item-action bg-white"
                        >Mejores clientes</a
                    >
                    <a
                        href="pedidosPorFecha.jsp"
                        class="list-group-item list-group-item-action bg-white"
                        >Ordenar por fecha</a
                    >
                     <a
                        href="pedidosPorUsuario.jsp"
                        class="list-group-item list-group-item-action bg-white"
                        >Ver pedidos de un usuario</a
                    > 
                     <a
                        href="pedidosPorProducto.jsp"
                        class="list-group-item list-group-item-action bg-white"
                        >Pedidos por producto</a
                    > 
                </div>
            </div>
            <!-- /#sidebar-wrapper -->

            <!-- Page Content -->
            <div id="page-content-wrapper">
                <nav class="navbar navbar-expand-lg navbar-white bg-white ">
                    <a href class="lead text-dark font-weight-bold" id="menu-toggle"
                       >Herramientas de administración</a
                    >

                    <button
                        class="navbar-toggler"
                        type="button"
                        data-toggle="collapse"
                        data-target="#navbarSupportedContent"
                        aria-controls="navbarSupportedContent"
                        aria-expanded="false"
                        aria-label="Toggle navigation"
                        >
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <ul class="navbar-nav ml-auto mt-2 mt-lg-0">
                        <li class="nav-item">
                            <p class="lead font-weight-bold text-center justify-content-center  p-1"><%=user.getUsername()%></p>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-dark nav-link text-white mr-2" href="logout"
                               >Cerrar Sesión</a
                            >
                        </li>

                        <li>

                        </li>
                    </ul>
                </nav>
                <!-- CONTAINER LOG + DINAMIC PAGE -->
                <div class="container-fluid">
                    <h1 class="font-weight-bold">Pedidos tramitados</h1>
                    <!-- CARRITO -->
                    <table class="table table-dark table-striped text-center">
                        <thead>
                            <tr>
                                <th scope="col">Usuario</th>
                                <th scope="col">Email</th>
                                <th scope="col">Pedidos realizados</th>
                                <th scope="col">Gastado</th>

                            </tr>
                        </thead>

                        <%if (lista != null) {%>
                        <%for (BestCliente c : lista) {%>


                        <tr>
                            
                            <td class="align-middle"><%=c.getUsername()%></td>
                            <td class="align-middle"><%=c.getEmail()%></td>                              
                            <td class="align-middle"><%=c.getNumeroPedidos()%></td>  
                            <td class="align-middle"><%=df.format(c.getGastado())%>€</td>  

                        </tr>
                        <%}%>
                        <%}%>
                    </table>
                    <!-- CARRITO -->
                </div>
                <!-- CONTAINER LOGO + DINAMIC PAGE -->
            </div>
            <!-- /#page-content-wrapper -->
        </div>
        <!-- /#wrapper -->
        <!-- FOOTER -->
        <footer class="footerColor text-white text-left text-lg-start mt-5">
            <!-- Grid container -->
            <div class="container p-4">
                <!--Grid row-->
                <div class="row">
                    <!--Grid column-->
                    <div class="col-lg-6 col-md-12 mb-4 mb-md-0">
                        <h5 class="text-uppercase">
                            <img
                                src="imagenes/logoWhite.png"
                                width="100px"
                                alt=""
                                srcset=""
                                />
                        </h5>

                        <h2>Acerca de Nike</h2>

                        <p class="acercaDe">
                            Nuestra misión es lo que nos impulsa a hacer todo lo posible para
                            expandir el potencial humano.
                        </p>
                        <p class="acercaDe">
                            Lo hacemos creando innovaciones deportivas pioneras, haciendo que
                            nuestros productos sean más sostenibles, construyendo un equipo
                            global creativo y diverso y generando un impacto positivo en las
                            comunidades donde vivimos y trabajamos.
                        </p>
                    </div>
                    <!--Grid column-->

                    <!--Grid column-->
                    <div class="col-lg-3 col-md-6 mb-4 mb-md-0">
                        <h5 class="text-uppercase">Acerca de NIKE</h5>

                        <ul class="list-unstyled mb-0">
                            <li>
                                <a href="#!" class="text-white">Novedades</a>
                            </li>
                            <li>
                                <a href="#!" class="text-white">Hombres</a>
                            </li>
                            <li>
                                <a href="#!" class="text-white">Mujeres</a>
                            </li>
                            <li>
                                <a href="#!" class="text-white">Niños</a>
                            </li>
                            <li>
                                <a href="#!" class="text-white">Niñas</a>
                            </li>
                            <li>
                                <a href="#!" class="text-white">Sostenibilidad</a>
                            </li>
                        </ul>
                    </div>
                    <!--Grid column-->

                    <!--Grid column-->
                    <div class="col-lg-3 col-md-6 mb-4 mb-md-0">
                        <h5 class="text-uppercase mb-0">Ayuda</h5>

                        <ul class="list-unstyled">
                            <li>
                                <a href="#!" class="text-white">Pedidos y entregas</a>
                            </li>
                            <li>
                                <a href="#!" class="text-white">Contacto</a>
                            </li>
                        </ul>
                    </div>
                    <!--Grid column-->
                </div>
                <!--Grid row-->
            </div>
            <!-- Grid container -->

            <!-- Copyright -->
            <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2)">
                © 2020 GitHub:
                <a class="text-white" target="blank" href="https://github.com/joserm91"
                   >#joserm91</a
                >
            </div>
            <!-- Copyright -->
        </footer>
        <!-- FOOTER -->

        <!-- Bootstrap core JavaScript -->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- Menu Toggle Script -->
        <script>
            $("#menu-toggle").click(function (e) {
                e.preventDefault();
                $("#wrapper").toggleClass("toggled");
            });
        </script>
    </body>
</html>
