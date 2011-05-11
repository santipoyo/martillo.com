<?php
session_start(); // Initialize Session data
ob_start(); // Turn on output buffering
?>
<?php include_once "ewcfg8.jsp" ?>
<?php include_once "ewmysql8.jsp" ?>
<?php include_once "phpfn8.jsp" ?>
<?php include_once "sec_perfilinfo.jsp" ?>
<?php include_once "userfn8.jsp" ?>
<?php ew_Header(FALSE) ?>
<?php

// Create page object
$sec_perfil_view = new csec_perfil_view();
$Page =& $sec_perfil_view;

// Page init
$sec_perfil_view->Page_Init();

// Page main
$sec_perfil_view->Page_Main();
?>
<?php include_once "header.jsp" ?>
<?php if ($sec_perfil->Export == "") { ?>
<script type="text/javascript">
<!--

// Create page object
var sec_perfil_view = new ew_Page("sec_perfil_view");

// page properties
sec_perfil_view.PageID = "view"; // page ID
sec_perfil_view.FormID = "fsec_perfilview"; // form ID
var EW_PAGE_ID = sec_perfil_view.PageID; // for backward compatibility

// extend page with Form_CustomValidate function
sec_perfil_view.Form_CustomValidate =  
 function(fobj) { // DO NOT CHANGE THIS LINE!

 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
<?php if (EW_CLIENT_VALIDATE) { ?>
sec_perfil_view.ValidateRequired = true; // uses JavaScript validation
<?php } else { ?>
sec_perfil_view.ValidateRequired = false; // no JavaScript validation
<?php } ?>

//-->
</script>
<script language="JavaScript" type="text/javascript">
<!--

// Write your client script here, no need to add script tags.
//-->

</script>
<?php } ?>
<?php $sec_perfil_view->ShowPageHeader(); ?>
<p class="phpmaker ewTitle"><?php echo $Language->Phrase("View") ?>&nbsp;<?php echo $Language->Phrase("TblTypeTABLE") ?><?php echo $sec_perfil->TableCaption() ?>
&nbsp;&nbsp;<?php $sec_perfil_view->ExportOptions->Render("body"); ?>
</p>
<?php if ($sec_perfil->Export == "") { ?>
<p class="phpmaker">
<a href="<?php echo $sec_perfil_view->ListUrl ?>"><?php echo $Language->Phrase("BackToList") ?></a>&nbsp;
<a href="<?php echo $sec_perfil_view->AddUrl ?>"><?php echo $Language->Phrase("ViewPageAddLink") ?></a>&nbsp;
<a href="<?php echo $sec_perfil_view->EditUrl ?>"><?php echo $Language->Phrase("ViewPageEditLink") ?></a>&nbsp;
<a href="<?php echo $sec_perfil_view->CopyUrl ?>"><?php echo $Language->Phrase("ViewPageCopyLink") ?></a>&nbsp;
<a href="<?php echo $sec_perfil_view->DeleteUrl ?>"><?php echo $Language->Phrase("ViewPageDeleteLink") ?></a>&nbsp;
<?php } ?>
</p>
<?php
$sec_perfil_view->ShowMessage();
?>
<p>
<table cellspacing="0" class="ewGrid"><tr><td class="ewGridContent">
<div class="ewGridMiddlePanel">
<table cellspacing="0" class="ewTable">
<?php if ($sec_perfil->ID_PERFIL->Visible) { // ID_PERFIL ?>
	<tr id="r_ID_PERFIL"<?php echo $sec_perfil->RowAttributes() ?>>
		<td class="ewTableHeader"><?php echo $sec_perfil->ID_PERFIL->FldCaption() ?></td>
		<td<?php echo $sec_perfil->ID_PERFIL->CellAttributes() ?>>
<div<?php echo $sec_perfil->ID_PERFIL->ViewAttributes() ?>><?php echo $sec_perfil->ID_PERFIL->ViewValue ?></div></td>
	</tr>
<?php } ?>
<?php if ($sec_perfil->DES_PERFIL->Visible) { // DES_PERFIL ?>
	<tr id="r_DES_PERFIL"<?php echo $sec_perfil->RowAttributes() ?>>
		<td class="ewTableHeader"><?php echo $sec_perfil->DES_PERFIL->FldCaption() ?></td>
		<td<?php echo $sec_perfil->DES_PERFIL->CellAttributes() ?>>
<div<?php echo $sec_perfil->DES_PERFIL->ViewAttributes() ?>><?php echo $sec_perfil->DES_PERFIL->ViewValue ?></div></td>
	</tr>
<?php } ?>
</table>
</div>
</td></tr></table>
<p>
<?php
$sec_perfil_view->ShowPageFooter();
if (EW_DEBUG_ENABLED)
	echo ew_DebugMsg();
?>
<?php if ($sec_perfil->Export == "") { ?>
<script language="JavaScript" type="text/javascript">
<!--

// Write your table-specific startup script here
// document.write("page loaded");
//-->

</script>
<?php } ?>
<?php include_once "footer.jsp" ?>
<?php
$sec_perfil_view->Page_Terminate();
?>
<?php

//
// Page class
//
class csec_perfil_view {

	// Page ID
	var $PageID = 'view';

	// Table name
	var $TableName = 'sec_perfil';

	// Page object name
	var $PageObjName = 'sec_perfil_view';

	// Page name
	function PageName() {
		return ew_CurrentPage();
	}

	// Page URL
	function PageUrl() {
		$PageUrl = ew_CurrentPage() . "?";
		global $sec_perfil;
		if ($sec_perfil->UseTokenInUrl) $PageUrl .= "t=" . $sec_perfil->TableVar . "&"; // Add page token
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
		global $objForm, $sec_perfil;
		if ($sec_perfil->UseTokenInUrl) {
			if ($objForm)
				return ($sec_perfil->TableVar == $objForm->GetValue("t"));
			if (@$_GET["t"] <> "")
				return ($sec_perfil->TableVar == $_GET["t"]);
		} else {
			return TRUE;
		}
	}

	//
	// Page class constructor
	//
	function csec_perfil_view() {
		global $conn, $Language;

		// Language object
		if (!isset($Language)) $Language = new cLanguage();

		// Table object (sec_perfil)
		if (!isset($GLOBALS["sec_perfil"])) {
			$GLOBALS["sec_perfil"] = new csec_perfil();
			$GLOBALS["Table"] =& $GLOBALS["sec_perfil"];
		}
		$KeyUrl = "";
		if (@$_GET["ID_PERFIL"] <> "") {
			$this->RecKey["ID_PERFIL"] = $_GET["ID_PERFIL"];
			$KeyUrl .= "&ID_PERFIL=" . urlencode($this->RecKey["ID_PERFIL"]);
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
			define("EW_TABLE_NAME", 'sec_perfil', TRUE);

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
		global $sec_perfil;

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
		global $Language, $sec_perfil;
		$sReturnUrl = "";
		$bMatchRecord = FALSE;
		if ($this->IsPageRequest()) { // Validate request
			if (@$_GET["ID_PERFIL"] <> "") {
				$sec_perfil->ID_PERFIL->setQueryStringValue($_GET["ID_PERFIL"]);
				$this->RecKey["ID_PERFIL"] = $sec_perfil->ID_PERFIL->QueryStringValue;
			} else {
				$sReturnUrl = "sec_perfillist.jsp"; // Return to list
			}

			// Get action
			$sec_perfil->CurrentAction = "I"; // Display form
			switch ($sec_perfil->CurrentAction) {
				case "I": // Get a record to display
					if (!$this->LoadRow()) { // Load record based on key
						if ($this->getSuccessMessage() == "" && $this->getFailureMessage() == "")
							$this->setFailureMessage($Language->Phrase("NoRecord")); // Set no record message
						$sReturnUrl = "sec_perfillist.jsp"; // No matching record, return to list
					}
			}
		} else {
			$sReturnUrl = "sec_perfillist.jsp"; // Not page request, return to list
		}
		if ($sReturnUrl <> "")
			$this->Page_Terminate($sReturnUrl);

		// Render row
		$sec_perfil->RowType = EW_ROWTYPE_VIEW;
		$sec_perfil->ResetAttrs();
		$this->RenderRow();
	}

	// Set up starting record parameters
	function SetUpStartRec() {
		global $sec_perfil;
		if ($this->DisplayRecs == 0)
			return;
		if ($this->IsPageRequest()) { // Validate request
			if (@$_GET[EW_TABLE_START_REC] <> "") { // Check for "start" parameter
				$this->StartRec = $_GET[EW_TABLE_START_REC];
				$sec_perfil->setStartRecordNumber($this->StartRec);
			} elseif (@$_GET[EW_TABLE_PAGE_NO] <> "") {
				$PageNo = $_GET[EW_TABLE_PAGE_NO];
				if (is_numeric($PageNo)) {
					$this->StartRec = ($PageNo-1)*$this->DisplayRecs+1;
					if ($this->StartRec <= 0) {
						$this->StartRec = 1;
					} elseif ($this->StartRec >= intval(($this->TotalRecs-1)/$this->DisplayRecs)*$this->DisplayRecs+1) {
						$this->StartRec = intval(($this->TotalRecs-1)/$this->DisplayRecs)*$this->DisplayRecs+1;
					}
					$sec_perfil->setStartRecordNumber($this->StartRec);
				}
			}
		}
		$this->StartRec = $sec_perfil->getStartRecordNumber();

		// Check if correct start record counter
		if (!is_numeric($this->StartRec) || $this->StartRec == "") { // Avoid invalid start record counter
			$this->StartRec = 1; // Reset start record counter
			$sec_perfil->setStartRecordNumber($this->StartRec);
		} elseif (intval($this->StartRec) > intval($this->TotalRecs)) { // Avoid starting record > total records
			$this->StartRec = intval(($this->TotalRecs-1)/$this->DisplayRecs)*$this->DisplayRecs+1; // Point to last page first record
			$sec_perfil->setStartRecordNumber($this->StartRec);
		} elseif (($this->StartRec-1) % $this->DisplayRecs <> 0) {
			$this->StartRec = intval(($this->StartRec-1)/$this->DisplayRecs)*$this->DisplayRecs+1; // Point to page boundary
			$sec_perfil->setStartRecordNumber($this->StartRec);
		}
	}

	// Load row based on key values
	function LoadRow() {
		global $conn, $Security, $sec_perfil;
		$sFilter = $sec_perfil->KeyFilter();

		// Call Row Selecting event
		$sec_perfil->Row_Selecting($sFilter);

		// Load SQL based on filter
		$sec_perfil->CurrentFilter = $sFilter;
		$sSql = $sec_perfil->SQL();
		$res = FALSE;
		$rs = ew_LoadRecordset($sSql);
		if ($rs && !$rs->EOF) {
			$res = TRUE;
			$this->LoadRowValues($rs); // Load row values

			// Call Row Selected event
			$row = $rs->fields;
			$sec_perfil->Row_Selected($row);
			$rs->Close();
		}
		return $res;
	}

	// Load row values from recordset
	function LoadRowValues(&$rs) {
		global $conn, $sec_perfil;
		if (!$rs || $rs->EOF) return;
		$sec_perfil->ID_PERFIL->setDbValue($rs->fields('ID_PERFIL'));
		$sec_perfil->DES_PERFIL->setDbValue($rs->fields('DES_PERFIL'));
	}

	// Render row values based on field settings
	function RenderRow() {
		global $conn, $Security, $Language, $sec_perfil;

		// Initialize URLs
		$this->AddUrl = $sec_perfil->AddUrl();
		$this->EditUrl = $sec_perfil->EditUrl();
		$this->CopyUrl = $sec_perfil->CopyUrl();
		$this->DeleteUrl = $sec_perfil->DeleteUrl();
		$this->ListUrl = $sec_perfil->ListUrl();

		// Call Row_Rendering event
		$sec_perfil->Row_Rendering();

		// Common render codes for all row types
		// ID_PERFIL
		// DES_PERFIL

		if ($sec_perfil->RowType == EW_ROWTYPE_VIEW) { // View row

			// ID_PERFIL
			$sec_perfil->ID_PERFIL->ViewValue = $sec_perfil->ID_PERFIL->CurrentValue;
			$sec_perfil->ID_PERFIL->ViewCustomAttributes = "";

			// DES_PERFIL
			$sec_perfil->DES_PERFIL->ViewValue = $sec_perfil->DES_PERFIL->CurrentValue;
			$sec_perfil->DES_PERFIL->ViewCustomAttributes = "";

			// ID_PERFIL
			$sec_perfil->ID_PERFIL->LinkCustomAttributes = "";
			$sec_perfil->ID_PERFIL->HrefValue = "";
			$sec_perfil->ID_PERFIL->TooltipValue = "";

			// DES_PERFIL
			$sec_perfil->DES_PERFIL->LinkCustomAttributes = "";
			$sec_perfil->DES_PERFIL->HrefValue = "";
			$sec_perfil->DES_PERFIL->TooltipValue = "";
		}

		// Call Row Rendered event
		if ($sec_perfil->RowType <> EW_ROWTYPE_AGGREGATEINIT)
			$sec_perfil->Row_Rendered();
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
