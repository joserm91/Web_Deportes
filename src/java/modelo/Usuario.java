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
public class Usuario {

    private int idusuario;
    private String username;
    private String password;
    private String email;
    private String rol;

    public Usuario(int idusuario, String username, String password, String email, String rol) {
        this.idusuario = idusuario;
        this.username = username;
        this.password = password;
        this.email = email;
        this.rol = rol;
    }

    public int getIdusuario() {
        return idusuario;
    }

    public void setIdusuario(int idusuario) {
        this.idusuario = idusuario;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    @Override
    public String toString() {
        return "Usuario{" + "idusuario=" + idusuario + ", username=" + username + ", password=" + password + ", email=" + email + ", rol=" + rol + '}';
    }
    
    
    
}
