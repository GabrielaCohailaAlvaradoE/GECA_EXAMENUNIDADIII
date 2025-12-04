package com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo;

import java.time.LocalDateTime;

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
@Table(name = "comprobantes_pago")
public class Obj_GECA_ComprobantePago {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_comprobante")
    private Integer idComprobante;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_planilla", nullable = false)
    private Obj_GECA_Planilla planilla;

    @Column(name = "ruta_pdf", nullable = false, length = 255)
    private String rutaPdf;

    @Column(name = "fecha_carga", nullable = false)
    private LocalDateTime fechaCarga;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_usuario_carga", nullable = false)
    private Obj_GECA_Usuario usuarioCarga;

    public Integer getIdComprobante() {
        return idComprobante;
    }

    public void setIdComprobante(Integer idComprobante) {
        this.idComprobante = idComprobante;
    }

    public Obj_GECA_Planilla getPlanilla() {
        return planilla;
    }

    public void setPlanilla(Obj_GECA_Planilla planilla) {
        this.planilla = planilla;
    }

    public String getRutaPdf() {
        return rutaPdf;
    }

    public void setRutaPdf(String rutaPdf) {
        this.rutaPdf = rutaPdf;
    }

    public LocalDateTime getFechaCarga() {
        return fechaCarga;
    }

    public void setFechaCarga(LocalDateTime fechaCarga) {
        this.fechaCarga = fechaCarga;
    }

    public Obj_GECA_Usuario getUsuarioCarga() {
        return usuarioCarga;
    }

    public void setUsuarioCarga(Obj_GECA_Usuario usuarioCarga) {
        this.usuarioCarga = usuarioCarga;
    }
}