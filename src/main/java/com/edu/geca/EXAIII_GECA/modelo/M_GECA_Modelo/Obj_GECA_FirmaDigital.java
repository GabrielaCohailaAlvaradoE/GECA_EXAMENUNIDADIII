package com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "firmas_digitales")
public class Obj_GECA_FirmaDigital {

    public enum EstadoFirma { FIRMADO, OBSERVADO, PENDIENTE }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_firma")
    private Integer idFirma;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_planilla", nullable = false)
    private Obj_GECA_Planilla planilla;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_usuario", nullable = false)
    private Obj_GECA_Usuario usuario;

    @Column(nullable = false, length = 30)
    private String fase;

    @Column(name = "fecha_firma", nullable = false)
    private LocalDateTime fechaFirma;

    @Column(name = "ip_equipo", nullable = false, length = 50)
    private String ipEquipo;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 10)
    private EstadoFirma estado = EstadoFirma.FIRMADO;

    @Column(length = 255)
    private String observacion;

    public Integer getIdFirma() {
        return idFirma;
    }

    public void setIdFirma(Integer idFirma) {
        this.idFirma = idFirma;
    }

    public Obj_GECA_Planilla getPlanilla() {
        return planilla;
    }

    public void setPlanilla(Obj_GECA_Planilla planilla) {
        this.planilla = planilla;
    }

    public Obj_GECA_Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Obj_GECA_Usuario usuario) {
        this.usuario = usuario;
    }

    public String getFase() {
        return fase;
    }

    public void setFase(String fase) {
        this.fase = fase;
    }

    public LocalDateTime getFechaFirma() {
        return fechaFirma;
    }

    public void setFechaFirma(LocalDateTime fechaFirma) {
        this.fechaFirma = fechaFirma;
    }

    public String getIpEquipo() {
        return ipEquipo;
    }

    public void setIpEquipo(String ipEquipo) {
        this.ipEquipo = ipEquipo;
    }

    public EstadoFirma getEstado() {
        return estado;
    }

    public void setEstado(EstadoFirma estado) {
        this.estado = estado;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }
}