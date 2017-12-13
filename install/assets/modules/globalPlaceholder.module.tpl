// <?php 
/**
 * globalPlaсeholders
 * 
 * project global settings module
 * 
 * @category	module
 * @version 	0.1
 * @license 	http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @author      WorkForFood
 * @internal	@properties	 
 * @internal	@guid 4b4a6e4c16ee4fdfb4e7a41c25662f48
 * @internal	@shareparams 1
 * @internal    @locked 1
 * @internal	@modx_category globalPlaсeholders
 */

$useG = $modx->getConfig("gph_useG");
$globalprefix = $modx->getConfig("gph_globalprefix");
$outputTabs = $modx->getConfig("gph_outputTabs");
$output = "";		
$table = $modx->getFullTableName("system_settings");
$userrole = $modx->getUserInfo($modx->getLoginUserID());
$userrole = $userrole['role'];
$modulename = "globalplaceholders";
$globalPHPath = MODX_BASE_PATH.'assets/modules/'.$modulename.'/';
$moduleurl = 'index.php?a=112&id='.$_GET['id'].'&';

include_once($globalPHPath."includes/class.renderer.inc.php");
$render = new Render($modx,$modulename);
$render->templatesDir = $globalPHPath."templates";
$render->setPlaceholders(Array('moduleurl' => $moduleurl, 'modulename' => $modulename, 'modulepath' => $globalPHPath, 'theme' => $modx->config['manager_theme'], 'modx_manager_url' => MODX_MANAGER_URL, 'pluginid' => $_REQUEST['id']));

function checkMainConfig ($modx,$table,$rewrite = false) {
	$config = array (
		"gph_installed"=>"1",
		"gph_outputTabs"=>"1",
		"gph_fronteditor"=>"0",
		"gph_useG"=>"0",
		"gph_prefix"=>"",
		"gph_globalprefix"=>"g_"
	);
	foreach ($config as $k=>$v) {
		$oldconfig = $modx->getConfig($k);
		if(!$oldconfig && !$rewrite) {
			$new = array();
			$new['setting_name'] = $k;
			$new['setting_value'] = $v;
			$result = $modx->db->insert($new,$table);
		} else 
		if(!empty($oldconfig) || $rewrite) {
			$result = $modx->db->update(Array("setting_value"=>$v), $table, $table.".`setting_name` = '".$k."'");
		}
	}
}

function renderSettingElement ($values,$render) {
	if($values['type'] == "text" || $values['type'] == "textarea") {
		$values['value'] = is_array($values['value']) ? json_encode_wrapper($values['value']) : $values['value'];
	}
	if($values['type'] == "checkbox") {
		if($values['value'] == "1") {
			$values['checked'] = "checked";
		} else {
			$values['checked'] = "";
		}
	}
	if($values['type'] == "select") {
		$selectValues = "";
		$svals = explode("||",$values['values']);
		foreach($svals as $kk=>$vv) {
			$svalspair = explode("==",$vv);
			$kkey = sizeof($svalspair) > 1 ? $svalspair[0] : $vv;
			$vval = sizeof($svalspair) > 1 ? $svalspair[1] : $vv;
			$selected = $values['value'] == $kkey ? "selected" : "";
			$render->setPlaceholders(array("optionValue"=>$kkey,"optionName"=>$vval,"optionSelected"=>$selected),"view.");
			$selectValues .= $render->render("optionElement",$render->ph);
		}
		$values['selectValues'] = $selectValues;
	}
	return $values;
}

function json_encode_wrapper ($array) {
	if(!is_array($array)) { return $array; }
	if (version_compare(phpversion(), '5.4.0', '<')) {
		return preg_replace_callback('/\\\u([0-9а-яА-Яa-fA-F]{4})/',create_function('$match', 'return mb_convert_encoding("&#" . intval($match[1], 16) . ";", "UTF-8", "HTML-ENTITIES");'),json_encode($array));
	} else {
		return json_encode($array, JSON_UNESCAPED_UNICODE);
	}
}

function compareOrder ($a,$b) {
	$a['setting_order'] = $a['setting_order'] ? $a['setting_order'] : 0;
	$b['setting_order'] = $b['setting_order'] ? $b['setting_order'] : 0;
	if ($a['setting_order'] == $b['setting_order']) {
		return 0;
	}
	return ($a['setting_order'] < $b['setting_order']) ? -1 : 1;
}

switch ($_REQUEST['h']) {
	default:
		if($modx->getConfig("gph_installed") != "1") {
			checkMainConfig($modx,$table);
			$modx->clearCache('full');
			sleep(2);
			header('Location: '.$moduleurl);
		}
		$settings = $modx->config;
		$globalSettings = Array();
		$groups = Array();
		$groupsSettings = Array();
		$outGroups = "";
		$outSettings = "";
		$replace_richtexteditor = array();
		foreach($settings as $key=>$value) {
			if(stristr($key, 'global_')) {
				if (is_object(json_decode($value))) //check if setting is JSON object?
				{ 
					$jsonval = json_decode($value,true);
					$jsonval['settingName'] = str_replace("global_", "", $key);
					$groups[$jsonval['group']] = Array("group"=>$jsonval['group'],"groupName"=>$jsonval['groupName']);
					$globalSettings[$key] = $jsonval;
					$groupsSettings[$jsonval['group']][$key] = $jsonval;
					
				}
			}
		}
		sort($groups);
		if(sizeof($globalSettings) == 0) {
			$output = $render->render("mainpage",$render->ph);
		} else {
			$outSettingsTemplate = $outputTabs == "1" ? "mainTabTabSettingsParent" : "mainTabSettingsParent";
			$settingsItemsTemplate = $outputTabs == "1" ? "mainTabTabSettingItem" : "mainTabSettingItem";
			$settingsItemsTemplate = $userrole == 1 ? $settingsItemsTemplate : $settingsItemsTemplate."User";
			foreach ($groups as $key=>$value) {
				$groupsItems = "";
				$settingsItems = "";
				usort($groupsSettings[$value['group']],"compareOrder");
				foreach($groupsSettings[$value['group']] as $k=>$v) {
					$v['settingSD'] = "";
					$v['value'] = $v['value'] ? $v['value'] : "";
					if($v['type'] == "richtext") { 
						array_push($replace_richtexteditor,"global_".$v['settingName']);
						$v['value'] = $modx->htmlspecialchars($v['value']);
					}
					if($v['type'] == "richtext" || $v['type'] == "textarea" || $v['type'] == "input") { 
						$v['value'] = stripslashes($v['value']);
						if($v['type'] == "textarea") {
							$v['value'] = str_replace("<br>","\r\n", $v['value']);
						}
					}
					$v['settingSD'] .= $v['globalTV'] === true || $v['globalTV'] == "1" ? "gTV " : "" ;
					$v['settingSD'] .= $v['globalPH'] === true || $v['globalPH'] == "1" ? "gPH " : "" ;
					$v['settingSD'] .= $v['frontEditor'] === true || $v['frontEditor'] == "1" ? "FrontEditor" : "" ;
					$v['settingSD'] = trim($v['settingSD']);
					$newValues = renderSettingElement($v,$render);
					$render->setPlaceholders($newValues,"view.");
					$settingsElement = $render->render("settingsElement".$v['type'],$render->ph);
					$render->setPlaceholder("view.settingInput",$settingsElement);
					$groupsItems .= $render->render("mainTabItemItem",$render->ph);
					$settingsItems .= $render->render($settingsItemsTemplate,$render->ph);
				}
				$outGroups .= $render->render("mainTabItemParent",Array('view.group'=>$value['group'],'view.groupName'=>$value['groupName'], 'view.groupItems'=>$groupsItems ));
				$outSettings .= $render->render($outSettingsTemplate,Array('view.group'=>$value['group'],'view.groupName'=>$value['groupName'], 'view.groupItems'=>$settingsItems ));
			}
			
			if (is_array($replace_richtexteditor) && sizeof($replace_richtexteditor) > 0) {
				// invoke OnRichTextEditorInit event
				$evtOut = $modx->invokeEvent('OnRichTextEditorInit', array(
					'editor' => $modx->getConfig("which_editor"),
					'elements' => $replace_richtexteditor
				));
				if (is_array($evtOut)) {
					$render->setPlaceholder("view.richtext",implode('', $evtOut));
				}
			}
			
			$tab = (is_numeric($_GET['tab'])) ? '<script type="text/javascript"> Us.setSelectedIndex( '.$_GET['tab'].' );</script>' : '';
			$render->setPlaceholders(Array('tab' => $tab, 'tabGroups' => $outGroups, 'tabSettings' => $outSettings ));
			$templatename = $userrole == 1 ? "mainpage" : "mainpageUser";
			if($outputTabs == "1") {
				$templatename .= "Tabs";
			}
			$output = $render->render($templatename,$render->ph);
			$output = $modx->mergeSettingsContent($output);
		}
	break;
	case "config":
		$settings = $modx->config;
		foreach($settings as $key=>$value) {
			if(stristr($key, 'gph_')) {
				if($key != "gph_prefix" && $key != "gph_globalprefix") {
					$render->setPlaceholder("view.".$key."_".$value,"selected");
				} else {
					$render->setPlaceholder("view.".$key,$value);
				}
			}
		}
		$output = $render->render("config",$render->ph);
		$output = $modx->mergeSettingsContent($output);
	break;
	case "saveconfig":
		foreach($_POST as $key=>$value) {
			if(stristr($key, 'gph_')) {
				$result = $modx->db->update(Array("setting_value"=>$value), $table, $table.".`setting_name` = '".$key."'");
			}
		}
		$modx->clearCache('full');
		sleep(2);
		header('Location: '.$moduleurl."h=config");
	break;
	case "resetconfig":
		checkMainConfig($modx,$table,true);
		$modx->clearCache('full');
		sleep(2);
		header('Location: '.$moduleurl."h=config");
	break;
	case "add":
		$settings = $modx->config;
		$groups = Array();
		$groupOut = "";
		foreach($settings as $key=>$value) {
			if(stristr($key, 'global_')) {
				$jsonval = json_decode($value,true);
				if(!$groups[$jsonval['group']]) {
					$render->setPlaceholders(array("optionValue"=>$jsonval['group'],"optionName"=>$jsonval['groupName']),"view.");
					$groupOut .= $render->render("optionElement",$render->ph);
					$groups[$jsonval['group']] = Array("group"=>$jsonval['group'],"groupName"=>$jsonval['groupName']);
				}
			}
		}
		sort($groups);
		$render->setPlaceholder("view.groups",$groupOut);
		$output = $render->render("addpage",$render->ph);
		$output = $modx->mergeSettingsContent($output);
	break;
	case "edit":
		$settings = $modx->config;
		$settingName = $_REQUEST['settingid'];
		$data = json_decode($modx->getConfig($settingName),true);
		$groupOut = "";
		$groups = Array();
		foreach($settings as $key=>$value) {
			if(stristr($key, 'global_')) {
				$jsonval = json_decode($value,true);
				if(!$groups[$jsonval['group']]) {
					$selected = $data['group'] == $jsonval['group'] ? "selected" : "";
					$render->setPlaceholders(array("optionValue"=>$jsonval['group'],"optionName"=>$jsonval['groupName'],"optionSelected"=>$selected),"view.");
					$groupOut .= $render->render("optionElement",$render->ph);
					$groups[$jsonval['group']] = Array("group"=>$jsonval['group'],"groupName"=>$jsonval['groupName']);
				}
			}
		}
		sort($groups);
		$data['groups'] = $groupOut;
		$data['setting_name'] = str_replace("global_", "", $settingName);
		$data['selected'.$data['type']] = "selected";
		if($data['globalTV'] === true || $data['globalTV'] == "1") { $data['globalTVchecked'] = "checked"; } 
		if($data['globalPH'] === true || $data['globalPH'] == "1") { $data['globalPHchecked'] = "checked"; } 
		if($data['frontEditor'] === true || $data['frontEditor'] == "1") { $data['frontEditorchecked'] = "checked"; }
		$render->setPlaceholders($data,"view.");
		$output = $render->render("editpage",$render->ph);
		$output = $modx->mergeSettingsContent($output);
	break;
	case "save":
		$settings = $modx->config;
		if(empty($_POST['setting_name'])) { header('Location: '.$_SERVER['HTTP_REFERER']); break; }
		$old = json_decode($modx->getConfig($_POST['setting_oldname']),true);
		$new = array();
		$groups = Array();
		foreach($settings as $key=>$value) {
			if(stristr($key, 'global_')) {
				$jsonval = json_decode($value,true);
				if(!$groups[$jsonval['group']]) {
					$groups[$jsonval['group']] = Array("group"=>$jsonval['group'],"groupName"=>$jsonval['groupName']);
				}
			}
		}
		if($_POST['newgroup'] == "" && ($_POST['group'] == "no_category" || !isset($_POST['group']) )) { $_POST['newgroup'] = $render->lang['no_category']; }
		if(!isset($_POST['globalTV'])) { $_POST['globalTV'] = 0; }
		if(!isset($_POST['globalPH'])) { $_POST['globalPH'] = 0; }
		if(!isset($_POST['frontEditor'])) { $_POST['frontEditor'] = 0; }
		if(!empty($_POST['setting_name'])) { $_POST['setting_name'] = $render->translateString($_POST['setting_name']); }
		if(!isset($_POST['setting_oldname'])) {
			$duplicate = json_decode($modx->getConfig("global_".$_POST['setting_name']),true);
			if(is_array($duplicate)) {
				$_POST['setting_name'] = "duplicate_".$_POST['setting_name'];
			}
			$new['setting_name'] = "global_".$_POST['setting_name'];
			$new['setting_value'] = array(
				"type"=>$_POST['type'],
				"frontEditor" => $_POST['frontEditor'],
				"values"=>$_POST['values'],
				"globalTV"=>$_POST['globalTV'],
				"globalPH"=>$_POST['globalTV'],
				"settingDescription"=>$_POST['settingDescription'],
				"setting_order"=>$_POST['setting_order']
			);
			if(!empty($_POST['newgroup']) && $_POST['newgroup'] != "") {
				$new['setting_value']['group'] = $render->translateString($_POST['newgroup']);
				$new['setting_value']['groupName'] = $_POST['newgroup'];
			} else {
				$new['setting_value']['group'] = $groups[$_POST['group']]['group'];
				$new['setting_value']['groupName'] = $groups[$_POST['group']]['groupName'];
			}
			$new['setting_value'] = json_encode_wrapper($new['setting_value']);
			$result = $modx->db->insert($new,$table);
			//add work without plugin
			if ($useG == "1") {
				$result = $modx->db->insert(array('setting_name'=>str_replace("global_", $globalprefix, $new['setting_name']) ),$table);
			}
			$modx->clearCache('full');
			sleep(2);
			header('Location: '.$moduleurl);
		} else {
			$duplicate = json_decode($modx->getConfig("global_".$_POST['setting_name']),true);
			if(is_array($duplicate) && $_POST['setting_oldname'] != "global_".$_POST['setting_name']) {
				$_POST['setting_name'] = "duplicate_".$_POST['setting_name'];
			}
			if(!isset($old['values'])) {
				$old['values'] = $_POST['values'];
			}
			$old['value'] = addslashes(stripslashes($old['value']));
			foreach ($old as $key=>$value) {
				if($_POST[$key] !== $value && isset($_POST[$key]) && $_POST[$key] != "") {
					$old[$key] = $_POST[$key];
				}
			}
			if(!empty($_POST['newgroup'])) {
				$old['group'] = $render->translateString($_POST['newgroup']);
				$old['groupName'] = $_POST['newgroup'];
			} else {
				$old['group'] = $groups[$_POST['group']]['group'];
				$old['groupName'] = $groups[$_POST['group']]['groupName'];
			}
			
			$old['frontEditor'] = $_POST['frontEditor'];
			$old['setting_order'] = $_POST['setting_order'];
			$old['globalTV'] = $_POST['globalTV'];
			$old['globalPH'] = $_POST['globalPH'];
			$old = json_encode_wrapper($old);
			$updata = array();
			$updata['setting_value'] = $old;
			$result = $modx->db->update($updata, $table, $table.".`setting_name` = '".$_POST['setting_oldname']."'");
			if($_POST['setting_oldname'] != "global_".$_POST['setting_name']) {
				$updata = array();
				$updata['setting_name'] = "global_".$_POST['setting_name'];
				$modx->db->query("UPDATE  ".$table." SET  `setting_name` =  'global_".$_POST['setting_name']."' WHERE  ".$table.".`setting_name` =  '".$_POST['setting_oldname']."'");
				//add work without plugin
				if ($useG == "1") {
					$modx->db->query("UPDATE  ".$table." SET  `setting_name` =  'g_".$_POST['setting_name']."' WHERE  ".$table.".`setting_name` =  '".str_replace("global_", $globalprefix, $_POST['setting_oldname'])."'");
				}
			}
			if($result) {
				$modx->clearCache('full');
				sleep(2);
				header('Location: '.$moduleurl);
			} else {
				echo "shit";
			}
		}
	break;
	case "delete":
		$settingName = $_REQUEST['settingid'];
		$old = json_decode($modx->getConfig($settingName),true);
		$result = $modx->db->delete($table, "`setting_name` = '".$settingName."'");
		//add work without plugin
		if ($useG == "1") {
			$result = $modx->db->delete($table, "`setting_name` = '".str_replace("global_", $globalprefix, $settingName)."'");
		}
		if($result) {
			$modx->clearCache('full');
			sleep(2);
			header('Location: '.$moduleurl);
		}
	break;
	case "saveSettings":
		$settings = $modx->config;		
		foreach($settings as $key=>$value) {
			if(stristr($key, 'global_')) {
				$jsonval = json_decode($value,true);
				$origval = is_array($jsonval['value']) ? json_encode_wrapper($jsonval['value']) : $jsonval['value'];
				if(!isset($_POST[$key])) { $_POST[$key] = 0; }
				if($origval != $_POST[$key]) {
					$jsonval['value'] = json_decode($_POST[$key],true);
					if($jsonval['type'] == "richtext" || $jsonval['type'] == "textarea" || $jsonval['type'] == "input") {
						$rn = $jsonval['type'] == "textarea" || $jsonval['type'] == "input" ? "<br>" : "";
						$jsonval['value'] = addslashes(stripslashes($_POST[$key]));
						$jsonval['value'] = trim(str_replace(array("\r\n","\n", "\r"), $rn, json_encode_wrapper($jsonval['value'])));
						$jsonval['value'] = is_array(json_decode(stripslashes($jsonval['value']),true)) ? json_decode(stripslashes($jsonval['value']),true) : $jsonval['value'];
					} else {
						$jsonval['value'] = is_array($jsonval['value']) ? $jsonval['value'] : $_POST[$key];
					}
					$value = json_encode_wrapper($jsonval);
					$result = $modx->db->update(Array("setting_value"=>$value), $table, $table.".`setting_name` = '".$key."'");
					//add work without plugin
					if ($useG == "1") {
						$isset = $modx->db->getValue( $modx->db->select( 'count(*)', $table, "setting_name='".str_replace("global_", $globalprefix, $key)."'") );
						if($isset){
							$result = $modx->db->update(Array("setting_value"=>$jsonval['value']), $table, $table.".`setting_name` = '".str_replace("global_", $globalprefix, $key)."'");
						} else {
							$result = $modx->db->insert(array('setting_name'=>str_replace("global_", $globalprefix, $key), "setting_value"=>$jsonval['value'] ),$table);   
						}
					}
				}
			}
		}
			
		$modx->clearCache('full');
		sleep(2);
		header('Location: '.$moduleurl);
	break;
}
$render->setPlaceholder("view.content",$output);
$output = $render->render("main",$render->ph);
$output = $modx->mergeSettingsContent($output);
echo $output;
