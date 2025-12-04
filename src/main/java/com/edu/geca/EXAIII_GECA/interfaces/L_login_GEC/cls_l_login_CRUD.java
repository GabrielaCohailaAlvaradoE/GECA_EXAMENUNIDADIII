package com.edu.geca.EXAIII_GECA.interfaces.L_login_GECA;

import java.util.List;
import java.util.Optional;

import com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo.M_GECA_login;
import com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo.Obj_GECA_FirmaDigital;
import com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo.Obj_GECA_Planilla;
import com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo.Obj_GECA_PlanillaDetalle;
import com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo.Obj_GECA_Usuario;

public interface cls_l_login_CRUD {

    Optional<Obj_GECA_Usuario> validarAcceso(M_GECA_login login);

    List<Obj_GECA_Planilla> listarPlanillasGeneradas();

    List<Obj_GECA_PlanillaDetalle> obtenerDetallePlanilla(int idPlanilla);

    List<Obj_GECA_FirmaDigital> obtenerFirmasPlanilla(int idPlanilla);

    Obj_GECA_FirmaDigital firmarPlanilla(int idPlanilla, Obj_GECA_Usuario usuario, String fase, String ipEquipo,
            String observacion);
}