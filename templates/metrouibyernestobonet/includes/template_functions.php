<?php
/**
 * Created by PhpStorm.
 * User: Ernesto
 * Date: 8/28/15
 * Time: 4:46 p.m.
 */




function getMenu($menu,$style){
    $result="";
    foreach($menu as $menuitem)
    {

        if($menuitem->level==1) {
            $haschildclass = "";
            $result = $result. '<li>' . "\n";
            if (hasChilds($menuitem->id, $menu))
                $haschildclass = 'class=""';
            switch ($menuitem->title) {
                case 'Inicio':
                    $result = $result . '<a ' . $haschildclass . ' href="' . $menuitem->link . '">'

                        . '<i class="fa fa-home"></i> <span>' . "\n" . $menuitem->title . "\n" . '</a>' . "\n";
                    if ($haschildclass != "") {
                        $result = $result . '<ul class="treeview-menu ' . $style . '" data-role="dropdown">' . "\n";
                        $result = $result . getChildsMenu($menuitem->id, $menu, $style);
                        $result = $result . '</ul>' . "\n";
                    }
                    $result = $result . '</li>' . "\n";

                    break;

                case 'Programa':
                    $result = $result . '<a ' . $haschildclass . ' href="'. $menuitem->link . '">'

                        . '<i class="fa fa-folder-open"></i> <span>' . "\n" . $menuitem->title . "\n" . '</span> <i class="fa fa-angle-left pull-right"></i>
						</a>' . "\n";
                    if ($haschildclass != "") {
                        $result = $result . '<ul class="treeview-menu ' . $style . '" data-role="dropdown">' . "\n";
                        $result = $result . getChildsMenu($menuitem->id, $menu, $style);
                        $result = $result . '</ul>' . "\n";
                    }
                    $result = $result . '</li>' . "\n";

                    break;

                case 'Proyecto':
                    $result = $result . '<a ' . $haschildclass . ' href="' . $menuitem->link . '">'

                        . '<i class="fa fa-th"></i> <span>' . "\n" . $menuitem->title . "\n" . ' </span> <i class="fa fa-angle-left pull-right"></i>
						</a>' . "\n";
                    if ($haschildclass != "") {
                        $result = $result . '<ul class="treeview-menu ' . $style . '" data-role="dropdown">' . "\n";
                        $result = $result . getChildsMenu($menuitem->id, $menu, $style);
                        $result = $result . '</ul>' . "\n";
                    }
                    $result = $result . '</li>' . "\n";

                    break;
                case 'Ejecución':
                    $result = $result . '<a ' . $haschildclass . ' href="' . $menuitem->link . '">'

                        . '<i class="fa fa-th"></i> <span>' . "\n" . $menuitem->title . "\n" . ' </span> <i class="fa fa-angle-left pull-right"></i>
						</a>' . "\n";
                    if ($haschildclass != "") {
                        $result = $result . '<ul class="treeview-menu ' . $style . '" data-role="dropdown">' . "\n";
                        $result = $result . getChildsMenu($menuitem->id, $menu, $style);
                        $result = $result . '</ul>' . "\n";
                    }
                    $result = $result . '</li>' . "\n";

                    break;
                case 'Control':
                    $result = $result . '<a ' . $haschildclass . ' href="' . $menuitem->link . '">'

                        . '<i class="fa fa-file-text"></i> <span>' . "\n" . $menuitem->title . "\n" . ' </span> <i class="fa fa-angle-left pull-right"></i>
						</a>' . "\n";
                    if ($haschildclass != "") {
                        $result = $result . '<ul class="treeview-menu ' . $style . '" data-role="dropdown">' . "\n";
                        $result = $result . getChildsMenu($menuitem->id, $menu, $style);
                        $result = $result . '</ul>' . "\n";
                    }
                    $result = $result . '</li>' . "\n";

                    break;
                case 'Reportes':
                    $result = $result . '<a ' . $haschildclass . ' href="' . $menuitem->link . '">'

                        . '<i class="fa fa-bar-chart-o"></i> <span>' . "\n" . $menuitem->title . "\n" . '</span><i class="fa fa-angle-left pull-right"></i>
						</a>' . "\n";
                    if ($haschildclass != "") {
                        $result = $result . '<ul class="treeview-menu ' . $style . '" data-role="dropdown">' . "\n";
                        $result = $result . getChildsMenu($menuitem->id, $menu, $style);
                        $result = $result . '</ul>' . "\n";
                    }
                    $result = $result . '</li>' . "\n";

                    break;
                case 'Nomencladores':
                    $result = $result . '<a ' . $haschildclass . ' href="' . $menuitem->link . '">'

                        . '<i class="fa fa-sitemap"></i> <span>' . "\n" . $menuitem->title . "\n" . ' </span> <i class="fa fa-angle-left pull-right"></i>
						</a>' . "\n";
                    if ($haschildclass != "") {
                        $result = $result . '<ul class="treeview-menu ' . $style . '" data-role="dropdown">' . "\n";
                        $result = $result . getChildsMenu($menuitem->id, $menu, $style);
                        $result = $result . '</ul>' . "\n";
                    }
                    $result = $result . '</li>' . "\n";

                    break;
                case 'Herramientas':
                    $result = $result . '<a ' . $haschildclass . ' href="' . $menuitem->link . '">'

                        . '<i class="icon ion-gear-a"></i> <span>' . "\n" . $menuitem->title . "\n" . ' </span> <i class="fa fa-angle-left pull-right"></i>
						</a>' . "\n";
                    if ($haschildclass != "") {
                        $result = $result . '<ul class="treeview-menu ' . $style . '" data-role="dropdown">' . "\n";
                        $result = $result . getChildsMenu($menuitem->id, $menu, $style);
                        $result = $result . '</ul>' . "\n";
                    }
                    $result = $result . '</li>' . "\n";

                    break;
                case 'Trazas':
                    $result = $result . '<a ' . $haschildclass . ' href="' . $menuitem->link . '">'

                        . '<i class="ion-ios-game-controller-a" size ="48"></i> <span>' . "\n" . $menuitem->title . "\n" . ' </span>
						</a>' . "\n";

                    $result = $result . '</li>' . "\n";

                    break;
                case 'Roles':
                    $result = $result . '<a ' . $haschildclass . ' href="' . $menuitem->link . '">'

                        . '<i class="ion-ios-people" size ="48"></i> <span>' . "\n" . $menuitem->title . "\n" . '
						</a>' . "\n";

                    $result = $result . '</li>' . "\n";

                    break;
                case 'Registros(Logs)':
                    $result = $result . '<a ' . $haschildclass . ' href="' . $menuitem->link . '">'

                        . '<i class="fa fa-file-text"></i> <span>' . "\n" . $menuitem->title . "\n" . '</a>' . "\n";
                    $result = $result . '</li>' . "\n";

                    break;

            }

        }

    }

    return $result;

}

function getChildsMenu($parentid,$menu,$style)
{
    $result="";

    foreach($menu as $menuitem)
    {
        if($menuitem->level>1 && $menuitem->parent_id==$parentid)
        {
            $haschildclass="";
            $result=$result.'<li>'."\n";
            if(hasChilds($menuitem->id,$menu))
                $haschildclass='class="dropdown-toggle"';
            $result=$result.'<a '.$haschildclass.' href="index.php/'.$menuitem->route.'">
                         '."\n".$menuitem->title."\n".'
                      </a>'."\n";
            if($haschildclass!="")
            {
                $result=$result.'<ul class="dropdown-menu '.$style.'" data-role="dropdown">'."\n";
                $result=$result.getChildsMenu($menuitem->id,$menu,$style);
                $result=$result.'</ul>'."\n";
            }
            $result=$result.'</li>'."\n";
        }
    }
    return $result;
}

function hasChilds($parentid,$menu)
{
    $result=false;
    $cant=count($menu);
    $i=0;
    while($i<$cant && !$result)
    {
        $menuitem=$menu[$i];
        if($menuitem->parent_id==$parentid)
        {
            $result=true;
        }
        $i++;
    }
    return $result;
}
?>
