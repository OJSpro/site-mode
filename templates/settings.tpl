<script>
	$(function() {ldelim}
	$('#siteModeSettingsForm').pkpHandler('$.pkp.controllers.form.AjaxFormHandler');
	{rdelim});
</script>

<form class="pkp_form" id="siteModeSettingsForm" method="post"
	action="{url router=\PKP\core\PKPApplication::ROUTE_COMPONENT op="manage" category="generic" plugin=$pluginName verb="settings" save=true}">
	{csrf}
	{include file="controllers/notification/inPlaceNotification.tpl" notificationId="siteModeSettingsFormNotification"}

	<div id="description">{translate key="plugins.generic.siteMode.description"}</div>

	{fbvFormArea id="siteModeSettingsFormArea"}
	{fbvFormSection title="plugins.generic.siteMode.settings.mode" list=true}
	{fbvElement type="radio" id="mode-disabled" name="mode" value="disabled" checked=$mode|compare:"disabled" label="plugins.generic.siteMode.settings.mode.disabled"}
	{fbvElement type="radio" id="mode-comingSoon" name="mode" value="comingSoon" checked=$mode|compare:"comingSoon" label="plugins.generic.siteMode.settings.mode.comingSoon"}
	{fbvElement type="radio" id="mode-maintenance" name="mode" value="maintenance" checked=$mode|compare:"maintenance" label="plugins.generic.siteMode.settings.mode.maintenance"}
	{/fbvFormSection}

	<div id="comingSoonSettings" style="display: {if $mode == 'comingSoon'}block{else}none{/if};">
		{fbvFormSection title="plugins.generic.siteMode.settings.comingSoon.content" description="plugins.generic.siteMode.settings.comingSoon.content.description"}
		{fbvElement type="textarea" multilingual=false name="comingSoonContent" id="comingSoonContent" value=$comingSoonContent rich=true height=$fbvStyles.height.TALL}
		{/fbvFormSection}

		{fbvFormSection title="plugins.generic.siteMode.settings.comingSoon.date" description="plugins.generic.siteMode.settings.comingSoon.date.description"}
		{fbvElement type="text" id="comingSoonDate" name="comingSoonDate" value=$comingSoonDate}
		{/fbvFormSection}
	</div>

	<div id="maintenanceSettings" style="display: {if $mode == 'maintenance'}block{else}none{/if};">
		{fbvFormSection title="plugins.generic.siteMode.settings.maintenance.content" description="plugins.generic.siteMode.settings.maintenance.content.description"}
		{fbvElement type="textarea" multilingual=false name="maintenanceContent" id="maintenanceContent" value=$maintenanceContent rich=true height=$fbvStyles.height.TALL}
		{/fbvFormSection}
	</div>
	{/fbvFormArea}

	{fbvFormButtons}

	<p><span class="formRequired">{translate key="common.requiredField"}</span></p>
</form>

<script type="text/javascript">
	$(document).ready(function() {ldelim}
	// Show/hide settings based on mode selection
	$('input[name="mode"]').change(function() {ldelim}
	var selectedMode = $(this).val();

	$('#comingSoonSettings').hide();
	$('#maintenanceSettings').hide();

	if (selectedMode === 'comingSoon') {ldelim}
	$('#comingSoonSettings').show();
	{rdelim} else if (selectedMode === 'maintenance') {ldelim}
	$('#maintenanceSettings').show();
	{rdelim}
	{rdelim});
	{rdelim});
</script>