package com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo;

import java.math.BigDecimal;

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
@Table(name = "asientos_contables")
public class Obj_GECA_AsientoContable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_asiento")
    private Integer idAsiento;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_planilla", nullable = false)
    private Obj_GECA_Planilla planilla;

    @Column(nullable = false, length = 10)
    private String cuenta;

    @Column(nullable = false, length = 100)
    private String denominacion;

    @Column(precision = 12, scale = 2)
    private BigDecimal debe;

    @Column(precision = 12, scale = 2)
    private BigDecimal haber;

    public Integer getIdAsiento() {
        return idAsiento;
    }

    public void setIdAsiento(Integer idAsiento) {
        this.idAsiento = idAsiento;
    }

    public Obj_GECA_Planilla getPlanilla() {
        return planilla;
    }

    public void setPlanilla(Obj_GECA_Planilla planilla) {
        this.planilla = planilla;
    }

    public String getCuenta() {
        return cuenta;
    }

    public void setCuenta(String cuenta) {
        this.cuenta = cuenta;
    }

    public String getDenominacion() {
        return denominacion;
    }

    public void setDenominacion(String denominacion) {
        this.denominacion = denominacion;
    }

    public BigDecimal getDebe() {
        return debe;
    }

    public void setDebe(BigDecimal debe) {
        this.debe = debe;
    }

    public BigDecimal getHaber() {
        return haber;
    }

    public void setHaber(BigDecimal haber) {
        this.haber = haber;
    }
}