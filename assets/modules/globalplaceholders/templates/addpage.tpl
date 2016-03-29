<h1>[+lang.add+]</h1>
<div id="actions">
	<ul class="actionButtons">
		<!--<li id="Button1"><a href="#" onclick="documentDirty=false; document.settings.submit();"> Сохранить </a></li>-->
		<li id="Button2"><a href="#" onclick="documentDirty=false; document.settings.submit();"><img src="[+style.icons_add+]"> [+lang.save+] </a></li>
		<li id="Button5"><a href="#" onclick="documentDirty=false; document.location.href='index.php?a=112&id=[+pluginid+]';"><img src="[+style.icons_cancel+]"> [+lang.cancel+] </a></li>
	</ul>
</div>
<form name="settings" action="[+moduleurl+]h=save" method="post">
	<input type="hidden" name="filemanager_path" value="[(filemanager_path)]">
	<input type="hidden" name="rb_base_dir" value="[(rb_base_dir)]">
	<input type="hidden" name="check_files_onlogin" value="[(check_files_onlogin)]">
	<div class="section">
		<div class="sectionHeader"> [+lang.add+] </div>
		<div class="sectionBody">
			<div class="row" style="margin-bottom: 15px;">
				<div class="col-ss-12 col-xs-4 col-sm-3 col-md-2 col-lg-2">
					<span class="warning">Имя поля</span><br><span class="comment">имя поля по которому он будет дступен</span>
				</div>
				<div class="col-ss-12 col-xs-8 col-sm-9 col-md-10 col-lg-10">
					<label class="input">
						<input type="text" required name="setting_name" onchange="documentDirty=true;" value="[+view.name+]" />
					</label>
				</div>
			</div>
			<div class="row" style="margin-bottom: 15px;">
				<div class="col-ss-12 col-xs-4 col-sm-3 col-md-2 col-lg-2">
					<span class="warning">Описание поля</span><br><span class="comment">описание поля</span>
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
						<input type="text" name="setting_order" onchange="documentDirty=true;" value="0" />
					</label>
				</div>
			</div>
			<div class="row" style="margin-bottom: 15px;">
				<div class="col-ss-12 col-xs-4 col-sm-3 col-md-2 col-lg-2">
					<span class="warning">Тип поля</span><br><span class="comment">визуальный компонент поля</span>
				</div>
				<div class="col-ss-12 col-xs-8 col-sm-9 col-md-10 col-lg-10">
					<label class="select">
						<select name="type" onchange="documentDirty=true;">
							<option value="text">Text</option>
							<option value="textarea">Textarea</option>
							<option value="richtext">Richtext</option>
							<option value="checkbox">Checkbox</option>
							<option value="select">Select</option>
							<option value="image">Image</option>
							<option value="file">File</option>
						</select>
						<i></i>
					</label>
				</div>
			</div>
			<div class="row" style="margin-bottom: 15px;">
				<div class="col-ss-12 col-xs-4 col-sm-3 col-md-2 col-lg-2">
					<span class="warning">Возможные значения</span><br><span class="comment">возможные значения для селекта и чекбоксов</span>
				</div>
				<div class="col-ss-12 col-xs-8 col-sm-9 col-md-10 col-lg-10">
					<label class="textarea">
						<textarea rows="5" name="values" onchange="documentDirty=true;"></textarea>
					</label>
				</div>
			</div>
			<div class="row" style="margin-bottom: 15px;">
				<div class="col-ss-12 col-xs-4 col-sm-3 col-md-2 col-lg-2">
					<span class="warning">Перезаписывать TV</span><br><span class="comment">Если да то значение будет доступно в [**]</span>
				</div>
				<div class="col-ss-12 col-xs-8 col-sm-9 col-md-10 col-lg-10">
					<label class="checkbox">
						<input type="checkbox" name="globalTV" onchange="documentDirty=true;" value="1" />
						<i></i>
					</label>
				</div>
			</div>
			<div class="row" style="margin-bottom: 15px;">
				<div class="col-ss-12 col-xs-4 col-sm-3 col-md-2 col-lg-2">
					<span class="warning">Перезаписывать PH</span><br><span class="comment">Если да то значение будет доступно в <span>[</span>++]</span>
				</div>
				<div class="col-ss-12 col-xs-8 col-sm-9 col-md-10 col-lg-10">
					<label class="checkbox">
						<input type="checkbox" name="globalPH" onchange="documentDirty=true;" value="1" />
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
						<input type="checkbox" name="frontEditor" onchange="documentDirty=true;" value="1" />
						<i></i>
					</label>
				</div>
			</div>
			<div class="row" style="margin-bottom: 15px;">
				<div class="col-ss-12 col-xs-4 col-sm-3 col-md-2 col-lg-2">
					<span class="warning">Существующие категории</span><br><span class="comment">выберите существующую категорию</span>
				</div>
				<div class="col-ss-12 col-xs-8 col-sm-9 col-md-10 col-lg-10">
					<label class="select">
						<select name="group" onchange="documentDirty=true;">
							<option selected disabled value="no_category">[+lang.no_category+]</option>
							[+view.groups+]
						</select>
						<i></i>
					</label>
				</div>
			</div>
			<div class="row" style="margin-bottom: 15px;">
				<div class="col-ss-12 col-xs-4 col-sm-3 col-md-2 col-lg-2">
					<span class="warning">Новая категория</span><br><span class="comment">имя новой категории</span>
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