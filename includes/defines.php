<?php
/**
 * @package    Joomla.Site
 *
 * @copyright  Copyright (C) 2005 - 2015 Open Source Matters, Inc. All rights reserved.
 * @license    GNU General Public License version 2 or later; see LICENSE.txt
 */

defined('_JEXEC') or die;

// Global definitions
$parts = explode(DIRECTORY_SEPARATOR, JPATH_BASE);

// Defines.
define('JPATH_ROOT',          implode(DIRECTORY_SEPARATOR, $parts));
define('JPATH_SITE',          JPATH_ROOT);
define('JPATH_AUTENTICARSE', 'gestionando');
define('JPATH_CONFIGURATION', JPATH_ROOT);
define('JINDEX'             ,JPATH_ROOT.'index.php');
define('JPATH_ADMINISTRATOR', JPATH_ROOT . DIRECTORY_SEPARATOR . 'administrator');
define('JPATH_LIBRARIES',     JPATH_ROOT . DIRECTORY_SEPARATOR . 'libraries');
define('JPATH_PLUGINS',       JPATH_ROOT . DIRECTORY_SEPARATOR . 'plugins');
define('JPATH_INSTALLATION',  JPATH_ROOT . DIRECTORY_SEPARATOR . 'installation');
define('JPATH_THEMES',        JPATH_BASE . DIRECTORY_SEPARATOR . 'templates');
define('JPATH_CACHE',         JPATH_BASE . DIRECTORY_SEPARATOR . 'cache');
define('JPATH_MANIFESTS',     JPATH_ADMINISTRATOR . DIRECTORY_SEPARATOR . 'manifests');
define('JPATH_DB_FILE',       JPATH_ROOT . DIRECTORY_SEPARATOR . 'assets/php/DB_Externa.php');
define('JPATH_BACKUP_DB',     JPATH_ROOT . DIRECTORY_SEPARATOR . 'assets/php/backup_db.php');
define('JPATH_AJAX',          JPATH_ROOT . DIRECTORY_SEPARATOR . 'assets/php/ajax.php');
define('JPATH_IMG_UPLOAD',    JPATH_ROOT.DIRECTORY_SEPARATOR.'images/users'.DIRECTORY_SEPARATOR);
define('JPATH_MPDF',          JPATH_BASE.DIRECTORY_SEPARATOR.'assets'.DIRECTORY_SEPARATOR.'phpmpdf'.DIRECTORY_SEPARATOR);
define('JPATH_EXCEL',         JPATH_ROOT.DIRECTORY_SEPARATOR.'assets/PHPExcel/');
define('JPATH_LOGOMIC',      JPATH_ROOT.DIRECTORY_SEPARATOR.'images/logomic.png');
define('JPATH_LOGFILE',      JPATH_ROOT.DIRECTORY_SEPARATOR.'logs/error.php');
define('JPATH_LOGFILEBUSSINES',      JPATH_ROOT.DIRECTORY_SEPARATOR.'logs/logs.php');
define('JPATH_ANTICIPOFILES', JPATH_ROOT.DIRECTORY_SEPARATOR.'assets/anticipo/anticipo.doc');
define('JPATH_CERTIFARFILES', JPATH_ROOT.DIRECTORY_SEPARATOR.'assets/certif/certfar.doc');
define('JPATH_CV', JPATH_ROOT.DIRECTORY_SEPARATOR.'assets/cv/');
define('JPATH_ANEXOSID', JPATH_ROOT.DIRECTORY_SEPARATOR.'assets/anexos_i_d/');
define('JPATH_NOTIF', JPATH_ROOT.DIRECTORY_SEPARATOR.'assets/notif/notif.doc');
define('JPATH_INFETAPA', JPATH_ROOT.DIRECTORY_SEPARATOR.'assets/infetp/infetp.doc');
define('JPATH_LOGIN'        , JPATH_ROOT.DIRECTORY_SEPARATOR.'templates/metrouibyernestobonet/');
