/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import modelo.BestCliente;
import modelo.LineaDePedido;
import modelo.Lineal;
import modelo.Pedido;
import modelo.Producto;
import modelo.ProductoEstrella;
import modelo.Usuario;

public class DB {

    public static String usuario = "root";
    public static String password = "";
    public static String servidor = "localhost:3306";
    public static String basedatos = "bbdd_nike";

    public static boolean finalizarPedido(int idpedido, double total) {
        Producto prod = null;
        Connection cnn = null;

        try {
            cnn = CrearConexion();
            String sql = "UPDATE pedidos set comprado = 1,precio_total = ? WHERE idpedidos = ?";
            PreparedStatement pst = cnn.prepareStatement(sql);
            pst.setDouble(1, total);
            pst.setInt(2, idpedido);

            pst.executeUpdate();
            return true;

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> infoProductoPorId()");
        }
        return false;
    }

    public static ArrayList<Pedido> buscarPedidosContenedores(int idProducto) {
        ArrayList<Pedido> listaDePedidos = new ArrayList<Pedido>();
        Pedido pedi = null;
        Connection cnn = null;

        try {
            cnn = CrearConexion();

            String sql = "SELECT * FROM pedidos,linea_pedido WHERE comprado = 1 AND pedidos.idpedidos = linea_pedido.pedidos_idpedidos AND linea_pedido.productos_idproductos = ?";
            PreparedStatement pst = cnn.prepareStatement(sql);
            pst.setInt(1, idProducto);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("idpedidos");
                double precio_total = rs.getDouble("precio_total");

                java.util.Date fecha = new Date(1);
                Timestamp timestamp = rs.getTimestamp("fecha");

                int idUser = rs.getInt("usuarios_idusuarios");
                boolean comprado = true;
                pedi = new Pedido(idUser, precio_total, timestamp, idProducto, comprado);
                listaDePedidos.add(pedi);
            }

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> infoProductoPorId()");
        }
        return listaDePedidos;

    }

    public DB() {
        Connection cnn = null;
        try {
            cnn = CrearConexion();
        } catch (SQLException ex) {
            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static Connection CrearConexion() throws SQLException {
        Connection cnn = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");//Invocamos al driver
            String url = "jdbc:mysql://" + servidor + "/" + basedatos;
            cnn = DriverManager.getConnection(url, usuario, password); //nos conectamos a la base de datos
            System.out.println("exito");
        } catch (ClassNotFoundException e) {
            System.out.println("Controlador JDBC no encontrado" + e.toString());
        } catch (Exception e) {
            System.out.println("Otras excepciones" + e.toString());
        }

        return cnn;
    }

    public static boolean usuarioExiste(String usuario, String password) {

        Connection cnn = null;
        try {
            cnn = CrearConexion();

            String sql = "SELECT * FROM usuarios WHERE username = ? AND password = ?";
            PreparedStatement pst = cnn.prepareStatement(sql);
            pst.setString(1, usuario);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                return true;
            }

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> usuarioExiste()");
            return false;
        }

        return false;
    }

    public static Usuario confirmaRol(String usuario, String password) {
        Usuario user = null;
        Connection cnn = null;
        String rol = "";
        try {
            cnn = CrearConexion();

            String sql = "SELECT * FROM usuarios WHERE username = ? AND password = ?";
            PreparedStatement pst = cnn.prepareStatement(sql);
            pst.setString(1, usuario);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {

                int idusuario = rs.getInt("idusuarios");
                String username = rs.getString("username");
                password = rs.getString("password");
                String email = rs.getString("email");
                rol = rs.getString("rol");

                user = new Usuario(idusuario, usuario, password, email, rol);
            }

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> confirmaRol()");

        }

        return user;
    }

    public static String usuarioRepetido(String usuario, String password, String email) {

        Connection cnn = null;
        try {
            cnn = CrearConexion();

            String sql = "SELECT * FROM usuarios WHERE username = ?";
            PreparedStatement pst = cnn.prepareStatement(sql);
            pst.setString(1, usuario);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                return "repe";
            }

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> usuarioRepetido()");
            return "repe";
        }

        return "norepe";
    }

    public static String emailRepetido(String usuario, String password, String email) {

        Connection cnn = null;
        try {
            cnn = CrearConexion();

            String sql = "SELECT * FROM usuarios WHERE email = ?";
            PreparedStatement pst = cnn.prepareStatement(sql);
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                return "repe";
            }

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> emailRepetido()");
            return "repe";
        }

        return "norepe";
    }

    public static boolean registro(String usuario, String password, String email, String rol) {

        Connection cnn = null;
        try {
            cnn = CrearConexion();

            String sql = "INSERT INTO usuarios(username, password, rol, email) VALUES (?,?,?,?)";
            PreparedStatement pst = cnn.prepareStatement(sql);
            pst.setString(1, usuario);
            pst.setString(2, password);
            pst.setString(3, rol);
            pst.setString(4, email);
            pst.executeUpdate();
            return true;

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> emailRepetido()");
            return false;
        }

    }

    public static ArrayList<Producto> infoProductosPorCategoria(int numeroCategoria) {
        ArrayList listaProductos = null;
        Connection cnn = null;
        try {
            cnn = CrearConexion();

            String sql = "SELECT * FROM productos WHERE categorias_idcategorias = ?";
            PreparedStatement pst = cnn.prepareStatement(sql);
            pst.setInt(1, numeroCategoria);
            ResultSet rs = pst.executeQuery();
            listaProductos = new ArrayList<Producto>();
            Producto infoPro;
            while (rs.next()) {

                int id_producto = rs.getInt("idproductos");
                String nombre_producto = rs.getString("nombre_producto");
                int categoria = numeroCategoria;
                double precio = rs.getDouble("precio");
                String foto = rs.getString("foto");
                infoPro = new Producto(id_producto, nombre_producto, categoria, precio, foto);
                listaProductos.add(infoPro);
            }

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> infoProductosPorCategoria()");

        }
        return listaProductos;
    }

    public static Producto addToCesta(int idProductoElegido, int idUsuario, int idPedido) {
//------------------------------------------------------------------------------ LINEA DE PEDIDO
        Producto infoProdu = null;
        Connection cnn = null;

        try {
            cnn = CrearConexion();

            boolean lineaExiste = false;

            String sql = "SELECT productos_idproductos,cantidad FROM linea_pedido WHERE productos_idproductos = ? AND pedidos_idpedidos = ?";
            PreparedStatement pst = cnn.prepareStatement(sql);
            pst.setInt(1, idProductoElegido);
            pst.setInt(2, idPedido);
            ResultSet rs = pst.executeQuery();
            int cantidad = 0;
            while (rs.next()) {
                lineaExiste = true;
                cantidad = rs.getInt("cantidad");
            }

            if (lineaExiste) {
                cantidad++;
                sql = "UPDATE linea_pedido SET cantidad = ? WHERE pedidos_idpedidos = ? AND productos_idproductos = ?";
                pst = cnn.prepareStatement(sql);
                pst.setInt(1, cantidad);
                pst.setInt(2, idPedido);
                pst.setInt(3, idProductoElegido);
                pst.executeUpdate();

            } else {
                sql = "SELECT * FROM productos WHERE idproductos = ?";
                pst = cnn.prepareStatement(sql);
                pst.setInt(1, idProductoElegido);
                rs = pst.executeQuery();
                while (rs.next()) {

                    String nombre_producto = rs.getString("nombre_producto");
                    double precio = rs.getDouble("precio");
                    int categorias_idcategorias = rs.getInt("categorias_idcategorias");
                    String foto = rs.getString("foto");

                    infoProdu = new Producto(idProductoElegido, nombre_producto, categorias_idcategorias, precio, foto);

                    String sql2 = "INSERT INTO linea_pedido(cantidad, pedidos_idpedidos, productos_idproductos) VALUES (?,?,?)";
                    pst = cnn.prepareStatement(sql2);
                    pst.setInt(1, 1);
                    pst.setInt(2, idPedido);
                    pst.setInt(3, idProductoElegido);
                    pst.executeUpdate();

                }

            }

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> addToCesta()");

        }
        return infoProdu;
    }

    public static Pedido abrirNuevoPedido(Usuario user) {
//------------------------------------------------------------------------------ LINEA DE PEDIDO
        Pedido pedido = null;
        Connection cnn = null;

        try {
            cnn = CrearConexion();
            String sql = "INSERT INTO pedidos(usuarios_idusuarios, comprado,fecha) VALUES (?,?,?)";
            PreparedStatement pst = cnn.prepareStatement(sql);

            java.util.Date d = new java.util.Date();
            java.sql.Date fecha = new java.sql.Date(d.getTime());

            SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy/MM/dd kk:mm:ss");
            String fechaC = formatoFecha.format(fecha);
            pst.setInt(1, user.getIdusuario());
            pst.setInt(2, 0);
            pst.setString(3, fechaC);
            pst.executeUpdate();

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> abrirNuevoPedido()");

        }

        pedido = DB.TienePedidoSinPagar(user);

        return pedido;
    }

    public static Pedido TienePedidoSinPagar(Usuario user) {
//------------------------------------------------------------------------------ LINEA DE PEDIDO
        Pedido pedido = null;
        Connection cnn = null;

        try {
            cnn = CrearConexion();
            String sql = "SELECT * FROM pedidos WHERE usuarios_idusuarios = ? AND comprado = 0";
            PreparedStatement pst = cnn.prepareStatement(sql);
            pst.setInt(1, user.getIdusuario());
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int idpedido = rs.getInt("idpedidos");
                double precio_total = rs.getDouble("precio_total");
                Timestamp fecha = rs.getTimestamp("fecha");
                int idUsuario = rs.getInt("usuarios_idusuarios");
                int pendiente = rs.getInt("comprado");
                boolean comprado = false;

                if (pendiente == 0) {
                    comprado = false;
                } else {
                    comprado = true;
                }

                pedido = new Pedido(idpedido, precio_total, fecha, idUsuario, comprado);

            }

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> addToCesta()");
        }
        return pedido;
    }

    public static ArrayList<Producto> currentCesta(int idPedido) {//CORREGIR
        ArrayList<Producto> cesta = new ArrayList<Producto>();
        Connection cnn = null;
        try {
            cnn = CrearConexion();
            String sql = "SELECT * FROM linea_pedido WHERE pedidos_idpedidos = ?";
            PreparedStatement pst = cnn.prepareStatement(sql);
            System.out.println("ID DEL PEDIDO -> " + idPedido);
            pst.setInt(1, idPedido);
            ResultSet rs = pst.executeQuery();
            String ids = "";

            while (rs.next()) {

                int productos = rs.getInt("productos_idproductos");
                ids += productos + ";";

            }

            String idDeProductos[] = ids.split(";");

            for (int i = 0; i < idDeProductos.length; i++) {

                sql = "SELECT * FROM productos WHERE idproductos = ?";
                pst = cnn.prepareStatement(sql);
                pst.setString(1, idDeProductos[i]);
                rs = pst.executeQuery();
                Producto pro = null;

                while (rs.next()) {

                    int id_producto = rs.getInt("idproductos");
                    String nombre_producto = rs.getString("nombre_producto");
                    int categoria = rs.getInt("categorias_idcategorias");
                    double precio = rs.getDouble("precio");
                    String foto = rs.getString("foto");
                    pro = new Producto(id_producto, nombre_producto, categoria, precio, foto);
                    System.out.println(pro);
                    cesta.add(pro);

                }

            }

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> currentCesta()");

        }

        return cesta;
    }

    public static ArrayList<LineaDePedido> infoLP(int idPedido) {
//------------------------------------------------------------------------------ LINEA DE PEDIDO
        ArrayList<LineaDePedido> lp = null;
        Connection cnn = null;

        try {

            cnn = CrearConexion();
            lp = new ArrayList<LineaDePedido>();

            String sql = "SELECT * FROM linea_pedido WHERE pedidos_idpedidos = ?";
            PreparedStatement pst = cnn.prepareStatement(sql);

            pst.setInt(1, idPedido);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int id_lineadepedido = rs.getInt("id_lineadepedido");
                int cantidad = rs.getInt("cantidad");
                int pedidos_idpedidos = rs.getInt("pedidos_idpedidos");
                int productos_idproductos = rs.getInt("productos_idproductos");
                LineaDePedido infoLP = new LineaDePedido(id_lineadepedido, cantidad, pedidos_idpedidos, productos_idproductos);
                lp.add(infoLP);
            }

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> infoLP()");
        }
        return lp;

    }

    public static Producto infoProductoPorId(int idProducto) {
//------------------------------------------------------------------------------ LINEA DE PEDIDO
        Producto prod = null;
        Connection cnn = null;

        try {
            cnn = CrearConexion();

            String sql = "SELECT * FROM productos WHERE idproductos = ?";
            PreparedStatement pst = cnn.prepareStatement(sql);
            pst.setInt(1, idProducto);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int idproductos = rs.getInt("idproductos");
                String nombre_producto = rs.getString("nombre_producto");
                double precio = rs.getDouble("precio");
                int categoria = rs.getInt("categorias_idcategorias");
                String foto = rs.getString("foto");
                prod = new Producto(idproductos, nombre_producto, categoria, precio, foto);

            }

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> infoProductoPorId()");
        }
        return prod;
    }

    public static boolean modificarLinea(String accion, int idPedido, int idProducto, int cantidad) {
        Connection cnn = null;
        try {
            cnn = CrearConexion();
            String sql = "";
            PreparedStatement pst = null;

            switch (accion) {

                case "sumar":
                    cantidad++;
                    sql = "UPDATE linea_pedido SET cantidad = ? WHERE pedidos_idpedidos = ? AND productos_idproductos = ?";
                    pst = cnn.prepareStatement(sql);
                    pst.setInt(1, cantidad);
                    pst.setInt(2, idPedido);
                    pst.setInt(3, idProducto);
                    pst.executeUpdate();
                    return true;
                case "restar":
                    cantidad--;
                    sql = "UPDATE linea_pedido SET cantidad = ? WHERE pedidos_idpedidos = ? AND productos_idproductos = ?";
                    pst = cnn.prepareStatement(sql);
                    pst.setInt(1, cantidad);
                    pst.setInt(2, idPedido);
                    pst.setInt(3, idProducto);
                    pst.executeUpdate();
                    return true;

                case "eliminar":
                    sql = "DELETE FROM linea_pedido WHERE pedidos_idpedidos = ? AND productos_idproductos = ?";
                    pst = cnn.prepareStatement(sql);
                    pst.setInt(1, idPedido);
                    pst.setInt(2, idProducto);
                    pst.executeUpdate();
                    return true;
                default:
                    return false;

            }

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> modificarLinea()");
        }
        return false;
    }

    public static ArrayList<Pedido> pedidosTramitados() {
        ArrayList<Pedido> pedidosTramitados = new ArrayList<Pedido>();
        Pedido pedi = null;
        Connection cnn = null;

        try {
            cnn = CrearConexion();

            String sql = "SELECT * FROM pedidos WHERE comprado = 1";
            PreparedStatement pst = cnn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("idpedidos");
                double precio_total = rs.getDouble("precio_total");

                Timestamp fecha = rs.getTimestamp("fecha");

                int idUser = rs.getInt("usuarios_idusuarios");
                boolean comprado = true;
                pedi = new Pedido(id, precio_total, fecha, idUser, comprado);
                pedidosTramitados.add(pedi);
            }

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> infoProductoPorId()");
        }
        return pedidosTramitados;

    }

    public static Usuario infoUsuario(int idU) {
        Usuario user = null;

        Connection cnn = null;

        try {
            cnn = CrearConexion();

            String sql = "SELECT * FROM usuarios WHERE idusuarios = ?";
            PreparedStatement pst = cnn.prepareStatement(sql);
            pst.setInt(1, idU);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("idusuarios");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String email = rs.getString("email");
                String rol = rs.getString("rol");
                user = new Usuario(id, username, password, email, rol);
            }

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> infoProductoPorId()");
        }
        return user;
    }

    public static ArrayList<Pedido> pedidosTramitadosPorFecha(String fecha1, String fecha2) {
        ArrayList<Pedido> pedidosTramitados = new ArrayList<Pedido>();
        Pedido pedi = null;
        Connection cnn = null;

        try {
            cnn = CrearConexion();

            String sql = "SELECT * FROM pedidos WHERE COMPRADO = 1 AND fecha BETWEEN ? AND ?";
            PreparedStatement pst = cnn.prepareStatement(sql);
            pst.setString(1, fecha1);
            pst.setString(2, fecha2);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("idpedidos");
                double precio_total = rs.getDouble("precio_total");

                Timestamp fecha = rs.getTimestamp("fecha");

                int idUser = rs.getInt("usuarios_idusuarios");
                boolean comprado = true;
                pedi = new Pedido(id, precio_total, fecha, idUser, comprado);
                pedidosTramitados.add(pedi);
            }

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> infoProductoPorId()");
        }
        return pedidosTramitados;

    }

    public static ProductoEstrella topVentas() {
        ProductoEstrella prod = null;
        Producto produ = null;
        Connection cnn = null;

        try {
            cnn = CrearConexion();

            String sql = "SELECT productos_idproductos,SUM(cantidad) as vendidas FROM linea_pedido,pedidos WHERE linea_pedido.pedidos_idpedidos = pedidos.idpedidos AND pedidos.comprado = 1 AND productos_idproductos = linea_pedido.productos_idproductos group by productos_idproductos order by sum(cantidad)desc limit 1";
            PreparedStatement pst = cnn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                produ = DB.infoProductoPorId(rs.getInt("productos_idproductos"));
                int vendidas = rs.getInt("vendidas");
                int productos_idproductos = rs.getInt("productos_idproductos");
                String nombre_producto = produ.getNombre_producto();
                String foto = produ.getFoto();
                int categoria = produ.getCategoria();
                double precio = produ.getPrecio();
                double total_ganancias = produ.getPrecio() * vendidas;

                prod = new ProductoEstrella(vendidas, productos_idproductos, categoria, nombre_producto, foto, precio, total_ganancias);
            }

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> infoProductoPorId()");
        }
        return prod;

    }

    public static ArrayList<BestCliente> mejoresClientes() {
        ArrayList<BestCliente> lista = new ArrayList<BestCliente>();
        Connection cnn = null;

        BestCliente cliente = null;
        try {
            cnn = CrearConexion();

            String sql = "SELECT username,email,count(DISTINCT(pedidos.idpedidos)) as 'numero_depedidos',SUM(pedidos.precio_total) as 'gastado' FROM usuarios,pedidos WHERE usuarios.idusuarios = pedidos.usuarios_idusuarios group by usuarios.username order by gastado DESC limit 3";
            PreparedStatement pst = cnn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                String name = rs.getString("username");
                String email = rs.getString("email");
                int numero_depedidos = rs.getInt("numero_depedidos");
                double gastado = rs.getDouble("gastado");
                cliente = new BestCliente(name, email, numero_depedidos, gastado);
                lista.add(cliente);
            }

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> infoProductoPorId()");
        }
        return lista;

    }

    public static ArrayList<Pedido> pedidosTramitadosDeUnUsuario(String username) {
        ArrayList<Pedido> pedidosTramitados = new ArrayList<Pedido>();
        Pedido pedi = null;
        Connection cnn = null;

        try {
            cnn = CrearConexion();

            String sqlUser = "SELECT idusuarios FROM usuarios WHERE username = ?";
            PreparedStatement pst = cnn.prepareStatement(sqlUser);
            pst = cnn.prepareStatement(sqlUser);
            pst.setString(1, username);
            pst.executeQuery();
            ResultSet rs = pst.executeQuery();
            int id = 0;

            while (rs.next()) {
                id = rs.getInt("idusuarios");
                System.out.println(id + "<-------------ID USUARIO");
            }

            String sql = "SELECT * FROM pedidos WHERE comprado = 1 AND usuarios_idusuarios = ?";
            pst = cnn.prepareStatement(sql);
            pst.setInt(1, id);
            rs = pst.executeQuery();

            while (rs.next()) {
                int id2 = rs.getInt("idpedidos");
                double precio_total = rs.getDouble("precio_total");

                Timestamp fecha = rs.getTimestamp("fecha");

                int idUser = rs.getInt("usuarios_idusuarios");
                boolean comprado = true;
                pedi = new Pedido(id2, precio_total, fecha, idUser, comprado);
                System.out.println(pedi);
                pedidosTramitados.add(pedi);
            }

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> infoProductoPorId()");
        }
        return pedidosTramitados;

    }

    public static ArrayList<Producto> todosLosProductos() {
//------------------------------------------------------------------------------ LINEA DE PEDIDO
        Producto prod = null;
        Connection cnn = null;
        ArrayList<Producto> listaDeProductos = new ArrayList<Producto>();
        try {
            cnn = CrearConexion();

            String sql = "SELECT * FROM productos";
            PreparedStatement pst = cnn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int idproductos = rs.getInt("idproductos");
                String nombre_producto = rs.getString("nombre_producto");
                double precio = rs.getDouble("precio");
                int categoria = rs.getInt("categorias_idcategorias");
                String foto = rs.getString("foto");
                prod = new Producto(idproductos, nombre_producto, categoria, precio, foto);
                listaDeProductos.add(prod);
            }

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> infoProductoPorId()");
        }
        return listaDeProductos;
    }

    public static ArrayList<ProductoEstrella> mejorVendidos() {
        ProductoEstrella prod = null;
        ArrayList<ProductoEstrella> listaMasVendidos = new ArrayList<ProductoEstrella>();

        Connection cnn = null;
        ArrayList<Producto> listaDeProductos = new ArrayList<Producto>();
        try {
            cnn = CrearConexion();

            String sql = "SELECT productos.foto,productos.nombre_producto,categorias.nombre,productos.precio,linea_pedido.productos_idproductos,sum(cantidad) as vendidos FROM linea_pedido,productos,categorias WHERE productos.idproductos = linea_pedido.productos_idproductos and categorias.idcategorias = productos.categorias_idcategorias GROUP BY productos_idproductos order by vendidos DESC limit 5";
            PreparedStatement pst = cnn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                int idproductos = rs.getInt("linea_pedido.productos_idproductos");
                String nombre_producto = rs.getString("productos.nombre_producto");
                double precio = rs.getDouble("productos.precio");
                String categoriaString = rs.getString("categorias.nombre");
                String foto = rs.getString("productos.foto");
                int vendidos = rs.getInt("vendidos");
                double total = precio * vendidos;
                prod = new ProductoEstrella(vendidos, idproductos, categoriaString, nombre_producto, foto, precio, total);
                listaMasVendidos.add(prod);
            }

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> infoProductoPorId()");
        }

        return listaMasVendidos;
    }
     public static ArrayList<Lineal> graficaLineal() {
        Lineal li = null;
        ArrayList<Lineal> listaLineal = new ArrayList<Lineal>();

        Connection cnn = null;
       
        try {
            cnn = CrearConexion();

            String sql = "SELECT sum(comprado) as vendido,month(fecha) as mes FROM `pedidos` where comprado = 1 group by month(fecha)";
            PreparedStatement pst = cnn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
               int cantidad = rs.getInt("vendido");
               int mes = rs.getInt("mes");
               li =new Lineal(cantidad, mes);
                listaLineal.add(li);
            }

        } catch (SQLException ex) {
            System.out.println(ex + " PROBLEMAS EN --> infoProductoPorId()");
        }

        return listaLineal;
    }
    
}
