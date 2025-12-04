package com.edu.geca.EXAIII_GECA.controller.C_login_GECA_controlador;

import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.edu.geca.EXAIII_GECA.interfaces.L_login_GECA.cls_l_login_CRUD;
import com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo.M_GECA_login;
import com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo.Obj_GECA_FirmaDigital;
import com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo.Obj_GECA_Planilla;
import com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo.Obj_GECA_PlanillaDetalle;
import com.edu.geca.EXAIII_GECA.modelo.M_GECA_Modelo.Obj_GECA_Usuario;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping
public class C_GECA_login {

    private final cls_l_login_CRUD loginService;

    public C_GECA_login(cls_l_login_CRUD loginService) {
        this.loginService = loginService;
    }

    @GetMapping("/")
    public String inicio(Model model,
                         HttpSession session,
                         @RequestParam(name = "planillaId", required = false) Integer planillaId) {

        Obj_GECA_Usuario usuario = (Obj_GECA_Usuario) session.getAttribute("usuarioGECA");
        cargarPlanillas(model, planillaId);
        model.addAttribute("usuario", usuario);
        model.addAttribute("loginForm", new M_GECA_login());
        return "V_LOGIN_GECA/index";
    }

    private void cargarPlanillas(Model model, Integer planillaId) {
        List<Obj_GECA_Planilla> planillas = loginService.listarPlanillasGeneradas();
        model.addAttribute("planillas", planillas);

        
        
        
        
        
        
        
        
        Obj_GECA_Planilla planillaActual = null;
        if (planillaId != null) {
            planillaActual = planillas.stream().filter(p -> p.getIdPlanilla().equals(planillaId)).findFirst()
                    .orElse(planillas.stream().findFirst().orElse(null));
        } else {
            planillaActual = planillas.stream().findFirst().orElse(null);
        }
        model.addAttribute("planillaActual", planillaActual);

        if (planillaActual != null) {
            List<Obj_GECA_PlanillaDetalle> detalles = loginService.obtenerDetallePlanilla(planillaActual.getIdPlanilla());
            List<Obj_GECA_FirmaDigital> firmas = loginService.obtenerFirmasPlanilla(planillaActual.getIdPlanilla());
            model.addAttribute("detalles", detalles);
            model.addAttribute("firmas", firmas);
        }
    }

    @GetMapping("/login")
    public String mostrarLogin(Model model) {
        if (!model.containsAttribute("loginForm")) {
            model.addAttribute("loginForm", new M_GECA_login());
        }
        return "V_LOGIN_GECA/Login_GECA_validar";
    }

    @GetMapping("/rrhh")
    public String vistaRRHH(Model model, HttpSession session,
            @RequestParam(name = "planillaId", required = false) Integer planillaId,
            RedirectAttributes redirect) {
        if (!asegurarSesion(model, session, redirect)) {
            return "redirect:/login";
        }
        cargarPlanillas(model, planillaId);
        return "V_LOGIN_GECA/fase_rrhh";
    }

    @GetMapping("/gerencia")
    public String vistaGerencia(Model model, HttpSession session,
            @RequestParam(name = "planillaId", required = false) Integer planillaId,
            RedirectAttributes redirect) {
        if (!asegurarSesion(model, session, redirect)) {
            return "redirect:/login";
        }
        cargarPlanillas(model, planillaId);
        return "V_LOGIN_GECA/fase_gerencia";
    }

    @GetMapping("/tesoreria")
    public String vistaTesoreria(Model model, HttpSession session,
            @RequestParam(name = "planillaId", required = false) Integer planillaId,
            RedirectAttributes redirect) {
        if (!asegurarSesion(model, session, redirect)) {
            return "redirect:/login";
        }
        cargarPlanillas(model, planillaId);
        return "V_LOGIN_GECA/fase_tesoreria";
    }

    @GetMapping("/empleado")
    public String vistaEmpleado(Model model, HttpSession session,
            @RequestParam(name = "planillaId", required = false) Integer planillaId,
            RedirectAttributes redirect) {
        if (!asegurarSesion(model, session, redirect)) {
            return "redirect:/login";
        }
        cargarPlanillas(model, planillaId);
        return "V_LOGIN_GECA/fase_empleado";
    }

    @GetMapping("/reporte-firmas")
    public String vistaReporteFirmas(Model model, HttpSession session,
            @RequestParam(name = "planillaId", required = false) Integer planillaId,
            RedirectAttributes redirect) {
        if (!asegurarSesion(model, session, redirect)) {
            return "redirect:/login";
        }
        cargarPlanillas(model, planillaId);
        return "V_LOGIN_GECA/fase_reporte";
    }

    @PostMapping("/login")
    public String procesarLogin(@ModelAttribute("loginForm") M_GECA_login loginForm, HttpServletRequest request,
            HttpSession session, RedirectAttributes redirect) {
        Optional<Obj_GECA_Usuario> usuarioOpt = loginService.validarAcceso(loginForm);
        if (usuarioOpt.isEmpty()) {
            redirect.addFlashAttribute("error", "Credenciales inválidas o usuario inactivo.");
            redirect.addFlashAttribute("loginForm", loginForm);
            return "redirect:/login";
        }

        Obj_GECA_Usuario usuario = usuarioOpt.get();
        if (!estaEnHorario(usuario)) {
            redirect.addFlashAttribute("error", "Fuera del horario permitido para autenticación.");
            redirect.addFlashAttribute("loginForm", loginForm);
            return "redirect:/login";
        }

        session.setAttribute("usuarioGECA", usuario);
        redirect.addFlashAttribute("success", "Ingreso correcto. Bienvenido " + usuario.getNombreCompleto());
        return "redirect:/";
    }

    private boolean asegurarSesion(Model model, HttpSession session, RedirectAttributes redirect) {
        Obj_GECA_Usuario usuario = (Obj_GECA_Usuario) session.getAttribute("usuarioGECA");
        if (usuario == null) {
            redirect.addFlashAttribute("error", "Debe iniciar sesión para acceder al módulo.");
            return false;
        }
        model.addAttribute("usuario", usuario);
        return true;
    }

    @PostMapping("/logout")
    public String cerrarSesion(HttpSession session, RedirectAttributes redirect) {
        session.invalidate();
        redirect.addFlashAttribute("success", "Sesión cerrada correctamente.");
        return "redirect:/";
    }

    @PostMapping("/firmar")
    public String firmarPlanilla(@RequestParam("planillaId") int planillaId, @RequestParam("observacion") String observacion,
            HttpSession session, HttpServletRequest request, RedirectAttributes redirect) {
        Obj_GECA_Usuario usuario = (Obj_GECA_Usuario) session.getAttribute("usuarioGECA");
        if (usuario == null) {
            redirect.addFlashAttribute("error", "Debe iniciar sesión para firmar la planilla.");
            return "redirect:/login";
        }

        String fase = deducirFase(usuario);
        if (fase == null) {
            redirect.addFlashAttribute("error", "Su rol no tiene una fase de firma asignada.");
            return "redirect:/";
        }

        String ipActual = request.getRemoteAddr();
        String observacionFinal = observacion;
        if (requiereIpRestrictiva(usuario) && !ipCoincide(usuario, ipActual)) {
            
            
            
            
            
            
            observacionFinal = StringUtils.hasText(observacion) ? observacion
                    : "Firma observada por intento desde IP distinta: " + ipActual;
        }

        loginService.firmarPlanilla(planillaId, usuario, fase, ipActual, observacionFinal);
        redirect.addFlashAttribute("success", "Firma registrada para la fase " + fase + " con IP " + ipActual);
        return "redirect:/?planillaId=" + planillaId;
    }

    private boolean requiereIpRestrictiva(Obj_GECA_Usuario usuario) {
        return usuario.getRol() != null && "RRHH".equalsIgnoreCase(usuario.getRol().getNombreRol());
    }

    private boolean ipCoincide(Obj_GECA_Usuario usuario, String ipActual) {
        if (!StringUtils.hasText(usuario.getIpPermitida())) {
            return true;
        }
        return usuario.getIpPermitida().trim().equals(ipActual);
    }

    private boolean estaEnHorario(Obj_GECA_Usuario usuario) {
        LocalTime ahora = LocalTime.now();
        LocalTime inicio = usuario.getHorarioIngreso();
        LocalTime salida = usuario.getHorarioSalida();
        if (inicio == null || salida == null) {
            return true;
        }
        return !ahora.isBefore(inicio) && !ahora.isAfter(salida);
    }

    private String deducirFase(Obj_GECA_Usuario usuario) {
        if (usuario.getRol() == null) {
            return null;
        }
        return switch (usuario.getRol().getNombreRol()) {
        case "RRHH" -> "FASE2_RRHH";
        case "GERENTE_FINANCIERO" -> "FASE3_GER_FIN";
        case "GERENTE_GENERAL" -> "FASE3_GER_GRAL";
        case "TESORERIA" -> "FASE4_TESORERIA";
        case "CONTABILIDAD" -> "FASE4_CONTABILIDAD";
        case "EMPLEADO" -> "FASE6_EMPLEADO";
        case "JEFE" -> "FASE7_REPORTE";
        default -> "FASE1_CALCULO";
        };
    }
}
