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
public class Lineal {
    private int cantidad;
    private int mes;

    public Lineal(int cantidad, int mes) {
        this.cantidad = cantidad;
        this.mes = mes;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public int getMes() {
        return mes;
    }

    public void setMes(int mes) {
        this.mes = mes;
    }

    @Override
    public String toString() {
        return "Lineal{" + "cantidad=" + cantidad + ", mes=" + mes + '}';
    }
    
}
