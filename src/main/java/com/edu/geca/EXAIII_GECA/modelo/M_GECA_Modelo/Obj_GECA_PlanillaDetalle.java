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
@Table(name = "planilla_detalle")
public class Obj_GECA_PlanillaDetalle {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_detalle")
    private Integer idDetalle;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_planilla", nullable = false)
    private Obj_GECA_Planilla planilla;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_empleado", nullable = false)
    private Obj_GECA_Empleado empleado;

    @Column(name = "horas_trabajadas", nullable = false)
    private Integer horasTrabajadas;

    @Column(precision = 10, scale = 2, nullable = false)
    private BigDecimal sueldo;

    @Column(precision = 10, scale = 2)
    private BigDecimal gratificacion;

    @Column(precision = 10, scale = 2)
    private BigDecimal vacaciones;

    @Column(name = "asignacion_familiar", precision = 10, scale = 2)
    private BigDecimal asignacionFamiliar;

    @Column(name = "bonificacion_9", precision = 10, scale = 2)
    private BigDecimal bonificacion9;

    @Column(name = "regimen_salud", precision = 10, scale = 2)
    private BigDecimal regimenSalud;

    @Column(precision = 10, scale = 2)
    private BigDecimal cts;

    @Column(name = "essalud_monto", precision = 10, scale = 2)
    private BigDecimal essaludMonto;

    @Column(name = "afp_monto", precision = 10, scale = 2)
    private BigDecimal afpMonto;

    @Column(name = "onp_monto", precision = 10, scale = 2)
    private BigDecimal onpMonto;

    @Column(name = "total_bruto", precision = 10, scale = 2)
    private BigDecimal totalBruto;

    @Column(name = "total_descuentos", precision = 10, scale = 2)
    private BigDecimal totalDescuentos;

    @Column(name = "neto_pagar", precision = 10, scale = 2)
    private BigDecimal netoPagar;

    public Integer getIdDetalle() {
        return idDetalle;
    }

    public void setIdDetalle(Integer idDetalle) {
        this.idDetalle = idDetalle;
    }

    public Obj_GECA_Planilla getPlanilla() {
        return planilla;
    }

    public void setPlanilla(Obj_GECA_Planilla planilla) {
        this.planilla = planilla;
    }

    public Obj_GECA_Empleado getEmpleado() {
        return empleado;
    }

    public void setEmpleado(Obj_GECA_Empleado empleado) {
        this.empleado = empleado;
    }

    public Integer getHorasTrabajadas() {
        return horasTrabajadas;
    }

    public void setHorasTrabajadas(Integer horasTrabajadas) {
        this.horasTrabajadas = horasTrabajadas;
    }

    public BigDecimal getSueldo() {
        return sueldo;
    }

    public void setSueldo(BigDecimal sueldo) {
        this.sueldo = sueldo;
    }

    public BigDecimal getGratificacion() {
        return gratificacion;
    }

    public void setGratificacion(BigDecimal gratificacion) {
        this.gratificacion = gratificacion;
    }

    public BigDecimal getVacaciones() {
        return vacaciones;
    }

    public void setVacaciones(BigDecimal vacaciones) {
        this.vacaciones = vacaciones;
    }

    public BigDecimal getAsignacionFamiliar() {
        return asignacionFamiliar;
    }

    public void setAsignacionFamiliar(BigDecimal asignacionFamiliar) {
        this.asignacionFamiliar = asignacionFamiliar;
    }

    public BigDecimal getBonificacion9() {
        return bonificacion9;
    }

    public void setBonificacion9(BigDecimal bonificacion9) {
        this.bonificacion9 = bonificacion9;
    }

    public BigDecimal getRegimenSalud() {
        return regimenSalud;
    }

    public void setRegimenSalud(BigDecimal regimenSalud) {
        this.regimenSalud = regimenSalud;
    }

    public BigDecimal getCts() {
        return cts;
    }

    public void setCts(BigDecimal cts) {
        this.cts = cts;
    }

    public BigDecimal getEssaludMonto() {
        return essaludMonto;
    }

    public void setEssaludMonto(BigDecimal essaludMonto) {
        this.essaludMonto = essaludMonto;
    }

    public BigDecimal getAfpMonto() {
        return afpMonto;
    }

    public void setAfpMonto(BigDecimal afpMonto) {
        this.afpMonto = afpMonto;
    }

    public BigDecimal getOnpMonto() {
        return onpMonto;
    }

    public void setOnpMonto(BigDecimal onpMonto) {
        this.onpMonto = onpMonto;
    }

    public BigDecimal getTotalBruto() {
        return totalBruto;
    }

    public void setTotalBruto(BigDecimal totalBruto) {
        this.totalBruto = totalBruto;
    }

    public BigDecimal getTotalDescuentos() {
        return totalDescuentos;
    }

    public void setTotalDescuentos(BigDecimal totalDescuentos) {
        this.totalDescuentos = totalDescuentos;
    }

    public BigDecimal getNetoPagar() {
        return netoPagar;
    }

    public void setNetoPagar(BigDecimal netoPagar) {
        this.netoPagar = netoPagar;
    }
}