<?php
session_start(); // Initialize Session data
ob_start(); // Turn on output buffering
?>
<?php include_once "ewcfg8.jsp" ?>
<?php include_once "ewmysql8.jsp" ?>
<?php include_once "phpfn8.jsp" ?>
<?php include_once "sis_productoinfo.jsp" ?>
<?php include_once "userfn8.jsp" ?>
<?php ew_Header(FALSE) ?>
<?php

// Create page object
$sis_producto_view = new csis_producto_view();
$Page =& $sis_producto_view;

// Page init
$sis_producto_view->Page_Init();

// Page main
$sis_producto_view->Page_Main();
?>
<?php include_once "header.jsp" ?>
<?php if ($sis_producto->Export == "") { ?>
<script type="text/javascript">
<!--

// Create page object
var sis_producto_view = new ew_Page("sis_producto_view");

// page properties
sis_producto_view.PageID = "view"; // page ID
sis_producto_view.FormID = "fsis_productoview"; // form ID
var EW_PAGE_ID = sis_producto_view.PageID; // for backward compatibility

// extend page with Form_CustomValidate function
sis_producto_view.Form_CustomValidate =  
 function(fobj) { // DO NOT CHANGE THIS LINE!

 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
<?php if (EW_CLIENT_VALIDATE) { ?>
sis_producto_view.ValidateRequired = true; // uses JavaScript validation
<?php } else { ?>
sis_producto_view.ValidateRequired = false; // no JavaScript validation
<?php } ?>

//-->
</script>
<script language="JavaScript" type="text/javascript">
<!--

// Write your client script here, no need to add script tags.
//-->

</script>
<?php } ?>
<?php $sis_producto_view->ShowPageHeader(); ?>
<p class="phpmaker ewTitle"><?php echo $Language->Phrase("View") ?>&nbsp;<?php echo $Language->Phrase("TblTypeTABLE") ?><?php echo $sis_producto->TableCaption() ?>
&nbsp;&nbsp;<?php $sis_producto_view->ExportOptions->Render("body"); ?>
</p>
<?php if ($sis_producto->Export == "") { ?>
<p class="phpmaker">
<a href="<?php echo $sis_producto_view->ListUrl ?>"><?php echo $Language->Phrase("BackToList") ?></a>&nbsp;
<a href="<?php echo $sis_producto_view->AddUrl ?>"><?php echo $Language->Phrase("ViewPageAddLink") ?></a>&nbsp;
<a href="<?php echo $sis_producto_view->EditUrl ?>"><?php echo $Language->Phrase("ViewPageEditLink") ?></a>&nbsp;
<a href="<?php echo $sis_producto_view->CopyUrl ?>"><?php echo $Language->Phrase("ViewPageCopyLink") ?></a>&nbsp;
<a href="<?php echo $sis_producto_view->DeleteUrl ?>"><?php echo $Language->Phrase("ViewPageDeleteLink") ?></a>&nbsp;
<?php } ?>
</p>
<?php
$sis_producto_view->ShowMessage();
?>
<p>
<table cellspacing="0" class="ewGrid"><tr><td class="ewGridContent">
<div class="ewGridMiddlePanel">
<table cellspacing="0" class="ewTable">
<?php if ($sis_producto->ID_PRODUCTO->Visible) { // ID_PRODUCTO ?>
	<tr id="r_ID_PRODUCTO"<?php echo $sis_producto->RowAttributes() ?>>
		<td class="ewTableHeader"><?php echo $sis_producto->ID_PRODUCTO->FldCaption() ?></td>
		<td<?php echo $sis_producto->ID_PRODUCTO->CellAttributes() ?>>
<div<?php echo $sis_producto->ID_PRODUCTO->ViewAttributes() ?>><?php echo $sis_producto->ID_PRODUCTO->ViewValue ?></div></td>
	</tr>
<?php } ?>
<?php if ($sis_producto->NOM_PRODUCTO->Visible) { // NOM_PRODUCTO ?>
	<tr id="r_NOM_PRODUCTO"<?php echo $sis_producto->RowAttributes() ?>>
		<td class="ewTableHeader"><?php echo $sis_producto->NOM_PRODUCTO->FldCaption() ?></td>
		<td<?php echo $sis_producto->NOM_PRODUCTO->CellAttributes() ?>>
<div<?php echo $sis_producto->NOM_PRODUCTO->ViewAttributes() ?>><?php echo $sis_producto->NOM_PRODUCTO->ViewValue ?></div></td>
	</tr>
<?php } ?>
<?php if ($sis_producto->DES_PRODUCTO->Visible) { // DES_PRODUCTO ?>
	<tr id="r_DES_PRODUCTO"<?php echo $sis_producto->RowAttributes() ?>>
		<td class="ewTableHeader"><?php echo $sis_producto->DES_PRODUCTO->FldCaption() ?></td>
		<td<?php echo $sis_producto->DES_PRODUCTO->CellAttributes() ?>>
<div<?php echo $sis_producto->DES_PRODUCTO->ViewAttributes() ?>><?php echo $sis_producto->DES_PRODUCTO->ViewValue ?></div></td>
	</tr>
<?php } ?>
</table>
</div>
</td></tr></table>
<p>
<?php
$sis_producto_view->ShowPageFooter();
if (EW_DEBUG_ENABLED)
	echo ew_DebugMsg();
?>
<?php if ($sis_producto->Export == "") { ?>
<script language="JavaScript" type="text/javascript">
<!--

// Write your table-specific startup script here
// document.write("page loaded");
//-->

</script>
<?php } ?>
<?php include_once "footer.jsp" ?>
<?php
$sis_producto_view->Page_Terminate();
?>
<?php

//
// Page class
//
class csis_producto_view {

	// Page ID
	var $PageID = 'view';

	// Table name
	var $TableName = 'sis_producto';

	// Page object name
	var $PageObjName = 'sis_producto_view';

	// Page name
	function PageName() {
		return ew_CurrentPage();
	}

	// Page URL
	function PageUrl() {
		$PageUrl = ew_CurrentPage() . "?";
		global $sis_producto;
		if ($sis_producto->UseTokenInUrl) $PageUrl .= "t=" . $sis_producto->TableVar . "&"; // Add page token
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
		global $objForm, $sis_producto;
		if ($sis_producto->UseTokenInUrl) {
			if ($objForm)
				return ($sis_producto->TableVar == $objForm->GetValue("t"));
			if (@$_GET["t"] <> "")
				return ($sis_producto->TableVar == $_GET["t"]);
		} else {
			return TRUE;
		}
	}

	//
	// Page class constructor
	//
	function csis_producto_view() {
		global $conn, $Language;

		// Language object
		if (!isset($Language)) $Language = new cLanguage();

		// Table object (sis_producto)
		if (!isset($GLOBALS["sis_producto"])) {
			$GLOBALS["sis_producto"] = new csis_producto();
			$GLOBALS["Table"] =& $GLOBALS["sis_producto"];
		}
		$KeyUrl = "";
		if (@$_GET["ID_PRODUCTO"] <> "") {
			$this->RecKey["ID_PRODUCTO"] = $_GET["ID_PRODUCTO"];
			$KeyUrl .= "&ID_PRODUCTO=" . urlencode($this->RecKey["ID_PRODUCTO"]);
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
			define("EW_TABLE_NAME", 'sis_producto', TRUE);

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
		global $sis_producto;

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
		global $Language, $sis_producto;
		$sReturnUrl = "";
		$bMatchRecord = FALSE;
		if ($this->IsPageRequest()) { // Validate request
			if (@$_GET["ID_PRODUCTO"] <> "") {
				$sis_producto->ID_PRODUCTO->setQueryStringValue($_GET["ID_PRODUCTO"]);
				$this->RecKey["ID_PRODUCTO"] = $sis_producto->ID_PRODUCTO->QueryStringValue;
			} else {
				$sReturnUrl = "sis_productolist.jsp"; // Return to list
			}

			// Get action
			$sis_producto->CurrentAction = "I"; // Display form
			switch ($sis_producto->CurrentAction) {
				case "I": // Get a record to display
					if (!$this->LoadRow()) { // Load record based on key
						if ($this->getSuccessMessage() == "" && $this->getFailureMessage() == "")
							$this->setFailureMessage($Language->Phrase("NoRecord")); // Set no record message
						$sReturnUrl = "sis_productolist.jsp"; // No matching record, return to list
					}
			}
		} else {
			$sReturnUrl = "sis_productolist.jsp"; // Not page request, return to list
		}
		if ($sReturnUrl <> "")
			$this->Page_Terminate($sReturnUrl);

		// Render row
		$sis_producto->RowType = EW_ROWTYPE_VIEW;
		$sis_producto->ResetAttrs();
		$this->RenderRow();
	}

	// Set up starting record parameters
	function SetUpStartRec() {
		global $sis_producto;
		if ($this->DisplayRecs == 0)
			return;
		if ($this->IsPageRequest()) { // Validate request
			if (@$_GET[EW_TABLE_START_REC] <> "") { // Check for "start" parameter
				$this->StartRec = $_GET[EW_TABLE_START_REC];
				$sis_producto->setStartRecordNumber($this->StartRec);
			} elseif (@$_GET[EW_TABLE_PAGE_NO] <> "") {
				$PageNo = $_GET[EW_TABLE_PAGE_NO];
				if (is_numeric($PageNo)) {
					$this->StartRec = ($PageNo-1)*$this->DisplayRecs+1;
					if ($this->StartRec <= 0) {
						$this->StartRec = 1;
					} elseif ($this->StartRec >= intval(($this->TotalRecs-1)/$this->DisplayRecs)*$this->DisplayRecs+1) {
						$this->StartRec = intval(($this->TotalRecs-1)/$this->DisplayRecs)*$this->DisplayRecs+1;
					}
					$sis_producto->setStartRecordNumber($this->StartRec);
				}
			}
		}
		$this->StartRec = $sis_producto->getStartRecordNumber();

		// Check if correct start record counter
		if (!is_numeric($this->StartRec) || $this->StartRec == "") { // Avoid invalid start record counter
			$this->StartRec = 1; // Reset start record counter
			$sis_producto->setStartRecordNumber($this->StartRec);
		} elseif (intval($this->StartRec) > intval($this->TotalRecs)) { // Avoid starting record > total records
			$this->StartRec = intval(($this->TotalRecs-1)/$this->DisplayRecs)*$this->DisplayRecs+1; // Point to last page first record
			$sis_producto->setStartRecordNumber($this->StartRec);
		} elseif (($this->StartRec-1) % $this->DisplayRecs <> 0) {
			$this->StartRec = intval(($this->StartRec-1)/$this->DisplayRecs)*$this->DisplayRecs+1; // Point to page boundary
			$sis_producto->setStartRecordNumber($this->StartRec);
		}
	}

	// Load row based on key values
	function LoadRow() {
		global $conn, $Security, $sis_producto;
		$sFilter = $sis_producto->KeyFilter();

		// Call Row Selecting event
		$sis_producto->Row_Selecting($sFilter);

		// Load SQL based on filter
		$sis_producto->CurrentFilter = $sFilter;
		$sSql = $sis_producto->SQL();
		$res = FALSE;
		$rs = ew_LoadRecordset($sSql);
		if ($rs && !$rs->EOF) {
			$res = TRUE;
			$this->LoadRowValues($rs); // Load row values

			// Call Row Selected event
			$row = $rs->fields;
			$sis_producto->Row_Selected($row);
			$rs->Close();
		}
		return $res;
	}

	// Load row values from recordset
	function LoadRowValues(&$rs) {
		global $conn, $sis_producto;
		if (!$rs || $rs->EOF) return;
		$sis_producto->ID_PRODUCTO->setDbValue($rs->fields('ID_PRODUCTO'));
		$sis_producto->NOM_PRODUCTO->setDbValue($rs->fields('NOM_PRODUCTO'));
		$sis_producto->DES_PRODUCTO->setDbValue($rs->fields('DES_PRODUCTO'));
	}

	// Render row values based on field settings
	function RenderRow() {
		global $conn, $Security, $Language, $sis_producto;

		// Initialize URLs
		$this->AddUrl = $sis_producto->AddUrl();
		$this->EditUrl = $sis_producto->EditUrl();
		$this->CopyUrl = $sis_producto->CopyUrl();
		$this->DeleteUrl = $sis_producto->DeleteUrl();
		$this->ListUrl = $sis_producto->ListUrl();

		// Call Row_Rendering event
		$sis_producto->Row_Rendering();

		// Common render codes for all row types
		// ID_PRODUCTO
		// NOM_PRODUCTO
		// DES_PRODUCTO

		if ($sis_producto->RowType == EW_ROWTYPE_VIEW) { // View row

			// ID_PRODUCTO
			$sis_producto->ID_PRODUCTO->ViewValue = $sis_producto->ID_PRODUCTO->CurrentValue;
			$sis_producto->ID_PRODUCTO->ViewCustomAttributes = "";

			// NOM_PRODUCTO
			$sis_producto->NOM_PRODUCTO->ViewValue = $sis_producto->NOM_PRODUCTO->CurrentValue;
			$sis_producto->NOM_PRODUCTO->ViewCustomAttributes = "";

			// DES_PRODUCTO
			$sis_producto->DES_PRODUCTO->ViewValue = $sis_producto->DES_PRODUCTO->CurrentValue;
			$sis_producto->DES_PRODUCTO->ViewCustomAttributes = "";

			// ID_PRODUCTO
			$sis_producto->ID_PRODUCTO->LinkCustomAttributes = "";
			$sis_producto->ID_PRODUCTO->HrefValue = "";
			$sis_producto->ID_PRODUCTO->TooltipValue = "";

			// NOM_PRODUCTO
			$sis_producto->NOM_PRODUCTO->LinkCustomAttributes = "";
			$sis_producto->NOM_PRODUCTO->HrefValue = "";
			$sis_producto->NOM_PRODUCTO->TooltipValue = "";

			// DES_PRODUCTO
			$sis_producto->DES_PRODUCTO->LinkCustomAttributes = "";
			$sis_producto->DES_PRODUCTO->HrefValue = "";
			$sis_producto->DES_PRODUCTO->TooltipValue = "";
		}

		// Call Row Rendered event
		if ($sis_producto->RowType <> EW_ROWTYPE_AGGREGATEINIT)
			$sis_producto->Row_Rendered();
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
