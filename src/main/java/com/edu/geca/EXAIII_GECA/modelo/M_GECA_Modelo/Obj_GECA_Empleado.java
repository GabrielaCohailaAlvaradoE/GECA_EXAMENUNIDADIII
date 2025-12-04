package com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo;

import java.math.BigDecimal;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "empleados")
public class Obj_GECA_Empleado {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_empleado")
    private Integer idEmpleado;

    @Column(nullable = false, unique = true, length = 15)
    private String dni;

    @Column(nullable = false, length = 100)
    private String nombres;

    @Column(nullable = false, length = 100)
    private String apellidos;

    @Column(name = "fecha_ingreso")
    private LocalDate fechaIngreso;

    @Column(name = "sueldo_basico", nullable = false, precision = 10, scale = 2)
    private BigDecimal sueldoBasico;

    @Column(name = "tipo_pension", nullable = false, length = 3)
    private String tipoPension;

    @Column(name = "porc_afp", precision = 5, scale = 2)
    private BigDecimal porcAfp;

    @Column(name = "porc_onp", precision = 5, scale = 2)
    private BigDecimal porcOnp;

    @Column(precision = 5, scale = 2)
    private BigDecimal essalud;

    @Column(name = "asignacion_familiar", precision = 10, scale = 2)
    private BigDecimal asignacionFamiliar;

    @Column(nullable = false)
    private boolean estado = true;

    public Integer getIdEmpleado() {
        return idEmpleado;
    }

    public void setIdEmpleado(Integer idEmpleado) {
        this.idEmpleado = idEmpleado;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public LocalDate getFechaIngreso() {
        return fechaIngreso;
    }

    public void setFechaIngreso(LocalDate fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    public BigDecimal getSueldoBasico() {
        return sueldoBasico;
    }

    public void setSueldoBasico(BigDecimal sueldoBasico) {
        this.sueldoBasico = sueldoBasico;
    }

    public String getTipoPension() {
        return tipoPension;
    }

    public void setTipoPension(String tipoPension) {
        this.tipoPension = tipoPension;
    }

    public BigDecimal getPorcAfp() {
        return porcAfp;
    }

    public void setPorcAfp(BigDecimal porcAfp) {
        this.porcAfp = porcAfp;
    }

    public BigDecimal getPorcOnp() {
        return porcOnp;
    }

    public void setPorcOnp(BigDecimal porcOnp) {
        this.porcOnp = porcOnp;
    }

    public BigDecimal getEssalud() {
        return essalud;
    }

    public void setEssalud(BigDecimal essalud) {
        this.essalud = essalud;
    }

    public BigDecimal getAsignacionFamiliar() {
        return asignacionFamiliar;
    }

    public void setAsignacionFamiliar(BigDecimal asignacionFamiliar) {
        this.asignacionFamiliar = asignacionFamiliar;
    }

    public boolean isEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }
}