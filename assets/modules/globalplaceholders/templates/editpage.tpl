<h1>[+lang.edit+]</h1>
<div id="actions">
	<ul class="actionButtons">
		<!--<li id="Button1"><a href="#" onclick="documentDirty=false; document.settings.submit();"> Сохранить </a></li>-->
		<li id="Button2"><a href="#" onclick="documentDirty=false; document.mutate.submit();"><img src="[+style.icons_add+]"> [+lang.save+] </a></li>
		<li id="Button5"><a href="#" onclick="if(confirm('Вы уверены?')==true) { documentDirty=false; document.location.href='[+moduleurl+]h=delete&settingid=global_[+view.setting_name+]'; }"><img src="[+style.icons_delete+]"> [+lang.delete+] </a></li>
		<li id="Button5"><a href="#" onclick="documentDirty=false; document.location.href='index.php?a=112&id=[+pluginid+]';"><img src="[+style.icons_cancel+]"> [+lang.cancel+] </a></li>
	</ul>
</div>
<form name="mutate" action="index.php?a=112&id=[+pluginid+]&h=save" method="post" id="EvoSettings">
	<input type="hidden" name="filemanager_path" value="[(filemanager_path)]">
	<input type="hidden" name="rb_base_dir" value="[(rb_base_dir)]">
	<input type="hidden" name="check_files_onlogin" value="[(check_files_onlogin)]">
	<input type="hidden" name="setting_oldname" value="global_[+view.setting_name+]">
	<div class="section">
		<div class="sectionHeader"> [+lang.edit+] [+view.setting_name+]</div>
		<div class="sectionBody">
			<div class="row" style="margin-bottom: 15px;">
				<div class="col-ss-12 col-xs-4 col-sm-3 col-md-2 col-lg-2">
					<span class="warning">Имя поля</span><br><span class="comment">Описание первого тестового параметра</span>
				</div>
				<div class="col-ss-12 col-xs-8 col-sm-9 col-md-10 col-lg-10">
					<label class="input">
						<input type="text" name="setting_name" onchange="documentDirty=true;" value="[+view.setting_name+]" />
					</label>
				</div>
			</div>
			<div class="row" style="margin-bottom: 15px;">
				<div class="col-ss-12 col-xs-4 col-sm-3 col-md-2 col-lg-2">
					<span class="warning">Описание поля</span><br><span class="comment">Описание первого тестового параметра</span>
				</div>
				<div class="col-ss-12 col-xs-8 col-sm-9 col-md-10 col-lg-10">
					<label class="input">
						<input type="text" name="settingDescription" onchange="documentDirty=true;" value="[+view.settingDescription+]" />
					</label>
				</div>
			</div>
			<div class="row" style="margin-bottom: 15px;">
				<div class="col-ss-12 col-xs-4 col-sm-3 col-md-2 col-lg-2">
					<span class="warning">Позиция в меню</span><br><span class="comment">Позиция в меню (начинается от 0, 0 наивысшая позиция)</span>
				</div>
				<div class="col-ss-12 col-xs-8 col-sm-9 col-md-10 col-lg-10">
					<label class="input">
						<input type="text" name="setting_order" onchange="documentDirty=true;" value="[+view.setting_order+]" />
					</label>
				</div>
			</div>
			<div class="row" style="margin-bottom: 15px;">
				<div class="col-ss-12 col-xs-4 col-sm-3 col-md-2 col-lg-2">
					<span class="warning">Тип поля</span><br><span class="comment">Описание первого тестового параметра</span>
				</div>
				<div class="col-ss-12 col-xs-8 col-sm-9 col-md-10 col-lg-10">
					<label class="select">
						<select name="type" onchange="documentDirty=true;">
							<option value="text" [+view.selectedtext+]>Text</option>
							<option value="textarea" [+view.selectedtextarea+]>Textarea</option>
							<option value="richtext" [+view.selectedrichtext+]>Richtext</option>
							<option value="checkbox" [+view.selectedcheckbox+]>Checkbox</option>
							<option value="select" [+view.selectedselect+]>Select</option>
							<option value="image" [+view.selectedimage+]>Image</option>
							<option value="file" [+view.selectedfile+]>File</option>
						</select>
						<i></i>
					</label>
				</div>
			</div>
			<div class="row" style="margin-bottom: 15px;">
				<div class="col-ss-12 col-xs-4 col-sm-3 col-md-2 col-lg-2">
					<span class="warning">Возможные значения</span><br><span class="comment">Описание первого тестового параметра</span>
				</div>
				<div class="col-ss-12 col-xs-8 col-sm-9 col-md-10 col-lg-10">
					<label class="textarea">
						<textarea rows="5" name="values" onchange="documentDirty=true;">[+view.values+]</textarea>
					</label>
				</div>
			</div>
			<div class="row" style="margin-bottom: 15px;">
				<div class="col-ss-12 col-xs-4 col-sm-3 col-md-2 col-lg-2">
					<span class="warning">Перезаписывать TV</span><br><span class="comment">Описание первого тестового параметра</span>
				</div>
				<div class="col-ss-12 col-xs-8 col-sm-9 col-md-10 col-lg-10">
					<label class="checkbox">
						<input type="checkbox" name="globalTV" onchange="documentDirty=true;" value="1" [+view.globalTVchecked+] />
						<i></i>
					</label>
				</div>
			</div>
			<div class="row" style="margin-bottom: 15px;">
				<div class="col-ss-12 col-xs-4 col-sm-3 col-md-2 col-lg-2">
					<span class="warning">Перезаписывать PH</span><br><span class="comment">Описание первого тестового параметра</span>
				</div>
				<div class="col-ss-12 col-xs-8 col-sm-9 col-md-10 col-lg-10">
					<label class="checkbox">
						<input type="checkbox" name="globalPH" onchange="documentDirty=true;" value="1" [+view.globalPHchecked+] />
						<i></i>
					</label>
				</div>
			</div>
			<div class="row" style="margin-bottom: 15px;">
				<div class="col-ss-12 col-xs-4 col-sm-3 col-md-2 col-lg-2">
					<span class="warning">Редактировать на фронтэнде</span><br><span class="comment">Если да то значение будет доступно к редактированию на сайте при условии что у вас установлен плагин gPH Front Editor</span>
				</div>
				<div class="col-ss-12 col-xs-8 col-sm-9 col-md-10 col-lg-10">
					<label class="checkbox">
						<input type="checkbox" name="frontEditor" onchange="documentDirty=true;" value="1" [+view.frontEditorchecked+]/>
						<i></i>
					</label>
				</div>
			</div>
			<div class="row" style="margin-bottom: 15px;">
				<div class="col-ss-12 col-xs-4 col-sm-3 col-md-2 col-lg-2">
					<span class="warning">Существующие категории</span><br><span class="comment">Описание первого тестового параметра</span>
				</div>
				<div class="col-ss-12 col-xs-8 col-sm-9 col-md-10 col-lg-10">
					<label class="select">
						<select name="group" onchange="documentDirty=true;">
							<option selected disabled value="Unmarked"></option>
							[+view.groups+]
						</select>
						<i></i>
					</label>
				</div>
			</div>
			<div class="row" style="margin-bottom: 15px;">
				<div class="col-ss-12 col-xs-4 col-sm-3 col-md-2 col-lg-2">
					<span class="warning">Новая категория</span><br><span class="comment">Описание первого тестового параметра</span>
				</div>
				<div class="col-ss-12 col-xs-8 col-sm-9 col-md-10 col-lg-10">
					<label class="input">
						<input type="text" name="newgroup" onchange="documentDirty=true;" />
					</label>
				</div>
			</div>
		</div>
	</div>
</form>