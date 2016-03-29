<h1>Глобальные настройки сайта</h1>
<form name="settings" action="[+moduleurl+]h=saveSettings" method="post" id="EvoSettings">
	<input type="hidden" name="filemanager_path" value="[(filemanager_path)]">
	<input type="hidden" name="rb_base_dir" value="[(rb_base_dir)]">
	<input type="hidden" name="check_files_onlogin" value="[(check_files_onlogin)]">
	<div id="actions">
		<ul class="actionButtons">
			<li id="Button1"><a href="#" onclick="documentDirty=false; document.settings.submit();"><img src="[+style.icons_save+]"> [+lang.save+] </a></li>
			<li id="Button2"><a href="#" onclick="documentDirty=false; document.location.href='index.php?a=112&h=add&id=[+pluginid+]';"><img src="[+style.icons_add+]"> [+lang.add+] </a></li>
			<li id="Button5"><a href="#" onclick="documentDirty=false; document.location.href='index.php?a=2';"><img src="[+style.icons_cancel+]"> [+lang.cancel+] </a></li>
		</ul>
	</div>
	<div class="sectionBody">
		<div class="tab-pane" id="docManagerPane">
			<script type="text/javascript">
				Us = new WebFXTabPane(document.getElementById('docManagerPane'));
			</script>
			[+tabSettings+]
			<div class="tab-page" id="tabSettings">
				<h2 class="tab">[+lang.add+] / [+lang.edit+]</h2>
				<ul>
					[+tabGroups+]
				</ul>
			</div>
		</div>
	</div>
</form>
<script type="text/javascript">        
	Us.addTabPage(document.getElementById('tabSettings'));
</script>
[+tab+]