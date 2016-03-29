<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<title>Пользовательские настройки сайта</title>
	<link rel="stylesheet" type="text/css" href="media/style/[+theme+]/style.css" />
	<link rel="stylesheet" type="text/css" href="/assets/modules/[+modulename+]/assets/styles/fontAwesome.css" />
	<link rel="stylesheet" type="text/css" href="/assets/modules/[+modulename+]/assets/styles/forms.css" />
	<link rel="stylesheet" type="text/css" href="/assets/modules/[+modulename+]/assets/styles/bootstrapGrid.css" />
	<style>
		input, textarea, .inp {width: 50%}
		.item {margin-bottom: 10px}
		table { font-size: 12px !important;}
		.row input, .row select {
			box-sizing: border-box;
			width: 100% !important;
			height: 38px !important;
			line-height: 20px !important;
		}
		.split {
			margin-top: 5px;
		}
		.sectionBody {
			padding: 15px !important;
		}
		.preLoaderText {
			left: 50%;
			top: 50%;
			box-sizing: border-box;
			margin-left: -200px;
			margin-top: -75px;
			position: relative;
		}
		#preLoader {
			padding: 0px;
			position: fixed;
			left: 0px;
			right: 0px;
			top: 0px;
			bottom: 0px;
		}
	</style>
	<script type="text/javascript" src="media/script/tabpane.js"></script>
	<script type="text/javascript" src="media/script/datefunctions.js"></script>
	<script type="text/javascript" src="media/script/mootools/mootools.js"></script>
	<script type="text/javascript" src="media/calendar/datepicker.js"></script>
	<script type="text/javascript" src="media/script/mootools/moodx.js"></script>
	<script type="text/javascript">

			var documentDirty=false;

			function checkDirt(evt) {
				if(documentDirty==true) {
					var message = "Изменения не были сохранены. Вы можете остаться на этой странице для того, чтобы сохранить изменения ('Отмена'), либо покинуть ее, утеряв все изменения ('OK').";
					if (typeof evt == 'undefined') {
						evt = window.event;
					}
					if (evt) {
						evt.returnValue = message;
					}
					return message;
				}
			}

			function showLoader(evt) {
				document.getElementById('preLoader').style.display = "block";
			}

			function hideLoader() {
				document.getElementById('preLoader').style.display = "none";
			}

			hideL = window.setTimeout("hideLoader()", 500);

			// add the 'unsaved changes' warning event handler
			if( window.addEventListener ) {
				window.addEventListener('beforeunload',checkDirt,false);
				window.addEventListener('beforeunload',showLoader,false);
			} else if ( window.attachEvent ) {
				window.attachEvent('onbeforeunload',checkDirt);
				window.attachEvent('onbeforeunload',showLoader);
			} else {
				window.onbeforeunload = checkDirt;
			}
			/* ]]> */
		/* <![CDATA[ */
			var lastImageCtrl;
			var lastFileCtrl;
			function OpenServerBrowser(url, width, height ) {
				var iLeft = (screen.width  - width) / 2 ;
				var iTop  = (screen.height - height) / 2 ;

				var sOptions = 'toolbar=no,status=no,resizable=yes,dependent=yes' ;
				sOptions += ',width=' + width ;
				sOptions += ',height=' + height ;
				sOptions += ',left=' + iLeft ;
				sOptions += ',top=' + iTop ;

				var oWindow = window.open( url, 'FCKBrowseWindow', sOptions ) ;
			}
			function BrowseServer(ctrl) {
				lastImageCtrl = ctrl;
				var w = screen.width * 0.5;
				var h = screen.height * 0.5;
				OpenServerBrowser('[+modx_manager_url+]media/browser/mcpuk/browser.php?Type=images', w, h);
			}
			function BrowseFileServer(ctrl) {
				lastFileCtrl = ctrl;
				var w = screen.width * 0.5;
				var h = screen.height * 0.5;
				OpenServerBrowser('[+modx_manager_url+]media/browser/mcpuk/browser.php?Type=files', w, h);
			}
			function SetUrlChange(el) {
				if ('createEvent' in document) {
					var evt = document.createEvent('HTMLEvents');
					evt.initEvent('change', false, true);
					el.dispatchEvent(evt);
				} else {
					el.fireEvent('onchange');
				}
			}
			function SetUrl(url, width, height, alt) {
				if(lastFileCtrl) {
					var c = document.getElementById(lastFileCtrl);
					if(c && c.value != url) {
						c.value = url;
						SetUrlChange(c);
					}
					lastFileCtrl = '';
				} else if(lastImageCtrl) {
					var c = document.getElementById(lastImageCtrl);
					var cc = document.getElementById(lastImageCtrl+"_image");
					console.log(cc);
					if(c && c.value != url) {
						c.value = url;
						if(cc) {
							cc.src = "/"+url;
						}
						SetUrlChange(c);
					}
					lastImageCtrl = '';
				} else {
					return;
				}
			}
		/* ]]> */
	</script>
</head>
<body>
<div id="preLoader"><div class="preLoaderText"><div class="loadertext">[+lang.loading_page+]</div><div class="loaderimg"></div></div></div>
[+view.content+]


[+view.richtext+]
</body>
</html>