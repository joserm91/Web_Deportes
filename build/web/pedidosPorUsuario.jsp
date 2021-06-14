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

        <title>Filtro usuarios</title>

        <!-- Bootstrap core CSS -->
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Condensed:ital,wght@1,700&display=swap" rel="stylesheet">
        <script src="https://kit.fontawesome.com/79a941ea93.js" crossorigin="anonymous"></script>
        <!-- Custom styles for this template -->
        <link href="css/simple-sidebar.css" rel="stylesheet" />
        <link rel="stylesheet" href="css/index.css" />
        <link rel="stylesheet" href="css/cssGeneral.css" />
        <link rel="shortcut icon" href="imagenes/admin.png" type="image/x-icon">
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
        ArrayList<Pedido> lista = (ArrayList<Pedido>) sesion.getAttribute("pedidosTramitadosUsiario");


    %>
    <body>
        <div class="d-flex" id="wrapper">
            <!-- Sidebar -->
            <div class="bg-white border-right" id="sidebar-wrapper">
                <div class="sidebar-heading text-center">
                    <a href="vistaAdmin.jsp" >               
                        <img src="imagenes/admin.png" width="60px" alt="" srcset="" />
                    </a>

                </div>
                <div class="list-group list-group-flush mt-4">
                    <a
                        href="pedidosTramitados.jsp"
                        class="list-group-item list-group-item-action bg-white herramientasLinks text-center"
                        ><i class="fas fa-boxes fa-3x"></i><span style="font-size: 13px">Pedidos Tramitados</span></a>
                    <a
                        href="topVentas.jsp"
                        class="list-group-item list-group-item-action bg-white herramientasLinks text-center"
                        ><i class="fas fa-medal fa-3x"></i><span style="font-size: 13px">Top Ventas</span></a>
                    <a
                        href="mejoresClientes.jsp"
                        class="list-group-item list-group-item-action bg-white herramientasLinks text-center" 
                        ><i class="fas fa-crown fa-3x"></i><span style="font-size: 13px">Mejores clientes</span></a
                    >
                    <a
                        href="pedidosPorFecha.jsp"
                        class="list-group-item list-group-item-action bg-white herramientasLinks text-center"
                        ><i class="fas fa-calendar fa-3x"></i><span style="font-size: 13px">Filtrar por fecha</span></a
                    >
                    <a
                        href="pedidosPorUsuario.jsp"
                        class="list-group-item list-group-item-action  bg-dark herramientasLinks text-center active"
                        ><i class="fas fa-users fa-3x"></i><span style="font-size: 13px">Filtrar por usuario</span></a
                    > 
                    <form class="form-group" action="ServletFiltroUsers" method="POST">
                        <label class="font-weight-bold">Username:</label><input class="form-control" type="text" name="username">

                        <input class="btn btn-outline-info" type="submit" value="Filtrar">
                    </form>
                    <a
                        href="pedidosPorProducto.jsp"
                        class="list-group-item list-group-item-action  bg-white herramientasLinks text-center"
                        ><i class="fas fa-cubes fa-3x"></i><span style="font-size: 13px">Filtrar por producto</span></a
                    > 

                </div>
            </div>
            <!-- /#sidebar-wrapper -->

            <!-- Page Content -->
            <div class="container-fluid" id="page-content-wrapper">
                <nav class="navbar navbar-expand-lg navbar-white bg-light ">
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

                            <a href="logout" id="btnCerrar" data-toggle="modal" data-target="#modalLogout">
                                <!-- cerrar sesion -->
                                <i class="fas fa-power-off fa-2x btnOff mt-2"></i>
                            </a>
                        </li>

                        <li>

                        </li>
                    </ul>
                </nav>
                <!-- CONTAINER LOG + DINAMIC PAGE -->
                <div class="container-fluid mt-5">
                    <h1 class="font-weight-bold"><i class="fas fa-users fa-3x"></i></h1>&nbsp;<h3>Filtrado por usuario</h3>
                    <!-- CARRITO -->
                    <table class="table table-dark table-striped text-center">
                        <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Gastado</th>
                                <th scope="col">Fecha</th>
                                <th scope="col">Usuario</th>
                                <th scope="col">Email</th>
                                <th scope="col">Estado</th>

                            </tr>
                        </thead>

                        <%if (lista != null) {%>
                        <%for (Pedido pedi : lista) {%>
                        <%
                            String fechaC = pedi.getFecha().toString();
                            System.out.print(fechaC);
                            if (fechaC != null && fechaC != "") {
                                fechaC = fechaC.substring(0, fechaC.length() - 2);
                                fechaC = fechaC.replace(" ", " -- ");
                            }
                            Usuario infoU = DB.infoUsuario(pedi.getUsuarios_idusuarios());
                            String estado = "";
                            if (pedi.isComprado()) {
                                estado = "Tramitado";
                            } else {
                                estado = "Pendiente";
                            }
                        %>
                        <tr>
                            <th scope="row"><a class="text-info" href="desglose.jsp?idPedido=<%=pedi.getIdpedidos()%>&userName=<%=infoU.getUsername()%>&userEmail=<%=infoU.getEmail()%>&fechaC=<%=fechaC%>"><i class="fas fa-bars fa-1x"></i> </a></th>
                            <td class="align-middle"><%=df.format(pedi.getPrecio_total())%>€</td>
                            <td class="align-middle"><%=fechaC%></td>                              
                            <td class="align-middle"><%=infoU.getUsername()%></td>
                            <td class="align-middle"><%=infoU.getEmail()%></td>
                            <td class="align-middle"><%=estado%></td>
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
        <!-- Modal confirm -->
        <div class="modal fade" id="modalLogout" tabindex="-1" role="dialog" aria-labelledby="modalLogout" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header  w-100">
                        <h5 class="modal-title w-100 font-weight-bold text-danger"><p class="w-100 text-center">Aviso</p></h5>
                        <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p class="text-center">¿Está seguro que quiera cerrar sesión?</p>
                    </div>
                    <div class="modal-footer ">
                        <a href="logout"   class="btn btn-white text-dark">Si</a>
                        <button type="button" class="btn btn-dark text-white" data-dismiss="modal">No</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal confirm -->
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