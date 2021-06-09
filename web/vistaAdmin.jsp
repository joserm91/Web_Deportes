<%@page import="modelo.Lineal"%>
<%@page import="modelo.ProductoEstrella"%>
<%@page import="java.util.*"%>
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

<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>


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

        <title>Administración</title>

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
        ArrayList<ProductoEstrella> mejorVendidos = DB.mejorVendidos();
        ArrayList<Lineal> linealList = DB.graficaLineal();
        DecimalFormat df = new DecimalFormat("#.00");

        /* ======== GRÁFICA ===========*/
        Gson gsonObj = new Gson();
        Map<Object, Object> map = null;
        List<Map<Object, Object>> list = new ArrayList<Map<Object, Object>>();

        int c = 0;
        for (ProductoEstrella producto : mejorVendidos) {
            map = new HashMap<Object, Object>();

            map.put("label", producto.getNombre_producto());
            map.put("y", producto.getVendidas());

            if (c == 0) {
                map.put("exploded", true);
            }
            c++;
            list.add(map);
            map = null;
        }

        String dataPoints = gsonObj.toJson(list);

        Gson gsonObj2 = new Gson();
        Map<Object, Object> map2 = null;
        List<Map<Object, Object>> list2 = new ArrayList<Map<Object, Object>>();

        String meses[] = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};

        for (Lineal li : linealList) {
            map2 = new HashMap<Object, Object>();
            map2.put("label", meses[li.getMes()]);
            map2.put("y", li.getCantidad());
            list2.add(map2);
            map2 = null;
        }

        String dataPoints2 = gsonObj2.toJson(list2);
    %>

    <body>
        <div class="d-flex" id="wrapper">
            <!-- Sidebar -->
            <div class="bg-white border-right" id="sidebar-wrapper">
                <div class="sidebar-heading text-center">
                    <img src="imagenes/admin.png" width="60px" alt="" srcset="" />
                </div>
                <!-- acordeon -->
                <div id="accordion" class="container-fluid">

                    <h5 class="mb-0 text-center">
                        <button class="btn btn-dark text-white collapsed " data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                            Herramientas
                        </button>
                    </h5>
                </div>
                <!-- acordeon -->
                <div id="collapseTwo" class="collapse m-2" aria-labelledby="headingTwo" data-parent="#accordion">
                    <a
                        href="#"
                        class="list-group-item list-group-item-action bg-white herramientasLinks"
                        >#</a
                    >
                    <a
                        href="vistaAdmin.jsp"
                        class="list-group-item list-group-item-action bg-white herramientasLinks"
                        >Inicio</a
                    >
                    <a
                        href="pedidosTramitados.jsp"
                        class="list-group-item list-group-item-action bg-white herramientasLinks"
                        >Pedidos Tramitados</a
                    >
                    <a
                        href="topVentas.jsp"
                        class="list-group-item list-group-item-action bg-white herramientasLinks"
                        >Top ventas</a
                    >
                    <a
                        href="mejoresClientes.jsp"
                        class="list-group-item list-group-item-action bg-white herramientasLinks" 
                        >Mejores clientes</a
                    >
                    <a
                        href="pedidosPorFecha.jsp"
                        class="list-group-item list-group-item-action bg-white herramientasLinks"
                        >Ordenar por fecha</a
                    >
                    <a
                        href="pedidosPorUsuario.jsp"
                        class="list-group-item list-group-item-action bg-white herramientasLinks"
                        >Filtrar por usuario</a
                    > 
                    <a
                        href="pedidosPorProducto.jsp"
                        class="list-group-item list-group-item-action bg-white herramientasLinks"
                        >Pedidos por producto</a
                    > 

                </div>
            </div>
            <!-- /#sidebar-wrapper -->

            <!-- Page Content -->
            <div id="page-content-wrapper">
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

                    <ul class="navbar-nav ml-auto  mt-lg-2 ">
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

                    <div id="chartContainer" style="height: 370px; width: 100%;overflow: hidden;"></div>                    
                    <div id="chartContainer2" style="height: 370px; width: 100%; margin-top: 50px;overflow: hidden;"></div>
                    <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
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
            /* =============== GRÁFICA ===================== */
            window.onload = function () {

                var chart = new CanvasJS.Chart("chartContainer", {
                    theme: "light2",
                    animationEnabled: true,
                    exportFileName: "web nike",
                    exportEnabled: true,
                    title: {
                        text: "Más vendidos"
                    },
                    data: [{
                            type: "pie",
                            showInLegend: true,
                            legendText: "{label}",
                            toolTipContent: "{label}: <strong>{y} unidades</strong>",
                            indexLabel: "{label}",
                            dataPoints: <%out.print(dataPoints);%>
                        }]
                });

                chart.render();
                //--------------------
                var chart2 = new CanvasJS.Chart("chartContainer2", {
                    theme: "light2",
                    title: {
                        text: "Pedidos por meses"
                    },
                    axisX: {
                        title: ""
                    },
                    axisY: {
                        title: "",
                        includeZero: true
                    },
                    data: [{
                            type: "line",
                            yValueFormatString: "#,## Pedidos",
                            dataPoints: <%out.print(dataPoints2);%>
                        }]
                });
                chart2.render();

            }
        </script>
    </body>
</html>