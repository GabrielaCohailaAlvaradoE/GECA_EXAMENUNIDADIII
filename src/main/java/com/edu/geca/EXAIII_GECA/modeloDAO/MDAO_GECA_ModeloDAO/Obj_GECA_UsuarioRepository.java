package com.edu.geca.EXAIII_GECA.modeloDAO.MDAO_GECA_ModeloDAO;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo.Obj_GECA_Usuario;

public interface Obj_GECA_UsuarioRepository extends JpaRepository<Obj_GECA_Usuario, Integer> {

    Optional<Obj_GECA_Usuario> findByUsernameAndPasswordAndEstadoIsTrue(String username, String password);
}