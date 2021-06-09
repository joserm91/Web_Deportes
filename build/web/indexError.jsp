<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
            />
        <meta name="description" content="" />
        <meta name="author" content="" />

        <title>NIKE</title>

        <!-- Bootstrap core CSS -->
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />

        <!-- Custom styles for this template -->
        <link href="css/simple-sidebar.css" rel="stylesheet" />
        <!-- css -->

        <link rel="stylesheet" href="css/login.css">
        <!-- css -->
        <!-- Bootstrap styles&Scripts -->
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        
        <!------ Include the above in your HEAD tag ---------->
        <link rel="shortcut icon" href="imagenes/error.png" type="image/x-icon">
    </head>
    <%
        String errores = "";
        String erroresDeRegistro = "";
        String faltaLog ="";
        errores = (String) request.getServletContext().getAttribute("erroresEnLogin");
        erroresDeRegistro = (String) request.getServletContext().getAttribute("erroresDeRegistro");
        faltaLog = (String) request.getServletContext().getAttribute("faltaLog");

    %>
    <body>
        <div class="d-flex" id="wrapper">


            <!-- Page Content -->
            <div id="page-content-wrapper">
                <nav class="navbar navbar-expand-lg navbar-white bg-white">

                    <ul class="navbar-nav ml-auto mt-2 mt-lg-0">
                        <li class="nav-item active">
                            <a class="nav-link text-dark" href="#"></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-dark" href="#"></a>
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
                        <h4><Novedades></h4>
                        <!-- FORM LOGIN -->
                        <div class="container">
                            <div class="row">
                                <div class="col-md-6 col-md-offset-3">
                                    <div class="panel panel-login">
                                        <div class="panel-heading">
                                            <div class="row">
                                                <div class="col-xs-6">
                                                    <a href="index.jsp" class="active" id="login-form-link">Iniciar sesión</a>
                                                </div>
                                                <div class="col-xs-6">
                                                    <a href="registro.jsp" id="register-form-link">Regístrate ahora</a>
                                                </div>
                                            </div>
                                            <hr>
                                        </div>
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="col-lg-12">

                                                    <form id="login-form" action="ServletRegistro_Login" method="GET" role="form" style="display: block;">
                                                        <div class="form-group">
                                                           <%if(faltaLog != null){%>
                                                                <span class="errorEnLogin" style="color: red"><%=faltaLog%></span>
                                                            <%
                                                                    faltaLog = "";
                                                                    request.getServletContext().setAttribute("faltaLog", faltaLog);
                                                                }%>
                                                            <%if (errores != null) {%>
                                                            <span class="errorEnLogin" style="color: red"><%=errores%></span>
                                                            <%
                                                                    errores = "";
                                                                    request.getServletContext().setAttribute("errores", errores);
                                                                }%>
                                                                </br>
                                                                 
                                                            <input type="text" name="username" id="username" tabindex="1" class="form-control" placeholder="Usuario" value="">
                                                        </div>
                                                        <div class="form-group">
                                                            <input type="password" name="password" id="password" tabindex="2" class="form-control" placeholder="Contraseña">
                                                        </div>

                                                        <div class="form-group">
                                                            <div class="row">
                                                                <div class="col-sm-6 col-sm-offset-3">
                                                                    <input type="submit" name="login-submit" id="login-submit" tabindex="4" class="form-control btn btn-login" value="Iniciar sesión">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="form-group mb-5">
                                                            <div class="row">
                                                                <div class="col-lg-12 mb-5">
                                                                    <div class="text-center">
                                                                        <a href="#" tabindex="5" class="forgot-password">¿Has olvidado tu contraseña?</a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </form>
                                                    <form id="register-form" action="ServletRegistro" method="POST" role="form" style="display: none;">
                                                        <div class="form-group">
                                                            <%if (erroresDeRegistro != null) {%>
                                                            <span class="erroresDeRegistro" style="color: red"><%=erroresDeRegistro%></span>
                                                            <%
                                                                    erroresDeRegistro = "";
                                                                    request.getServletContext().setAttribute("erroresDeRegistro", erroresDeRegistro);
                                                                }%>
                                                            <input type="text" name="username" id="username" tabindex="1" class="form-control" placeholder="Usuario" value="">
                                                        </div>
                                                        <div class="form-group">
                                                            <input type="email" name="email" id="email" tabindex="1" class="form-control" placeholder="Correo electronico" value="">
                                                        </div>
                                                        <div class="form-group">
                                                            <input type="password" name="password" id="password" tabindex="2" class="form-control" placeholder="Contraseña">
                                                        </div>
                                                        <div class="form-group">
                                                            <input type="password" name="confirm-password" id="confirm-password" tabindex="2" class="form-control" placeholder="Confirmar contraseña">
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="row">
                                                                <div class="col-sm-6 col-sm-offset-3">
                                                                    <input type="submit" name="register-submit" id="register-submit" tabindex="4" class="form-control btn btn-register" value="Crear cuenta">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- FORM LOGIN -->
                    </div>
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
                        <h5 class="text-uppercase"><img src="imagenes/logoWhite.png" width="100px" alt="" srcset=""></h5>

                        <h2> Acerca de Nike</h2>

                        <p class="acercaDe">Nuestra misión es lo que nos impulsa a hacer todo lo posible para expandir el potencial humano. </p>
                        <p class="acercaDe">Lo hacemos creando innovaciones deportivas pioneras, haciendo que nuestros productos sean más sostenibles,
                            construyendo un equipo global creativo y diverso y generando un impacto positivo en las comunidades donde vivimos y trabajamos.</p>


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
                <a class="text-white" target="blank" href="https://github.com/joserm91">#joserm91</a>
            </div>
            <!-- Copyright -->
        </footer>
        <!-- FOOTER -->
        <!-- Bootstrap core JavaScript -->
        <script src="vendor/jquery/jquery.min.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>


        <script>

            //   ALTER REGISTRO & LOGIN   //
             window.onload = cambiar;
            function cambiar(){
                
                 $('#register-form-link').removeClass('active');
                    $('#login-form-link').addClass('active');
                    e.preventDefault();
                
            }
            
            //   ALTER REGISTRO & LOGIN   //
        </script>
    </body>
</html>