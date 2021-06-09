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
public class ProductoEstrella {

    private int vendidas; 
    private int idproducto;
    private int categoria;
    private String categoriaString;
    private String nombre_producto;
    private String foto;
    private double precio;
    private double total_ganancias;

    public ProductoEstrella(int vendidas,int idproducto, int categoria, String nombre_producto, String foto, double precio, double total_ganancias) {
        this.vendidas = vendidas;
       
        this.idproducto = idproducto;
        this.categoria = categoria;
        this.nombre_producto = nombre_producto;
        this.foto = foto;
        this.precio = precio;
        this.total_ganancias = total_ganancias;
    }

    public ProductoEstrella(int vendidas, int idproducto, String categoriaString, String nombre_producto, String foto, double precio, double total_ganancias) {
        this.vendidas = vendidas;
        this.idproducto = idproducto;
        this.categoriaString = categoriaString;
        this.nombre_producto = nombre_producto;
        this.foto = foto;
        this.precio = precio;
        this.total_ganancias = total_ganancias;
    }

    public String getCategoriaString() {
        return categoriaString;
    }

    public void setCategoriaString(String categoriaString) {
        this.categoriaString = categoriaString;
    }

    
    
    public int getCategoria() {
        return categoria;
    }

    public void setCategoria(int categoria) {
        this.categoria = categoria;
    }

    public String getFoto() {
        return foto;
    }

    public void setFoto(String foto) {
        this.foto = foto;
    }

    public int getVendidas() {
        return vendidas;
    }

    public void setVendidas(int vendidas) {
        this.vendidas = vendidas;
    }


    public int getIdproducto() {
        return idproducto;
    }

    public void setIdproducto(int idproducto) {
        this.idproducto = idproducto;
    }

    public String getNombre_producto() {
        return nombre_producto;
    }

    public void setNombre_producto(String nombre_producto) {
        this.nombre_producto = nombre_producto;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public double getTotal_ganancias() {
        return total_ganancias;
    }

    public void setTotal_ganancias(double total_ganancias) {
        this.total_ganancias = total_ganancias;
    }

}
