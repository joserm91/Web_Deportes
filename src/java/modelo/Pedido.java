/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.Date;

/**
 *
 * @author Ramos-PC
 */
public class Pedido {
    private int idpedidos;
    private double precio_total;
    private Date fecha;
    private int usuarios_idusuarios;
    private boolean comprado;

    public Pedido(int idpedidos, double precio_total, Date fecha, int usuarios_idusuarios, boolean comprado) {
        this.idpedidos = idpedidos;
        this.precio_total = precio_total;
        this.fecha = fecha;
        this.usuarios_idusuarios = usuarios_idusuarios;
        this.comprado = comprado;
    }

    public int getIdpedidos() {
        return idpedidos;
    }

    public void setIdpedidos(int idpedidos) {
        this.idpedidos = idpedidos;
    }

    public double getPrecio_total() {
        return precio_total;
    }

    public void setPrecio_total(double precio_total) {
        this.precio_total = precio_total;
    }

    public Date getFecha() {
        
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public int getUsuarios_idusuarios() {
        return usuarios_idusuarios;
    }

    public void setUsuarios_idusuarios(int usuarios_idusuarios) {
        this.usuarios_idusuarios = usuarios_idusuarios;
    }

    public boolean isComprado() {
        return comprado;
    }

    public void setComprado(boolean comprado) {
        this.comprado = comprado;
    }
    
}
