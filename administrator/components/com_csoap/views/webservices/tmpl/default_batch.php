<?php
 /**
 * @package		SOAP Integration
 * @subpackage	com_csoap
 * @copyright	Copyright (C) 2012 Conflate. All rights reserved.
 * @license		GNU General Public License <http://www.gnu.org/copyleft/gpl.html>
 * @link		http://www.conflate.nl
 */
 
// no direct access
defined('_JEXEC') or die;

$published = $this->state->get('filter.published');
?>
<fieldset class="batch">
	<legend><?php echo JText::_('COM_CSOAP_BATCH_OPTIONS');?></legend>
	<?php echo JHtml::_('batch.access');?>

	<?php if ($published >= 0) : ?>
		<?php echo JHtml::_('batch.item', 'com_csoap', $published);?>
	<?php endif; ?>

	<button type="submit" onclick="Joomla.submitbutton('webservice.batch');">
		<?php echo JText::_('JGLOBAL_BATCH_PROCESS'); ?>
	</button>
</fieldset>
