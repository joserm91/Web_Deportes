<%@page import="java.text.DecimalFormat"%>
<%@page import="modelo.Pedido"%>
<%@page import="modelo.LineaDePedido"%>
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

        
        
        <!-- Bootstrap core CSS -->
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Condensed:ital,wght@1,700&display=swap" rel="stylesheet">
        <script src="https://kit.fontawesome.com/79a941ea93.js" crossorigin="anonymous"></script>
        
        <!-- Custom styles for this template -->
        <link href="css/simple-sidebar.css" rel="stylesheet" />
        <link rel="stylesheet" href="css/index.css" />
        <link rel="stylesheet" href="css/cssGeneral.css" />
        
        <!-- modal confirmacion -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        
        <title>Tu carrito</title>
        <link rel="shortcut icon" href="imagenes/carro.png" type="image/x-icon">
    </head>
    <style>
        .modal-confirm {		
            color: #434e65;
            width: 525px;
        }
        .modal-confirm .modal-content {
            padding: 20px;
            font-size: 16px;
            border-radius: 5px;
            border: none;
        }
        .modal-confirm .modal-header {
            background: #47c9a2;
            border-bottom: none;   
            position: relative;
            text-align: center;
            margin: -20px -20px 0;
            border-radius: 5px 5px 0 0;
            padding: 35px;
        }
        .modal-confirm h4 {
            text-align: center;
            font-size: 36px;
            margin: 10px 0;
        }
        .modal-confirm .form-control, .modal-confirm .btn {
            min-height: 40px;
            border-radius: 3px; 
        }
        .modal-confirm .close {
            position: absolute;
            top: 15px;
            right: 15px;
            color: #fff;
            text-shadow: none;
            opacity: 0.5;
        }
        .modal-confirm .close:hover {
            opacity: 0.8;
        }
        .modal-confirm .icon-box {
            color: #fff;		
            width: 95px;
            height: 95px;
            display: inline-block;
            border-radius: 50%;
            z-index: 9;
            border: 5px solid #fff;
            padding: 15px;
            text-align: center;
        }
        .modal-confirm .icon-box i {
            font-size: 64px;
            margin: -4px 0 0 -4px;
        }
        .modal-confirm.modal-dialog {
            margin-top: 80px;
        }
        .modal-confirm .btn, .modal-confirm .btn:active {
            color: #fff;
            border-radius: 4px;
            background: #eeb711 !important;
            text-decoration: none;
            transition: all 0.4s;
            line-height: normal;
            border-radius: 30px;
            margin-top: 10px;
            padding: 6px 20px;
            border: none;
        }
        .modal-confirm .btn:hover, .modal-confirm .btn:focus {
            background: #eda645 !important;
            outline: none;
        }
        .modal-confirm .btn span {
            margin: 1px 3px 0;
            float: left;
        }
        .modal-confirm .btn i {
            margin-left: 1px;
            font-size: 20px;
            float: right;
        }
        .trigger-btn {
            display: inline-block;
            margin: 100px auto;
        }
    </style>
    <%
        HttpSession sesion = request.getSession();
        Usuario user = (Usuario) sesion.getAttribute("usuario");
        RequestDispatcher rd;
        if (user == null) {
            String faltaLog = "* No se ha iniciado sesión.";
            request.getServletContext().setAttribute("faltaLog", faltaLog);
            String erroresEnLogin = "";
            request.getServletContext().setAttribute("erroresEnLogin", erroresEnLogin);
            rd = request.getRequestDispatcher("indexError.jsp");
            rd.forward(request, response);
        }

        Pedido infoPedido = (Pedido) sesion.getAttribute("pedido");
        int idPedido = infoPedido.getIdpedidos();
        ArrayList<Producto> cesta = (ArrayList<Producto>) sesion.getAttribute("cesta");
        cesta = DB.currentCesta(infoPedido.getIdpedidos());
        ArrayList<LineaDePedido> LP = DB.infoLP(idPedido);
        int objetos = 0;
        int contadorItems = 0;
        double total = 0;
        DecimalFormat df = new DecimalFormat("#.00");
        if (LP != null) {

            for (LineaDePedido lp : LP) {
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
                    <img src="imagenes/nike-3.svg" width="60px" alt="" srcset="" />
                </div>
                <div class="list-group list-group-flush">
                    <a
                        href="novedades.jsp"
                        class="list-group-item list-group-item-action bg-white"
                        >Novedades</a
                    >
                    <a
                        href="hombre.jsp"
                        class="list-group-item list-group-item-action bg-white"
                        >Hombre</a
                    >
                    <a
                        href="mujer.jsp"
                        class="list-group-item list-group-item-action bg-white"
                        >Mujer</a
                    >
                    <a
                        href="ninio.jsp"
                        class="list-group-item list-group-item-action bg-white"
                        >Niño</a
                    >
                    <a
                        href="ninia.jsp"
                        class="list-group-item list-group-item-action bg-white"
                        >Niña</a
                    >
                </div>
            </div>
            <!-- /#sidebar-wrapper -->

            <!-- Page Content -->
            <div id="page-content-wrapper">
                <nav class="navbar navbar-expand-lg navbar-white bg-white ">
                    <a href class="lead text-dark " id="menu-toggle"
                       ><i class="fas fa-bars fa-1x"></i></a
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
                        <!--lead font-weight-bold text-center justify-content-center  p-1-->
                        <li class="nav-item">

                            <a href="logout" id="btnCerrar" data-toggle="modal" data-target="#modalLogout">
                                <!-- cerrar sesion -->
                                <i class="fas fa-power-off fa-2x btnOff mt-2"></i>
                            </a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link text-dark" href="carrito.jsp"
                               ><img
                                    class="img-fluid ml-3"
                                    src="imagenes/carrito.svg"
                                    width="30px"
                                    alt=""
                                    srcset=""
                                    /><%if (LP != null) {%>
                                <span class="lead justify-content-center text-center font-weight-bold bg-dark text-white rounded-circle p-1"><%=objetos%></span>
                                <%} else {%>
                                <span class="lead justify-content-center text-center font-weight-bold bg-dark text-white rounded-circle p-1">objetos</span>
                                <%}%></a>

                        </li>
                        <li>

                        </li>
                    </ul>
                </nav>
                <!-- CONTAINER LOG + DINAMIC PAGE -->
                <div class="container-fluid">
                    <h1 class="my-4">
                        <img
                            class="justdoit"
                            src="imagenes/nike_just_do_it_logo.jpg"
                            alt=""
                            srcset=""
                            />
                    </h1>
                    <h2 class="display-3 parah2 mt-5">EQUÍPATE</h2>

                    <div class="container-fluid mt-5">
                        <h4 class="my-3"><img class="img-fluid mr-5" src="imagenes/nike-3.svg" width="60px" >Tu carrito <img class="img-fluid" width="30px" src="imagenes/carrito.svg"></h4>
                        <!-- CARRITO -->
                        <div class="table-responsive myCartTable">
                            <table class="table table-dark table-striped text-center">
                                <thead>
                                    <tr>
                                        <th scope="col"></th>
                                        <th scope="col">Producto</th>
                                        <th scope="col">Categoría</th>
                                        <th scope="col">Precio</th>
                                        <th scope="col">Unidades</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        String categoria = "";
                                        for (LineaDePedido lp : LP) {%>

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
                                        <td class="align-middle "><%=prod.getNombre_producto()%></td>
                                        <td class="align-middle text-capitalize"><%=categoria%></td>                              
                                        <td class="align-middle"><%=prod.getPrecio()%>€</td>
                                        <td class="align-middle"><%=lp.getCantidad()%></td>
                                        <td class="align-middle"><a href="ServletLineaController?idProducto=<%=prod.getId_producto()%>&idPedido=<%=lp.getPedidos_idpedidos()%>&accion=sumar&cantidad=<%=lp.getCantidad()%>" style="width: 50px" class="btn btn-outline-info">+</a>
                                            <a href="ServletLineaController?idProducto=<%=prod.getId_producto()%>&idPedido=<%=lp.getPedidos_idpedidos()%>&accion=restar&cantidad=<%=lp.getCantidad()%>" style="width: 50px" class="btn btn-outline-warning">-</a>
                                            <a href="ServletLineaController?idProducto=<%=prod.getId_producto()%>&idPedido=<%=lp.getPedidos_idpedidos()%>&accion=eliminar&cantidad=<%=lp.getCantidad()%>" style="width: 100px" class="btn btn-outline-danger">Eliminar</a></td>
                                    </tr>

                                    <%}%>
                                    <tr>
                                        <th scope="row"></th>
                                        <td></td>
                                        <td></td>
                                        <td>TOTAL</td>
                                        <td>Total Unidades</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th class="align-middle" scope="row"></th>
                                        <td></td>
                                        <td></td>
                                        <td class="align-middle"><%if (contadorItems > 0) {%><%=df.format(total)%><%} else {%>0<%}%>€</td>
                                        <td class="align-middle"><%=contadorItems%></td>
                                        <td class="align-middle">
                                            <%if (contadorItems > 0) {%>
                                            <a  class="btn btn-outline-info launch-modal" >Finalizar pedido</a>

                                            <%} else {%>
                                            <a href="novedades.jsp"  class="btn btn-outline-info">Seguir comprando</a></td>
                                            <%}%>
                                    </tr>

                                </tbody>
                            </table>
                        </div>
                                             <!-- CARRITO -->
                    </div>
                </div>
                <button onclick="topFunction()" id="myBtn" title="Go to top"><i class="fa fa-arrow-up fa-2x"></i></button>
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

        <%for (Producto info : cesta) {%>

        <div
            class="modal fade"

            id="exampleModal<%=info.getId_producto()%>"
            tabindex="-1"
            aria-labelledby="exampleModalLabel"
            aria-hidden="true"
            >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel"><%=info.getNombre_producto()%></h5>
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

                                int catego = info.getCategoria();
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
                            src="images_zapatillas/<%=categoria%>/<%=info.getFoto()%>"
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
                        <p class="text-center">¿Seguro que desea cerrar sesión?</p>
                    </div>
                    <div class="modal-footer ">
                        <a href="logout"   class="btn btn-white text-dark">Si</a>
                        <button type="button" class="btn btn-dark text-white" data-dismiss="modal">No</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal confirm -->

        <!-- Modal mySuccessModal -->
        <div id="mySuccessModal" class="modal fade">
            <div class="modal-dialog modal-confirm">
                <div class="modal-content">
                    <div class="modal-header justify-content-center">
                        <div class="icon-box">
                            <i class="material-icons">&#xE876;</i>
                        </div>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body text-center">
                        <h4>Confirmación</h4>	

                        <a class="btn btn-success" onclick="pedidoFinalizadoAlert()" data-dismiss="modal" ><span>Realizar pedido</span> <i class="material-icons">&#xE5C8;</i></a>
                    </div>
                </div>
            </div>
        </div>     
        <!-- Bootstrap core JavaScript -->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- Menu Toggle Script -->
        <script>
                            $("#menu-toggle").click(function (e) {
                                e.preventDefault();
                                $("#wrapper").toggleClass("toggled");
                            });
                            //SCROLL UP
                            //Get the button:
                            mybutton = document.getElementById("myBtn");

                            // When the user scrolls down 20px from the top of the document, show the button
                            window.onscroll = function () {
                                scrollFunction()
                            };

                            function scrollFunction() {
                                if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                                    mybutton.style.display = "block";
                                } else {
                                    mybutton.style.display = "none";
                                }
                            }

                            // When the user clicks on the button, scroll to the top of the document
                            function topFunction() {
                                document.body.scrollTop = 0; // For Safari
                                document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
                            }

                            //Muestra modal de success compra
                            function pedidoFinalizadoAlert() {
                                window.location = "ServletFinalizarPedido?idp=<%=idPedido%>&total=<%=total%>";
                            }


                            $(document).ready(function () {
                                $('.launch-modal').click(function () {
                                    $('#mySuccessModal').modal({
                                        backdrop: 'static'
                                    });
                                });
                            });
        </script>
    </body>
</html>