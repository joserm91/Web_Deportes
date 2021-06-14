<%@page import="java.text.DecimalFormat"%>
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
        <meta name="author" content="" >

        <title>Información pedido</title>

        <!-- Bootstrap core CSS -->
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
 <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Condensed:ital,wght@1,700&display=swap" rel="stylesheet">
        <script src="https://kit.fontawesome.com/79a941ea93.js" crossorigin="anonymous"></script>
        <!-- Custom styles for this template -->
        <link href="css/simple-sidebar.css" rel="stylesheet"/>
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
        int idPedido = Integer.parseInt(request.getParameter("idPedido"));
        String userName = (request.getParameter("userName"));
        String userEmail = (request.getParameter("userEmail"));
        String fechaC = (request.getParameter("fechaC"));
        ArrayList<LineaDePedido> desglose = DB.infoLP(idPedido);
        int objetos = 0;
        int contadorItems = 0;
        double total = 0;
        DecimalFormat df = new DecimalFormat("#.00");
        if (desglose != null) {

            for (LineaDePedido lp : desglose) {
                System.out.print(lp.getId_lineadepedido() + "<-------");
                objetos += lp.getCantidad();

            }
        }

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
                        class="list-group-item list-group-item-action bg-white herramientasLinks text-center"
                        ><i class="fas fa-users fa-3x"></i><span style="font-size: 13px">Filtrar por usuario</span></a
                    > 
                    <a
                        href="pedidosPorProducto.jsp"
                        class="list-group-item list-group-item-action bg-white herramientasLinks text-center"
                        ><i class="fas fa-cubes fa-3x"></i><span style="font-size: 13px">Filtrar por producto</span></a
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
                <div class="container-fluid mt-5 ">
                    <table class="table table-dark text-center w-50" style="margin-bottom: 10px !important;" border="1">
                        <h3>Nº Pedido: <%=idPedido%></h3>
                        <thead>
                        <th class="align-middle p-1">Usuario</th>
                        <th class="align-middle p-1">Email</th>
                        <th class="align-middle p-1">Fecha compra</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="align-middle p-1"><%=userName%></td>
                                <td class="align-middle p-1"><%=userEmail%></td>
                                <td class="align-middle p-1"><%=fechaC%></td>
                            </tr>
                        </tbody>
                    </table>
                    
                    
                    <!-- CARRITO -->
                    <table class="table table-dark table-striped text-center">
                        <thead>
                            <tr>
                                <th scope="col">Foto</th>
                                <th scope="col">Producto</th>
                                <th scope="col">Categoría</th>
                                <th scope="col">Cantidad</th>
                                <th scope="col">Precio</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                String categoria = "";
                                for (LineaDePedido lp : desglose) {%>

                            <%
                                Producto prod = DB.infoProductoPorId(lp.getProductos_idproductos());
                                contadorItems += lp.getCantidad();
                                total += lp.getCantidad() * prod.getPrecio();

                                int catego = prod.getCategoria();
                                switch (catego) {
                                    case 1:
                                        categoria = "niño";
                                        break;
                                    case 2:
                                        categoria = "niña";
                                        break;
                                    case 3:
                                        categoria = "hombre";
                                        break;
                                    case 4:
                                        categoria = "mujer";
                                        break;
                                    case 5:
                                        categoria = "novedades";
                                        break;
                                    default:
                                        categoria = "0";
                                        break;

                                }
                            %>
                            <tr>
                                <th scope="row " ><img 
                                        data-toggle="modal"
                                        data-target="#exampleModal<%=prod.getId_producto()%>"
                                        class="img-fluid rounded fotitoCarrito" width="100px" src="images_zapatillas/<%=categoria%>/<%=prod.getFoto()%>"></th>
                                <td class="align-middle"><%=prod.getNombre_producto()%></td>
                                <td class="align-middle text-capitalize"><%=categoria%></td>  
                                <td class="align-middle"><%=lp.getCantidad()%></td>
                                <td class="align-middle"><%=prod.getPrecio()%>€/ud.</td>


                            </tr>

                            <%}%>
                            <tr>
                                <th scope="row"></th>
                                <td></td>
                                <td></td>
                                <td>Artículos</td>
                                <td>Total</td>
                                <td></td>
                            </tr>
                            <tr>
                                <th class="align-middle" scope="row"></th>
                                <td></td>
                                <td></td>

                                <td class="align-middle"><%=contadorItems%></td>
                                <td class="align-middle"><%if (contadorItems > 0) {%><%=df.format(total)%><%} else {%>0<%}%>€</td>
                                <td class="align-middle">

                                    <a href="pedidosTramitados.jsp"  class="btn btn-outline-info">Volver a pedidos</a></td>

                            </tr>

                        </tbody>
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
        <!-- MODAL -->

        <%for (LineaDePedido lp : desglose) {%>
        <%

            Producto prod = DB.infoProductoPorId(lp.getProductos_idproductos());

        %>
        <div
            class="modal fade"

            id="exampleModal<%=lp.getProductos_idproductos()%>"
            tabindex="-1"
            aria-labelledby="exampleModalLabel"
            aria-hidden="true"
            >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel"><%=prod.getNombre_producto()%></h5>
                        <button
                            type="button"
                            class="close"
                            data-dismiss="modal"
                            aria-label="Close"
                            >
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <img
                            class="img-fluid w-100"
                            <%

                                int catego = prod.getCategoria();
                                switch (catego) {
                                    case 1:
                                        categoria = "niño";
                                        break;
                                    case 2:
                                        categoria = "niña";
                                        break;
                                    case 3:
                                        categoria = "hombre";
                                        break;
                                    case 4:
                                        categoria = "mujer";
                                        break;
                                    case 5:
                                        categoria = "novedades";
                                        break;
                                    default:
                                        categoria = "0";
                                        break;
                                }
                            %>
                            src="images_zapatillas/<%=categoria%>/<%=prod.getFoto()%>"
                            alt=""
                            srcset=""
                            />
                    </div>

                </div>
            </div>
        </div>

        <%}%>

        <!-- MODAL -->
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