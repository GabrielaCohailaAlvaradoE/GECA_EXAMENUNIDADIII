package com.edu.geca.EXAIII_GECA.modeloDAO.MDAO_GECA_ModeloDAO;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo.Obj_GECA_FirmaDigital;

public interface Obj_GECA_FirmaDigitalRepository extends JpaRepository<Obj_GECA_FirmaDigital, Integer> {

    List<Obj_GECA_FirmaDigital> findByPlanillaIdPlanilla(Integer idPlanilla);

    Optional<Obj_GECA_FirmaDigital> findTopByPlanillaIdPlanillaAndUsuarioIdUsuarioAndFaseOrderByFechaFirmaDesc(
            Integer idPlanilla, Integer idUsuario, String fase);
}