<h1>[+lang.settings_config+]</h1>
<div id="actions">
	<ul class="actionButtons">
		<!--<li id="Button1"><a href="#" onclick="documentDirty=false; document.settings.submit();"> Сохранить </a></li>-->
		<li id="Button2"><a href="#" onclick="documentDirty=false; document.settings.submit();"><img src="[+style.icons_add+]"> [+lang.save+] </a></li>
		<li id="Button2"><a href="#" onclick="documentDirty=false; document.location.href='index.php?a=112&id=[+pluginid+]&h=resetconfig';"><img src="[+style.icons_delete+]"> [+lang.reset+] </a></li>
		<li id="Button5"><a href="#" onclick="documentDirty=false; document.location.href='index.php?a=112&id=[+pluginid+]';"><img src="[+style.icons_cancel+]"> [+lang.cancel+] </a></li>
	</ul>
</div>
<form name="settings" action="[+moduleurl+]h=saveconfig" method="post">
	<input type="hidden" name="filemanager_path" value="[(filemanager_path)]">
	<input type="hidden" name="rb_base_dir" value="[(rb_base_dir)]">
	<input type="hidden" name="check_files_onlogin" value="[(check_files_onlogin)]">
	<div class="section">
		<div class="sectionHeader"> [+lang.settings_config+] </div>
		<div class="sectionBody">
			<div class="row" style="margin-bottom: 15px;">
				<div class="col-ss-12 col-xs-4 col-sm-3 col-md-2 col-lg-2">
					<span class="warning">Использовать табы</span><br><span class="comment">в представлении модуля</span>
				</div>
				<div class="col-ss-12 col-xs-8 col-sm-9 col-md-10 col-lg-10">
					<label class="select">
						<select name="gph_outputTabs" onchange="documentDirty=true;">
							<option value="1" [+view.gph_outputTabs_1+]>Да</option>
							<option value="0" [+view.gph_outputTabs_0+]>Нет</option>
						</select>
						<i></i>
					</label>
				</div>
			</div>
			<div class="row" style="margin-bottom: 15px;">
				<div class="col-ss-12 col-xs-4 col-sm-3 col-md-2 col-lg-2">
					<span class="warning">Редактор настроек</span><br><span class="comment">на фронт энде</span>
				</div>
				<div class="col-ss-12 col-xs-8 col-sm-9 col-md-10 col-lg-10">
					<label class="select">
						<select name="gph_fronteditor" onchange="documentDirty=true;">
							<option value="1" [+view.gph_fronteditor_1+]>Да</option>
							<option value="0" [+view.gph_fronteditor_0+]>Нет</option>
						</select>
						<i></i>
					</label>
				</div>
			</div>
			<div class="row" style="margin-bottom: 15px;">
				<div class="col-ss-12 col-xs-4 col-sm-3 col-md-2 col-lg-2">
					<span class="warning">Использовать настройки без плагина</span><br><span class="comment">Создавать настройку с префиксом g_ (по умолчанию) для использования без плагина gPHParser</span>
				</div>
				<div class="col-ss-12 col-xs-8 col-sm-9 col-md-10 col-lg-10">
					<label class="select">
						<select name="gph_useG" onchange="documentDirty=true;">
							<option value="1" [+view.gph_useG_1+]>Да</option>
							<option value="0" [+view.gph_useG_0+]>Нет</option>
						</select>
						<i></i>
					</label>
				</div>
			</div>
			<div class="row" style="margin-bottom: 15px;">
				<div class="col-ss-12 col-xs-4 col-sm-3 col-md-2 col-lg-2">
					<span class="warning">Префикс</span><br><span class="comment">для подмененных TV PH и CONFIG</span>
				</div>
				<div class="col-ss-12 col-xs-8 col-sm-9 col-md-10 col-lg-10">
					<label class="input">
						<input type="text" name="gph_prefix" onchange="documentDirty=true;" value="[+view.gph_prefix+]" />
					</label>
				</div>
			</div>
			<div class="row" style="margin-bottom: 15px;">
				<div class="col-ss-12 col-xs-4 col-sm-3 col-md-2 col-lg-2">
					<span class="warning">Префикс</span><br><span class="comment">для настройки без плагина (не используется если отключена работа без плагина)</span>
				</div>
				<div class="col-ss-12 col-xs-8 col-sm-9 col-md-10 col-lg-10">
					<label class="input">
						<input type="text" name="gph_globalprefix" onchange="documentDirty=true;" value="[+view.gph_globalprefix+]" />
					</label>
				</div>
			</div>
		</div>
	</div>
</form>