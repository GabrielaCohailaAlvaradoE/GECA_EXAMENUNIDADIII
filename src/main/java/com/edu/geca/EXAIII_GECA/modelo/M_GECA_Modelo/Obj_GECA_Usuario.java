package com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo;

import java.time.LocalTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "usuarios")
public class Obj_GECA_Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_usuario")
    private Integer idUsuario;

    @Column(nullable = false, length = 50, unique = true)
    private String username;

    @Column(nullable = false, length = 200)
    private String password;

    @Column(name = "nombre_completo", length = 100)
    private String nombreCompleto;

    @Column(length = 100)
    private String email;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_rol", nullable = false)
    private Obj_GECA_Rol rol;

    @Column(nullable = false)
    private boolean estado = true;

    @Column(name = "ip_permitida", length = 50)
    private String ipPermitida;

    @Column(name = "horario_ingreso")
    private LocalTime horarioIngreso;

    @Column(name = "horario_salida")
    private LocalTime horarioSalida;

    public Integer getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Integer idUsuario) {
        this.idUsuario = idUsuario;
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

    public String getNombreCompleto() {
        return nombreCompleto;
    }

    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Obj_GECA_Rol getRol() {
        return rol;
    }

    public void setRol(Obj_GECA_Rol rol) {
        this.rol = rol;
    }

    public boolean isEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }

    public String getIpPermitida() {
        return ipPermitida;
    }

    public void setIpPermitida(String ipPermitida) {
        this.ipPermitida = ipPermitida;
    }

    public LocalTime getHorarioIngreso() {
        return horarioIngreso;
    }

    public void setHorarioIngreso(LocalTime horarioIngreso) {
        this.horarioIngreso = horarioIngreso;
    }

    public LocalTime getHorarioSalida() {
        return horarioSalida;
    }

    public void setHorarioSalida(LocalTime horarioSalida) {
        this.horarioSalida = horarioSalida;
    }
}