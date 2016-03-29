<label class="input append-big-btn">
	<input type="text" id="global_[+view.settingName+]" name="global_[+view.settingName+]"  class="imageField init" value="[+view.value+]" onchange="documentDirty=true;" />
	<div class="file-button ImageFieldButton">Выбрать<input type="button" value="Выбрать" onclick="BrowseServer('global_[+view.settingName+]')" style="position: absolute; top: 0px; right: 0px; margin-right: 0px;" /></div>
</label>
<div class="tvimage" onclick="BrowseServer('global_[+view.settingName+]')"><img id="global_[+view.settingName+]_image" src="/[+view.value+]" style="max-width: 300px; max-height: 300px; margin: 4px 0px; cursor: pointer;"></div>