//<?php
/**
 * gPHFrontEditor
 * 
 * globalPlaceholders frontend content editor
 *
 * @category 	plugin
 * @version 	0.1
 * @license 	http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @author      WorkForFood
 * @internal	@properties 
 * @internal	@events OnWebPagePrerender,OnWebPageInit,OnWebPageComplete
 * @internal    @installset base
 * @internal    @legacy_names gPHFrontEditor
 * @internal    @disabled 1
 * @internal    @locked 1
 * @internal	@modx_category globalPlaсeholders
 */

$useG = $modx->getConfig("gph_useG");
$prefix = $modx->getConfig("gph_prefix");
$outputTabs = $modx->getConfig("gph_outputTabs");
$fronteditor = $modx->getConfig("gph_fronteditor");
$globalprefix = $modx->getConfig("gph_globalprefix");
$action = $_REQUEST['gphfe'] ? $_REQUEST['gphfe'] : "default";
$validated = isset($_SESSION['mgrValidated']) && $_SESSION['mgrValidated'] == 1 ? $_SESSION['mgrValidated'] : 0;
$e = $modx->Event;
$gphfe = new gPHfe($modx);
$gphfe->modx = &$modx;
$gphfe->useG = $useG;
$gphfe->table = $modx->getFullTableName("system_settings");
$gphfe->fronteditor = $fronteditor;
$gphfe->globalprefix = $globalprefix;

switch ($e->name) {
	case "OnWebPagePrerender":
		if($action == "savePH" && $validated == 1 && $fronteditor == 1) {
			$o = &$modx->documentOutput;
			$data = array();
			$data['name'] = $modx->db->escape($_REQUEST['name']);
			$data['value'] = $modx->db->escape($_REQUEST['value']);
			$data['setting'] = $modx->getConfig($data['name']);
			$o = $gphfe->saveSetting($data);
		}
		return;
	break;
	case "OnWebPageInit":
		if($action == "default" && $validated == 1 && $fronteditor == 1) {
			$gphfe->insertScripts();
			$gphfe->insertImageEditor();
		}
		return;
	break;
	case "OnWebPageComplete":
		if($validated == 1 && $fronteditor == 1) {
			$modx->clearCache();
		}
		return;
	break;
	default:
		return;
	break;
}


class gPHfe {
	public $modx = null;
	public $useG = false;
	public $table = null;
	public $fronteditor = null;
	public $globalprefix = null;
	function __construct ($modx) {
		$this->modx = $modx;
	}
	
	function insertImageEditor() {
		if($this->fronteditor == "1") {
			$settings = $this->modx->config;
			$imagesout = '<script type="text/javascript"> ';
			foreach($settings as $key=>$value) {
				if(stristr($key, 'global_')) {
					$val = json_decode($value,true);
					if($this->fronteditor == "1" && ($val['frontEditor'] === true || $val['frontEditor'] == "1")) {
						if($val['type'] == "image") {
							$imagesout .= 'addinsertImageEditor("'.$val['value'].'","'.$key.'"); ';
						}
						if($val['type'] == "file") {
							$imagesout .= 'addinsertFileEditor("'.$val['value'].'","'.$key.'"); ';
						}
					}
				}
			}
			$imagesout .= "addInputEventListner(); </script>";
			$this->modx->regClientHTMLBlock($imagesout);
		}
	}

	function insertScripts() {
		if($this->fronteditor == "1") {
			$replace_richtexteditor = array(".globalplaceholdereditor");
			$editor =  "";
			if (is_array($replace_richtexteditor) && sizeof($replace_richtexteditor) > 0) {
				// invoke OnRichTextEditorInit event
				$evtOut = $this->modx->invokeEvent('OnRichTextEditorInit', array(
					'editor' => $this->modx->getConfig("which_editor"),
					'elements' => $replace_richtexteditor
				));
				if (is_array($evtOut)) {
					$editor = implode('', $evtOut);
				}
			}
			if($this->modx->getConfig("which_editor") == "TinyMCE4") {
				$editor = str_replace("file: 'media/","file: '/manager/media/",$editor);
				$editor = str_replace("tinymce.init({","tinymce.init({ inline: true, setup: function (ed) { ed.on(\"blur\", function () { addinsertTextEditorContainerChange(ed); }) }, ",$editor);
				$editor = str_replace("textarea#","",$editor);
			}
			$jquery = "assets/js/jquery.min.js";
			$gphscripts = "assets/plugins/gph/js/gph.js";
			$gphstyle = '<link type="text/css" media="screen" rel="stylesheet" href="assets/plugins/gph/css/style.css" />';
			$preloader =  "<div class='fixed abs_full b_black_o7 none gphfepreloader' style='z-index: 65535;'></div>";
			$this->modx->regClientStartupScript($jquery);
			$this->modx->regClientStartupScript($gphscripts);
			$this->modx->regClientStartupHTMLBlock($gphstyle);
			$this->modx->regClientHTMLBlock($editor);
			$this->modx->regClientHTMLBlock($preloader);
		}
	}
	
	function saveSetting ($data) {
		$name = $data['name'];
		$value = $data['value'];
		if(!empty($name) && !empty($value)) {
			$settingval = $data['setting'];
			$settingval = json_decode($settingval,true);
			if($settingval['value'] == $value ) {
				return "ok";
				$this->modx->clearCache('full');
			} else {
				if(!empty($settingval)) {
					if($settingval['type'] == "richtext" || $settingval['type'] == "textarea" || $settingval['type'] == "input") {
						$settingval['value'] = addslashes(htmlspecialchars_decode(stripslashes($value)));
						$settingval['value'] = trim(str_replace(array("\r\n","\n", "\r"), '', $this->json_encode_wrapper($settingval['value'])));
						$settingval['value'] = is_array(json_decode(stripslashes($settingval['value']),true)) ? json_decode(stripslashes($settingval['value']),true) : $settingval['value'];
						$settingval = $this->json_encode_wrapper($settingval);
					} else {
						$settingval['value'] = is_array($settingval['value']) ? $settingval['value'] : $value;
						$settingval = stripslashes($this->json_encode_wrapper($settingval));
					}
					$result = true;
					$result = $this->modx->db->update(Array("setting_value"=>$settingval), $this->table, $this->table.".`setting_name` = '".$name."'");
					//add work without plugin
					if ($this->useG) {
						$result = $this->modx->db->update(Array("setting_value"=>$value), $this->table, $this->table.".`setting_name` = '".str_replace("global_", $this->globalprefix, $name)."'");
					}
					if($result) {
						$this->modx->clearCache('full');
						sleep(2);
						return "ok";
					}
				} else {
					return "error";
				}
			}
		} else {
			return "error";
		}
		$this->modx->clearCache('full');
	}
	
	function json_encode_wrapper ($array) {
		if(!is_array($array)) { return $array; }
		if (version_compare(phpversion(), '5.4.0', '<')) {
			return preg_replace_callback('/\\\u([0-9а-яА-Яa-fA-F]{4})/',create_function('$match', 'return mb_convert_encoding("&#" . intval($match[1], 16) . ";", "UTF-8", "HTML-ENTITIES");'),json_encode($array));
		} else {
			return json_encode($array, JSON_UNESCAPED_UNICODE);
		}
	}
	
}