#
#<?php die('Forbidden.'); ?>
#Date: 2016-02-24 19:37:36 UTC
#Software: Joomla Platform 13.1.0 Stable [ Curiosity ] 24-Apr-2013 00:00 GMT

#Fields: datetime	priority clientip	category	message
2016-02-24T19:37:36+00:00	ERROR 127.0.0.1	com_perfil_programa	eliminado
2016-02-24T20:48:10+00:00	ERROR 127.0.0.1	com_programa	Cannot delete or update a parent row: a foreign key constraint fails (`dev_bussines`.`perfil_proyecto`, CONSTRAINT `Refprograma57` FOREIGN KEY (`id_programa`) REFERENCES `programa` (`id_programa`)) SQL=DELETE 
FROM programa
WHERE `id_programa` = '5'
2016-02-25T06:47:27+00:00	ERROR 127.0.0.1	com_control_programa_proyecto	Cannot add or update a child row: a foreign key constraint fails (`dev_bussines`.`control_programa_proyecto`, CONSTRAINT `Refejecutora75` FOREIGN KEY (`id_entidad`) REFERENCES `ejecutora` (`id_entidad`)) SQL=INSERT INTO `control_programa_proyecto`
(`entidad_finacista`,`otros_aspectos`,`acuerdos_adoptados`,`nombre_apellidos_evaluador`,`nombre_apellidos_evaluado`,`participante`,`fecha_control`,`id_estado_ejecucion_proyecto`,`id_problema_detectado`,`id_entidad`,`id_proyecto`,`fecha_firma_evaluador`,`fecha_firma_evaluado`) VALUES 
('4','','Varios','Jose CArlos Guillama','Luis Enrique Escobar','3','2016/02/25','1','3','3','7','2016/03/28','2016/03/17')
2016-02-25T06:53:18+00:00	ERROR 127.0.0.1	com_control_programa_proyecto	Cannot add or update a child row: a foreign key constraint fails (`dev_bussines`.`control_programa_proyecto`, CONSTRAINT `Refejecutora75` FOREIGN KEY (`id_entidad`) REFERENCES `ejecutora` (`id_entidad`) ON UPDATE CASCADE) SQL=INSERT INTO `control_programa_proyecto`
(`entidad_finacista`,`otros_aspectos`,`acuerdos_adoptados`,`nombre_apellidos_evaluador`,`nombre_apellidos_evaluado`,`participante`,`fecha_control`,`id_estado_ejecucion_proyecto`,`id_problema_detectado`,`id_entidad`,`id_proyecto`,`fecha_firma_evaluador`,`fecha_firma_evaluado`) VALUES 
('4','','Varios','Jose Angel Munero','Luis Vega','4','2016/02/25','1','1','3','7','2016/02/27','2016/02/29')
2016-02-25T18:28:38+00:00	NOTICE 127.0.0.1	-	correo enviado
2016-02-25T18:28:45+00:00	ERROR 127.0.0.1	com_anticipo	No se pudo enviar el correo  al financistaCALISOFT
2016-02-25T18:30:17+00:00	NOTICE 127.0.0.1	-	correo enviado
2016-02-25T18:30:20+00:00	ERROR 127.0.0.1	com_anticipo	No se pudo enviar el correo  al financistaCALISOFT
2016-02-25T18:31:32+00:00	NOTICE 127.0.0.1	-	correo enviado
2016-02-25T18:31:32+00:00	ERROR 127.0.0.1	com_anticipo	No se pudo enviar el correo  al financistaCALISOFT
2016-02-25T18:36:21+00:00	NOTICE 127.0.0.1	-	correo enviado
2016-02-25T18:36:21+00:00	ERROR 127.0.0.1	com_anticipo	No se pudo enviar el correo  al financistaCALISOFT
2016-02-25T18:44:24+00:00	NOTICE 127.0.0.1	-	correo enviado
2016-02-25T18:44:30+00:00	ERROR 127.0.0.1	com_anticipo	No se pudo enviar el correo  al financistaCALISOFT
2016-02-25T18:52:04+00:00	ERROR 127.0.0.1	com_notificacion_ingreso_gastos	No se pudo enviar el correo  al financistaCALISOFT
2016-02-25T18:53:15+00:00	ERROR 127.0.0.1	com_notificacion_ingreso_gastos	No se pudo enviar el correo  al financistaCALISOFT
2016-02-25T18:54:44+00:00	ERROR 127.0.0.1	com_notificacion_ingreso_gastos	No se pudo enviar el correo  al financistaCALISOFT
2016-02-25T18:57:22+00:00	NOTICE 127.0.0.1	-	correo enviado
2016-02-25T18:57:22+00:00	ERROR 127.0.0.1	com_anticipo	No se pudo enviar el correo  al financistaCALISOFT
2016-02-25T18:59:44+00:00	ALERT 127.0.0.1	com_notificacion_ingreso_gastos	Se pudo enviar el correo  al financistaCALISOFT
2016-02-25T18:59:44+00:00	ERROR 127.0.0.1	com_notificacion_ingreso_gastos	No se pudo enviar el correo  al financistaCALISOFT
2016-02-25T19:07:21+00:00	NOTICE 127.0.0.1	-	correo enviado
2016-02-25T19:07:21+00:00	ERROR 127.0.0.1	com_anticipo	No se pudo enviar el correo  al financistaCALISOFT
2016-02-25T19:10:48+00:00	NOTICE 127.0.0.1	-	correo enviado
2016-02-25T19:10:48+00:00	ERROR 127.0.0.1	com_anticipo	No se pudo enviar el correo  al financistaCALISOFT
2016-02-25T20:25:37+00:00	ERROR 127.0.0.1	com_oponencia_informe_etapa	Cannot add or update a child row: a foreign key constraint fails (`dev_bussines`.`oponencia_informe_etapa`, CONSTRAINT `oponencia_informe_etapa_fk` FOREIGN KEY (`id_proyecto`) REFERENCES `informe_etapa` (`id_proyecto`) ON UPDATE CASCADE) SQL=INSERT INTO `oponencia_informe_etapa`
(`id_informe_etapa`,`resultados_programados`,`conclusiones`,`recomendaciones`,`fecha`) VALUES 
('4','fsgsdfg','sdfgsdf','sgdfg','2016/02/16')
2016-02-25T23:17:21+00:00	ERROR 127.0.0.1	com_oponencia_informe_etapa	Cannot add or update a child row: a foreign key constraint fails (`dev_bussines`.`oponencia_informe_etapa`, CONSTRAINT `oponencia_informe_etapa_fk` FOREIGN KEY (`id_proyecto`) REFERENCES `informe_etapa` (`id_proyecto`) ON UPDATE CASCADE) SQL=INSERT INTO `oponencia_informe_etapa`
(`id_informe_etapa`,`resultados_programados`,`conclusiones`,`recomendaciones`,`fecha`) VALUES 
('4','sdfsdfadfa','afadfs','sdfsd','2016/02/29')
2016-02-25T23:19:25+00:00	ERROR 127.0.0.1	com_oponencia_informe_etapa	Cannot add or update a child row: a foreign key constraint fails (`dev_bussines`.`oponencia_informe_etapa`, CONSTRAINT `oponencia_informe_etapa_fk` FOREIGN KEY (`id_proyecto`) REFERENCES `informe_etapa` (`id_proyecto`) ON UPDATE CASCADE) SQL=INSERT INTO `oponencia_informe_etapa`
(`id_informe_etapa`,`resultados_programados`,`conclusiones`,`recomendaciones`,`fecha`) VALUES 
('4','dfasd','fasdfa','asdfasdf','2016/02/29')
2016-02-25T23:21:35+00:00	ERROR 127.0.0.1	com_oponencia_informe_etapa	Cannot add or update a child row: a foreign key constraint fails (`dev_bussines`.`oponencia_informe_etapa`, CONSTRAINT `oponencia_informe_etapa_fk` FOREIGN KEY (`id_proyecto`) REFERENCES `informe_etapa` (`id_proyecto`) ON DELETE CASCADE ON UPDATE CASCADE) SQL=INSERT INTO `oponencia_informe_etapa`
(`id_informe_etapa`,`resultados_programados`,`conclusiones`,`recomendaciones`,`fecha`) VALUES 
('4','sfasdf','asdfasd','asdfasd','2016/02/29')
2016-02-25T23:23:49+00:00	ERROR 127.0.0.1	com_dictamen_grupo_expertos_inf_etapa	Duplicata du champ '1' pour la clef 'dictamen_grupo_expertos_inf_etapa_id_informe_etapa_uindex' SQL=INSERT INTO `dictamen_grupo_expertos_inf_etapa`
(`id_informe_etapa`,`evaluacion_objetivos`,`evaluacion_resultados`,`evaluacion_actividades`,`observaciones`,`conclusiones`,`recomendaciones`,`nombre_apellidos_miembroGEP`,`fecha_dictamen`,`anno`) VALUES 
('1','2','1','1','adsfasdfa','Certificar','asdfa','asdfasdf','2016/02/29','2016')
2016-02-25T23:25:34+00:00	ERROR 127.0.0.1	com_dictamen_grupo_expertos_inf_etapa	Duplicata du champ '1' pour la clef 'dictamen_grupo_expertos_inf_etapa_id_informe_etapa_uindex' SQL=INSERT INTO `dictamen_grupo_expertos_inf_etapa`
(`id_informe_etapa`,`evaluacion_objetivos`,`evaluacion_resultados`,`evaluacion_actividades`,`observaciones`,`conclusiones`,`recomendaciones`,`nombre_apellidos_miembroGEP`,`fecha_dictamen`,`anno`) VALUES 
('1','2','1','2','sadfadf','Certificar','asdfasdfa','sdfadfas','2016/02/29','2016')
2016-02-25T23:27:14+00:00	ERROR 127.0.0.1	com_dictamen_grupo_expertos_inf_etapa	Duplicata du champ '4' pour la clef 'dictamen_grupo_expertos_inf_etapa_id_informe_etapa_uindex' SQL=INSERT INTO `dictamen_grupo_expertos_inf_etapa`
(`id_informe_etapa`,`evaluacion_objetivos`,`evaluacion_resultados`,`evaluacion_actividades`,`observaciones`,`conclusiones`,`recomendaciones`,`nombre_apellidos_miembroGEP`,`fecha_dictamen`,`anno`) VALUES 
('4','2','1','1','asdfasdf','Certificar','asdfadfas','asdfasd','2016/02/29','2016')
2016-02-25T23:55:18+00:00	ERROR 127.0.0.1	com_control_ejecucion_presupuesto	Cannot add or update a child row: a foreign key constraint fails (`dev_bussines`.`control_ejecucion_presupuesto`, CONSTRAINT `Refnotificacion_ingreso_gastos34` FOREIGN KEY (`id_notif_ingresos_gastos`) REFERENCES `notificacion_ingreso_gastos` (`id_notif_ingre) SQL=INSERT INTO `control_ejecucion_presupuesto`
(`anno`,`fecha_inicio`,`id_anticipo`,`fecha_terminacion`,`id_certificacion`,`id_programa`,`id_proyecto`,`etapa`) VALUES 
('2016','2016/02/24','18','2016/02/29','4','5','7','enero-marzo')
2016-02-26T04:43:37+00:00	ERROR 127.0.0.1	com_informe_etapa	Cannot add or update a child row: a foreign key constraint fails (`dev_bussines`.`informe_etapa`, CONSTRAINT `Refjefeproyecto56` FOREIGN KEY (`id_persona`) REFERENCES `jefeproyecto` (`id_persona`)) SQL=INSERT INTO `informe_etapa`
(`etapa`,`cumplimiento_cronograma_actividades`,`cumplimiento_resultados_programados`,`id_programa`,`id_entidad`,`id_persona`,`id_proyecto`,`anno`) VALUES 
('mayo','Cumplidos','Programados','5','3','546','7','2016')
2016-02-26T05:46:19+00:00	ERROR 127.0.0.1	com_documentacion_evidencias_objetivas	Cannot add or update a child row: a foreign key constraint fails (`dev_bussines`.`informe_auditoria`, CONSTRAINT `informe_auditoria_fk` FOREIGN KEY (`id_documentacion_evidencias`) REFERENCES `documentacion_evidencias_objetivas` (`id_documentacion_evidencias`) SQL=INSERT INTO `informe_auditoria`
(`fecha_confeccion`,`objetivos`,`alcance`,`auditor_lider`,`equipo_auditor`,`documentacion_revisada`,`personal_entrevistado`,`opinion_equipo_auditor`,`observaciones`,`elaborado_por`,`id_programa`,`id_entidad`,`id_proyecto`) VALUES 
('2016/03/23','Todos','Maximo','Juan Cruz','Lorena,Susy, Vianca','documentacion y pruebas realizadas al software','Kenny Arevalo','Lopez Sosa, Carla Maria','','Rigoberto Dominguez','5','3','7')
2016-02-26T05:50:01+00:00	ERROR 127.0.0.1	com_documentacion_evidencias_objetivas	Cannot add or update a child row: a foreign key constraint fails (`dev_bussines`.`informe_auditoria`, CONSTRAINT `informe_auditoria_fk` FOREIGN KEY (`id_documentacion_evidencias`) REFERENCES `documentacion_evidencias_objetivas` (`id_documentacion_evidencias`) SQL=INSERT INTO `informe_auditoria`
(`fecha_confeccion`,`objetivos`,`alcance`,`auditor_lider`,`equipo_auditor`,`documentacion_revisada`,`personal_entrevistado`,`opinion_equipo_auditor`,`observaciones`,`elaborado_por`,`id_programa`,`id_entidad`,`id_proyecto`) VALUES 
('2016/03/23','Optimizar el proceso de la entidad','Completo','Juan Cruz','Marcos, Rafael','Todos los manuales del software','Kenny, Pablo,Jose','Muy  buena opinion','','Denia Suarez','5','3','7')
2016-02-27T18:45:19+00:00	ERROR 127.0.0.1	com_prioridad	Cannot delete or update a parent row: a foreign key constraint fails (`dev_bussines`.`perfil_programa`, CONSTRAINT `Refprioridad801` FOREIGN KEY (`id_prioridad`) REFERENCES `prioridad` (`id_prioridad`) ON UPDATE CASCADE) SQL=DELETE 
FROM prioridad
WHERE `id_prioridad` = '4'
