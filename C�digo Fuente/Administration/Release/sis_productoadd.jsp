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
$sis_producto_add = new csis_producto_add();
$Page =& $sis_producto_add;

// Page init
$sis_producto_add->Page_Init();

// Page main
$sis_producto_add->Page_Main();
?>
<?php include_once "header.jsp" ?>
<script type="text/javascript">
<!--

// Create page object
var sis_producto_add = new ew_Page("sis_producto_add");

// page properties
sis_producto_add.PageID = "add"; // page ID
sis_producto_add.FormID = "fsis_productoadd"; // form ID
var EW_PAGE_ID = sis_producto_add.PageID; // for backward compatibility

// extend page with ValidateForm function
sis_producto_add.ValidateForm = function(fobj) {
	ew_PostAutoSuggest(fobj);
	if (!this.ValidateRequired)
		return true; // ignore validation
	if (fobj.a_confirm && fobj.a_confirm.value == "F")
		return true;
	var i, elm, aelm, infix;
	var rowcnt = 1;
	for (i=0; i<rowcnt; i++) {
		infix = "";
		elm = fobj.elements["x" + infix + "_ID_PRODUCTO"];
		if (elm && !ew_HasValue(elm))
			return ew_OnError(this, elm, ewLanguage.Phrase("EnterRequiredField") + " - <?php echo ew_JsEncode2($sis_producto->ID_PRODUCTO->FldCaption()) ?>");
		elm = fobj.elements["x" + infix + "_ID_PRODUCTO"];
		if (elm && !ew_CheckInteger(elm.value))
			return ew_OnError(this, elm, "<?php echo ew_JsEncode2($sis_producto->ID_PRODUCTO->FldErrMsg()) ?>");
		elm = fobj.elements["x" + infix + "_NOM_PRODUCTO"];
		if (elm && !ew_HasValue(elm))
			return ew_OnError(this, elm, ewLanguage.Phrase("EnterRequiredField") + " - <?php echo ew_JsEncode2($sis_producto->NOM_PRODUCTO->FldCaption()) ?>");
		elm = fobj.elements["x" + infix + "_DES_PRODUCTO"];
		if (elm && !ew_HasValue(elm))
			return ew_OnError(this, elm, ewLanguage.Phrase("EnterRequiredField") + " - <?php echo ew_JsEncode2($sis_producto->DES_PRODUCTO->FldCaption()) ?>");

		// Call Form Custom Validate event
		if (!this.Form_CustomValidate(fobj)) return false;
	}

	// Process detail page
	var detailpage = (fobj.detailpage) ? fobj.detailpage.value : "";
	if (detailpage != "") {
		return eval(detailpage+".ValidateForm(fobj)");
	}
	return true;
}

// extend page with Form_CustomValidate function
sis_producto_add.Form_CustomValidate =  
 function(fobj) { // DO NOT CHANGE THIS LINE!

 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
<?php if (EW_CLIENT_VALIDATE) { ?>
sis_producto_add.ValidateRequired = true; // uses JavaScript validation
<?php } else { ?>
sis_producto_add.ValidateRequired = false; // no JavaScript validation
<?php } ?>

//-->
</script>
<script language="JavaScript" type="text/javascript">
<!--

// Write your client script here, no need to add script tags.
//-->

</script>
<?php $sis_producto_add->ShowPageHeader(); ?>
<p class="phpmaker ewTitle"><?php echo $Language->Phrase("Add") ?>&nbsp;<?php echo $Language->Phrase("TblTypeTABLE") ?><?php echo $sis_producto->TableCaption() ?></p>
<p class="phpmaker"><a href="<?php echo $sis_producto->getReturnUrl() ?>"><?php echo $Language->Phrase("GoBack") ?></a></p>
<?php
$sis_producto_add->ShowMessage();
?>
<form name="fsis_productoadd" id="fsis_productoadd" action="<?php echo ew_CurrentPage() ?>" method="post" onsubmit="return sis_producto_add.ValidateForm(this);">
<p>
<input type="hidden" name="t" id="t" value="sis_producto">
<input type="hidden" name="a_add" id="a_add" value="A">
<table cellspacing="0" class="ewGrid"><tr><td class="ewGridContent">
<div class="ewGridMiddlePanel">
<table cellspacing="0" class="ewTable">
<?php if ($sis_producto->ID_PRODUCTO->Visible) { // ID_PRODUCTO ?>
	<tr id="r_ID_PRODUCTO"<?php echo $sis_producto->RowAttributes() ?>>
		<td class="ewTableHeader"><?php echo $sis_producto->ID_PRODUCTO->FldCaption() ?><?php echo $Language->Phrase("FieldRequiredIndicator") ?></td>
		<td<?php echo $sis_producto->ID_PRODUCTO->CellAttributes() ?>><span id="el_ID_PRODUCTO">
<input type="text" name="x_ID_PRODUCTO" id="x_ID_PRODUCTO" size="30" value="<?php echo $sis_producto->ID_PRODUCTO->EditValue ?>"<?php echo $sis_producto->ID_PRODUCTO->EditAttributes() ?>>
</span><?php echo $sis_producto->ID_PRODUCTO->CustomMsg ?></td>
	</tr>
<?php } ?>
<?php if ($sis_producto->NOM_PRODUCTO->Visible) { // NOM_PRODUCTO ?>
	<tr id="r_NOM_PRODUCTO"<?php echo $sis_producto->RowAttributes() ?>>
		<td class="ewTableHeader"><?php echo $sis_producto->NOM_PRODUCTO->FldCaption() ?><?php echo $Language->Phrase("FieldRequiredIndicator") ?></td>
		<td<?php echo $sis_producto->NOM_PRODUCTO->CellAttributes() ?>><span id="el_NOM_PRODUCTO">
<input type="text" name="x_NOM_PRODUCTO" id="x_NOM_PRODUCTO" size="30" maxlength="50" value="<?php echo $sis_producto->NOM_PRODUCTO->EditValue ?>"<?php echo $sis_producto->NOM_PRODUCTO->EditAttributes() ?>>
</span><?php echo $sis_producto->NOM_PRODUCTO->CustomMsg ?></td>
	</tr>
<?php } ?>
<?php if ($sis_producto->DES_PRODUCTO->Visible) { // DES_PRODUCTO ?>
	<tr id="r_DES_PRODUCTO"<?php echo $sis_producto->RowAttributes() ?>>
		<td class="ewTableHeader"><?php echo $sis_producto->DES_PRODUCTO->FldCaption() ?><?php echo $Language->Phrase("FieldRequiredIndicator") ?></td>
		<td<?php echo $sis_producto->DES_PRODUCTO->CellAttributes() ?>><span id="el_DES_PRODUCTO">
<input type="text" name="x_DES_PRODUCTO" id="x_DES_PRODUCTO" size="30" maxlength="100" value="<?php echo $sis_producto->DES_PRODUCTO->EditValue ?>"<?php echo $sis_producto->DES_PRODUCTO->EditAttributes() ?>>
</span><?php echo $sis_producto->DES_PRODUCTO->CustomMsg ?></td>
	</tr>
<?php } ?>
</table>
</div>
</td></tr></table>
<p>
<input type="submit" name="btnAction" id="btnAction" value="<?php echo ew_BtnCaption($Language->Phrase("AddBtn")) ?>">
</form>
<?php
$sis_producto_add->ShowPageFooter();
if (EW_DEBUG_ENABLED)
	echo ew_DebugMsg();
?>
<script language="JavaScript" type="text/javascript">
<!--

// Write your table-specific startup script here
// document.write("page loaded");
//-->

</script>
<?php include_once "footer.jsp" ?>
<?php
$sis_producto_add->Page_Terminate();
?>
<?php

//
// Page class
//
class csis_producto_add {

	// Page ID
	var $PageID = 'add';

	// Table name
	var $TableName = 'sis_producto';

	// Page object name
	var $PageObjName = 'sis_producto_add';

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
	function csis_producto_add() {
		global $conn, $Language;

		// Language object
		if (!isset($Language)) $Language = new cLanguage();

		// Table object (sis_producto)
		if (!isset($GLOBALS["sis_producto"])) {
			$GLOBALS["sis_producto"] = new csis_producto();
			$GLOBALS["Table"] =& $GLOBALS["sis_producto"];
		}

		// Page ID
		if (!defined("EW_PAGE_ID"))
			define("EW_PAGE_ID", 'add', TRUE);

		// Table name (for backward compatibility)
		if (!defined("EW_TABLE_NAME"))
			define("EW_TABLE_NAME", 'sis_producto', TRUE);

		// Start timer
		if (!isset($GLOBALS["gTimer"])) $GLOBALS["gTimer"] = new cTimer();

		// Open connection
		if (!isset($conn)) $conn = ew_Connect();
	}

	// 
	//  Page_Init
	//
	function Page_Init() {
		global $gsExport, $gsExportFile, $UserProfile, $Language, $Security, $objForm;
		global $sis_producto;

		// Create form object
		$objForm = new cFormObj();

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
	var $DbMasterFilter = "";
	var $DbDetailFilter = "";
	var $Priv = 0;
	var $OldRecordset;

	// 
	// Page main
	//
	function Page_Main() {
		global $objForm, $Language, $gsFormError, $sis_producto;

		// Process form if post back
		if (@$_POST["a_add"] <> "") {
			$sis_producto->CurrentAction = $_POST["a_add"]; // Get form action
			$this->LoadOldRecord(); // Load old recordset
			$this->LoadFormValues(); // Load form values

			// Validate form
			if (!$this->ValidateForm()) {
				$sis_producto->CurrentAction = "I"; // Form error, reset action
				$sis_producto->EventCancelled = TRUE; // Event cancelled
				$this->RestoreFormValues(); // Restore form values
				$this->setFailureMessage($gsFormError);
			}
		} else { // Not post back

			// Load key values from QueryString
			$bCopy = TRUE;
			if (@$_GET["ID_PRODUCTO"] != "") {
				$sis_producto->ID_PRODUCTO->setQueryStringValue($_GET["ID_PRODUCTO"]);
				$sis_producto->setKey("ID_PRODUCTO", $sis_producto->ID_PRODUCTO->CurrentValue); // Set up key
			} else {
				$sis_producto->setKey("ID_PRODUCTO", ""); // Clear key
				$bCopy = FALSE;
			}
			if ($bCopy) {
				$sis_producto->CurrentAction = "C"; // Copy record
			} else {
				$sis_producto->CurrentAction = "I"; // Display blank record
				$this->LoadDefaultValues(); // Load default values
			}
		}

		// Perform action based on action code
		switch ($sis_producto->CurrentAction) {
			case "I": // Blank record, no action required
				break;
			case "C": // Copy an existing record
				if (!$this->LoadRow()) { // Load record based on key
					$this->setFailureMessage($Language->Phrase("NoRecord")); // No record found
					$this->Page_Terminate("sis_productolist.jsp"); // No matching record, return to list
				}
				break;
			case "A": // ' Add new record
				$sis_producto->SendEmail = TRUE; // Send email on add success
				if ($this->AddRow($this->OldRecordset)) { // Add successful
					$this->setSuccessMessage($Language->Phrase("AddSuccess")); // Set up success message
					$sReturnUrl = $sis_producto->getReturnUrl();
					if (ew_GetPageName($sReturnUrl) == "sis_productoview.jsp")
						$sReturnUrl = $sis_producto->ViewUrl(); // View paging, return to view page with keyurl directly
					$this->Page_Terminate($sReturnUrl); // Clean up and return
				} else {
					$this->RestoreFormValues(); // Add failed, restore form values
				}
		}

		// Render row based on row type
		$sis_producto->RowType = EW_ROWTYPE_ADD;  // Render add type

		// Render row
		$sis_producto->ResetAttrs();
		$this->RenderRow();
	}

	// Get upload files
	function GetUploadFiles() {
		global $objForm, $sis_producto;

		// Get upload data
	}

	// Load default values
	function LoadDefaultValues() {
		global $sis_producto;
		$sis_producto->ID_PRODUCTO->CurrentValue = NULL;
		$sis_producto->ID_PRODUCTO->OldValue = $sis_producto->ID_PRODUCTO->CurrentValue;
		$sis_producto->NOM_PRODUCTO->CurrentValue = NULL;
		$sis_producto->NOM_PRODUCTO->OldValue = $sis_producto->NOM_PRODUCTO->CurrentValue;
		$sis_producto->DES_PRODUCTO->CurrentValue = NULL;
		$sis_producto->DES_PRODUCTO->OldValue = $sis_producto->DES_PRODUCTO->CurrentValue;
	}

	// Load form values
	function LoadFormValues() {

		// Load from form
		global $objForm, $sis_producto;
		if (!$sis_producto->ID_PRODUCTO->FldIsDetailKey) {
			$sis_producto->ID_PRODUCTO->setFormValue($objForm->GetValue("x_ID_PRODUCTO"));
		}
		if (!$sis_producto->NOM_PRODUCTO->FldIsDetailKey) {
			$sis_producto->NOM_PRODUCTO->setFormValue($objForm->GetValue("x_NOM_PRODUCTO"));
		}
		if (!$sis_producto->DES_PRODUCTO->FldIsDetailKey) {
			$sis_producto->DES_PRODUCTO->setFormValue($objForm->GetValue("x_DES_PRODUCTO"));
		}
	}

	// Restore form values
	function RestoreFormValues() {
		global $objForm, $sis_producto;
		$this->LoadOldRecord();
		$sis_producto->ID_PRODUCTO->CurrentValue = $sis_producto->ID_PRODUCTO->FormValue;
		$sis_producto->NOM_PRODUCTO->CurrentValue = $sis_producto->NOM_PRODUCTO->FormValue;
		$sis_producto->DES_PRODUCTO->CurrentValue = $sis_producto->DES_PRODUCTO->FormValue;
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

	// Load old record
	function LoadOldRecord() {
		global $sis_producto;

		// Load key values from Session
		$bValidKey = TRUE;
		if (strval($sis_producto->getKey("ID_PRODUCTO")) <> "")
			$sis_producto->ID_PRODUCTO->CurrentValue = $sis_producto->getKey("ID_PRODUCTO"); // ID_PRODUCTO
		else
			$bValidKey = FALSE;

		// Load old recordset
		if ($bValidKey) {
			$sis_producto->CurrentFilter = $sis_producto->KeyFilter();
			$sSql = $sis_producto->SQL();
			$this->OldRecordset = ew_LoadRecordset($sSql);
			$this->LoadRowValues($this->OldRecordset); // Load row values
		}
		return TRUE;
	}

	// Render row values based on field settings
	function RenderRow() {
		global $conn, $Security, $Language, $sis_producto;

		// Initialize URLs
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
		} elseif ($sis_producto->RowType == EW_ROWTYPE_ADD) { // Add row

			// ID_PRODUCTO
			$sis_producto->ID_PRODUCTO->EditCustomAttributes = "";
			$sis_producto->ID_PRODUCTO->EditValue = ew_HtmlEncode($sis_producto->ID_PRODUCTO->CurrentValue);

			// NOM_PRODUCTO
			$sis_producto->NOM_PRODUCTO->EditCustomAttributes = "";
			$sis_producto->NOM_PRODUCTO->EditValue = ew_HtmlEncode($sis_producto->NOM_PRODUCTO->CurrentValue);

			// DES_PRODUCTO
			$sis_producto->DES_PRODUCTO->EditCustomAttributes = "";
			$sis_producto->DES_PRODUCTO->EditValue = ew_HtmlEncode($sis_producto->DES_PRODUCTO->CurrentValue);

			// Edit refer script
			// ID_PRODUCTO

			$sis_producto->ID_PRODUCTO->HrefValue = "";

			// NOM_PRODUCTO
			$sis_producto->NOM_PRODUCTO->HrefValue = "";

			// DES_PRODUCTO
			$sis_producto->DES_PRODUCTO->HrefValue = "";
		}
		if ($sis_producto->RowType == EW_ROWTYPE_ADD ||
			$sis_producto->RowType == EW_ROWTYPE_EDIT ||
			$sis_producto->RowType == EW_ROWTYPE_SEARCH) { // Add / Edit / Search row
			$sis_producto->SetupFieldTitles();
		}

		// Call Row Rendered event
		if ($sis_producto->RowType <> EW_ROWTYPE_AGGREGATEINIT)
			$sis_producto->Row_Rendered();
	}

	// Validate form
	function ValidateForm() {
		global $Language, $gsFormError, $sis_producto;

		// Initialize form error message
		$gsFormError = "";

		// Check if validation required
		if (!EW_SERVER_VALIDATE)
			return ($gsFormError == "");
		if (!is_null($sis_producto->ID_PRODUCTO->FormValue) && $sis_producto->ID_PRODUCTO->FormValue == "") {
			ew_AddMessage($gsFormError, $Language->Phrase("EnterRequiredField") . " - " . $sis_producto->ID_PRODUCTO->FldCaption());
		}
		if (!ew_CheckInteger($sis_producto->ID_PRODUCTO->FormValue)) {
			ew_AddMessage($gsFormError, $sis_producto->ID_PRODUCTO->FldErrMsg());
		}
		if (!is_null($sis_producto->NOM_PRODUCTO->FormValue) && $sis_producto->NOM_PRODUCTO->FormValue == "") {
			ew_AddMessage($gsFormError, $Language->Phrase("EnterRequiredField") . " - " . $sis_producto->NOM_PRODUCTO->FldCaption());
		}
		if (!is_null($sis_producto->DES_PRODUCTO->FormValue) && $sis_producto->DES_PRODUCTO->FormValue == "") {
			ew_AddMessage($gsFormError, $Language->Phrase("EnterRequiredField") . " - " . $sis_producto->DES_PRODUCTO->FldCaption());
		}

		// Return validate result
		$ValidateForm = ($gsFormError == "");

		// Call Form_CustomValidate event
		$sFormCustomError = "";
		$ValidateForm = $ValidateForm && $this->Form_CustomValidate($sFormCustomError);
		if ($sFormCustomError <> "") {
			ew_AddMessage($gsFormError, $sFormCustomError);
		}
		return $ValidateForm;
	}

	// Add record
	function AddRow($rsold = NULL) {
		global $conn, $Language, $Security, $sis_producto;

		// Check if key value entered
		if ($sis_producto->ID_PRODUCTO->CurrentValue == "" && $sis_producto->ID_PRODUCTO->getSessionValue() == "") {
			$this->setFailureMessage($Language->Phrase("InvalidKeyValue"));
			return FALSE;
		}

		// Check for duplicate key
		$bCheckKey = TRUE;
		$sFilter = $sis_producto->KeyFilter();
		if ($bCheckKey) {
			$rsChk = $sis_producto->LoadRs($sFilter);
			if ($rsChk && !$rsChk->EOF) {
				$sKeyErrMsg = str_replace("%f", $sFilter, $Language->Phrase("DupKey"));
				$this->setFailureMessage($sKeyErrMsg);
				$rsChk->Close();
				return FALSE;
			}
		}
		$rsnew = array();

		// ID_PRODUCTO
		$sis_producto->ID_PRODUCTO->SetDbValueDef($rsnew, $sis_producto->ID_PRODUCTO->CurrentValue, 0, FALSE);

		// NOM_PRODUCTO
		$sis_producto->NOM_PRODUCTO->SetDbValueDef($rsnew, $sis_producto->NOM_PRODUCTO->CurrentValue, "", FALSE);

		// DES_PRODUCTO
		$sis_producto->DES_PRODUCTO->SetDbValueDef($rsnew, $sis_producto->DES_PRODUCTO->CurrentValue, "", FALSE);

		// Call Row Inserting event
		$rs = ($rsold == NULL) ? NULL : $rsold->fields;
		$bInsertRow = $sis_producto->Row_Inserting($rs, $rsnew);
		if ($bInsertRow) {
			$conn->raiseErrorFn = 'ew_ErrorFn';
			$AddRow = $conn->Execute($sis_producto->InsertSQL($rsnew));
			$conn->raiseErrorFn = '';
		} else {
			if ($sis_producto->CancelMessage <> "") {
				$this->setFailureMessage($sis_producto->CancelMessage);
				$sis_producto->CancelMessage = "";
			} else {
				$this->setFailureMessage($Language->Phrase("InsertCancelled"));
			}
			$AddRow = FALSE;
		}

		// Get insert id if necessary
		if ($AddRow) {
		}
		if ($AddRow) {

			// Call Row Inserted event
			$rs = ($rsold == NULL) ? NULL : $rsold->fields;
			$sis_producto->Row_Inserted($rs, $rsnew);
		}
		return $AddRow;
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

	// Form Custom Validate event
	function Form_CustomValidate(&$CustomError) {

		// Return error message in CustomError
		return TRUE;
	}
}
?>
