package com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "planillas")
public class Obj_GECA_Planilla {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_planilla")
    private Integer idPlanilla;

    @Column(name = "periodo_mes", nullable = false)
    private Integer periodoMes;

    @Column(name = "periodo_anio", nullable = false)
    private Integer periodoAnio;

    @Column(name = "fecha_generacion", nullable = false)
    private LocalDateTime fechaGeneracion;

    @Column(nullable = false, length = 20)
    private String estado;

    @Column(name = "total_bruto", precision = 12, scale = 2)
    private BigDecimal totalBruto;

    @Column(name = "total_descuentos", precision = 12, scale = 2)
    private BigDecimal totalDescuentos;

    @Column(name = "total_neto", precision = 12, scale = 2)
    private BigDecimal totalNeto;

    @OneToMany(mappedBy = "planilla", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<Obj_GECA_PlanillaDetalle> detalles;

    public Integer getIdPlanilla() {
        return idPlanilla;
    }

    public void setIdPlanilla(Integer idPlanilla) {
        this.idPlanilla = idPlanilla;
    }

    public Integer getPeriodoMes() {
        return periodoMes;
    }

    public void setPeriodoMes(Integer periodoMes) {
        this.periodoMes = periodoMes;
    }

    public Integer getPeriodoAnio() {
        return periodoAnio;
    }

    public void setPeriodoAnio(Integer periodoAnio) {
        this.periodoAnio = periodoAnio;
    }

    public LocalDateTime getFechaGeneracion() {
        return fechaGeneracion;
    }

    public void setFechaGeneracion(LocalDateTime fechaGeneracion) {
        this.fechaGeneracion = fechaGeneracion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
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

    public BigDecimal getTotalNeto() {
        return totalNeto;
    }

    public void setTotalNeto(BigDecimal totalNeto) {
        this.totalNeto = totalNeto;
    }

    public List<Obj_GECA_PlanillaDetalle> getDetalles() {
        return detalles;
    }

    public void setDetalles(List<Obj_GECA_PlanillaDetalle> detalles) {
        this.detalles = detalles;
    }
}