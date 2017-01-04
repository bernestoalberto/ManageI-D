<?php
 /**
 * @package		SOAP Integration
 * @subpackage	com_csoap
 * @copyright	Copyright (C) 2012 Conflate. All rights reserved.
 * @license		GNU General Public License <http://www.gnu.org/copyleft/gpl.html>
 * @link		http://www.conflate.nl
 */
 
// No direct access
defined('_JEXEC') or die('Restricted access');

?>
<div class="width-60 fltlft">
	<div id="cpanel" style="width: 90%;">
		<?php
		echo JHtml::_('tabs.start', 'csoap-cpanel-tabs', array('useCookie' => 1));
		echo JHtml::_('tabs.panel', JText::_('COM_CSOAP'), 'config');
        ?>
        
		<div class="config">
			<div class="icon">
				<a href="index.php?option=com_csoap&view=webservices" title="<?php echo JText::_('COM_CSOAP_WEBSERIVCES'); ?>">
					<img src="components/com_csoap/assets/images/icon-48-webservices.png" alt="" width="48" height="48" border="0"/>
					<span><?php echo JText::_('COM_CSOAP_WEBSERIVCES'); ?></span>
				</a>
			</div>
	      	<div class="icon">
				<a href="#" title="<?php echo JText::_('COM_CSOAP_HELP'); ?>" onclick="$$('dt.tabs.help').fireEvent('click')">
					<img src="templates/bluestork/images/header/icon-48-help_header.png" alt="" width="48" height="48" border="0"/>
					<span><?php echo JText::_('COM_CSOAP_HELP'); ?></span>
				</a>
			</div>
			<div style="clear: both;"></div>
	    </div>
	    
	   	<?php echo JHtml::_('tabs.panel', JText::_('COM_CSOAP_HELP'), 'help'); ?>
	   	<div class="config">
	   		<h2>Instructions</h2>
	   		<h3>Intro</h3>
	   		<p>
	   			The SOAP Integration extension makes it easy to write your own custom functions and making them available through a SOAP service with WSDL support. 
	   			You create an Joomla SOAP plugin which contains your custom functionality and you register the functions you want te be available in the service.<br />
	   			From the admin component you create a webservice and select which of the installed and enabled SOAP Plugins should be included, thus making up the functions for the webservice. 
	   			You can also select an authentication method.
	   		</p>
	   		<h3>Creating a SOAP Plugin</h3>
	   		<p>
	   			To create your custom functions for the SOAP webservice, you have to create an Joomla Plugin of type SOAP. In this plugin you can have as many functions as needed, but you need te register the specific functions needed for the webservice
	   			to make them callable by SOAP clients.<br />
	   			<a href="http://www.conflate.nl/extensions/plg-soap-helloworld.html" title="Download the Hello World example plugin" target="_blank">Download the Hello World example plugin</a> and see how you can create your own plugin. If you install this plugin it will also create a sample webservice!
	   		</p>
	   		<h3>Creating a SOAP webservice</h3>
	   		<p>
	   			When the SOAP plugins are installed and enabled you are ready to create your webservice. Go to the SOAP Integration component and from the Control Panel, click Webservices and then New.
	   			Enter a Title to identify your webservice in Joomla. Enter a namespace for your functions. The namespace is a name for your webservice functions and is not an URL for the SOAP envelope.<br />
	   			From the parameters, select which of the installed SOAP Plugins should be part of your webservice. If none selected, by default all the registered functions from all the enabled SOAP Plugins are added.<br />
	   			Select an authentication method:<br />
	   			- You can select to have no authentication. This makes your webservice publicly available so be careful.<br />
	   			- You can select to enter a username and password.<br />
	   			- You can select to use a specific Joomla user. Only the username and password for this user is accepted.<br />
	   			- You can select an access level. The usernames and passwords of the Joomla users with access to the selected level will be accepted.<br />
	   			<br />
				Now click save and your webservice is up and running. From the webservices overview you see the URL to your webservice. If you go to this URL you can see the available functions for this webservice. Also the link to the WSDL. 			
	   		</p>
	   	</div>
		<?php echo JHtml::_('tabs.end'); ?>
	</div>
</div>

<div class="width-40 fltrt">

	<?php
	echo JHtml::_('sliders.start', 'csoap-info-pane', array('useCookie' => 1, 'allowAllClose' => false));
	echo JHtml::_('sliders.panel', JText::_('COM_CSOAP'), 'info-panel');
	?>
	
	<table class="adminlist">
	   <tr>
			<td colspan="2">
          		<img src="components/com_csoap/assets/images/logo.png" align="middle" alt="<?php print JText::_('COM_CSOAP');?> logo" style="margin: 8px;" />
			</td>
		</tr>
		<tr>
			<td colspan="2">
          		<?php print JText::_('COM_CSOAP_DESC'); ?>
			</td>
		</tr>
		<tr class="row1">
			<td width="25%"><?php print JText::_('COM_CONFLATE_PACKAGE_VERSION'); ?>:</td>
			<td><?php print $this->info['package_version']; ?></td>
		</tr>
		<tr class="row1">
			<td width="25%"><?php print JText::_('COM_CSOAP_NUSOAP_VERSION'); ?>:</td>
			<td><?php print $this->info['nusoap_version']; ?></td>
		</tr>
		<tr>
			<td colspan="2">
          		<img src="components/com_csoap/assets/images/logo_conflate.png" align="middle" alt="Conflate logo" />
			</td>
		</tr>
		<tr class="row">
			<td width="25%"><?php print JText::_('COM_CONFLATE_AUTHOR'); ?>:</td>
			<td><?php print $this->info['author']; ?></td>
		</tr>
		<tr class="row1">
			<td width="25%"><?php print JText::_('COM_CONFLATE_EMAIL'); ?>:</td>
			<td><?php print $this->info['email']; ?></td>
		</tr>
		<tr class="row">
			<td width="25%"><?php print JText::_('COM_CONFLATE_WEBSITE'); ?>:</td>
			<td><a href="<?php print $this->info['website']; ?>" title="Conflate website" target="_blank"><?php print $this->info['website']; ?></a></td>
		</tr>
		<tr class="row1">
			<td width="25%"><?php print JText::_('COM_CONFLATE_EXTENSION_PAGE'); ?>:</td>
			<td><a href="<?php print $this->info['extension_url']; ?>" target="_blank"><?php print $this->info['extension_url']; ?></a></td>
		</tr>
		<tr class="row">
			<td width="25%"><?php print JText::_('COM_CONFLATE_SUPPORT_US'); ?>:</td>
			<td>
				<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_blank">
					<input type="hidden" name="cmd" value="_donations">
					<input type="hidden" name="business" value="sebastiaan@paauwtjes.nl">
					<input type="hidden" name="lc" value="US">
					<input type="hidden" name="item_name" value="Donation for the Joomla SOAP Integration extension by Conflate">
					<input type="hidden" name="no_note" value="0">
					<input type="hidden" name="currency_code" value="EUR">
					<input type="hidden" name="bn" value="PP-DonationsBF:btn_donateCC_LG.gif:NonHostedGuest">
					<input type="image" src="components/com_csoap/assets/images/btn_paypal.png" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
					<img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
				</form>
			</td>
		</tr>
	</table>

	<?php
	echo JHtml::_('sliders.end');
	?>
    	
</div>

<form action="index.php" method="post" name="adminForm" id="adminForm">

<input type="hidden" name="option" value="com_csoap" />
<input type="hidden" name="boxchecked" value="0" />
<input type="hidden" name="task" value="" />
<input type="hidden" name="statusType" value="" />
<input type="hidden" name="controller" value="" />
<?php echo JHTML::_('form.token'); ?>
</form>
