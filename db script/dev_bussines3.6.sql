

USE `dev_bussines`;

#
# Structure for the `indicadores_impacto` table : 
#

DROP TABLE IF EXISTS `indicadores_impacto`;

CREATE TABLE `indicadores_impacto` (
  `id_indicador` int(11) NOT NULL AUTO_INCREMENT,
  `indicador` varchar(20) NOT NULL,
  PRIMARY KEY (`id_indicador`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

#
# Structure for the `prioridad` table : 
#

DROP TABLE IF EXISTS `prioridad`;

CREATE TABLE `prioridad` (
  `id_prioridad` int(11) NOT NULL AUTO_INCREMENT,
  `problema` text NOT NULL,
  PRIMARY KEY (`id_prioridad`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

#
# Structure for the `perfil_programa` table : 
#

DROP TABLE IF EXISTS `perfil_programa`;

CREATE TABLE `perfil_programa` (
  `id_programa` int(11) NOT NULL AUTO_INCREMENT,
  `denominacion` text NOT NULL,
  `fundamentacion` text NOT NULL,
  `objetivo_especifico` text NOT NULL,
  `principalesResultados` text NOT NULL,
  `potencialHumano` text NOT NULL,
  `presupuesto` double(18,0) NOT NULL,
  `plazoEjecucion` int(2) NOT NULL,
  `otro` text,
  `numero_proyectos` int(11) NOT NULL,
  `id_prioridad` int(11) NOT NULL,
  `id_indicador` int(11) NOT NULL,
  `archivo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_programa`),
  KEY `Refindicadores_impacto781` (`id_indicador`),
  KEY `Refprioridad801` (`id_prioridad`),
  CONSTRAINT `Refindicadores_impacto781` FOREIGN KEY (`id_indicador`) REFERENCES `indicadores_impacto` (`id_indicador`) ON UPDATE CASCADE,
  CONSTRAINT `Refprioridad801` FOREIGN KEY (`id_prioridad`) REFERENCES `prioridad` (`id_prioridad`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

#
# Structure for the `persona` table : 
#

DROP TABLE IF EXISTS `persona`;

CREATE TABLE `persona` (
  `id_persona` int(11) NOT NULL,
  `dni` int(11) NOT NULL COMMENT 'Carne de Identidad',
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(25) NOT NULL,
  `direccion` varchar(80) NOT NULL,
  `correo` varchar(30) NOT NULL,
  `telefono` int(7) DEFAULT NULL,
  `movil` int(7) NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(30) NOT NULL,
  `foto` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_persona`),
  UNIQUE KEY `movil` (`movil`),
  UNIQUE KEY `movil_2` (`movil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `programa` table : 
#

DROP TABLE IF EXISTS `programa`;

CREATE TABLE `programa` (
  `nombre` varchar(25) NOT NULL,
  `id_programa` int(11) NOT NULL,
  `id_persona` int(11) NOT NULL,
  `secretarioprograma` int(11) NOT NULL,
  `objetivoGeneral` text NOT NULL,
  `grupoExpertos` varchar(100) NOT NULL,
  `id_entidad` int(11) NOT NULL,
  `otras_entidades` text,
  PRIMARY KEY (`id_programa`),
  KEY `Ref3458` (`id_programa`),
  KEY `Ref3659` (`id_persona`),
  CONSTRAINT `Refperfil_programa58` FOREIGN KEY (`id_programa`) REFERENCES `perfil_programa` (`id_programa`),
  CONSTRAINT `Refpersona59` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `clasificacion` table : 
#

DROP TABLE IF EXISTS `clasificacion`;

CREATE TABLE `clasificacion` (
  `id_clasificacion` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_clasificacion` varchar(25) NOT NULL,
  PRIMARY KEY (`id_clasificacion`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

#
# Structure for the `provincia` table : 
#

DROP TABLE IF EXISTS `provincia`;

CREATE TABLE `provincia` (
  `id_provincia` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_provincia` varchar(20) NOT NULL,
  PRIMARY KEY (`id_provincia`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

#
# Structure for the `entidad` table : 
#

DROP TABLE IF EXISTS `entidad`;

CREATE TABLE `entidad` (
  `id_entidad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `id_provincia` int(11) NOT NULL,
  `telefono` int(11) DEFAULT NULL,
  `direccion` text,
  `correo` varchar(30) DEFAULT NULL,
  `paginaWeb` varchar(50) DEFAULT NULL,
  `vision` text,
  `mision` text,
  `id_programa` int(11) NOT NULL,
  PRIMARY KEY (`id_entidad`),
  KEY `Ref4155` (`id_provincia`),
  CONSTRAINT `Refprovincia55` FOREIGN KEY (`id_provincia`) REFERENCES `provincia` (`id_provincia`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

#
# Structure for the `tipo_proyecto` table : 
#

DROP TABLE IF EXISTS `tipo_proyecto`;

CREATE TABLE `tipo_proyecto` (
  `id_tipo_proyecto` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(35) NOT NULL,
  PRIMARY KEY (`id_tipo_proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

#
# Structure for the `perfil_proyecto` table : 
#

DROP TABLE IF EXISTS `perfil_proyecto`;

CREATE TABLE `perfil_proyecto` (
  `id_proyecto` int(11) NOT NULL AUTO_INCREMENT,
  `titulo_proyecto` varchar(80) NOT NULL,
  `id_tipo_proyecto` int(11) NOT NULL,
  `id_prioridad` int(11) DEFAULT NULL,
  `id_clasificacion` int(11) NOT NULL,
  `clientes` varchar(50) NOT NULL,
  `duracion` int(11) NOT NULL,
  `presupuesto_total` double(18,0) NOT NULL,
  `resumen` text NOT NULL,
  `fecha_recepcion` date NOT NULL,
  `id_entidad` int(11) NOT NULL,
  `id_programa` int(11) NOT NULL,
  `id_persona` int(11) NOT NULL,
  `otra_institucion` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id_proyecto`),
  UNIQUE KEY `id_prioridad` (`id_prioridad`),
  UNIQUE KEY `id_prioridad_2` (`id_prioridad`),
  KEY `Refclasificacion5` (`id_clasificacion`),
  KEY `Refentidad39` (`id_entidad`),
  KEY `Refjefeproyecto891` (`id_persona`),
  KEY `Refprograma57` (`id_programa`),
  KEY `Reftipo_proyecto78` (`id_tipo_proyecto`),
  CONSTRAINT `Refclasificacion5` FOREIGN KEY (`id_clasificacion`) REFERENCES `clasificacion` (`id_clasificacion`),
  CONSTRAINT `Refentidad39` FOREIGN KEY (`id_entidad`) REFERENCES `entidad` (`id_entidad`),
  CONSTRAINT `Refentidad6` FOREIGN KEY (`id_entidad`) REFERENCES `entidad` (`id_entidad`),
  CONSTRAINT `Refprograma57` FOREIGN KEY (`id_programa`) REFERENCES `programa` (`id_programa`),
  CONSTRAINT `Reftipo_proyecto78` FOREIGN KEY (`id_tipo_proyecto`) REFERENCES `tipo_proyecto` (`id_tipo_proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

#
# Structure for the `proyecto` table : 
#

DROP TABLE IF EXISTS `proyecto`;

CREATE TABLE `proyecto` (
  `numero` int(5) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `nombre_proyecto` varchar(50) NOT NULL,
  PRIMARY KEY (`id_proyecto`),
  UNIQUE KEY `id_proyecto` (`id_proyecto`),
  KEY `Ref3568` (`id_proyecto`),
  CONSTRAINT `Refperfil_proyecto68` FOREIGN KEY (`id_proyecto`) REFERENCES `perfil_proyecto` (`id_proyecto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `anticipo` table : 
#

DROP TABLE IF EXISTS `anticipo`;

CREATE TABLE `anticipo` (
  `id_anticipo` int(11) NOT NULL AUTO_INCREMENT,
  `cantidad_anticipa` double(18,0) NOT NULL,
  `fecha_recibe` date NOT NULL,
  `id_programa` int(11) NOT NULL,
  `anno` year(4) NOT NULL,
  `fecha_firma` date NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `etapa` varchar(20) NOT NULL,
  `nombre_recibe` varchar(40) NOT NULL,
  `cargo_recibe` varchar(20) NOT NULL,
  PRIMARY KEY (`id_anticipo`),
  KEY `Refprograma42` (`id_programa`),
  KEY `Refproyecto41` (`id_proyecto`),
  CONSTRAINT `Refprograma42` FOREIGN KEY (`id_programa`) REFERENCES `programa` (`id_programa`),
  CONSTRAINT `Refproyecto41` FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

#
# Structure for the `auditoria` table : 
#

DROP TABLE IF EXISTS `auditoria`;

CREATE TABLE `auditoria` (
  `id_programa_auditoria` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_auditoria` date NOT NULL,
  `fecha_reunion_apertura` datetime NOT NULL,
  `lugar_reunion_apertura` varchar(30) NOT NULL,
  `dia` int(11) DEFAULT NULL,
  `nombre_auditor` varchar(30) NOT NULL,
  `aspectos_evaluar` varchar(50) NOT NULL,
  `fecha_reunion_auditores` datetime NOT NULL,
  `lugar_reunion_auditores` varchar(30) DEFAULT NULL,
  `fecha_reunion_clausura` datetime NOT NULL,
  `lugar_reunion_clausura` varchar(30) NOT NULL,
  `nombre_enterado` varchar(40) NOT NULL,
  `fecha_enterado` date NOT NULL,
  `comunica` varchar(40) NOT NULL,
  `fecha_comunica` date NOT NULL,
  `id_programa` int(11) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `id_entidad` int(11) NOT NULL,
  PRIMARY KEY (`id_programa_auditoria`),
  KEY `id_programa` (`id_programa`),
  KEY `id_proyecto` (`id_proyecto`),
  KEY `id_entidad` (`id_entidad`),
  CONSTRAINT `auditoria_fk` FOREIGN KEY (`id_proyecto`) REFERENCES `perfil_proyecto` (`id_proyecto`),
  CONSTRAINT `auditoria_fk1` FOREIGN KEY (`id_programa`) REFERENCES `perfil_proyecto` (`id_programa`),
  CONSTRAINT `auditoria_fk2` FOREIGN KEY (`id_entidad`) REFERENCES `perfil_proyecto` (`id_entidad`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Structure for the `cat_cientifica` table : 
#

DROP TABLE IF EXISTS `cat_cientifica`;

CREATE TABLE `cat_cientifica` (
  `id_categoria` int(11) NOT NULL AUTO_INCREMENT,
  `categoria` varchar(20) NOT NULL,
  PRIMARY KEY (`id_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

#
# Structure for the `evaluacion` table : 
#

DROP TABLE IF EXISTS `evaluacion`;

CREATE TABLE `evaluacion` (
  `id_evaluacion` int(11) NOT NULL AUTO_INCREMENT,
  `evaluacion` varchar(50) NOT NULL,
  PRIMARY KEY (`id_evaluacion`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

#
# Structure for the `certificacion_activdades_resultados` table : 
#

DROP TABLE IF EXISTS `certificacion_activdades_resultados`;

CREATE TABLE `certificacion_activdades_resultados` (
  `id_certificacion` int(11) NOT NULL AUTO_INCREMENT,
  `periodo_evaluacion_cert` varchar(20) NOT NULL,
  `actividades_resultados` text NOT NULL,
  `a_r_dos` text,
  `a_r_tres` text,
  `cumplimiento` varchar(10) NOT NULL,
  `cumplimiento_dos` varchar(10) DEFAULT NULL,
  `cumplimiento_tres` varchar(10) DEFAULT NULL,
  `gastos_incurridos` double(18,0) NOT NULL,
  `observaciones` text,
  `nombre_apellidos_presidente` text NOT NULL,
  `fecha_certifica_presidente` date NOT NULL,
  `nombre_apellidos_director` varchar(25) NOT NULL,
  `fecha_certifica_director` date NOT NULL,
  `id_programa` int(11) NOT NULL,
  `id_evaluacion` int(11) NOT NULL,
  `id_anticipo` int(11) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `anno` year(4) NOT NULL,
  PRIMARY KEY (`id_certificacion`),
  KEY `Refanticipo49` (`id_anticipo`),
  KEY `Refevaluacion48` (`id_evaluacion`),
  KEY `Refprograma45` (`id_programa`),
  KEY `Refproyecto44` (`id_proyecto`),
  CONSTRAINT `Refanticipo49` FOREIGN KEY (`id_anticipo`) REFERENCES `anticipo` (`id_anticipo`) ON UPDATE CASCADE,
  CONSTRAINT `Refevaluacion48` FOREIGN KEY (`id_evaluacion`) REFERENCES `evaluacion` (`id_evaluacion`),
  CONSTRAINT `Refprograma45` FOREIGN KEY (`id_programa`) REFERENCES `programa` (`id_programa`),
  CONSTRAINT `Refproyecto44` FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

#
# Structure for the `forma_entrega` table : 
#

DROP TABLE IF EXISTS `forma_entrega`;

CREATE TABLE `forma_entrega` (
  `id_forma_entrega` int(11) NOT NULL AUTO_INCREMENT,
  `informe` varchar(20) NOT NULL,
  PRIMARY KEY (`id_forma_entrega`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

#
# Structure for the `contrato` table : 
#

DROP TABLE IF EXISTS `contrato`;

CREATE TABLE `contrato` (
  `id_contrato` int(11) NOT NULL AUTO_INCREMENT,
  `resultado_actividades` text NOT NULL,
  `duracionInicio` date NOT NULL,
  `duracionFinal` date NOT NULL,
  `id_forma_entrega` int(11) NOT NULL,
  `fechaEntrega` date NOT NULL,
  `cliente_representante_legal` varchar(25) NOT NULL,
  `representante_entidad_ejecutora` varchar(25) NOT NULL,
  `id_proyecto_contrato` int(11) NOT NULL,
  PRIMARY KEY (`id_contrato`,`id_proyecto_contrato`),
  KEY `Refforma_entrega35` (`id_forma_entrega`),
  KEY `Ref4257` (`id_proyecto_contrato`),
  CONSTRAINT `Refforma_entrega35` FOREIGN KEY (`id_forma_entrega`) REFERENCES `forma_entrega` (`id_forma_entrega`) ON UPDATE CASCADE,
  CONSTRAINT `Refproyecto57` FOREIGN KEY (`id_proyecto_contrato`) REFERENCES `proyecto` (`id_proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

#
# Structure for the `control_ejecucion_presupuesto` table : 
#

DROP TABLE IF EXISTS `control_ejecucion_presupuesto`;

CREATE TABLE `control_ejecucion_presupuesto` (
  `id_control_ejecucion_presupuesto` int(11) NOT NULL AUTO_INCREMENT,
  `anno` year(4) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `id_anticipo` int(11) NOT NULL,
  `fecha_terminacion` date DEFAULT NULL,
  `id_certificacion` int(11) NOT NULL,
  `id_notif_ingresos_gastos` int(11) NOT NULL,
  `id_programa` int(11) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `etapa` varchar(20) NOT NULL,
  PRIMARY KEY (`id_control_ejecucion_presupuesto`),
  UNIQUE KEY `id_control_ejecucion_presupuesto` (`id_control_ejecucion_presupuesto`),
  KEY `Refcertificacion_activdades_resultados33` (`id_certificacion`),
  KEY `Refnotificacion_ingreso_gastos34` (`id_notif_ingresos_gastos`),
  KEY `Refproyecto36` (`id_proyecto`),
  KEY `Refprograma37` (`id_programa`),
  KEY `Refanticipo35` (`id_anticipo`),
  CONSTRAINT `Refanticipo35` FOREIGN KEY (`id_anticipo`) REFERENCES `anticipo` (`id_anticipo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Refprograma37` FOREIGN KEY (`id_programa`) REFERENCES `programa` (`id_programa`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Refproyecto36` FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

#
# Structure for the `estado_ejecucion_proyecto` table : 
#

DROP TABLE IF EXISTS `estado_ejecucion_proyecto`;

CREATE TABLE `estado_ejecucion_proyecto` (
  `id_estado_ejecucion_proyecto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_estado_ejecucion_proyecto` varchar(20) NOT NULL,
  PRIMARY KEY (`id_estado_ejecucion_proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

#
# Structure for the `problemas_detectados` table : 
#

DROP TABLE IF EXISTS `problemas_detectados`;

CREATE TABLE `problemas_detectados` (
  `id_problema_detectado` int(11) NOT NULL AUTO_INCREMENT,
  `problema` varchar(20) NOT NULL,
  PRIMARY KEY (`id_problema_detectado`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

#
# Structure for the `control_programa_proyecto` table : 
#

DROP TABLE IF EXISTS `control_programa_proyecto`;

CREATE TABLE `control_programa_proyecto` (
  `id_control` int(11) NOT NULL AUTO_INCREMENT,
  `entidad_finacista` int(11) NOT NULL,
  `otros_aspectos` text,
  `acuerdos_adoptados` text NOT NULL,
  `nombre_apellidos_evaluador` varchar(25) NOT NULL,
  `nombre_apellidos_evaluado` varchar(25) NOT NULL,
  `participante` int(11) NOT NULL,
  `fecha_control` date NOT NULL,
  `id_estado_ejecucion_proyecto` int(11) NOT NULL,
  `id_problema_detectado` int(11) NOT NULL,
  `id_entidad` int(11) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `fecha_firma_evaluado` date NOT NULL,
  `fecha_firma_evaluador` date NOT NULL,
  PRIMARY KEY (`id_control`),
  KEY `Refejecutora75` (`id_entidad`),
  KEY `Refestado_ejecucion_proyecto71` (`id_estado_ejecucion_proyecto`),
  KEY `Refproblemas_detectados72` (`id_problema_detectado`),
  KEY `Refproyecto74` (`id_proyecto`),
  CONSTRAINT `Refestado_ejecucion_proyecto71` FOREIGN KEY (`id_estado_ejecucion_proyecto`) REFERENCES `estado_ejecucion_proyecto` (`id_estado_ejecucion_proyecto`),
  CONSTRAINT `Refproblemas_detectados72` FOREIGN KEY (`id_problema_detectado`) REFERENCES `problemas_detectados` (`id_problema_detectado`),
  CONSTRAINT `Refproyecto74` FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

#
# Structure for the `convocatoria` table : 
#

DROP TABLE IF EXISTS `convocatoria`;

CREATE TABLE `convocatoria` (
  `id_convocatoria` int(11) NOT NULL AUTO_INCREMENT,
  `id_programa_convocatoria` int(11) NOT NULL,
  `texto` text NOT NULL,
  `inicio` date NOT NULL,
  `cierre` date NOT NULL,
  `visibilidad` varchar(20) NOT NULL,
  `id_persona` int(11) NOT NULL,
  PRIMARY KEY (`id_convocatoria`,`id_programa_convocatoria`,`id_persona`),
  KEY `Ref4060` (`id_programa_convocatoria`),
  CONSTRAINT `Refprograma60` FOREIGN KEY (`id_programa_convocatoria`) REFERENCES `programa` (`id_programa`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

#
# Structure for the `dictamen_eval_perfil_proy` table : 
#

DROP TABLE IF EXISTS `dictamen_eval_perfil_proy`;

CREATE TABLE `dictamen_eval_perfil_proy` (
  `id_dictamen` int(11) NOT NULL AUTO_INCREMENT,
  `id_proyecto` int(11) NOT NULL,
  `criterio` text NOT NULL,
  `id_evaluacion` int(11) NOT NULL,
  `observaciones` text,
  `conclusiones` text NOT NULL,
  `recomendaciones` text NOT NULL,
  `fecha_evaluacion` datetime NOT NULL,
  `id_persona` int(5) NOT NULL,
  PRIMARY KEY (`id_dictamen`,`id_proyecto`),
  KEY `Ref3556` (`id_proyecto`),
  KEY `id_persona` (`id_persona`),
  CONSTRAINT `Refperfil_proyecto56` FOREIGN KEY (`id_proyecto`) REFERENCES `perfil_proyecto` (`id_proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

#
# Structure for the `informe_etapa` table : 
#

DROP TABLE IF EXISTS `informe_etapa`;

CREATE TABLE `informe_etapa` (
  `id_informe_etapa` int(11) NOT NULL AUTO_INCREMENT,
  `cumplimiento_cronograma_actividades` text NOT NULL,
  `cumplimiento_resultados_programados` text NOT NULL,
  `id_programa` int(11) NOT NULL,
  `id_entidad` int(11) NOT NULL,
  `id_persona` int(11) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `etapa` varchar(20) NOT NULL,
  `anno` year(4) NOT NULL,
  PRIMARY KEY (`id_informe_etapa`),
  KEY `Refentidad55` (`id_entidad`),
  KEY `Refjefeproyecto56` (`id_persona`),
  KEY `Refprograma53` (`id_programa`),
  KEY `Refproyecto54` (`id_proyecto`),
  CONSTRAINT `Refentidad55` FOREIGN KEY (`id_entidad`) REFERENCES `entidad` (`id_entidad`),
  CONSTRAINT `Refprograma53` FOREIGN KEY (`id_programa`) REFERENCES `programa` (`id_programa`),
  CONSTRAINT `Refproyecto54` FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

#
# Structure for the `dictamen_grupo_expertos_inf_etapa` table : 
#

DROP TABLE IF EXISTS `dictamen_grupo_expertos_inf_etapa`;

CREATE TABLE `dictamen_grupo_expertos_inf_etapa` (
  `id_dictamen_grup_exp` int(11) NOT NULL AUTO_INCREMENT,
  `id_informe_etapa` int(11) NOT NULL,
  `evaluacion_objetivos` int(11) NOT NULL,
  `evaluacion_resultados` int(11) NOT NULL,
  `evaluacion_actividades` int(11) NOT NULL,
  `observaciones` text,
  `conclusiones` varchar(20) NOT NULL,
  `recomendaciones` text,
  `nombre_apellidos_miembroGEP` varchar(25) NOT NULL,
  `fecha_dictamen` date NOT NULL,
  `anno` year(4) NOT NULL,
  PRIMARY KEY (`id_dictamen_grup_exp`,`id_informe_etapa`),
  UNIQUE KEY `id_dictamen_grup_exp` (`id_dictamen_grup_exp`),
  KEY `Refinforme_etapa991` (`id_informe_etapa`),
  CONSTRAINT `Refinforme_etapa991` FOREIGN KEY (`id_informe_etapa`) REFERENCES `informe_etapa` (`id_informe_etapa`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

#
# Structure for the `documentacion_evidencias_objetivas` table : 
#

DROP TABLE IF EXISTS `documentacion_evidencias_objetivas`;

CREATE TABLE `documentacion_evidencias_objetivas` (
  `id_documentacion_evidencias` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_auditor` varchar(25) NOT NULL,
  `nombre_auditado` varchar(10) NOT NULL,
  `deficiencias_evidencias` text NOT NULL,
  `fecha_recogida_info` date NOT NULL,
  `documento` varchar(25) NOT NULL,
  `id_programa` int(11) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  PRIMARY KEY (`id_documentacion_evidencias`),
  KEY `Refprograma88` (`id_programa`),
  KEY `Refproyecto89` (`id_proyecto`),
  CONSTRAINT `Refprograma88` FOREIGN KEY (`id_programa`) REFERENCES `programa` (`id_programa`),
  CONSTRAINT `Refproyecto89` FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

#
# Structure for the `ejecutora` table : 
#

DROP TABLE IF EXISTS `ejecutora`;

CREATE TABLE `ejecutora` (
  `numero_cuenta_bancaria` int(11) NOT NULL,
  `sucursal_creditos` varchar(25) NOT NULL,
  `cifra_planificada` double(18,0) NOT NULL,
  `plan_CIT` text NOT NULL,
  `coeficiente_gastos_directos` float(8,0) NOT NULL,
  `id_persona` int(11) NOT NULL,
  `id_entidad` int(11) NOT NULL,
  PRIMARY KEY (`id_entidad`),
  KEY `Ref1662` (`id_entidad`),
  CONSTRAINT `Refentidad62` FOREIGN KEY (`id_entidad`) REFERENCES `entidad` (`id_entidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `financista` table : 
#

DROP TABLE IF EXISTS `financista`;

CREATE TABLE `financista` (
  `plan_CIT` text NOT NULL,
  `cifra_planificada` double(18,0) NOT NULL,
  `id_programa` int(11) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `id_persona` int(11) NOT NULL,
  `id_entidad` int(11) NOT NULL,
  PRIMARY KEY (`id_entidad`),
  KEY `Ref1661` (`id_entidad`),
  CONSTRAINT `Refentidad61` FOREIGN KEY (`id_entidad`) REFERENCES `entidad` (`id_entidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `grado_cientifico` table : 
#

DROP TABLE IF EXISTS `grado_cientifico`;

CREATE TABLE `grado_cientifico` (
  `id_grado` int(11) NOT NULL AUTO_INCREMENT,
  `grado` varchar(20) NOT NULL,
  PRIMARY KEY (`id_grado`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

#
# Structure for the `i_d` table : 
#

DROP TABLE IF EXISTS `i_d`;

CREATE TABLE `i_d` (
  `antecedentes_justificacion` text NOT NULL,
  `beneficiarios_directos` varchar(25) NOT NULL,
  `clientes` varchar(25) NOT NULL,
  `sostenibilidad_resultados_proyecto` text NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `otros_anexos_i_d` int(80) DEFAULT NULL,
  PRIMARY KEY (`id_proyecto`),
  KEY `Ref4263` (`id_proyecto`),
  CONSTRAINT `Refproyecto63` FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `informe_auditoria` table : 
#

DROP TABLE IF EXISTS `informe_auditoria`;

CREATE TABLE `informe_auditoria` (
  `id_nforme_auditoria` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_confeccion` date NOT NULL,
  `objetivos` text NOT NULL,
  `alcance` text NOT NULL,
  `equipo_auditor` text NOT NULL,
  `documentacion_revisada` text NOT NULL,
  `personal_entrevistado` text NOT NULL,
  `opinion_equipo_auditor` text NOT NULL,
  `no_conformidades_detectadas` text NOT NULL,
  `observaciones` text NOT NULL,
  `elaborado_por` text NOT NULL,
  `id_programa` int(11) NOT NULL,
  `id_entidad` int(11) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `id_documentacion_evidencias` int(11) NOT NULL,
  `auditor_lider` varchar(30) NOT NULL,
  PRIMARY KEY (`id_nforme_auditoria`),
  KEY `Refentidad92` (`id_entidad`),
  KEY `Refprograma91` (`id_programa`),
  KEY `Refproyecto90` (`id_proyecto`),
  KEY `id_documentacion_evidencias` (`id_documentacion_evidencias`),
  CONSTRAINT `Refentidad92` FOREIGN KEY (`id_entidad`) REFERENCES `entidad` (`id_entidad`),
  CONSTRAINT `Refprograma91` FOREIGN KEY (`id_programa`) REFERENCES `programa` (`id_programa`),
  CONSTRAINT `Refproyecto90` FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

#
# Structure for the `informe_ejecucion_programa` table : 
#

DROP TABLE IF EXISTS `informe_ejecucion_programa`;

CREATE TABLE `informe_ejecucion_programa` (
  `id_informe_ejecucion_programa` int(11) NOT NULL AUTO_INCREMENT,
  `nivel_ejecucion_presupuesto` text NOT NULL,
  `etapa` varchar(15) NOT NULL,
  `principales_dificultades` text NOT NULL,
  `conclusiones_recomendaciones` text NOT NULL,
  `fecha_informe` date NOT NULL,
  `cumplimiento_objtvs_propuestos` text NOT NULL,
  `cumplimiento_resultados_programados` text NOT NULL,
  `id_programa` int(11) NOT NULL,
  `id_dictamen_grup_exp` int(11) NOT NULL,
  PRIMARY KEY (`id_informe_ejecucion_programa`,`id_programa`),
  KEY `Refprograma981` (`id_programa`),
  KEY `id_dictamen_grup_exp` (`id_dictamen_grup_exp`),
  CONSTRAINT `informe_ejecucion_programa_fk` FOREIGN KEY (`id_dictamen_grup_exp`) REFERENCES `dictamen_grupo_expertos_inf_etapa` (`id_dictamen_grup_exp`),
  CONSTRAINT `Refprograma981` FOREIGN KEY (`id_programa`) REFERENCES `programa` (`id_programa`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

#
# Structure for the `innovacion` table : 
#

DROP TABLE IF EXISTS `innovacion`;

CREATE TABLE `innovacion` (
  `problema_resolver` text NOT NULL,
  `fundamentacion_tecnologica` text,
  `fundamentacion_mercado` text,
  `aspectos_tecncios` text NOT NULL,
  `aspectos_eco_mercado` text NOT NULL,
  `capacidad_asimilacion_desarrollo` text NOT NULL,
  `energia` text NOT NULL,
  `mat_primas_recursos_naturales` text NOT NULL,
  `calidad` text NOT NULL,
  `medio_ambiente` text NOT NULL,
  `propiedad_intelectual` text NOT NULL,
  `tecnlogias_constructivas` text NOT NULL,
  `analisis_sostenibilidad_innovacion` text NOT NULL,
  `otros_anexos` varchar(150) DEFAULT NULL,
  `id_proyecto` int(11) NOT NULL,
  PRIMARY KEY (`id_proyecto`),
  KEY `Ref4266` (`id_proyecto`),
  CONSTRAINT `Refproyecto66` FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `jefeproyecto` table : 
#

DROP TABLE IF EXISTS `jefeproyecto`;

CREATE TABLE `jefeproyecto` (
  `titulo_obtenido` varchar(50) NOT NULL,
  `situacion_laboral` varchar(50) NOT NULL,
  `publicaciones` varchar(100) NOT NULL,
  `otros_aspectos` varchar(100) DEFAULT NULL,
  `presupuesto_anual` double(18,0) DEFAULT NULL,
  `id_categoria` int(11) NOT NULL,
  `id_grado` int(11) NOT NULL,
  `id_persona` int(11) NOT NULL,
  `cv` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id_persona`),
  KEY `Ref464` (`id_categoria`),
  KEY `Ref2265` (`id_grado`),
  KEY `Ref3667` (`id_persona`),
  CONSTRAINT `Refcat_cientifica64` FOREIGN KEY (`id_categoria`) REFERENCES `cat_cientifica` (`id_categoria`),
  CONSTRAINT `Refgrado_cientifico65` FOREIGN KEY (`id_grado`) REFERENCES `grado_cientifico` (`id_grado`),
  CONSTRAINT `Refpersona67` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Structure for the `lista_chequeo_auditoria` table : 
#

DROP TABLE IF EXISTS `lista_chequeo_auditoria`;

CREATE TABLE `lista_chequeo_auditoria` (
  `id_lista_chequeo` int(11) NOT NULL AUTO_INCREMENT,
  `actividad_proceso_evaluar` varchar(25) NOT NULL,
  `nombre_auditor` varchar(25) NOT NULL,
  `requisitos_evaluar` text NOT NULL,
  `observaciones` text,
  PRIMARY KEY (`id_lista_chequeo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

#
# Structure for the `notificacion_ingreso_gastos` table : 
#

DROP TABLE IF EXISTS `notificacion_ingreso_gastos`;

CREATE TABLE `notificacion_ingreso_gastos` (
  `id_notif_ingresos_gastos` int(11) NOT NULL AUTO_INCREMENT,
  `etapa` varchar(25) NOT NULL,
  `id_anticipo` int(11) NOT NULL,
  `id_evaluacion` int(11) NOT NULL,
  `autorizo_registrar_ingreso` double(18,0) NOT NULL,
  `autorizo_registrar_gasto` double(18,0) NOT NULL,
  `nombre_apellidos_secretario` varchar(40) NOT NULL,
  `fecha` date NOT NULL,
  `id_programa` int(11) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  `anno` int(11) NOT NULL,
  PRIMARY KEY (`id_notif_ingresos_gastos`),
  KEY `Refanticipo51` (`id_anticipo`),
  KEY `Refevaluacion52` (`id_evaluacion`),
  KEY `Refprograma50` (`id_programa`),
  KEY `id_proyecto` (`id_proyecto`),
  CONSTRAINT `notificacion_ingreso_gastos_fk` FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`),
  CONSTRAINT `Refevaluacion52` FOREIGN KEY (`id_evaluacion`) REFERENCES `evaluacion` (`id_evaluacion`),
  CONSTRAINT `Refprograma50` FOREIGN KEY (`id_programa`) REFERENCES `programa` (`id_programa`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

#
# Structure for the `oponencia_informe_etapa` table : 
#

DROP TABLE IF EXISTS `oponencia_informe_etapa`;

CREATE TABLE `oponencia_informe_etapa` (
  `anno` year(4) NOT NULL,
  `id_oponencia` int(11) NOT NULL AUTO_INCREMENT,
  `id_informe_etapa` int(11) NOT NULL,
  `resultados_programados` text NOT NULL,
  `conclusiones` text NOT NULL,
  `recomendaciones` text NOT NULL,
  `fecha` date NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  PRIMARY KEY (`id_oponencia`,`id_informe_etapa`),
  KEY `Refinforme_etapa961` (`id_informe_etapa`),
  KEY `id_proyecto` (`id_proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

#
# Structure for the `plan_auditoria` table : 
#

DROP TABLE IF EXISTS `plan_auditoria`;

CREATE TABLE `plan_auditoria` (
  `id_plan_auditoria` int(11) NOT NULL AUTO_INCREMENT,
  `objetivos_alcance` text NOT NULL,
  `fecha_plan` date NOT NULL,
  `director_entidad` varchar(20) NOT NULL,
  `equipo_auditor` text NOT NULL,
  `fecha_cumplimiento` date NOT NULL,
  `id_programa` int(11) NOT NULL,
  `id_entidad` int(11) NOT NULL,
  `id_proyecto` int(11) NOT NULL,
  PRIMARY KEY (`id_plan_auditoria`),
  KEY `Refentidad87` (`id_entidad`),
  KEY `Refprograma86` (`id_programa`),
  KEY `Refproyecto83` (`id_proyecto`),
  CONSTRAINT `Refentidad87` FOREIGN KEY (`id_entidad`) REFERENCES `entidad` (`id_entidad`),
  CONSTRAINT `Refprograma86` FOREIGN KEY (`id_programa`) REFERENCES `programa` (`id_programa`),
  CONSTRAINT `Refproyecto83` FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

#
# Structure for the `traza` table : 
#

DROP TABLE IF EXISTS `traza`;

CREATE TABLE `traza` (
  `id_traza` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(30) NOT NULL,
  `accion` varchar(50) NOT NULL,
  `componente` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL,
  `fecha` datetime NOT NULL,
  PRIMARY KEY (`id_traza`)
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=utf8;

#
# Definition for the `anticipo_ejecutora` view : 
#

DROP VIEW IF EXISTS `anticipo_ejecutora`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `anticipo_ejecutora` AS 
  select 
    `anticipo`.`etapa` AS `etapa`,
    `anticipo`.`anno` AS `anno`,
    `anticipo`.`cantidad_anticipa` AS `anticipo`,
    `entidad`.`nombre` AS `institución`,
    `anticipo`.`id_anticipo` AS `consecutivo`,
    `programa`.`nombre` AS `programa`,
    `anticipo`.`fecha_firma` AS `fecha_firma`,
    `ejecutora`.`numero_cuenta_bancaria` AS `numero_cuenta_bancaria`,
    `ejecutora`.`sucursal_creditos` AS `sucursal_creditos`,
    `persona`.`nombre` AS `persona`,
    `persona`.`apellido` AS `apellido`,
    `perfil_proyecto`.`titulo_proyecto` AS `proyecto`,
    `anticipo`.`fecha_recibe` AS `fecha_recibe`,
    `anticipo`.`nombre_recibe` AS `nombre_recibe`,
    `anticipo`.`cargo_recibe` AS `cargo_recibe` 
  from 
    ((((((`proyecto` join `anticipo` on((`proyecto`.`id_proyecto` = `anticipo`.`id_proyecto`))) join `perfil_proyecto` on((`proyecto`.`id_proyecto` = `perfil_proyecto`.`id_proyecto`))) join `ejecutora` on((`ejecutora`.`id_entidad` = `perfil_proyecto`.`id_entidad`))) join `entidad` on((`entidad`.`id_entidad` = `ejecutora`.`id_entidad`))) join `programa` on((`perfil_proyecto`.`id_programa` = `programa`.`id_programa`))) join `persona` on((`programa`.`secretarioprograma` = `persona`.`id_persona`)));

#
# Definition for the `cash_flow` view : 
#

DROP VIEW IF EXISTS `cash_flow`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `cash_flow` AS 
  select 
    `proyecto`.`numero` AS `numero`,
    `proyecto`.`nombre_proyecto` AS `nombre_proyecto`,
    `financista`.`cifra_planificada` AS `cifra_planificada`,
    `notificacion_ingreso_gastos`.`anno` AS `anno`,
    `notificacion_ingreso_gastos`.`etapa` AS `etapa`,
    `notificacion_ingreso_gastos`.`autorizo_registrar_ingreso` AS `ingreso`,
    `notificacion_ingreso_gastos`.`autorizo_registrar_gasto` AS `gasto`,
    `proyecto`.`id_proyecto` AS `id_proyecto` 
  from 
    (((`financista` join `proyecto` on((`financista`.`id_proyecto` = `proyecto`.`id_proyecto`))) join `control_ejecucion_presupuesto` on((`proyecto`.`id_proyecto` = `control_ejecucion_presupuesto`.`id_proyecto`))) join `notificacion_ingreso_gastos` on((`notificacion_ingreso_gastos`.`id_notif_ingresos_gastos` = `control_ejecucion_presupuesto`.`id_notif_ingresos_gastos`)));

#
# Definition for the `certificn_actvs_resultds` view : 
#

DROP VIEW IF EXISTS `certificn_actvs_resultds`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `certificn_actvs_resultds` AS 
  select 
    `proyecto`.`nombre_proyecto` AS `nombre_proyecto`,
    `proyecto`.`numero` AS `numero`,
    `programa`.`nombre` AS `programa`,
    `certificacion_activdades_resultados`.`anno` AS `anno`,
    `certificacion_activdades_resultados`.`periodo_evaluacion_cert` AS `periodo_evaluacion_cert`,
    `certificacion_activdades_resultados`.`actividades_resultados` AS `actividades_resultados`,
    `certificacion_activdades_resultados`.`cumplimiento` AS `cumplimiento`,
    `persona`.`nombre` AS `nombre`,
    `persona`.`apellido` AS `apellido`,
    `entidad`.`nombre` AS `institucion`,
    `certificacion_activdades_resultados`.`a_r_dos` AS `a_r_dos`,
    `certificacion_activdades_resultados`.`cumplimiento_dos` AS `cumplimiento_dos`,
    `certificacion_activdades_resultados`.`a_r_tres` AS `a_r_tres`,
    `certificacion_activdades_resultados`.`cumplimiento_tres` AS `cumplimiento_tres`,
    `certificacion_activdades_resultados`.`gastos_incurridos` AS `gastos_incurridos`,
    `certificacion_activdades_resultados`.`observaciones` AS `observaciones`,
    `certificacion_activdades_resultados`.`nombre_apellidos_presidente` AS `presidente`,
    `certificacion_activdades_resultados`.`fecha_certifica_presidente` AS `fecha_certifica_presidente`,
    `certificacion_activdades_resultados`.`nombre_apellidos_director` AS `director`,
    `certificacion_activdades_resultados`.`fecha_certifica_director` AS `fecha_certifica_director`,
    `anticipo`.`cantidad_anticipa` AS `anticipo`,
    `evaluacion`.`evaluacion` AS `evaluacion` 
  from 
    ((((((((`proyecto` join `certificacion_activdades_resultados` on((`proyecto`.`id_proyecto` = `certificacion_activdades_resultados`.`id_proyecto`))) join `perfil_proyecto` on((`proyecto`.`id_proyecto` = `perfil_proyecto`.`id_proyecto`))) join `entidad` on((`perfil_proyecto`.`id_entidad` = `entidad`.`id_entidad`))) join `programa` on((`programa`.`id_programa` = `perfil_proyecto`.`id_programa`))) join `jefeproyecto` on((`perfil_proyecto`.`id_persona` = `jefeproyecto`.`id_persona`))) join `persona` on((`jefeproyecto`.`id_persona` = `persona`.`id_persona`))) join `anticipo` on((`certificacion_activdades_resultados`.`id_anticipo` = `anticipo`.`id_anticipo`))) join `evaluacion` on((`certificacion_activdades_resultados`.`id_evaluacion` = `evaluacion`.`id_evaluacion`)));

#
# Definition for the `control_presupuestal` view : 
#

DROP VIEW IF EXISTS `control_presupuestal`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `control_presupuestal` AS 
  select 
    `proyecto`.`numero` AS `numero`,
    `proyecto`.`nombre_proyecto` AS `nombre_proyecto`,
    `anticipo`.`anno` AS `anno`,
    `anticipo`.`etapa` AS `etapa`,
    `anticipo`.`cantidad_anticipa` AS `cantidad_anticipa`,
    `notificacion_ingreso_gastos`.`autorizo_registrar_ingreso` AS `autorizo_registrar_ingreso`,
    `notificacion_ingreso_gastos`.`autorizo_registrar_gasto` AS `autorizo_registrar_gasto`,
    `certificacion_activdades_resultados`.`gastos_incurridos` AS `gastos_incurridos`,
    `control_ejecucion_presupuesto`.`fecha_inicio` AS `fecha_inicio`,
    `control_ejecucion_presupuesto`.`fecha_terminacion` AS `fecha_terminacion` 
  from 
    ((((`proyecto` join `control_ejecucion_presupuesto` on((`proyecto`.`id_proyecto` = `control_ejecucion_presupuesto`.`id_proyecto`))) join `anticipo` on((`control_ejecucion_presupuesto`.`id_anticipo` = `anticipo`.`id_anticipo`))) join `notificacion_ingreso_gastos` on((`control_ejecucion_presupuesto`.`id_notif_ingresos_gastos` = `notificacion_ingreso_gastos`.`id_notif_ingresos_gastos`))) join `certificacion_activdades_resultados` on((`control_ejecucion_presupuesto`.`id_certificacion` = `certificacion_activdades_resultados`.`id_certificacion`)));

#
# Definition for the `deficiencias_proyectos` view : 
#

DROP VIEW IF EXISTS `deficiencias_proyectos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `deficiencias_proyectos` AS 
  select 
    `proyecto`.`numero` AS `numero`,
    `proyecto`.`nombre_proyecto` AS `nombre_proyecto`,
    `documentacion_evidencias_objetivas`.`nombre_auditor` AS `nombre_auditor`,
    `documentacion_evidencias_objetivas`.`nombre_auditado` AS `nombre_auditado`,
    `documentacion_evidencias_objetivas`.`deficiencias_evidencias` AS `deficiencias_evidencias`,
    `documentacion_evidencias_objetivas`.`fecha_recogida_info` AS `fecha_recogida_info`,
    `documentacion_evidencias_objetivas`.`documento` AS `documento` 
  from 
    (`proyecto` join `documentacion_evidencias_objetivas` on((`proyecto`.`id_proyecto` = `documentacion_evidencias_objetivas`.`id_proyecto`)));

#
# Definition for the `dictamen_eval_grupo_exp` view : 
#

DROP VIEW IF EXISTS `dictamen_eval_grupo_exp`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dictamen_eval_grupo_exp` AS 
  select 
    `proyecto`.`numero` AS `numero`,
    `proyecto`.`nombre_proyecto` AS `nombre_proyecto`,
    `evaluacion`.`evaluacion` AS `evaluación_objetivos`,
    `resultados`.`evaluacion` AS `evaluación_resultados`,
    `actividades`.`evaluacion` AS `evaluación_actividades`,
    `dictamen_grupo_expertos_inf_etapa`.`observaciones` AS `observaciones`,
    `dictamen_grupo_expertos_inf_etapa`.`conclusiones` AS `conclusiones`,
    `dictamen_grupo_expertos_inf_etapa`.`recomendaciones` AS `recomendaciones`,
    `dictamen_grupo_expertos_inf_etapa`.`nombre_apellidos_miembroGEP` AS `nombre_apellidos_miembroGEP`,
    `informe_etapa`.`cumplimiento_cronograma_actividades` AS `cumplimiento_cronograma_actividades`,
    `informe_etapa`.`cumplimiento_resultados_programados` AS `cumplimiento_resultados_programados`,
    `informe_etapa`.`etapa` AS `etapa` 
  from 
    (((((`informe_etapa` join `dictamen_grupo_expertos_inf_etapa` on((`informe_etapa`.`id_informe_etapa` = `dictamen_grupo_expertos_inf_etapa`.`id_informe_etapa`))) join `proyecto` on((`informe_etapa`.`id_proyecto` = `proyecto`.`id_proyecto`))) join `evaluacion` on((`dictamen_grupo_expertos_inf_etapa`.`evaluacion_objetivos` = `evaluacion`.`id_evaluacion`))) join `evaluacion` `resultados` on((`dictamen_grupo_expertos_inf_etapa`.`evaluacion_resultados` = `resultados`.`id_evaluacion`))) join `evaluacion` `actividades` on((`dictamen_grupo_expertos_inf_etapa`.`evaluacion_actividades` = `actividades`.`id_evaluacion`)));

#
# Definition for the `estado_ejecucion_prog_proy` view : 
#

DROP VIEW IF EXISTS `estado_ejecucion_prog_proy`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `estado_ejecucion_prog_proy` AS 
  select 
    `proyecto`.`numero` AS `numero`,
    `proyecto`.`nombre_proyecto` AS `nombre_proyecto`,
    `estado_ejecucion_proyecto`.`nombre_estado_ejecucion_proyecto` AS `estado_ejecucion`,
    `programa`.`nombre` AS `programa` 
  from 
    ((((`proyecto` join `control_programa_proyecto` on((`proyecto`.`id_proyecto` = `control_programa_proyecto`.`id_proyecto`))) join `estado_ejecucion_proyecto` on((`control_programa_proyecto`.`id_estado_ejecucion_proyecto` = `estado_ejecucion_proyecto`.`id_estado_ejecucion_proyecto`))) join `perfil_proyecto` on((`proyecto`.`id_proyecto` = `perfil_proyecto`.`id_proyecto`))) join `programa` on((`perfil_proyecto`.`id_programa` = `programa`.`id_programa`)));

#
# Definition for the `financiamiento_programa_proyecto` view : 
#

DROP VIEW IF EXISTS `financiamiento_programa_proyecto`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `financiamiento_programa_proyecto` AS 
  select 
    distinct `perfil_programa`.`presupuesto` AS `presupuesto_programa`,
    `perfil_programa`.`numero_proyectos` AS `numero_proyectos`,
    `entidad`.`nombre` AS `institucion`,
    `perfil_proyecto`.`presupuesto_total` AS `presupuesto_proyecto`,
    `proyecto`.`numero` AS `numero`,
    `programa`.`nombre` AS `nombre_programa`,
    `perfil_proyecto`.`titulo_proyecto` AS `titulo_proyecto` 
  from 
    (((((`ejecutora` join `entidad` on((`ejecutora`.`id_entidad` = `entidad`.`id_entidad`))) join `perfil_proyecto` on((`ejecutora`.`id_entidad` = `perfil_proyecto`.`id_entidad`))) join `proyecto` on((`perfil_proyecto`.`id_proyecto` = `proyecto`.`id_proyecto`))) join `programa` on((`perfil_proyecto`.`id_programa` = `programa`.`id_programa`))) join `perfil_programa` on((`programa`.`id_programa` = `perfil_programa`.`id_programa`)));

#
# Definition for the `informe_auditoria_proyecto` view : 
#

DROP VIEW IF EXISTS `informe_auditoria_proyecto`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `informe_auditoria_proyecto` AS 
  select 
    `informe_auditoria`.`personal_entrevistado` AS `personal_entrevistado`,
    `informe_auditoria`.`opinion_equipo_auditor` AS `opinion_equipo_auditor`,
    `informe_auditoria`.`elaborado_por` AS `elaborado_por`,
    `informe_auditoria`.`objetivos` AS `objetivos`,
    `informe_auditoria`.`alcance` AS `alcance`,
    `informe_auditoria`.`fecha_confeccion` AS `fecha_confeccion`,
    `informe_auditoria`.`auditor_lider` AS `auditor_lider`,
    `informe_auditoria`.`observaciones` AS `observaciones`,
    `informe_auditoria`.`no_conformidades_detectadas` AS `no_conformidades_detectadas`,
    `proyecto`.`nombre_proyecto` AS `nombre_proyecto`,
    `entidad`.`nombre` AS `institucion`,
    `programa`.`nombre` AS `programa` 
  from 
    (((`entidad` join `informe_auditoria` on((`entidad`.`id_entidad` = `informe_auditoria`.`id_entidad`))) join `proyecto` on((`informe_auditoria`.`id_proyecto` = `proyecto`.`id_proyecto`))) join `programa` on((`informe_auditoria`.`id_programa` = `programa`.`id_programa`)));

#
# Definition for the `informe_etapa_proyecto` view : 
#

DROP VIEW IF EXISTS `informe_etapa_proyecto`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `informe_etapa_proyecto` AS 
  select 
    `proyecto`.`nombre_proyecto` AS `nombre_proyecto`,
    `proyecto`.`numero` AS `numero`,
    `programa`.`nombre` AS `programa`,
    `certificacion_activdades_resultados`.`anno` AS `anno`,
    `certificacion_activdades_resultados`.`periodo_evaluacion_cert` AS `periodo_evaluacion_cert`,
    `certificacion_activdades_resultados`.`actividades_resultados` AS `actividades_resultados`,
    `certificacion_activdades_resultados`.`cumplimiento` AS `cumplimiento`,
    `persona`.`nombre` AS `nombre`,
    `persona`.`apellido` AS `apellido`,
    `entidad`.`nombre` AS `institucion` 
  from 
    ((((((`proyecto` join `certificacion_activdades_resultados` on((`proyecto`.`id_proyecto` = `certificacion_activdades_resultados`.`id_proyecto`))) join `perfil_proyecto` on((`proyecto`.`id_proyecto` = `perfil_proyecto`.`id_proyecto`))) join `entidad` on((`perfil_proyecto`.`id_entidad` = `entidad`.`id_entidad`))) join `programa` on((`programa`.`id_programa` = `perfil_proyecto`.`id_programa`))) join `jefeproyecto` on((`perfil_proyecto`.`id_persona` = `jefeproyecto`.`id_persona`))) join `persona` on((`jefeproyecto`.`id_persona` = `persona`.`id_persona`)));

#
# Definition for the `listar_proyecto_i_d` view : 
#

DROP VIEW IF EXISTS `listar_proyecto_i_d`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `listar_proyecto_i_d` AS 
  select 
    `proyecto`.`id_proyecto` AS `id_proyecto`,
    `proyecto`.`numero` AS `numero`,
    `proyecto`.`nombre_proyecto` AS `nombre_proyecto` 
  from 
    `proyecto` 
  where 
    ((not(`proyecto`.`id_proyecto` in (
  select 
    `i_d`.`id_proyecto` 
  from 
    `i_d`))) and (not(`proyecto`.`id_proyecto` in (
  select 
    `innovacion`.`id_proyecto` 
  from 
    `innovacion`))));

#
# Definition for the `programa_auditoria` view : 
#

DROP VIEW IF EXISTS `programa_auditoria`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `programa_auditoria` AS 
  select 
    `entidad`.`nombre` AS `nombre`,
    `proyecto`.`numero` AS `numero`,
    `proyecto`.`nombre_proyecto` AS `nombre_proyecto`,
    `programa`.`nombre` AS `programa`,
    `auditoria`.`fecha_auditoria` AS `fecha_auditoria`,
    `auditoria`.`aspectos_evaluar` AS `aspectos_evaluar` 
  from 
    (((`entidad` join `auditoria` on((`entidad`.`id_entidad` = `auditoria`.`id_entidad`))) join `proyecto` on((`auditoria`.`id_proyecto` = `proyecto`.`id_proyecto`))) join `programa` on((`auditoria`.`id_programa` = `programa`.`id_programa`)));

#
# Definition for the `rep_convocatoria` view : 
#

DROP VIEW IF EXISTS `rep_convocatoria`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rep_convocatoria` AS 
  select 
    `programa`.`nombre` AS `programa`,
    `entidad`.`nombre` AS `entidad`,
    `persona`.`nombre` AS `nombre`,
    `persona`.`apellido` AS `apellido`,
    `convocatoria`.`texto` AS `texto`,
    `convocatoria`.`inicio` AS `inicio`,
    `convocatoria`.`cierre` AS `cierre`,
    `perfil_programa`.`denominacion` AS `denominacion`,
    `perfil_programa`.`objetivo_especifico` AS `objetivo_especifico`,
    `indicadores_impacto`.`indicador` AS `indicador`,
    `persona1`.`nombre` AS `secrenombre`,
    `persona1`.`apellido` AS `secreapellido`,
    `prioridad`.`problema` AS `problema`,
    `perfil_programa`.`presupuesto` AS `presupuesto` 
  from 
    (((((((`programa` join `convocatoria` on((`programa`.`id_programa` = `convocatoria`.`id_programa_convocatoria`))) join `entidad` on((`programa`.`id_entidad` = `entidad`.`id_entidad`))) join `persona` on((`convocatoria`.`id_persona` = `persona`.`id_persona`))) join `perfil_programa` on((`programa`.`id_programa` = `perfil_programa`.`id_programa`))) join `indicadores_impacto` on((`perfil_programa`.`id_indicador` = `indicadores_impacto`.`id_indicador`))) join `persona` `persona1` on((`programa`.`secretarioprograma` = `persona1`.`id_persona`))) join `prioridad` on((`perfil_programa`.`id_prioridad` = `prioridad`.`id_prioridad`))) 
  where 
    (`convocatoria`.`visibilidad` = 'publica');

#
# Definition for the `rep_informe_ejecucion_programa` view : 
#

DROP VIEW IF EXISTS `rep_informe_ejecucion_programa`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `rep_informe_ejecucion_programa` AS 
  select 
    `programa`.`nombre` AS `programa`,
    `programa`.`objetivoGeneral` AS `objetivoGeneral`,
    `informe_ejecucion_programa`.`nivel_ejecucion_presupuesto` AS `nivel_ejecucion_presupuesto`,
    `informe_ejecucion_programa`.`etapa` AS `etapa`,
    `informe_ejecucion_programa`.`principales_dificultades` AS `principales_dificultades`,
    `informe_ejecucion_programa`.`conclusiones_recomendaciones` AS `conclusiones_recomendaciones`,
    `informe_ejecucion_programa`.`fecha_informe` AS `fecha_informe`,
    `informe_ejecucion_programa`.`cumplimiento_objtvs_propuestos` AS `cumplimiento_objtvs_propuestos`,
    `informe_ejecucion_programa`.`cumplimiento_resultados_programados` AS `cumplimiento_resultados_programados`,
    `dictamen_grupo_expertos_inf_etapa`.`conclusiones` AS `conclusiones_grupo_exp`,
    `dictamen_grupo_expertos_inf_etapa`.`evaluacion_objetivos` AS `evaluacion_objetivos`,
    `dictamen_grupo_expertos_inf_etapa`.`evaluacion_resultados` AS `evaluacion_resultados`,
    `dictamen_grupo_expertos_inf_etapa`.`evaluacion_actividades` AS `evaluacion_actividades`,
    `dictamen_grupo_expertos_inf_etapa`.`observaciones` AS `observaciones`,
    `dictamen_grupo_expertos_inf_etapa`.`fecha_dictamen` AS `fecha_dictamen`,
    `entidad`.`nombre` AS `institucion`,
    `persona`.`nombre` AS `nombrejefe`,
    `persona`.`apellido` AS `apellidojefe`,
    `dictamen_grupo_expertos_inf_etapa`.`recomendaciones` AS `recomendaciones`,
    `persona1`.`nombre` AS `secrenombre`,
    `persona1`.`apellido` AS `secreapellido` 
  from 
    (((((`programa` join `informe_ejecucion_programa` on((`programa`.`id_programa` = `informe_ejecucion_programa`.`id_programa`))) join `dictamen_grupo_expertos_inf_etapa` on((`informe_ejecucion_programa`.`id_dictamen_grup_exp` = `dictamen_grupo_expertos_inf_etapa`.`id_dictamen_grup_exp`))) join `entidad` on((`programa`.`id_entidad` = `entidad`.`id_entidad`))) join `persona` on((`programa`.`id_persona` = `persona`.`id_persona`))) join `persona` `persona1` on((`programa`.`secretarioprograma` = `persona1`.`id_persona`)));

#
# Data for the `indicadores_impacto` table  (LIMIT 0,500)
#

INSERT INTO `indicadores_impacto` (`id_indicador`, `indicador`) VALUES 
  (1,'Científico'),
  (2,'Tecnológico'),
  (3,'Económico'),
  (5,'Medio Ambiental'),
  (6,'Social');

COMMIT;

#
# Data for the `prioridad` table  (LIMIT 0,500)
#

INSERT INTO `prioridad` (`id_prioridad`, `problema`) VALUES 
  (1,'tv digital'),
  (2,'salud'),
  (3,'educación'),
  (4,'Sostener y Desarrollar la industria del software y el proceso de informatización de la sociedad'),
  (5,'Transporte'),
  (8,'Evaluación del impacto de la implementación de soluciones organizacionales en el proceso de intregración del sistema de dirección en GECAL'),
  (9,'Lineamiento 131, “Sostener y desarrollar los resultados alcanzados en el campo de la biotecnología, la producción médico-farmacéutica, la industria del software y el proceso de informatización de la sociedad, las ciencias básicas, las ciencias naturales, los estudios y el empleo \r\nde las fuentes de energía renovables, las tecnologías sociales y educativas, la transferencia tecnológica industrial, la producción de equipos de tecnología avanzada, la nanotecnología y los \r\nservicios científicos y tecnológicos de alto valor agregado”\r\nLineamiento 83, “Trabajar para garantizar, por las empresas y entidades vinculadas a la \r\nexportación, que todos los bienes y servicios destinados a los mercados internacionales respondan a los más altos estándares de calidad”'),
  (10,'Internet'),
  (11,'Establecimiento de Redes 3g en la Habana');

COMMIT;

#
# Data for the `perfil_programa` table  (LIMIT 0,500)
#

INSERT INTO `perfil_programa` (`id_programa`, `denominacion`, `fundamentacion`, `objetivo_especifico`, `principalesResultados`, `potencialHumano`, `presupuesto`, `plazoEjecucion`, `otro`, `numero_proyectos`, `id_prioridad`, `id_indicador`, `archivo`) VALUES 
  (1,'tv hd','g','f','d','s',700,2,'',8,2,2,'antenas-caseras.pdf'),
  (3,'Educación','sistema de enseñanza','lol','ok','po',1550,3,'fg',2,3,6,'Propuesta base. Anuario.pub'),
  (5,'Desarrollo de la industria cubana del software','En la actualidad es un imperativo de cualquier país el desarrollo de la informatización en todos los sectores. Es evidente que para Cuba resulta un reto el logro de este propósito.\r\nEn estos momentos hay una tendencia mundial en el desarrollo estratégico de tres tecnologías de punta (Biotecnología, Informática y Comunicaciones y Nuevos Materiales). Nuestra nación hace considerables esfuerzos por desarrollar estas tecnologías y en particular se hace necesario acelerar las acciones a acometer en las tecnologías asociadas al desarrollo de productos y servicios Informáticos, lo que debe convertirse al pasar unos años en el desarrollo de la industria cubana del software, como un fondo exportable adicional e importante para nuestra economía.\r\nEl desarrollo de la economía cubana está vinculado en los momentos actuales a los avances relacionados con las nuevas tecnologías de la información y las comunicaciones (TIC) y exige la diversificación de la estructura de las exportaciones de bienes y servicios, dando preferencia a las que generan mayor valor agregado y contenido tecnológico, entre las cuales pueden estar las aplicaciones y servicios informáticos.\r\nEsta es una industria estratégica, en sí misma, para los países que pueden desarrollar a escala nacional la producción y los servicios de modo competitivo a nivel internacional, y lo es también para el resto, pero no por sí misma, sino en la medida en que se potencia el desarrollo del resto de las industrias.\r\nPor lo anterior, el Lineamiento 131, aprobado por el VI Congreso de nuestro Partido, enuncia: Sostener y desarrollar los resultados alcanzados en el campo de la biotecnología, la producción médico-farmacéutica, la industria del software y el proceso de informatización de la sociedad, las ciencias básicas, las ciencias naturales, los estudios y el empleo de las fuentes de energía renovables, las tecnologías sociales y educativas, la transferencia tecnológica industrial, la producción de equipos de tecnología avanzada, la nanotecnología y los servicios científicos y tecnológicos de alto valor agregado.\r\nDentro del sector de las nuevas tecnologías, la industria nacional de software muestra resultados modestos que todavía no se corresponden con el nivel de desarrollo, promoción y recursos humanos destinados a esta actividad. Considerando además que la inversión principal ya se creado a partir de la política educacional que ha seguido el país durante los últimos años y en especial en la educación superior, donde se hace necesario que esos\r\n\r\n recursos humanos estén actualizados y motivados al nivel del borde delantero de desarrollo de esta industria para que produzcan y se mantengan en ella.\r\nActualmente se desarrollan aplicaciones informáticas en empresas creadas a esos fines, en las universidades y en los Joven Club de computación. La mayoría de las  empresas , organizaciones superiores de Dirección Empresarial y los organismos de la administración central del estado (OACEs) cuentan con una estructura organizativa (empresas de tecnologías propias , unidad empresarial de base, otras formas estructurales) donde se desarrollan las aplicaciones y soluciones informáticas que las mismas necesitan, repitiéndose en ocasiones duplicidad de esfuerzo y recursos al  repetir por supuesto desarrollos similares en diferentes entidades, sin que exista un modelo metodológico y marco de trabajo que guíe cada intención, resultando además insuficiente para el desarrollo y la informatización nacional, mucho más para producir para un mercado internacional.  \r\nUn hecho que dio un impulso a esta industria fue la creación de la  Universidad de las Ciencias Informáticas (UCI) que surgió como una universidad productiva, agregando a la “industria” un nuevo modelo de producción, pues su misión es producir aplicaciones y brindar servicios informáticos a partir de la vinculación estudio – trabajo como modelo de formación.\r\nTeniendo en cuenta la necesidad expresada en los lineamientos del VI Congreso del Partido Comunista de Cuba, se está llevando a cabo en el país la incorporación de nuevos actores, como pueden ser los trabajadores por cuenta propia (TPC) y las cooperativas no agropecuarias (CNA), los que podrían aportar su potencialidad intelectual y productiva en función del desarrollo de este sector.\r\nA pesar de los esfuerzos realizados en los últimos años, no existe formalmente una industria cubana de software capaz de enfrentar los desafíos de la sociedad actual tanto en lo económico como en lo social. Esta industria está conformada por participantes muy diversos, que cuentan con un caudal de profesionales altamente calificados y en cualquier caso “calificables” entre los cuales se debe lograr la debida colaboración e integración.\r\nPor otra parte es necesario establecer normativas técnicas  nacionales unificadas y coherentes para la producción y certificación de soluciones informáticas, que aseguren el logro de una calidad competitiva en los desarrollos realizados por nuestras entidades. En este sentido, la inmediata creación de un Centro Nacional de Calidad de Software posibilitará la inserción del mismo en las acciones de este programa, con el fin de generalizar modelos de gestión que garanticen la producción de bienes y la prestación de servicios que cumplan con los estándares de calidad internacional.\r\nPor todo lo anterior resulta de vital importancia elaborar e implementar un programa nacional  de Investigación-Desarrollo en temas perspectivos de la informática y en particular del software, realizando además una efectiva coordinación para su ejecución con las universidades, centros de investigación  y las  áreas de I-D de centros con posibilidades para ello.\r\nSi se logra aprovechar las oportunidades que se ofrecen y se crean las condiciones para cubrir la demanda de estos mercados de las TIC y las expectativas del mercado internacional, se estaría avanzando en la aspiración de lograr una rápida y sostenible informatización de la sociedad y convertir a los servicios y aplicaciones informáticas en una importante fuente de ingresos para el país.\r\n','Contribuir a sostener y desarrollar el nivel de organización, eficiencia y eficacia de la industria cubana de software de forma tal que satisfaga las necesidades de informatización de la sociedad cubana con un nivel de competitividad acorde a los estándares internacionales, logrando además potenciar las exportaciones de software','Identificados e implantados modelos organizativos y marcos de trabajo que debe tener la industria de software para las condiciones de Cuba.\r\nUtilizadas herramientas de software de código abierto como elemento básico para garantizar la independencia tecnológica.\r\nDesarrollada distributivas cubanas de software sobre plataformas de código abierto.\r\nEstablecidas estándares, modelos y normativas de calidad reconocidos internacionalmente en la industria cubana del software.\r\nEstablecido un sistema de vigilancia tecnológica que permita la introducción de las nuevas tecnologías con el dinamismo que la industria requiere.\r\n','Los vinculados a las entidades participantes.',4100000,5,'La Dirección e Ciencia e Innovación Tecnológica del Ministerio de las Comunicaciones hasta la implementación de la nueva estructura, que en ese momento sería la Dirección de la Industria del SOFTWARE. Recibe y gestiona el financiamiento y supervisa a la entidad gestionadora en su administración.',15,4,2,NULL);

COMMIT;

#
# Data for the `persona` table  (LIMIT 0,500)
#

INSERT INTO `persona` (`id_persona`, `dni`, `nombre`, `apellido`, `direccion`, `correo`, `telefono`, `movil`, `username`, `password`, `foto`) VALUES 
  (540,2147483647,'Ernesto Alberto','Bonet Moncada','calle e #15815 apto a 52','bernestoalberto@gmail.com',0,52810911,'ernesto','$2y$10$hZekFNTk/WJ1rten0OyV6u/','ernesto.jpg'),
  (541,2147483647,'Gaby','Bonet Moncada','calle e #15815 apto a 52','gaby@hec.sld.cu',0,58742365,'gaby','$2y$10$9HKlRQ9DoqlECK5PXlN8juT','gaby.jpg'),
  (542,0,'isabel ','Moncada Rodriguez','calle e #15815 apto a 52','isamon@infomed.sld.cu',0,52874631,'isabel','$2y$10$tB7Coq5t3JKCUhlisPJEG.Y','isabel.jpg'),
  (543,2147483647,'Ruperto Pedro','Bonet Chaple','calle e #15815 apto a 52','brupertopedro@yahoo.es',0,54712356,'ruperto','$2y$10$scIAHvCBoz.KcrZ2btNoLeP','ruperto.jpg'),
  (544,0,'carlos','Nuñez Perez','habana','carlos@ceis.cujae.educ.cu',0,54231878,'carlos','$2y$10$iHdqdwgqh4MIgzMkQPd6y.h','carlos.JPG'),
  (545,0,'Marta Aleida Rodriguez Perez','Rodriguez Perez','alamar','marta@hec.sld.cu',0,52456721,'marta','$2y$10$fFc1fy1vN6wT5hljdQPEcOx','SAM_1738.JPG'),
  (546,2147483647,'abel alejandro yanez moncada','Yanez Moncada','alamar','abel.yanez@etecsa.cu',0,56431237,'abelito','$2y$10$wDgmyPIynyb8b68Zd.Ain.4','abel.JPG');

COMMIT;

#
# Data for the `programa` table  (LIMIT 0,500)
#

INSERT INTO `programa` (`nombre`, `id_programa`, `id_persona`, `secretarioprograma`, `objetivoGeneral`, `grupoExpertos`, `id_entidad`, `otras_entidades`) VALUES 
  ('LG',1,540,541,'HJ','GH',2,NULL),
  ('ASUS',3,544,543,'OG','GE',5,NULL),
  ('Ciencia e Innovación Tecn',5,540,545,'sd','sd',4,NULL);

COMMIT;

#
# Data for the `clasificacion` table  (LIMIT 0,500)
#

INSERT INTO `clasificacion` (`id_clasificacion`, `nombre_clasificacion`) VALUES 
  (1,'Investgación Básica'),
  (2,'Investgación Aplicada'),
  (3,'Desarrollo'),
  (4,'formación RRHH'),
  (5,'Innovación'),
  (6,'Inversión Nominal'),
  (7,'Inversión no Nominal');

COMMIT;

#
# Data for the `provincia` table  (LIMIT 0,500)
#

INSERT INTO `provincia` (`id_provincia`, `nombre_provincia`) VALUES 
  (1,'Pinar del Rio'),
  (2,'Cuidad de la Habana'),
  (4,'Artemisa'),
  (5,'Mayabueque'),
  (7,'Matanzas'),
  (8,'Isla de Pinos'),
  (9,'Cienfuegos'),
  (10,'Villa Clara'),
  (11,'Ciego de Avila'),
  (12,'Sancti Spiritus'),
  (13,'Camaguey'),
  (14,'Las Tunas'),
  (15,'Holguín'),
  (16,'Santiago de Cuba'),
  (17,'Granma'),
  (18,'Guantanamo');

COMMIT;

#
# Data for the `entidad` table  (LIMIT 0,500)
#

INSERT INTO `entidad` (`id_entidad`, `nombre`, `id_provincia`, `telefono`, `direccion`, `correo`, `paginaWeb`, `vision`, `mision`, `id_programa`) VALUES 
  (1,'AICROS',2,NULL,NULL,NULL,NULL,NULL,NULL,0),
  (2,'ALBET',2,NULL,NULL,NULL,NULL,NULL,NULL,0),
  (3,'AZCUBA',2,NULL,NULL,NULL,NULL,NULL,NULL,0),
  (4,'CALISOFT',2,NULL,NULL,NULL,NULL,NULL,NULL,0),
  (5,'CIGB',2,54890102,'dircc','myuser@example.com','www.ejemplo.com','v','m',0),
  (6,'CITMA',2,NULL,NULL,NULL,NULL,NULL,NULL,0),
  (7,'CITMATEL',2,NULL,NULL,NULL,NULL,NULL,NULL,0),
  (8,'COPEXTEL',2,NULL,NULL,NULL,NULL,NULL,NULL,0),
  (9,'DATACIMEX',2,NULL,NULL,NULL,NULL,NULL,NULL,0),
  (10,'DATYS',2,NULL,NULL,NULL,NULL,NULL,NULL,0),
  (11,'DESOFT',2,NULL,NULL,NULL,NULL,NULL,NULL,0),
  (12,'ETECSA',2,54890102,'dircc','myuser@example.com','www.ejemplo.com','v','m',0),
  (13,'ICID',2,NULL,NULL,NULL,NULL,NULL,NULL,0),
  (14,'ICIMAF',2,NULL,NULL,NULL,NULL,NULL,NULL,0),
  (15,'INFOMED',2,8784956,'vedado','info@infomed.sld.cu','www.sld.cu','','',0),
  (16,'LACETEL',2,NULL,NULL,NULL,NULL,NULL,NULL,0),
  (17,'LITA',2,NULL,NULL,NULL,NULL,NULL,NULL,0),
  (18,'MINFAR',2,NULL,NULL,NULL,NULL,NULL,NULL,0),
  (19,'OTRA',2,54890102,'dircc','myuser@example.com','site@server.domain','v','m',0),
  (20,'SOFTEL',2,8475212,'uci','info@softel.cu','www.softel.cu','','',0),
  (21,'TECMA',2,NULL,NULL,NULL,NULL,NULL,NULL,0),
  (22,'TEICO',2,NULL,NULL,NULL,NULL,NULL,NULL,0),
  (23,'UCI',2,NULL,NULL,NULL,NULL,NULL,NULL,0);

COMMIT;

#
# Data for the `tipo_proyecto` table  (LIMIT 0,500)
#

INSERT INTO `tipo_proyecto` (`id_tipo_proyecto`, `tipo`) VALUES 
  (1,'Asociado a Programa'),
  (2,'No Asociado a Programa'),
  (3,'Empresarial'),
  (4,'Institucional');

COMMIT;

#
# Data for the `perfil_proyecto` table  (LIMIT 0,500)
#

INSERT INTO `perfil_proyecto` (`id_proyecto`, `titulo_proyecto`, `id_tipo_proyecto`, `id_prioridad`, `id_clasificacion`, `clientes`, `duracion`, `presupuesto_total`, `resumen`, `fecha_recepcion`, `id_entidad`, `id_programa`, `id_persona`, `otra_institucion`) VALUES 
  (1,'SONYEA',3,NULL,5,'ETECSA',2,1000,'JfK','2015-12-10',8,3,542,NULL),
  (7,' Desarrollo de la Industria del Software',1,0,3,'Gesime',3,25000,'Desarrollar un modelo de pruebas de software  basado en normas y estándares  nacionales e \r\ninternacionales de calidad para lograr mayor eficiencia  en la evaluación de los productos de \r\nsoftware','2016-02-23',3,5,546,NULL);

COMMIT;

#
# Data for the `proyecto` table  (LIMIT 0,500)
#

INSERT INTO `proyecto` (`numero`, `id_proyecto`, `nombre_proyecto`) VALUES 
  (3,1,'SONYEA'),
  (4,7,' Desarrollo de la Industria del Software');

COMMIT;

#
# Data for the `anticipo` table  (LIMIT 0,500)
#

INSERT INTO `anticipo` (`id_anticipo`, `cantidad_anticipa`, `fecha_recibe`, `id_programa`, `anno`, `fecha_firma`, `id_proyecto`, `etapa`, `nombre_recibe`, `cargo_recibe`) VALUES 
  (1,2000,'2016-01-05',3,2016,'2016-01-07',1,'enero-marzo','Jose Maria Hernandez','económico'),
  (2,350,'2016-01-21',3,2016,'2016-01-28',1,'abril-junio','er','caers'),
  (3,5000,'2016-01-28',3,2016,'2016-01-28',1,'julio-septiembre','er','sdf'),
  (7,600,'2016-01-28',3,2016,'2016-01-29',1,'octubre-diciembre','Rene Descartes','house keeper'),
  (18,234,'2016-02-29',5,2016,'2016-03-02',7,'enero-marzo','zsdfsad','dfasdf');

COMMIT;

#
# Data for the `auditoria` table  (LIMIT 0,500)
#

INSERT INTO `auditoria` (`id_programa_auditoria`, `fecha_auditoria`, `fecha_reunion_apertura`, `lugar_reunion_apertura`, `dia`, `nombre_auditor`, `aspectos_evaluar`, `fecha_reunion_auditores`, `lugar_reunion_auditores`, `fecha_reunion_clausura`, `lugar_reunion_clausura`, `nombre_enterado`, `fecha_enterado`, `comunica`, `fecha_comunica`, `id_programa`, `id_proyecto`, `id_entidad`) VALUES 
  (1,'2016-01-09','2016-01-10','plaza',8,'rene','jhk','2016-01-20','carlos iii','2016-01-20','capitolio','lio','2016-01-28','hector','2016-01-28',3,1,8);

COMMIT;

#
# Data for the `cat_cientifica` table  (LIMIT 0,500)
#

INSERT INTO `cat_cientifica` (`id_categoria`, `categoria`) VALUES 
  (1,'Agregado'),
  (2,'Instructor'),
  (3,'Titular'),
  (4,'Auxiliar'),
  (5,'Consultante'),
  (6,'Científica'),
  (7,'Docente'),
  (8,'Tecnológica');

COMMIT;

#
# Data for the `evaluacion` table  (LIMIT 0,500)
#

INSERT INTO `evaluacion` (`id_evaluacion`, `evaluacion`) VALUES 
  (1,'aprobado'),
  (2,'no aprobado'),
  (3,'satisfactorio'),
  (5,'sobresaliente');

COMMIT;

#
# Data for the `certificacion_activdades_resultados` table  (LIMIT 0,500)
#

INSERT INTO `certificacion_activdades_resultados` (`id_certificacion`, `periodo_evaluacion_cert`, `actividades_resultados`, `a_r_dos`, `a_r_tres`, `cumplimiento`, `cumplimiento_dos`, `cumplimiento_tres`, `gastos_incurridos`, `observaciones`, `nombre_apellidos_presidente`, `fecha_certifica_presidente`, `nombre_apellidos_director`, `fecha_certifica_director`, `id_programa`, `id_evaluacion`, `id_anticipo`, `id_proyecto`, `anno`) VALUES 
  (4,'enero-marzo','Conciliación',NULL,NULL,'cumplido',NULL,NULL,500,'buenas','louis','2016-01-07','dereck','2016-01-20',3,1,1,1,2016),
  (5,'abril-junio','re','','','cumplido','','',823,'v','s','2016-01-27','s','2016-01-29',3,3,2,1,2016),
  (8,'enero-marzo','Implemetacion','Pruebas','Control y Cambio','cumplido','incumplido','incumplido',800,'','Juan Carlos Toledo','2016-02-25','Jose Guillama','2016-02-29',5,3,18,7,2016);

COMMIT;

#
# Data for the `forma_entrega` table  (LIMIT 0,500)
#

INSERT INTO `forma_entrega` (`id_forma_entrega`, `informe`) VALUES 
  (1,'informe'),
  (2,'artículo'),
  (3,'libro'),
  (4,'producto'),
  (5,'software'),
  (6,'tecnología'),
  (7,'servicio');

COMMIT;

#
# Data for the `contrato` table  (LIMIT 0,500)
#

INSERT INTO `contrato` (`id_contrato`, `resultado_actividades`, `duracionInicio`, `duracionFinal`, `id_forma_entrega`, `fechaEntrega`, `cliente_representante_legal`, `representante_entidad_ejecutora`, `id_proyecto_contrato`) VALUES 
  (4,'buenas','2016-01-19','2016-04-29',5,'2016-01-05','nh','cv',1),
  (5,'Informatización total de la Empresa','2016-02-25','2016-03-23',5,'2016-01-13','AzCUba','Ernesto Lopez Meireles',7);

COMMIT;

#
# Data for the `control_ejecucion_presupuesto` table  (LIMIT 0,500)
#

INSERT INTO `control_ejecucion_presupuesto` (`id_control_ejecucion_presupuesto`, `anno`, `fecha_inicio`, `id_anticipo`, `fecha_terminacion`, `id_certificacion`, `id_notif_ingresos_gastos`, `id_programa`, `id_proyecto`, `etapa`) VALUES 
  (25,2016,'2016-02-29',18,'2016-02-29',4,1,3,1,'enero-marzo'),
  (27,2016,'2016-02-25',18,'2016-02-29',4,16,5,7,'enero-marzo'),
  (28,2016,'2016-04-19',2,'2016-05-25',5,15,5,7,'abril-junio');

COMMIT;

#
# Data for the `estado_ejecucion_proyecto` table  (LIMIT 0,500)
#

INSERT INTO `estado_ejecucion_proyecto` (`id_estado_ejecucion_proyecto`, `nombre_estado_ejecucion_proyecto`) VALUES 
  (1,'Normal'),
  (3,'Cancelado'),
  (4,'Detenido'),
  (5,'Atrasado'),
  (7,'Concluido'),
  (8,'Pendiente de Inicio');

COMMIT;

#
# Data for the `problemas_detectados` table  (LIMIT 0,500)
#

INSERT INTO `problemas_detectados` (`id_problema_detectado`, `problema`) VALUES 
  (1,'Científico – técnico'),
  (2,'Organizativos'),
  (3,'Económicos');

COMMIT;

#
# Data for the `control_programa_proyecto` table  (LIMIT 0,500)
#

INSERT INTO `control_programa_proyecto` (`id_control`, `entidad_finacista`, `otros_aspectos`, `acuerdos_adoptados`, `nombre_apellidos_evaluador`, `nombre_apellidos_evaluado`, `participante`, `fecha_control`, `id_estado_ejecucion_proyecto`, `id_problema_detectado`, `id_entidad`, `id_proyecto`, `fecha_firma_evaluado`, `fecha_firma_evaluador`) VALUES 
  (1,6,'','d','ricardo','ernesto',7,'2016-01-15',1,3,8,1,'2016-01-15','2016-01-20'),
  (4,4,'','Varios','Luis Des','Munua Asterior',3,'2016-02-25',1,1,3,7,'2016-03-06','2016-02-29');

COMMIT;

#
# Data for the `convocatoria` table  (LIMIT 0,500)
#

INSERT INTO `convocatoria` (`id_convocatoria`, `id_programa_convocatoria`, `texto`, `inicio`, `cierre`, `visibilidad`, `id_persona`) VALUES 
  (13,3,'textos','2016-01-05','2016-01-28','publica',544),
  (19,5,'A los Centros de Investigación, Centros de Estudios, Universidades, Empresas y otras entidades afines, a la presentación de propuestas de proyectos de Investigación – Desarrollo – Innovación para el Programa Nacional: Desarrollo de la industria cubana del software.\r\n','2016-02-23','2016-02-29','publica',540),
  (20,1,'Importar tv de marcas','2016-02-03','2016-02-24','publica',540);

COMMIT;

#
# Data for the `dictamen_eval_perfil_proy` table  (LIMIT 0,500)
#

INSERT INTO `dictamen_eval_perfil_proy` (`id_dictamen`, `id_proyecto`, `criterio`, `id_evaluacion`, `observaciones`, `conclusiones`, `recomendaciones`, `fecha_evaluacion`, `id_persona`) VALUES 
  (5,1,'criterio',1,'ob','con','recom','2015-12-29 19:53:45',540),
  (6,7,'sdfsdf',1,'','sdfsdf','','2016-02-24 08:01:34',540);

COMMIT;

#
# Data for the `informe_etapa` table  (LIMIT 0,500)
#

INSERT INTO `informe_etapa` (`id_informe_etapa`, `cumplimiento_cronograma_actividades`, `cumplimiento_resultados_programados`, `id_programa`, `id_entidad`, `id_persona`, `id_proyecto`, `etapa`, `anno`) VALUES 
  (1,'El cumplimeinto de las actividades ha sido satisfactorio','Los resultados han sido prometedores ',3,8,542,1,'mayo',2016),
  (4,'cumplimentar','cumplido',3,8,542,1,'octubre',2016),
  (6,'Actividades','Programados',5,3,546,7,'mayo',2016);

COMMIT;

#
# Data for the `dictamen_grupo_expertos_inf_etapa` table  (LIMIT 0,500)
#

INSERT INTO `dictamen_grupo_expertos_inf_etapa` (`id_dictamen_grup_exp`, `id_informe_etapa`, `evaluacion_objetivos`, `evaluacion_resultados`, `evaluacion_actividades`, `observaciones`, `conclusiones`, `recomendaciones`, `nombre_apellidos_miembroGEP`, `fecha_dictamen`, `anno`) VALUES 
  (1,1,1,1,1,'locales','Certificar','somes','carlos','2016-01-07',2016),
  (2,4,1,5,3,'','Certificar','','Jlio Trigo','2016-01-29',2016),
  (7,4,1,2,1,'dfg','Certificar','dfg','dfg','2016-02-29',2016),
  (8,4,1,2,1,'','Certificar','','Carlos Rodriguez','2016-02-26',2016);

COMMIT;

#
# Data for the `documentacion_evidencias_objetivas` table  (LIMIT 0,500)
#

INSERT INTO `documentacion_evidencias_objetivas` (`id_documentacion_evidencias`, `nombre_auditor`, `nombre_auditado`, `deficiencias_evidencias`, `fecha_recogida_info`, `documento`, `id_programa`, `id_proyecto`) VALUES 
  (1,'CArlos Pazzi','Roberto So','muchas','2016-01-13','el viejo testamento',3,1),
  (2,'Sergio Ortega','Reinier Pe','Pocas deficiciencias encontradas','2016-02-25','El Manual de Frascasti',5,7);

COMMIT;

#
# Data for the `ejecutora` table  (LIMIT 0,500)
#

INSERT INTO `ejecutora` (`numero_cuenta_bancaria`, `sucursal_creditos`, `cifra_planificada`, `plan_CIT`, `coeficiente_gastos_directos`, `id_persona`, `id_entidad`) VALUES 
  (2147483647,'lisa',8000,'ik',0,0,2),
  (2147483647,'arroyo',5420,'jhf',5,0,4),
  (2147483647,'alamar',5000,'kl',8,0,5),
  (2147483647,'la lisa',9876,'jk',3,0,8),
  (0,'alquizar',1000,'LO',0,0,19);

COMMIT;

#
# Data for the `financista` table  (LIMIT 0,500)
#

INSERT INTO `financista` (`plan_CIT`, `cifra_planificada`, `id_programa`, `id_proyecto`, `id_persona`, `id_entidad`) VALUES 
  ('Plan de Ciencia e Innovación Tecnológica',80000,0,7,0,4),
  ('Plan de Ciencia e Innovación e  Tecnologica',2000,3,1,0,6);

COMMIT;

#
# Data for the `grado_cientifico` table  (LIMIT 0,500)
#

INSERT INTO `grado_cientifico` (`id_grado`, `grado`) VALUES 
  (1,'Doctor'),
  (2,'Master'),
  (3,'Licenciado'),
  (4,'Ingeniero'),
  (5,'técnico medio');

COMMIT;

#
# Data for the `i_d` table  (LIMIT 0,500)
#

INSERT INTO `i_d` (`antecedentes_justificacion`, `beneficiarios_directos`, `clientes`, `sostenibilidad_resultados_proyecto`, `id_proyecto`, `otros_anexos_i_d`) VALUES 
  ('La ejeución del proyecto, brinda resultados de valor observable.','MINAZ','Grupo MECANIS','Desarrollo de la Industria del Software',7,NULL);

COMMIT;

#
# Data for the `informe_auditoria` table  (LIMIT 0,500)
#

INSERT INTO `informe_auditoria` (`id_nforme_auditoria`, `fecha_confeccion`, `objetivos`, `alcance`, `equipo_auditor`, `documentacion_revisada`, `personal_entrevistado`, `opinion_equipo_auditor`, `no_conformidades_detectadas`, `observaciones`, `elaborado_por`, `id_programa`, `id_entidad`, `id_proyecto`, `id_documentacion_evidencias`, `auditor_lider`) VALUES 
  (1,'2016-01-21','lol','ji','jujhh','hj','kj','uyhk','','we','de',3,8,1,1,'CArlos'),
  (4,'2016-03-23','muchos','Completo','Lopez Vega y Carlos Gus','toda la referente al software','Todos los probadores de software','Buena','','','Mesa Lopez',5,3,7,0,'Juan Cruz');

COMMIT;

#
# Data for the `informe_ejecucion_programa` table  (LIMIT 0,500)
#

INSERT INTO `informe_ejecucion_programa` (`id_informe_ejecucion_programa`, `nivel_ejecucion_presupuesto`, `etapa`, `principales_dificultades`, `conclusiones_recomendaciones`, `fecha_informe`, `cumplimiento_objtvs_propuestos`, `cumplimiento_resultados_programados`, `id_programa`, `id_dictamen_grup_exp`) VALUES 
  (2,'j','diciembre','jj','j','2016-01-31','l','ed',1,1),
  (3,'s','junio','a','a','2016-01-30','d','f',1,1),
  (4,'sdf','junio','sdf','sdf','2016-02-25','sdf','asds',3,1),
  (6,'Bueno','junio','Principales dificultades','Conclusiones','2016-02-25','Cumplidos','Programados',5,1);

COMMIT;

#
# Data for the `innovacion` table  (LIMIT 0,500)
#

INSERT INTO `innovacion` (`problema_resolver`, `fundamentacion_tecnologica`, `fundamentacion_mercado`, `aspectos_tecncios`, `aspectos_eco_mercado`, `capacidad_asimilacion_desarrollo`, `energia`, `mat_primas_recursos_naturales`, `calidad`, `medio_ambiente`, `propiedad_intelectual`, `tecnlogias_constructivas`, `analisis_sostenibilidad_innovacion`, `otros_anexos`, `id_proyecto`) VALUES 
  ('k','l','k','j','hn','h','fd','v','t','r','e','s','l','C:\\wamp\\www\\gestionando\\components\\com_innovacion\\assets\\anexos\\7 Pasos para ser un desarrollador profesional en JavaScript.pdf',1);

COMMIT;

#
# Data for the `jefeproyecto` table  (LIMIT 0,500)
#

INSERT INTO `jefeproyecto` (`titulo_obtenido`, `situacion_laboral`, `publicaciones`, `otros_aspectos`, `presupuesto_anual`, `id_categoria`, `id_grado`, `id_persona`, `cv`) VALUES 
  ('lic. bioquimica y master en salud ambiental','empleada','muchas','-------',2000,2,2,542,'C:\\wamp\\www\\gestionando\\assets\\cv\\cv2.0.doc'),
  ('ing en sistemas','empleado','sistema de facturacion online',NULL,8000,1,2,546,NULL);

COMMIT;

#
# Data for the `lista_chequeo_auditoria` table  (LIMIT 0,500)
#

INSERT INTO `lista_chequeo_auditoria` (`id_lista_chequeo`, `actividad_proceso_evaluar`, `nombre_auditor`, `requisitos_evaluar`, `observaciones`) VALUES 
  (1,'contrataciones','Carlos Otero','todos',''),
  (2,'Contenido,Interfaz','Pedro Larondo','Todos los estimados','');

COMMIT;

#
# Data for the `notificacion_ingreso_gastos` table  (LIMIT 0,500)
#

INSERT INTO `notificacion_ingreso_gastos` (`id_notif_ingresos_gastos`, `etapa`, `id_anticipo`, `id_evaluacion`, `autorizo_registrar_ingreso`, `autorizo_registrar_gasto`, `nombre_apellidos_secretario`, `fecha`, `id_programa`, `id_proyecto`, `anno`) VALUES 
  (1,'enero-marzo',1,1,587,700,'Kotiro Saldivar','2016-02-25',1,1,2016),
  (15,'enero-marzo',18,1,1000,1500,'545','2016-02-25',5,7,2016),
  (16,'enero-marzo',18,1,1000,1500,'545','2016-02-25',5,7,2016);

COMMIT;

#
# Data for the `oponencia_informe_etapa` table  (LIMIT 0,500)
#

INSERT INTO `oponencia_informe_etapa` (`anno`, `id_oponencia`, `id_informe_etapa`, `resultados_programados`, `conclusiones`, `recomendaciones`, `fecha`, `id_proyecto`) VALUES 
  (2016,1,1,'buenoss','esperads','kil','2016-01-05',1),
  (2016,9,1,'Muchos','Buenas','','2016-02-25',7),
  (2016,11,4,'Progrmados','Esperadas','','2016-03-30',7);

COMMIT;

#
# Data for the `plan_auditoria` table  (LIMIT 0,500)
#

INSERT INTO `plan_auditoria` (`id_plan_auditoria`, `objetivos_alcance`, `fecha_plan`, `director_entidad`, `equipo_auditor`, `fecha_cumplimiento`, `id_programa`, `id_entidad`, `id_proyecto`) VALUES 
  (2,'lol','2016-01-14','Rene Descartes','lol','2016-01-27',3,8,1),
  (3,'Conocer el Grado de REndimiento del software','2016-02-25','Manuel Esquiarte','Jose,Juan,Pepe','2016-02-29',5,3,7);

COMMIT;

#
# Data for the `traza` table  (LIMIT 0,500)
#

INSERT INTO `traza` (`id_traza`, `usuario`, `accion`, `componente`, `fecha`) VALUES 
  (7,'ernesto','Actualizó el(la)programa','','2015-12-20 14:49:32'),
  (8,'ernesto','Actualizó el(la)programa','','2015-12-21 08:14:34'),
  (9,'ernesto','Actualizó el(la)programa','','2015-12-21 08:15:30'),
  (10,'ernesto','Creo el(la)programa','','2015-12-21 12:02:15'),
  (11,'ernesto','Actualizó el programa','','2015-12-21 12:16:55'),
  (12,'ernesto','Elimino o Cancelo el programa','','2015-12-21 12:28:35'),
  (13,'ernesto','Actualizó el programa','','2015-12-21 12:35:07'),
  (14,'ernesto','Actualizó el programalol','','2015-12-21 12:36:59'),
  (15,'ernesto','Actualizó el programaPetrus','','2015-12-21 12:41:35'),
  (16,'ernesto','Creo el programaApple','','2015-12-21 12:47:07'),
  (17,'ernesto','Cancelo el programa Apple','','2015-12-21 12:48:32'),
  (18,'ernesto','Creo el programa lo','','2015-12-21 14:18:48'),
  (19,'ernesto','Actualizó el programa Asus','','2015-12-22 05:01:36'),
  (20,'ernesto','Canceló el programa Asus','','2015-12-22 05:07:45'),
  (21,'ernesto','Actualizó el programa Asus','','2015-12-22 05:29:46'),
  (22,'ernesto','Canceló el programa Asus','','2015-12-22 05:30:25'),
  (23,'ernesto','Actualizó el programa Asus','','2015-12-22 05:31:31'),
  (24,'ernesto','Actualizó el programa Asus','','2015-12-22 05:33:57'),
  (25,'ernesto','Actualizó el programa TV digital','','2015-12-22 05:39:28'),
  (26,'ernesto','Canceló el programa TV digital','','2015-12-22 05:39:40'),
  (27,'ernesto','Actualizó el programa de','','2015-12-22 06:13:31'),
  (28,'ernesto','Creo el programa Asus','','2015-12-22 17:02:25'),
  (29,'ernesto','Canceló el programa Asus','','2015-12-22 17:55:21'),
  (30,'ernesto','Canceló el programa Asus','','2015-12-22 17:55:41'),
  (31,'ernesto','Creo el programa Asus','','2015-12-25 07:50:14'),
  (32,'ernesto','Creo el programa Asus','','2015-12-25 11:14:15'),
  (33,'ernesto','Actualizó el programa ASUS','','2015-12-25 13:18:21'),
  (34,'ernesto','Actualizó el programa LG','','2015-12-25 13:25:07'),
  (35,'ernesto','Actualizó el programa LG','','2015-12-25 13:32:48'),
  (36,'ernesto','Canceló el programa ','','2015-12-25 13:49:16'),
  (37,'ernesto','Canceló el programa LG','','2015-12-25 13:51:47'),
  (38,'ernesto','Canceló el programa ','','2015-12-25 13:53:24'),
  (39,'ernesto','Canceló el programa Asus','','2015-12-25 14:04:44'),
  (40,'ernesto','Canceló el programa Asus','','2015-12-25 14:07:14'),
  (41,'ernesto','Creo el programa jk','','2015-12-25 14:14:27'),
  (42,'ernesto','Actualizó el programa ASUS','','2015-12-25 14:16:00'),
  (43,'ernesto','Actualizó el programa LG','','2015-12-25 14:16:38'),
  (44,'ernesto','Creo el dictamen_eval_perfil_proy #__dictamen_eval','','2015-12-29 18:23:59'),
  (45,'ernesto','Canceló el dictamen_eval_perfil_proy ','','2015-12-29 18:44:33'),
  (46,'ernesto','Canceló el dictamen_eval_perfil_proy ','','2015-12-29 18:46:59'),
  (47,'ernesto','Canceló el dictamen_eval_perfil_proy SONYEA','','2015-12-29 18:49:53'),
  (48,'ernesto','Canceló el dictamen_eval_perfil_proy SONYEA','','2015-12-29 18:50:14'),
  (49,'ernesto','Canceló el dictamen_eval_perfil_proy SONYEA','','2015-12-29 18:50:52'),
  (50,'ernesto','Creo el dictamen_eval_perfil_proy SONYEA','','2015-12-29 19:15:19'),
  (51,'ernesto','Canceló el dictamen_eval_perfil_proy SONYEA','','2015-12-29 19:15:31'),
  (52,'ernesto','Creo el dictamen_eval_perfil_proy SONYEA','','2015-12-29 19:19:06'),
  (53,'ernesto','Actualizó el dictamen_eval_perfil_proy ','','2015-12-29 19:21:40'),
  (54,'ernesto','Actualizó el dictamen_eval_perfil_proy ','','2015-12-29 19:23:32'),
  (55,'ernesto','Actualizó el dictamen_eval_perfil_proy ','','2015-12-29 19:30:12'),
  (56,'ernesto','Actualizó el dictamen_eval_perfil_proy ','','2015-12-29 19:31:17'),
  (57,'ernesto','Actualizó el dictamen_eval_perfil_proy ','','2015-12-29 19:34:13'),
  (58,'ernesto','Canceló el dictamen_eval_perfil_proy SONYEA','','2015-12-29 19:37:15'),
  (59,'ernesto','Creo el dictamen_eval_perfil_proy SONYEA','','2015-12-29 19:38:27'),
  (60,'ernesto','Canceló el dictamen_eval_perfil_proy SONYEA','','2015-12-29 19:40:38'),
  (61,'ernesto','Creo el dictamen_eval_perfil_proy SONYEA','','2015-12-29 19:43:15'),
  (62,'ernesto','Canceló el dictamen_eval_perfil_proy SONYEA','','2015-12-29 19:52:46'),
  (63,'ernesto','Creo el dictamen_eval_perfil_proy SONYEA','','2015-12-29 19:53:45'),
  (64,'ernesto','Actualizó el perfil_proyecto #__perfil_proyecto','','2016-01-04 07:03:34'),
  (65,'ernesto','Actualizó el perfil_proyecto #__perfil_proyecto','','2016-01-04 07:05:48'),
  (66,'ernesto','Creo el informe_auditoria ','','2016-01-10 07:20:05'),
  (67,'ernesto','Canceló el prioridad No necesita un Programa','','2016-01-23 18:19:53'),
  (68,'ernesto','Canceló el prioridad No necesita un Programa','','2016-01-23 18:20:07'),
  (69,'ernesto','Canceló el prioridad No necesita un Programa','','2016-01-23 18:20:20'),
  (70,'ernesto','Creo el anticipo ','','2016-01-28 01:38:20'),
  (71,'ernesto','Canceló el anticipo ','','2016-01-28 05:29:22'),
  (72,'ernesto','Canceló el anticipo ','','2016-01-28 05:29:52'),
  (73,'ernesto','Creo el anticipo ','','2016-01-28 17:19:20'),
  (74,'ernesto','Canceló el anticipo ','','2016-01-30 01:46:33'),
  (75,'ernesto','Creo el anticipo ','','2016-01-30 01:59:29'),
  (76,'ernesto','Creo el anticipo ','','2016-01-30 02:14:01'),
  (77,'ernesto','Canceló el anticipo ','','2016-01-30 02:17:12'),
  (78,'ernesto','Creo el anticipo ','','2016-01-30 02:21:55'),
  (79,'ernesto','Canceló el anticipo ','','2016-01-30 02:22:12'),
  (80,'ernesto','Creo el anticipo ','','2016-01-30 02:29:51'),
  (81,'ernesto','Canceló el anticipo ','','2016-01-30 02:55:58'),
  (82,'ernesto','Canceló el anticipo ','','2016-01-30 03:01:19'),
  (83,'ernesto','Canceló el anticipo ','','2016-01-30 05:05:46'),
  (84,'ernesto','Canceló el anticipo ','','2016-01-30 05:13:31'),
  (85,'ernesto','Canceló el anticipo ','','2016-01-30 05:16:46'),
  (86,'ernesto','Canceló el anticipo ','','2016-01-30 05:18:43'),
  (87,'ernesto','Canceló el anticipo ','','2016-01-30 05:48:28'),
  (88,'ernesto','Canceló el anticipo ','','2016-01-30 05:59:02'),
  (89,'ernesto','Canceló el anticipo ','','2016-01-30 06:02:09'),
  (90,'ernesto','Canceló el anticipo ','','2016-01-30 06:07:52'),
  (91,'ernesto','Canceló el anticipo ','','2016-01-30 06:15:06'),
  (92,'ernesto','Canceló el anticipo ','','2016-01-30 06:16:28'),
  (93,'ernesto','Canceló el anticipo ','','2016-01-30 06:31:08'),
  (94,'ernesto','Canceló el anticipo ','','2016-01-30 06:34:31'),
  (95,'ernesto','Canceló el anticipo ','','2016-01-30 06:47:00'),
  (96,'ernesto','Canceló el anticipo ','','2016-01-30 06:47:29'),
  (97,'ernesto','Canceló el anticipo ','','2016-01-30 06:48:15'),
  (98,'ernesto','Canceló el anticipo ','','2016-01-30 06:52:44'),
  (99,'ernesto','Canceló el anticipo ','','2016-01-30 07:28:30'),
  (100,'ernesto','Canceló el anticipo ','','2016-01-30 07:43:54'),
  (101,'ernesto','Canceló el anticipo ','','2016-01-30 07:46:33'),
  (102,'ernesto','Canceló el anticipo ','','2016-01-30 08:01:35'),
  (103,'gaby','Canceló el anticipo ','','2016-02-02 21:51:42'),
  (104,'gaby','Canceló el anticipo ','','2016-02-02 21:53:37'),
  (105,'gaby','Canceló el anticipo ','','2016-02-02 22:00:30'),
  (106,'gaby','Canceló el anticipo ','','2016-02-02 22:00:48'),
  (107,'gaby','Canceló el anticipo ','','2016-02-02 22:02:19'),
  (108,'gaby','Canceló el anticipo ','','2016-02-02 22:05:16'),
  (109,'gaby','Canceló el anticipo ','','2016-02-02 22:06:41'),
  (110,'gaby','Canceló el anticipo ','','2016-02-02 22:38:34'),
  (111,'gaby','Canceló el anticipo ','','2016-02-02 22:40:43'),
  (112,'gaby','Canceló el anticipo ','','2016-02-02 22:42:31'),
  (113,'gaby','Canceló el anticipo ','','2016-02-02 22:45:47'),
  (114,'gaby','Canceló el anticipo ','','2016-02-02 22:48:45'),
  (115,'ernesto','Canceló el convocatoria No necesita un Programa','','2016-02-08 01:45:42'),
  (117,'ernesto','Canceló el convocatoria ','com_convocatoria','2016-02-08 02:31:00'),
  (119,'ernesto','Creo el(la) convocatoria ','com_convocatoria','2016-02-08 02:42:31'),
  (120,'gaby','Canceló el(la) programa LG','com_programa','2016-02-17 19:46:11'),
  (121,'gaby','Canceló el(la) programa LG','com_programa','2016-02-17 19:46:26'),
  (122,'gaby','Canceló el(la) programa LG','com_programa','2016-02-17 19:47:25'),
  (123,'gaby','Canceló el(la) programa LG','com_programa','2016-02-17 19:47:46'),
  (124,'marta','Creó el(la) programa Ciencia e Innovación Tecnolog','com_programa','2016-02-23 18:05:17'),
  (125,'marta','Canceló el(la) programa ','com_convocatoria','2016-02-23 18:11:30'),
  (126,'marta','Canceló el(la) convocatoria ','com_convocatoria','2016-02-23 20:13:22'),
  (127,'ruperto','Creó el(la) perfil_proyecto ','#__perfil_proyecto','2016-02-23 22:59:40'),
  (128,'ruperto','Creó el(la) perfil_proyecto ','#__perfil_proyecto','2016-02-23 23:01:38'),
  (129,'ruperto','Creó el(la) perfil_proyecto ','#__perfil_proyecto','2016-02-23 23:02:48'),
  (130,'ruperto','Creó el(la) perfil_proyecto ','#__perfil_proyecto','2016-02-23 23:23:16'),
  (131,'ruperto','Creó el(la) perfil_proyecto ','#__perfil_proyecto','2016-02-23 23:25:38'),
  (132,'ruperto','Creó el(la) perfil_proyecto ','#__perfil_proyecto','2016-02-23 23:30:44'),
  (133,'gaby','Creó el(la) dictamen_eval_perfil_proy ','SONYEA','2016-02-23 23:32:40'),
  (134,'gaby','Creó el(la) dictamen_eval_perfil_proy ','SONYEA','2016-02-23 23:36:53'),
  (135,'gaby','Creó el(la) dictamen_eval_perfil_proy ','SONYEA','2016-02-23 23:41:19'),
  (136,'gaby','Actualizó el(la) dictamen_eval_perfil_proy ','','2016-02-24 08:01:34'),
  (137,'marta','Canceló el(la) programa Ciencia e Innovación Tecn','com_programa','2016-02-24 18:03:15'),
  (138,'marta','Canceló el(la) programa Ciencia e Innovación Tecn','com_programa','2016-02-24 18:50:16'),
  (139,'marta','Canceló el(la) programa ASUS','com_programa','2016-02-24 18:50:47'),
  (140,'marta','Canceló el(la) programa Ciencia e Innovación Tecn','com_programa','2016-02-24 19:06:51'),
  (141,'marta','Canceló el(la) programa Ciencia e Innovación Tecn','com_programa','2016-02-24 20:48:10'),
  (142,'marta','Canceló el(la) programa ','com_convocatoria','2016-02-24 21:11:08'),
  (143,'marta','Creó el(la) financista ','com_financista','2016-02-25 01:31:02'),
  (144,'marta','Creó el(la) contrato ','com_contrato','2016-02-25 02:27:55'),
  (145,'gaby','Creó el(la) control_programa_proyecto ','','2016-02-25 06:47:19'),
  (146,'gaby','Creó el(la) control_programa_proyecto ','','2016-02-25 06:53:18'),
  (147,'gaby','Creó el(la) control_programa_proyecto ','','2016-02-25 06:55:39'),
  (148,'marta','Creó el(la) prioridad ','com_prioridad','2016-02-25 13:56:34'),
  (149,'marta','Canceló el(la) prioridad ','com_forma_entrega','2016-02-25 14:40:11'),
  (150,'marta','Canceló el(la) prioridad ','com_forma_entrega','2016-02-25 14:40:20'),
  (151,'gaby','Creó el(la) anticipo ','','2016-02-25 18:30:25'),
  (152,'gaby','Creó el(la) anticipo ','','2016-02-25 18:31:33'),
  (153,'gaby','Canceló el(la) anticipo ','','2016-02-25 18:32:02'),
  (154,'gaby','Creó el(la) anticipo ','','2016-02-25 18:36:22'),
  (155,'gaby','Creó el(la) anticipo ','','2016-02-25 18:44:36'),
  (156,'gaby','Canceló el(la) anticipo ','','2016-02-25 18:45:31'),
  (157,'gaby','Canceló el(la) anticipo ','','2016-02-25 18:46:28'),
  (158,'gaby','Canceló el(la) anticipo ','','2016-02-25 18:52:08'),
  (159,'gaby','Canceló el(la) anticipo ','','2016-02-25 18:53:16'),
  (160,'gaby','Canceló el(la) anticipo ','','2016-02-25 18:54:45'),
  (161,'gaby','Creó el(la) anticipo ','','2016-02-25 18:57:23'),
  (162,'gaby','Canceló el(la) anticipo ','','2016-02-25 18:59:45'),
  (163,'gaby','Canceló el(la) anticipo ','','2016-02-25 19:01:52'),
  (164,'gaby','Creó el(la) anticipo ','','2016-02-25 19:07:22'),
  (165,'gaby','Creó el(la) anticipo ','','2016-02-25 19:10:45'),
  (166,'gaby','Canceló el(la) anticipo ','','2016-02-25 19:11:16'),
  (167,'gaby','Canceló el(la) anticipo ','','2016-02-25 19:11:16'),
  (168,'gaby','Canceló el(la) anticipo ','','2016-02-25 19:11:16'),
  (169,'gaby','Canceló el(la) anticipo ','','2016-02-25 20:25:37'),
  (170,'gaby','Creó el(la) anticipo ','','2016-02-25 20:46:25'),
  (171,'gaby','Creó el(la) anticipo ','','2016-02-25 20:51:40'),
  (172,'gaby','Canceló el(la) anticipo ','','2016-02-25 22:56:19'),
  (173,'gaby','Canceló el(la) anticipo ','','2016-02-25 22:56:44'),
  (174,'gaby','Canceló el(la) anticipo ','','2016-02-25 22:57:15'),
  (175,'gaby','Creó el(la) anticipo ','','2016-02-25 22:57:57'),
  (176,'gaby','Canceló el(la) anticipo ','','2016-02-25 22:58:54'),
  (177,'gaby','Creó el(la) anticipo ','','2016-02-25 22:59:21'),
  (178,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:01:31'),
  (179,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:02:02'),
  (180,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:02:42'),
  (181,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:04:31'),
  (182,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:04:41'),
  (183,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:05:33'),
  (184,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:07:33'),
  (185,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:08:56'),
  (186,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:12:54'),
  (187,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:15:05'),
  (188,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:16:33'),
  (189,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:17:20'),
  (190,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:17:47'),
  (191,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:19:54'),
  (192,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:21:58'),
  (193,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:23:48'),
  (194,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:24:40'),
  (195,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:26:16'),
  (196,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:27:48'),
  (197,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:29:52'),
  (198,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:30:02'),
  (199,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:31:41'),
  (200,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:32:02'),
  (201,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:34:08'),
  (202,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:35:27'),
  (203,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:35:56'),
  (204,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:36:27'),
  (205,'gaby','Canceló el(la) anticipo ','','2016-02-25 23:36:50'),
  (206,'ruperto','Canceló el(la) certificacion_activdades_resultados','','2016-02-25 23:41:34'),
  (207,'ruperto','Actualizó el(la) certificacion_activdades_resultad','','2016-02-25 23:42:05'),
  (208,'ruperto','Canceló el(la) certificacion_activdades_resultados','','2016-02-25 23:42:21'),
  (209,'ruperto','Canceló el(la) certificacion_activdades_resultados','','2016-02-25 23:54:41'),
  (210,'ruperto','Canceló el(la) certificacion_activdades_resultados','','2016-02-25 23:55:58'),
  (211,'ruperto','Canceló el(la) certificacion_activdades_resultados','','2016-02-26 00:06:28'),
  (212,'ruperto','Canceló el(la) certificacion_activdades_resultados','','2016-02-26 00:07:09'),
  (213,'ruperto','Canceló el(la) certificacion_activdades_resultados','','2016-02-26 00:07:45'),
  (214,'ruperto','Canceló el(la) certificacion_activdades_resultados','','2016-02-26 00:08:46'),
  (215,'ruperto','Canceló el(la) certificacion_activdades_resultados','','2016-02-26 00:10:06'),
  (216,'ruperto','Canceló el(la) certificacion_activdades_resultados','','2016-02-26 00:12:23'),
  (217,'ruperto','Canceló el(la) certificacion_activdades_resultados','','2016-02-26 00:13:34'),
  (218,'ruperto','Canceló el(la) certificacion_activdades_resultados','','2016-02-26 00:15:26'),
  (219,'ruperto','Canceló el(la) certificacion_activdades_resultados','','2016-02-26 00:19:59'),
  (220,'ruperto','Canceló el(la) certificacion_activdades_resultados','','2016-02-26 00:21:45'),
  (221,'ruperto','Canceló el(la) certificacion_activdades_resultados','','2016-02-26 00:21:49'),
  (222,'ruperto','Canceló el(la) certificacion_activdades_resultados','','2016-02-26 00:21:56'),
  (223,'gaby','Actualizó el(la) informe_ejecucion_programa ','','2016-02-26 02:41:18'),
  (224,'gaby','Creó el(la) informe_ejecucion_programa ','','2016-02-26 02:42:56'),
  (225,'gaby','Canceló el(la) informe_ejecucion_programa ','','2016-02-26 03:09:56'),
  (226,'gaby','Canceló el(la) informe_ejecucion_programa ','','2016-02-26 03:11:58'),
  (227,'gaby','Canceló el(la) informe_ejecucion_programa ','','2016-02-26 03:55:42'),
  (228,'gaby','Canceló el(la) informe_ejecucion_programa ','','2016-02-26 04:03:54'),
  (229,'gaby','Canceló el(la) informe_ejecucion_programa ','','2016-02-26 04:09:36'),
  (230,'gaby','Canceló el(la) informe_ejecucion_programa ','','2016-02-26 04:10:34'),
  (231,'ruperto','Creó el(la) certificacion_activdades_resultados ','','2016-02-26 04:30:54'),
  (232,'ruperto','Canceló el(la) certificacion_activdades_resultados','','2016-02-26 04:31:36'),
  (233,'ruperto','Canceló el(la) certificacion_activdades_resultados','','2016-02-26 04:32:49'),
  (234,'ruperto','Canceló el(la) certificacion_activdades_resultados','','2016-02-26 04:42:00'),
  (235,'ruperto','Canceló el(la) certificacion_activdades_resultados','','2016-02-26 04:44:08'),
  (236,'marta','Actualizó el(la) financista ','com_financista','2016-02-26 05:31:19'),
  (237,'marta','Creó el(la) plan_auditoria ','com_plan_auditoria','2016-02-26 05:39:18'),
  (238,'marta','Canceló el(la) plan_auditoria ','com_lista_chequeo_au','2016-02-26 05:43:34'),
  (239,'marta','Canceló el(la) plan_auditoria ','com_documentacion_ev','2016-02-26 05:44:35'),
  (240,'marta','Canceló el(la) plan_auditoria ','','2016-02-26 05:46:19'),
  (241,'marta','Canceló el(la) plan_auditoria ','','2016-02-26 05:49:09'),
  (242,'marta','Canceló el(la) plan_auditoria ','','2016-02-26 05:51:25');

COMMIT;

