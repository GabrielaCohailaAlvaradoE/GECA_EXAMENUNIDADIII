package com.edu.geca.EXAIII_GECA.modeloDAO.MDAO_GECA_ModeloDAO;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo.Obj_GECA_PlanillaDetalle;

public interface Obj_GECA_PlanillaDetalleRepository extends JpaRepository<Obj_GECA_PlanillaDetalle, Integer> {

    List<Obj_GECA_PlanillaDetalle> findByPlanillaIdPlanilla(Integer idPlanilla);
}