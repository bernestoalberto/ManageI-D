
		<?php
			if (!JFactory::getUser()->authorise('core.admin', 'com_users')) { 
				    return JError::raiseWarning(404, JText::_('acceso no autorizado'));  
				}
		      $lista = $this->lista;
		      $listaNegocio = $this->listaNegocio;

				$componentbase = $this->_basePath;      ?>
				<html xmlns="http://www.w3.org/1999/html">
				<head>                                                                                     
				    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">               
				    <title>Logs Grid</title>
					
				</head>
				<body class="skin-blue sidebar-mini">

				<div class="nav-tabs-custom">
					<ul class="nav nav-tabs">
						<li><a data-toggle="tab" href="#file">Sistema</a></li>
						<li class="active"><a data-toggle="tab" href="#bussines">Negocio</a></li>
					</ul>
					<div class="tab-content">
						<div id="file" class="tab-pane">
							<div >
								<section class="content-header">
									<h1>
										Logs del Sistema
									</h1>

								</section>
								</br>
								<div class="content box box-primary" >
									<?php
									for($i=0;$i<count($lista);$i++){
										echo $lista[$i].' </br> ';
									}

									?>
								</div>


							</div>

						</div>
						<div id="bussines" class="tab-pane active">
							<div >
								<section class="content-header">
									<h1>
										Logs del Negocio
									</h1>

								</section>
								</br>
								<div class="content box box-primary" >
									<?php
									for($i=0;$i<count($listaNegocio);$i++){
										echo $listaNegocio[$i].' </br> ';
									}

									?>
								</div>
							</div>

						</div>
					</div>
				</div>


				</body>