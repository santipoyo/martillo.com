<?php
session_start(); // Initialize Session data
ob_start(); // Turn on output buffering
?>
<?php include_once "ewcfg8.jsp" ?>
<?php include_once "ewmysql8.jsp" ?>
<?php include_once "phpfn8.jsp" ?>
<?php include_once "sec_usuariosinfo.jsp" ?>
<?php include_once "userfn8.jsp" ?>
<?php ew_Header(FALSE) ?>
<?php

// Create page object
$sec_usuarios_view = new csec_usuarios_view();
$Page =& $sec_usuarios_view;

// Page init
$sec_usuarios_view->Page_Init();

// Page main
$sec_usuarios_view->Page_Main();
?>
<?php include_once "header.jsp" ?>
<?php if ($sec_usuarios->Export == "") { ?>
<script type="text/javascript">
<!--

// Create page object
var sec_usuarios_view = new ew_Page("sec_usuarios_view");

// page properties
sec_usuarios_view.PageID = "view"; // page ID
sec_usuarios_view.FormID = "fsec_usuariosview"; // form ID
var EW_PAGE_ID = sec_usuarios_view.PageID; // for backward compatibility

// extend page with Form_CustomValidate function
sec_usuarios_view.Form_CustomValidate =  
 function(fobj) { // DO NOT CHANGE THIS LINE!

 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
<?php if (EW_CLIENT_VALIDATE) { ?>
sec_usuarios_view.ValidateRequired = true; // uses JavaScript validation
<?php } else { ?>
sec_usuarios_view.ValidateRequired = false; // no JavaScript validation
<?php } ?>

//-->
</script>
<script language="JavaScript" type="text/javascript">
<!--

// Write your client script here, no need to add script tags.
//-->

</script>
<?php } ?>
<?php $sec_usuarios_view->ShowPageHeader(); ?>
<p class="phpmaker ewTitle"><?php echo $Language->Phrase("View") ?>&nbsp;<?php echo $Language->Phrase("TblTypeTABLE") ?><?php echo $sec_usuarios->TableCaption() ?>
&nbsp;&nbsp;<?php $sec_usuarios_view->ExportOptions->Render("body"); ?>
</p>
<?php if ($sec_usuarios->Export == "") { ?>
<p class="phpmaker">
<a href="<?php echo $sec_usuarios_view->ListUrl ?>"><?php echo $Language->Phrase("BackToList") ?></a>&nbsp;
<a href="<?php echo $sec_usuarios_view->AddUrl ?>"><?php echo $Language->Phrase("ViewPageAddLink") ?></a>&nbsp;
<a href="<?php echo $sec_usuarios_view->EditUrl ?>"><?php echo $Language->Phrase("ViewPageEditLink") ?></a>&nbsp;
<a href="<?php echo $sec_usuarios_view->CopyUrl ?>"><?php echo $Language->Phrase("ViewPageCopyLink") ?></a>&nbsp;
<a href="<?php echo $sec_usuarios_view->DeleteUrl ?>"><?php echo $Language->Phrase("ViewPageDeleteLink") ?></a>&nbsp;
<?php } ?>
</p>
<?php
$sec_usuarios_view->ShowMessage();
?>
<p>
<table cellspacing="0" class="ewGrid"><tr><td class="ewGridContent">
<div class="ewGridMiddlePanel">
<table cellspacing="0" class="ewTable">
<?php if ($sec_usuarios->ID_USUARIO->Visible) { // ID_USUARIO ?>
	<tr id="r_ID_USUARIO"<?php echo $sec_usuarios->RowAttributes() ?>>
		<td class="ewTableHeader"><?php echo $sec_usuarios->ID_USUARIO->FldCaption() ?></td>
		<td<?php echo $sec_usuarios->ID_USUARIO->CellAttributes() ?>>
<div<?php echo $sec_usuarios->ID_USUARIO->ViewAttributes() ?>><?php echo $sec_usuarios->ID_USUARIO->ViewValue ?></div></td>
	</tr>
<?php } ?>
<?php if ($sec_usuarios->DES_USUARIO->Visible) { // DES_USUARIO ?>
	<tr id="r_DES_USUARIO"<?php echo $sec_usuarios->RowAttributes() ?>>
		<td class="ewTableHeader"><?php echo $sec_usuarios->DES_USUARIO->FldCaption() ?></td>
		<td<?php echo $sec_usuarios->DES_USUARIO->CellAttributes() ?>>
<div<?php echo $sec_usuarios->DES_USUARIO->ViewAttributes() ?>><?php echo $sec_usuarios->DES_USUARIO->ViewValue ?></div></td>
	</tr>
<?php } ?>
</table>
</div>
</td></tr></table>
<p>
<?php
$sec_usuarios_view->ShowPageFooter();
if (EW_DEBUG_ENABLED)
	echo ew_DebugMsg();
?>
<?php if ($sec_usuarios->Export == "") { ?>
<script language="JavaScript" type="text/javascript">
<!--

// Write your table-specific startup script here
// document.write("page loaded");
//-->

</script>
<?php } ?>
<?php include_once "footer.jsp" ?>
<?php
$sec_usuarios_view->Page_Terminate();
?>
<?php

//
// Page class
//
class csec_usuarios_view {

	// Page ID
	var $PageID = 'view';

	// Table name
	var $TableName = 'sec_usuarios';

	// Page object name
	var $PageObjName = 'sec_usuarios_view';

	// Page name
	function PageName() {
		return ew_CurrentPage();
	}

	// Page URL
	function PageUrl() {
		$PageUrl = ew_CurrentPage() . "?";
		global $sec_usuarios;
		if ($sec_usuarios->UseTokenInUrl) $PageUrl .= "t=" . $sec_usuarios->TableVar . "&"; // Add page token
		return $PageUrl;
	}

	// Page URLs
	var $AddUrl;
	var $EditUrl;
	var $CopyUrl;
	var $DeleteUrl;
	var $ViewUrl;
	var $ListUrl;

	// Export URLs
	var $ExportPrintUrl;
	var $ExportHtmlUrl;
	var $ExportExcelUrl;
	var $ExportWordUrl;
	var $ExportXmlUrl;
	var $ExportCsvUrl;
	var $ExportPdfUrl;

	// Update URLs
	var $InlineAddUrl;
	var $InlineCopyUrl;
	var $InlineEditUrl;
	var $GridAddUrl;
	var $GridEditUrl;
	var $MultiDeleteUrl;
	var $MultiUpdateUrl;

	// Message
	function getMessage() {
		return @$_SESSION[EW_SESSION_MESSAGE];
	}

	function setMessage($v) {
		ew_AddMessage($_SESSION[EW_SESSION_MESSAGE], $v);
	}

	function getFailureMessage() {
		return @$_SESSION[EW_SESSION_FAILURE_MESSAGE];
	}

	function setFailureMessage($v) {
		ew_AddMessage($_SESSION[EW_SESSION_FAILURE_MESSAGE], $v);
	}

	function getSuccessMessage() {
		return @$_SESSION[EW_SESSION_SUCCESS_MESSAGE];
	}

	function setSuccessMessage($v) {
		ew_AddMessage($_SESSION[EW_SESSION_SUCCESS_MESSAGE], $v);
	}

	// Show message
	function ShowMessage() {
		$sMessage = $this->getMessage();
		$this->Message_Showing($sMessage, "");
		if ($sMessage <> "") { // Message in Session, display
			echo "<p class=\"ewMessage\">" . $sMessage . "</p>";
			$_SESSION[EW_SESSION_MESSAGE] = ""; // Clear message in Session
		}

		// Success message
		$sSuccessMessage = $this->getSuccessMessage();
		$this->Message_Showing($sSuccessMessage, "success");
		if ($sSuccessMessage <> "") { // Message in Session, display
			echo "<p class=\"ewSuccessMessage\">" . $sSuccessMessage . "</p>";
			$_SESSION[EW_SESSION_SUCCESS_MESSAGE] = ""; // Clear message in Session
		}

		// Failure message
		$sErrorMessage = $this->getFailureMessage();
		$this->Message_Showing($sErrorMessage, "failure");
		if ($sErrorMessage <> "") { // Message in Session, display
			echo "<p class=\"ewErrorMessage\">" . $sErrorMessage . "</p>";
			$_SESSION[EW_SESSION_FAILURE_MESSAGE] = ""; // Clear message in Session
		}
	}
	var $PageHeader;
	var $PageFooter;

	// Show Page Header
	function ShowPageHeader() {
		$sHeader = $this->PageHeader;
		$this->Page_DataRendering($sHeader);
		if ($sHeader <> "") { // Header exists, display
			echo "<p class=\"phpmaker\">" . $sHeader . "</p>";
		}
	}

	// Show Page Footer
	function ShowPageFooter() {
		$sFooter = $this->PageFooter;
		$this->Page_DataRendered($sFooter);
		if ($sFooter <> "") { // Fotoer exists, display
			echo "<p class=\"phpmaker\">" . $sFooter . "</p>";
		}
	}

	// Validate page request
	function IsPageRequest() {
		global $objForm, $sec_usuarios;
		if ($sec_usuarios->UseTokenInUrl) {
			if ($objForm)
				return ($sec_usuarios->TableVar == $objForm->GetValue("t"));
			if (@$_GET["t"] <> "")
				return ($sec_usuarios->TableVar == $_GET["t"]);
		} else {
			return TRUE;
		}
	}

	//
	// Page class constructor
	//
	function csec_usuarios_view() {
		global $conn, $Language;

		// Language object
		if (!isset($Language)) $Language = new cLanguage();

		// Table object (sec_usuarios)
		if (!isset($GLOBALS["sec_usuarios"])) {
			$GLOBALS["sec_usuarios"] = new csec_usuarios();
			$GLOBALS["Table"] =& $GLOBALS["sec_usuarios"];
		}
		$KeyUrl = "";
		if (@$_GET["ID_USUARIO"] <> "") {
			$this->RecKey["ID_USUARIO"] = $_GET["ID_USUARIO"];
			$KeyUrl .= "&ID_USUARIO=" . urlencode($this->RecKey["ID_USUARIO"]);
		}
		$this->ExportPrintUrl = $this->PageUrl() . "export=print" . $KeyUrl;
		$this->ExportHtmlUrl = $this->PageUrl() . "export=html" . $KeyUrl;
		$this->ExportExcelUrl = $this->PageUrl() . "export=excel" . $KeyUrl;
		$this->ExportWordUrl = $this->PageUrl() . "export=word" . $KeyUrl;
		$this->ExportXmlUrl = $this->PageUrl() . "export=xml" . $KeyUrl;
		$this->ExportCsvUrl = $this->PageUrl() . "export=csv" . $KeyUrl;
		$this->ExportPdfUrl = $this->PageUrl() . "export=pdf" . $KeyUrl;

		// Page ID
		if (!defined("EW_PAGE_ID"))
			define("EW_PAGE_ID", 'view', TRUE);

		// Table name (for backward compatibility)
		if (!defined("EW_TABLE_NAME"))
			define("EW_TABLE_NAME", 'sec_usuarios', TRUE);

		// Start timer
		if (!isset($GLOBALS["gTimer"])) $GLOBALS["gTimer"] = new cTimer();

		// Open connection
		if (!isset($conn)) $conn = ew_Connect();

		// Export options
		$this->ExportOptions = new cListOptions();
		$this->ExportOptions->Tag = "span";
		$this->ExportOptions->Separator = "&nbsp;&nbsp;";
	}

	// 
	//  Page_Init
	//
	function Page_Init() {
		global $gsExport, $gsExportFile, $UserProfile, $Language, $Security, $objForm;
		global $sec_usuarios;

		// Global Page Loading event (in userfn*.php)
		Page_Loading();

		// Page Load event
		$this->Page_Load();
	}

	//
	// Page_Terminate
	//
	function Page_Terminate($url = "") {
		global $conn;

		// Page Unload event
		$this->Page_Unload();

		// Global Page Unloaded event (in userfn*.php)
		Page_Unloaded();

		 // Close connection
		$conn->Close();

		// Go to URL if specified
		$this->Page_Redirecting($url);
		if ($url <> "") {
			if (!EW_DEBUG_ENABLED && ob_get_length())
				ob_end_clean();
			header("Location: " . $url);
		}
		exit();
	}
	var $ExportOptions; // Export options
	var $DisplayRecs = 1;
	var $StartRec;
	var $StopRec;
	var $TotalRecs = 0;
	var $RecRange = 10;
	var $RecCnt;
	var $RecKey = array();
	var $Recordset;

	//
	// Page main
	//
	function Page_Main() {
		global $Language, $sec_usuarios;
		$sReturnUrl = "";
		$bMatchRecord = FALSE;
		if ($this->IsPageRequest()) { // Validate request
			if (@$_GET["ID_USUARIO"] <> "") {
				$sec_usuarios->ID_USUARIO->setQueryStringValue($_GET["ID_USUARIO"]);
				$this->RecKey["ID_USUARIO"] = $sec_usuarios->ID_USUARIO->QueryStringValue;
			} else {
				$sReturnUrl = "sec_usuarioslist.jsp"; // Return to list
			}

			// Get action
			$sec_usuarios->CurrentAction = "I"; // Display form
			switch ($sec_usuarios->CurrentAction) {
				case "I": // Get a record to display
					if (!$this->LoadRow()) { // Load record based on key
						if ($this->getSuccessMessage() == "" && $this->getFailureMessage() == "")
							$this->setFailureMessage($Language->Phrase("NoRecord")); // Set no record message
						$sReturnUrl = "sec_usuarioslist.jsp"; // No matching record, return to list
					}
			}
		} else {
			$sReturnUrl = "sec_usuarioslist.jsp"; // Not page request, return to list
		}
		if ($sReturnUrl <> "")
			$this->Page_Terminate($sReturnUrl);

		// Render row
		$sec_usuarios->RowType = EW_ROWTYPE_VIEW;
		$sec_usuarios->ResetAttrs();
		$this->RenderRow();
	}

	// Set up starting record parameters
	function SetUpStartRec() {
		global $sec_usuarios;
		if ($this->DisplayRecs == 0)
			return;
		if ($this->IsPageRequest()) { // Validate request
			if (@$_GET[EW_TABLE_START_REC] <> "") { // Check for "start" parameter
				$this->StartRec = $_GET[EW_TABLE_START_REC];
				$sec_usuarios->setStartRecordNumber($this->StartRec);
			} elseif (@$_GET[EW_TABLE_PAGE_NO] <> "") {
				$PageNo = $_GET[EW_TABLE_PAGE_NO];
				if (is_numeric($PageNo)) {
					$this->StartRec = ($PageNo-1)*$this->DisplayRecs+1;
					if ($this->StartRec <= 0) {
						$this->StartRec = 1;
					} elseif ($this->StartRec >= intval(($this->TotalRecs-1)/$this->DisplayRecs)*$this->DisplayRecs+1) {
						$this->StartRec = intval(($this->TotalRecs-1)/$this->DisplayRecs)*$this->DisplayRecs+1;
					}
					$sec_usuarios->setStartRecordNumber($this->StartRec);
				}
			}
		}
		$this->StartRec = $sec_usuarios->getStartRecordNumber();

		// Check if correct start record counter
		if (!is_numeric($this->StartRec) || $this->StartRec == "") { // Avoid invalid start record counter
			$this->StartRec = 1; // Reset start record counter
			$sec_usuarios->setStartRecordNumber($this->StartRec);
		} elseif (intval($this->StartRec) > intval($this->TotalRecs)) { // Avoid starting record > total records
			$this->StartRec = intval(($this->TotalRecs-1)/$this->DisplayRecs)*$this->DisplayRecs+1; // Point to last page first record
			$sec_usuarios->setStartRecordNumber($this->StartRec);
		} elseif (($this->StartRec-1) % $this->DisplayRecs <> 0) {
			$this->StartRec = intval(($this->StartRec-1)/$this->DisplayRecs)*$this->DisplayRecs+1; // Point to page boundary
			$sec_usuarios->setStartRecordNumber($this->StartRec);
		}
	}

	// Load row based on key values
	function LoadRow() {
		global $conn, $Security, $sec_usuarios;
		$sFilter = $sec_usuarios->KeyFilter();

		// Call Row Selecting event
		$sec_usuarios->Row_Selecting($sFilter);

		// Load SQL based on filter
		$sec_usuarios->CurrentFilter = $sFilter;
		$sSql = $sec_usuarios->SQL();
		$res = FALSE;
		$rs = ew_LoadRecordset($sSql);
		if ($rs && !$rs->EOF) {
			$res = TRUE;
			$this->LoadRowValues($rs); // Load row values

			// Call Row Selected event
			$row = $rs->fields;
			$sec_usuarios->Row_Selected($row);
			$rs->Close();
		}
		return $res;
	}

	// Load row values from recordset
	function LoadRowValues(&$rs) {
		global $conn, $sec_usuarios;
		if (!$rs || $rs->EOF) return;
		$sec_usuarios->ID_USUARIO->setDbValue($rs->fields('ID_USUARIO'));
		$sec_usuarios->DES_USUARIO->setDbValue($rs->fields('DES_USUARIO'));
	}

	// Render row values based on field settings
	function RenderRow() {
		global $conn, $Security, $Language, $sec_usuarios;

		// Initialize URLs
		$this->AddUrl = $sec_usuarios->AddUrl();
		$this->EditUrl = $sec_usuarios->EditUrl();
		$this->CopyUrl = $sec_usuarios->CopyUrl();
		$this->DeleteUrl = $sec_usuarios->DeleteUrl();
		$this->ListUrl = $sec_usuarios->ListUrl();

		// Call Row_Rendering event
		$sec_usuarios->Row_Rendering();

		// Common render codes for all row types
		// ID_USUARIO
		// DES_USUARIO

		if ($sec_usuarios->RowType == EW_ROWTYPE_VIEW) { // View row

			// ID_USUARIO
			$sec_usuarios->ID_USUARIO->ViewValue = $sec_usuarios->ID_USUARIO->CurrentValue;
			$sec_usuarios->ID_USUARIO->ViewCustomAttributes = "";

			// DES_USUARIO
			$sec_usuarios->DES_USUARIO->ViewValue = $sec_usuarios->DES_USUARIO->CurrentValue;
			$sec_usuarios->DES_USUARIO->ViewCustomAttributes = "";

			// ID_USUARIO
			$sec_usuarios->ID_USUARIO->LinkCustomAttributes = "";
			$sec_usuarios->ID_USUARIO->HrefValue = "";
			$sec_usuarios->ID_USUARIO->TooltipValue = "";

			// DES_USUARIO
			$sec_usuarios->DES_USUARIO->LinkCustomAttributes = "";
			$sec_usuarios->DES_USUARIO->HrefValue = "";
			$sec_usuarios->DES_USUARIO->TooltipValue = "";
		}

		// Call Row Rendered event
		if ($sec_usuarios->RowType <> EW_ROWTYPE_AGGREGATEINIT)
			$sec_usuarios->Row_Rendered();
	}

	// PDF Export
	function ExportPDF($html) {
		echo($html);
		ew_DeleteTmpImages();
		exit();
	}

	// Page Load event
	function Page_Load() {

		//echo "Page Load";
	}

	// Page Unload event
	function Page_Unload() {

		//echo "Page Unload";
	}

	// Page Redirecting event
	function Page_Redirecting(&$url) {

		// Example:
		//$url = "your URL";

	}

	// Message Showing event
	// $type = ''|'success'|'failure'
	function Message_Showing(&$msg, $type) {

		// Example:
		//if ($type == 'success') $msg = "your success message";

	}

	// Page Data Rendering event
	function Page_DataRendering(&$header) {

		// Example:
		//$header = "your header";

	}

	// Page Data Rendered event
	function Page_DataRendered(&$footer) {

		// Example:
		//$footer = "your footer";

	}
}
?>
