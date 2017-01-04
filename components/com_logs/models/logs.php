    
<?php 
 defined( '_JEXEC' ) or die( 'Restricted access' );
jimport('joomla.application.component.controller');
    class logs extends JModelLegacy
{



     /**
     * Constructor
     *
     * @param object Database connector object
     */

	public $name_component='com_logs';


	function __construct( &$db ) {

        $path=FOFPlatform::getInstance()->getComponentBaseDirs($this->name_component);
        JModelLegacy::addIncludePath( $path['site'].'/models');
        
    }





}
