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
public class BestCliente {
    private String username;
    private String email;
    private int numeroPedidos;
    private double gastado;

    public BestCliente(String username, String email, int numeroPedidos, double gastado) {
        this.username = username;
        this.email = email;
        this.numeroPedidos = numeroPedidos;
        this.gastado = gastado;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getNumeroPedidos() {
        return numeroPedidos;
    }

    public void setNumeroPedidos(int numeroPedidos) {
        this.numeroPedidos = numeroPedidos;
    }

    public double getGastado() {
        return gastado;
    }

    public void setGastado(double gastado) {
        this.gastado = gastado;
    }
    
    
    
}
