//<?php
/**
 * gPHParser
 * 
 * globalPlaceholders config parser
 *
 * @category 	plugin
 * @version 	0.1
 * @license 	http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @author      WorkForFood
 * @internal	@properties 
 * @internal	@events OnParseDocument
 * @internal    @installset base
 * @internal    @legacy_names gPHParser
 * @internal    @disabled 1
 * @internal    @locked 1
 * @internal	@modx_category globalPlaсeholders
 */

$e = $modx->Event;
$useG = $modx->getConfig("gph_useG");
$prefix = $modx->getConfig("gph_prefix");
$outputTabs = $modx->getConfig("gph_outputTabs");
$fronteditor = $modx->getConfig("gph_fronteditor");
$globalprefix = $modx->getConfig("gph_globalprefix");
$validated = isset($_SESSION['mgrValidated']) && $_SESSION['mgrValidated'] == 1 ? $_SESSION['mgrValidated'] : 0;
$docid = &$modx->documentIdentifier;
$globalPlaceholders = false;
global $globalPlaceholders;

switch ($e->name) {		
	case "OnParseDocument":
		if(!$globalPlaceholders) {
			$globalPlaceholders = true;
			$settings = $modx->config;
			foreach($settings as $key=>$value) {
				if(stristr($key, 'global_')) {
					$val = json_decode($value,true);
					$newkey = str_replace("global_", "", $key);
					$newval = is_array($val['value']) ? json_encode($val['value']) : $val['value'];
					if($validated == 1 && $fronteditor == 1) {
						if ($val['frontEditor'] == 1) {
							if($val['type'] == "richtext") {
								$newval = "<div class='globalplaceholdereditor' id='".$key."' data-name='".$key."' data-value='".$newval."'>".$newval."</div>";
							} else 
							if($val['type'] == "text" || $val['type'] == "textarea") {
								$newval = "<div class='globalplaceholdereditortext' contenteditable='true' id='".$key."' data-name='".$key."' data-value='".$newval."'>".$newval."</div>";
							} else 
							if($val['type'] == "image" || $val['type'] == "file") {

							}
						}
					}
					$modx->config[$prefix.$newkey] = $newval;
					if($val['globalTV'] === true || $val['globalTV'] == "1") {
						$modx->documentObject[$prefix.$newkey][0] = $newkey;
						$modx->documentObject[$prefix.$newkey][1] = $newval;
					}
					if($val['globalPH'] === true || $val['globalPH'] == "1") {
						$modx->setPlaceholder($prefix.$newkey,$newval);
					}
				}
			}
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