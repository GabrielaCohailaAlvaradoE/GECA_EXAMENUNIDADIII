package com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo;

/**
 * Modelo utilizado para la autenticación de usuarios dentro del flujo de
 * firmas digitales de planillas.
 */
public class M_GECA_login {

    private String username;
    private String password;

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
}
