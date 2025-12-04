package com.edu.geca.EXAIII_GECA.modeloDAO.MDAO_GECA_ModeloDAO;

import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.edu.geca.EXAIII_GECA.interfaces.L_login_GECA.cls_l_login_CRUD;
import com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo.M_GECA_login;
import com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo.Obj_GECA_FirmaDigital;
import com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo.Obj_GECA_FirmaDigital.EstadoFirma;
import com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo.Obj_GECA_Planilla;
import com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo.Obj_GECA_PlanillaDetalle;
import com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo.Obj_GECA_Usuario;

@Service
public class MDAO_GECA_login implements cls_l_login_CRUD {

    private final Obj_GECA_UsuarioRepository usuarioRepository;
    private final Obj_GECA_PlanillaRepository planillaRepository;
    private final Obj_GECA_PlanillaDetalleRepository detalleRepository;
    private final Obj_GECA_FirmaDigitalRepository firmaDigitalRepository;

    public MDAO_GECA_login(Obj_GECA_UsuarioRepository usuarioRepository,
            Obj_GECA_PlanillaRepository planillaRepository,
            Obj_GECA_PlanillaDetalleRepository detalleRepository,
            Obj_GECA_FirmaDigitalRepository firmaDigitalRepository) {
        this.usuarioRepository = usuarioRepository;
        this.planillaRepository = planillaRepository;
        this.detalleRepository = detalleRepository;
        this.firmaDigitalRepository = firmaDigitalRepository;
    }

    @Override
    public Optional<Obj_GECA_Usuario> validarAcceso(M_GECA_login login) {
        if (login == null || login.getUsername() == null || login.getPassword() == null) {
            return Optional.empty();
        }
        return usuarioRepository.findByUsernameAndPasswordAndEstadoIsTrue(login.getUsername(), login.getPassword());
    }

    @Override
    public List<Obj_GECA_Planilla> listarPlanillasGeneradas() {
        List<Obj_GECA_Planilla> planillas = planillaRepository.findAll();
        planillas.sort(Comparator.comparing(Obj_GECA_Planilla::getPeriodoAnio)
                .thenComparing(Obj_GECA_Planilla::getPeriodoMes).reversed());
        return planillas;
    }

    @Override
    public List<Obj_GECA_PlanillaDetalle> obtenerDetallePlanilla(int idPlanilla) {
        return detalleRepository.findByPlanillaIdPlanilla(idPlanilla);
    }

    @Override
    public List<Obj_GECA_FirmaDigital> obtenerFirmasPlanilla(int idPlanilla) {
        return firmaDigitalRepository.findByPlanillaIdPlanilla(idPlanilla);
    }

    @Override
    @Transactional
    public Obj_GECA_FirmaDigital firmarPlanilla(int idPlanilla, Obj_GECA_Usuario usuario, String fase, String ipEquipo,
            String observacion) {
        Obj_GECA_Planilla planilla = planillaRepository.findById(idPlanilla)
                .orElseThrow(() -> new IllegalArgumentException("Planilla no encontrada"));

        Optional<Obj_GECA_FirmaDigital> firmaExistente = firmaDigitalRepository
                .findTopByPlanillaIdPlanillaAndUsuarioIdUsuarioAndFaseOrderByFechaFirmaDesc(planilla.getIdPlanilla(),
                        usuario.getIdUsuario(), fase);

        Obj_GECA_FirmaDigital firma = firmaExistente.orElseGet(Obj_GECA_FirmaDigital::new);
        firma.setPlanilla(planilla);
        firma.setUsuario(usuario);
        firma.setFase(fase);
        firma.setFechaFirma(LocalDateTime.now());
        firma.setIpEquipo(ipEquipo);
        firma.setEstado(observacion != null && !observacion.isBlank() ? EstadoFirma.OBSERVADO : EstadoFirma.FIRMADO);
        firma.setObservacion(observacion);

        return firmaDigitalRepository.save(firma);
    }
}
