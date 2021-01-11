/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

/**
 *
 * @author Ramos-PC
 */
public class LineaDePedido {
    private int id_lineadepedido;
    private int cantidad;
    private int pedidos_idpedidos;
    private int productos_idproductos;

    public LineaDePedido(int id_lineadepedido, int cantidad, int pedidos_idpedidos, int productos_idproductos) {
        this.id_lineadepedido = id_lineadepedido;
        this.cantidad = cantidad;
        this.pedidos_idpedidos = pedidos_idpedidos;
        this.productos_idproductos = productos_idproductos;
    }

    public int getId_lineadepedido() {
        return id_lineadepedido;
    }

    public void setId_lineadepedido(int id_lineadepedido) {
        this.id_lineadepedido = id_lineadepedido;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public int getPedidos_idpedidos() {
        return pedidos_idpedidos;
    }

    public void setPedidos_idpedidos(int pedidos_idpedidos) {
        this.pedidos_idpedidos = pedidos_idpedidos;
    }

    public int getProductos_idproductos() {
        return productos_idproductos;
    }

    public void setProductos_idproductos(int productos_idproductos) {
        this.productos_idproductos = productos_idproductos;
    }
    
    
}
