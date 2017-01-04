<?php

$html='';

    $html = '
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>

<body>
<h3>Principales incidencias del proceso de  convocatoria, evaluaci&oacute;n y selecci&oacute;n de proyectos</h3>';
try {
$listado= $this->listado;
$html1='';
for($i=0;$i<count($listado);$i++){
        $html1 = $html1.'
        <div>
  <p><strong>Programa: </strong>' . $listado[$i]->programa . ' <br />
      <strong>Resumen: </strong>' . $listado[$i]->texto . '<br />
      <strong>Inicio: </strong>' . $listado[$i]->inicio . '<br />
      <strong>Cierre:</strong>' . $listado[$i]->cierre . '<br />
	    <strong>Visibilidad:</strong>' . $listado[$i]->visibilidad . '<br />

  <p>&nbsp;</p>
</div>
<table border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td width="209" valign="top"><p><strong>Nombre</strong></p></td>
    <td width="168" valign="top"><p><strong>Cargo</strong></p></td>

  </tr>
  <tr>
    <td width="209" valign="top"><p>&nbsp;' . $listado[$i]->nombre. $listado[$i]->apellido. '</p></td>
    <td width="168" valign="top"><p>Jefe de programa</p></td>
  </tr>
</table>
  <br />
  <br />
  <br />
  <br />
';
    }
    $html3='';
    $html3 = $html3.'
    <img src="'.JPATH_LOGOMIC.' " />
    ';
//==============================================================
//==============================================================
//==============================================================
    include (JPATH_MPDF.'mpdf.php');

   // $mpdf=new mPDF('c','A4','','',32,25,27,25,16,13);
   // $mpdf=new mPDF();

 //   $mpdf->SetDisplayMode('fullpage');

    //$mpdf->list_indent_first_level = 0;	// 1 or 0 - whether to indent the first level of a list

// LOAD a stylesheet
  //  $stylesheet = file_get_contents(JPATH_MPDF.'mpdfstyletables.css');
    //$mpdf->WriteHTML($stylesheet,1);

        // The parameter 1 tells that this is css/style only and no body/html/text
    //$mpdf->WriteHTML($html,2);

    //$mpdf->Output('mpdf.pdf','I');
  //  $mpdf->Output();
    $mpdf=new mPDF();
    $html = $html.$html1.$html3;
    $mpdf->WriteHTML($html);
    $mpdf->Output();
    exit;
//==============================================================
//==============================================================
//==============================================================
}
catch(Exception $e){
    exit('No se puede mostrar la pagina solicitada:'.$e->getMessage());
}

?>
