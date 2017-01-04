
		<?php
	
				$componentbase = $this->_basePath;      ?>      
				<html xmlns="http://www.w3.org/1999/html">
				<head>                                                                                     
				    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">               
				    <title>Proyecto </title>
				</head>
				<body >

							<div >



								<section class="content-header">
									<h1>
										Proyectos Aprobados
									</h1>
									<ol class="breadcrumb">
										<div class="btn-group">
											<button type="button" class="btn btn-success">Acciones<i class="fa fa-gears"></i></button>
											<button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
												<span class="caret"></span>
												<span class="sr-only">Desplegar</span>
											</button>
											<ul class="dropdown-menu" role="menu">
												<li><a href= "#" title="PDF" id ="export_pdf_proyecto" onclick=""><i class='icon ion-android-document'></i> <?php  echo JText::_('Exportar a PDF');?></a></li>
											</ul>
										</div>
									</ol>
								</section>
								</br>
								<div class="content box box-primary" id ="pdf_proyecto">
									<div id="gridselection_proyecto"  style="width:100%"></div>
								</div>

							</div>




				</body>