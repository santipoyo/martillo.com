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
$sec_usuarios_edit = new csec_usuarios_edit();
$Page =& $sec_usuarios_edit;

// Page init
$sec_usuarios_edit->Page_Init();

// Page main
$sec_usuarios_edit->Page_Main();
?>
<?php include_once "header.jsp" ?>
<script type="text/javascript">
<!--

// Create page object
var sec_usuarios_edit = new ew_Page("sec_usuarios_edit");

// page properties
sec_usuarios_edit.PageID = "edit"; // page ID
sec_usuarios_edit.FormID = "fsec_usuariosedit"; // form ID
var EW_PAGE_ID = sec_usuarios_edit.PageID; // for backward compatibility

// extend page with ValidateForm function
sec_usuarios_edit.ValidateForm = function(fobj) {
	ew_PostAutoSuggest(fobj);
	if (!this.ValidateRequired)
		return true; // ignore validation
	if (fobj.a_confirm && fobj.a_confirm.value == "F")
		return true;
	var i, elm, aelm, infix;
	var rowcnt = 1;
	for (i=0; i<rowcnt; i++) {
		infix = "";
		elm = fobj.elements["x" + infix + "_ID_USUARIO"];
		if (elm && !ew_HasValue(elm))
			return ew_OnError(this, elm, ewLanguage.Phrase("EnterRequiredField") + " - <?php echo ew_JsEncode2($sec_usuarios->ID_USUARIO->FldCaption()) ?>");
		elm = fobj.elements["x" + infix + "_ID_USUARIO"];
		if (elm && !ew_CheckInteger(elm.value))
			return ew_OnError(this, elm, "<?php echo ew_JsEncode2($sec_usuarios->ID_USUARIO->FldErrMsg()) ?>");
		elm = fobj.elements["x" + infix + "_DES_USUARIO"];
		if (elm && !ew_HasValue(elm))
			return ew_OnError(this, elm, ewLanguage.Phrase("EnterRequiredField") + " - <?php echo ew_JsEncode2($sec_usuarios->DES_USUARIO->FldCaption()) ?>");

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
sec_usuarios_edit.Form_CustomValidate =  
 function(fobj) { // DO NOT CHANGE THIS LINE!

 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
<?php if (EW_CLIENT_VALIDATE) { ?>
sec_usuarios_edit.ValidateRequired = true; // uses JavaScript validation
<?php } else { ?>
sec_usuarios_edit.ValidateRequired = false; // no JavaScript validation
<?php } ?>

//-->
</script>
<script language="JavaScript" type="text/javascript">
<!--

// Write your client script here, no need to add script tags.
//-->

</script>
<?php $sec_usuarios_edit->ShowPageHeader(); ?>
<p class="phpmaker ewTitle"><?php echo $Language->Phrase("Edit") ?>&nbsp;<?php echo $Language->Phrase("TblTypeTABLE") ?><?php echo $sec_usuarios->TableCaption() ?></p>
<p class="phpmaker"><a href="<?php echo $sec_usuarios->getReturnUrl() ?>"><?php echo $Language->Phrase("GoBack") ?></a></p>
<?php
$sec_usuarios_edit->ShowMessage();
?>
<form name="fsec_usuariosedit" id="fsec_usuariosedit" action="<?php echo ew_CurrentPage() ?>" method="post" onsubmit="return sec_usuarios_edit.ValidateForm(this);">
<p>
<input type="hidden" name="a_table" id="a_table" value="sec_usuarios">
<input type="hidden" name="a_edit" id="a_edit" value="U">
<table cellspacing="0" class="ewGrid"><tr><td class="ewGridContent">
<div class="ewGridMiddlePanel">
<table cellspacing="0" class="ewTable">
<?php if ($sec_usuarios->ID_USUARIO->Visible) { // ID_USUARIO ?>
	<tr id="r_ID_USUARIO"<?php echo $sec_usuarios->RowAttributes() ?>>
		<td class="ewTableHeader"><?php echo $sec_usuarios->ID_USUARIO->FldCaption() ?><?php echo $Language->Phrase("FieldRequiredIndicator") ?></td>
		<td<?php echo $sec_usuarios->ID_USUARIO->CellAttributes() ?>><span id="el_ID_USUARIO">
<div<?php echo $sec_usuarios->ID_USUARIO->ViewAttributes() ?>><?php echo $sec_usuarios->ID_USUARIO->EditValue ?></div>
<input type="hidden" name="x_ID_USUARIO" id="x_ID_USUARIO" value="<?php echo ew_HtmlEncode($sec_usuarios->ID_USUARIO->CurrentValue) ?>">
</span><?php echo $sec_usuarios->ID_USUARIO->CustomMsg ?></td>
	</tr>
<?php } ?>
<?php if ($sec_usuarios->DES_USUARIO->Visible) { // DES_USUARIO ?>
	<tr id="r_DES_USUARIO"<?php echo $sec_usuarios->RowAttributes() ?>>
		<td class="ewTableHeader"><?php echo $sec_usuarios->DES_USUARIO->FldCaption() ?><?php echo $Language->Phrase("FieldRequiredIndicator") ?></td>
		<td<?php echo $sec_usuarios->DES_USUARIO->CellAttributes() ?>><span id="el_DES_USUARIO">
<input type="text" name="x_DES_USUARIO" id="x_DES_USUARIO" size="30" maxlength="50" value="<?php echo $sec_usuarios->DES_USUARIO->EditValue ?>"<?php echo $sec_usuarios->DES_USUARIO->EditAttributes() ?>>
</span><?php echo $sec_usuarios->DES_USUARIO->CustomMsg ?></td>
	</tr>
<?php } ?>
</table>
</div>
</td></tr></table>
<p>
<input type="submit" name="btnAction" id="btnAction" value="<?php echo ew_BtnCaption($Language->Phrase("EditBtn")) ?>">
</form>
<?php
$sec_usuarios_edit->ShowPageFooter();
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
$sec_usuarios_edit->Page_Terminate();
?>
<?php

//
// Page class
//
class csec_usuarios_edit {

	// Page ID
	var $PageID = 'edit';

	// Table name
	var $TableName = 'sec_usuarios';

	// Page object name
	var $PageObjName = 'sec_usuarios_edit';

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
	function csec_usuarios_edit() {
		global $conn, $Language;

		// Language object
		if (!isset($Language)) $Language = new cLanguage();

		// Table object (sec_usuarios)
		if (!isset($GLOBALS["sec_usuarios"])) {
			$GLOBALS["sec_usuarios"] = new csec_usuarios();
			$GLOBALS["Table"] =& $GLOBALS["sec_usuarios"];
		}

		// Page ID
		if (!defined("EW_PAGE_ID"))
			define("EW_PAGE_ID", 'edit', TRUE);

		// Table name (for backward compatibility)
		if (!defined("EW_TABLE_NAME"))
			define("EW_TABLE_NAME", 'sec_usuarios', TRUE);

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
		global $sec_usuarios;

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
	var $DbMasterFilter;
	var $DbDetailFilter;

	// 
	// Page main
	//
	function Page_Main() {
		global $objForm, $Language, $gsFormError, $sec_usuarios;

		// Load key from QueryString
		if (@$_GET["ID_USUARIO"] <> "")
			$sec_usuarios->ID_USUARIO->setQueryStringValue($_GET["ID_USUARIO"]);
		if (@$_POST["a_edit"] <> "") {
			$sec_usuarios->CurrentAction = $_POST["a_edit"]; // Get action code
			$this->LoadFormValues(); // Get form values

			// Validate form
			if (!$this->ValidateForm()) {
				$sec_usuarios->CurrentAction = ""; // Form error, reset action
				$this->setFailureMessage($gsFormError);
				$sec_usuarios->EventCancelled = TRUE; // Event cancelled
				$this->RestoreFormValues();
			}
		} else {
			$sec_usuarios->CurrentAction = "I"; // Default action is display
		}

		// Check if valid key
		if ($sec_usuarios->ID_USUARIO->CurrentValue == "")
			$this->Page_Terminate("sec_usuarioslist.jsp"); // Invalid key, return to list
		switch ($sec_usuarios->CurrentAction) {
			case "I": // Get a record to display
				if (!$this->LoadRow()) { // Load record based on key
					$this->setFailureMessage($Language->Phrase("NoRecord")); // No record found
					$this->Page_Terminate("sec_usuarioslist.jsp"); // No matching record, return to list
				}
				break;
			Case "U": // Update
				$sec_usuarios->SendEmail = TRUE; // Send email on update success
				if ($this->EditRow()) { // Update record based on key
					$this->setSuccessMessage($Language->Phrase("UpdateSuccess")); // Update success
					$sReturnUrl = $sec_usuarios->getReturnUrl();
					$this->Page_Terminate($sReturnUrl); // Return to caller
				} else {
					$sec_usuarios->EventCancelled = TRUE; // Event cancelled
					$this->RestoreFormValues(); // Restore form values if update failed
				}
		}

		// Render the record
		$sec_usuarios->RowType = EW_ROWTYPE_EDIT; // Render as Edit
		$sec_usuarios->ResetAttrs();
		$this->RenderRow();
	}

	// Get upload files
	function GetUploadFiles() {
		global $objForm, $sec_usuarios;

		// Get upload data
	}

	// Load form values
	function LoadFormValues() {

		// Load from form
		global $objForm, $sec_usuarios;
		if (!$sec_usuarios->ID_USUARIO->FldIsDetailKey) {
			$sec_usuarios->ID_USUARIO->setFormValue($objForm->GetValue("x_ID_USUARIO"));
		}
		if (!$sec_usuarios->DES_USUARIO->FldIsDetailKey) {
			$sec_usuarios->DES_USUARIO->setFormValue($objForm->GetValue("x_DES_USUARIO"));
		}
	}

	// Restore form values
	function RestoreFormValues() {
		global $objForm, $sec_usuarios;
		$this->LoadRow();
		$sec_usuarios->ID_USUARIO->CurrentValue = $sec_usuarios->ID_USUARIO->FormValue;
		$sec_usuarios->DES_USUARIO->CurrentValue = $sec_usuarios->DES_USUARIO->FormValue;
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
		} elseif ($sec_usuarios->RowType == EW_ROWTYPE_EDIT) { // Edit row

			// ID_USUARIO
			$sec_usuarios->ID_USUARIO->EditCustomAttributes = "";
			$sec_usuarios->ID_USUARIO->EditValue = $sec_usuarios->ID_USUARIO->CurrentValue;
			$sec_usuarios->ID_USUARIO->ViewCustomAttributes = "";

			// DES_USUARIO
			$sec_usuarios->DES_USUARIO->EditCustomAttributes = "";
			$sec_usuarios->DES_USUARIO->EditValue = ew_HtmlEncode($sec_usuarios->DES_USUARIO->CurrentValue);

			// Edit refer script
			// ID_USUARIO

			$sec_usuarios->ID_USUARIO->HrefValue = "";

			// DES_USUARIO
			$sec_usuarios->DES_USUARIO->HrefValue = "";
		}
		if ($sec_usuarios->RowType == EW_ROWTYPE_ADD ||
			$sec_usuarios->RowType == EW_ROWTYPE_EDIT ||
			$sec_usuarios->RowType == EW_ROWTYPE_SEARCH) { // Add / Edit / Search row
			$sec_usuarios->SetupFieldTitles();
		}

		// Call Row Rendered event
		if ($sec_usuarios->RowType <> EW_ROWTYPE_AGGREGATEINIT)
			$sec_usuarios->Row_Rendered();
	}

	// Validate form
	function ValidateForm() {
		global $Language, $gsFormError, $sec_usuarios;

		// Initialize form error message
		$gsFormError = "";

		// Check if validation required
		if (!EW_SERVER_VALIDATE)
			return ($gsFormError == "");
		if (!is_null($sec_usuarios->ID_USUARIO->FormValue) && $sec_usuarios->ID_USUARIO->FormValue == "") {
			ew_AddMessage($gsFormError, $Language->Phrase("EnterRequiredField") . " - " . $sec_usuarios->ID_USUARIO->FldCaption());
		}
		if (!ew_CheckInteger($sec_usuarios->ID_USUARIO->FormValue)) {
			ew_AddMessage($gsFormError, $sec_usuarios->ID_USUARIO->FldErrMsg());
		}
		if (!is_null($sec_usuarios->DES_USUARIO->FormValue) && $sec_usuarios->DES_USUARIO->FormValue == "") {
			ew_AddMessage($gsFormError, $Language->Phrase("EnterRequiredField") . " - " . $sec_usuarios->DES_USUARIO->FldCaption());
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

	// Update record based on key values
	function EditRow() {
		global $conn, $Security, $Language, $sec_usuarios;
		$sFilter = $sec_usuarios->KeyFilter();
		$sec_usuarios->CurrentFilter = $sFilter;
		$sSql = $sec_usuarios->SQL();
		$conn->raiseErrorFn = 'ew_ErrorFn';
		$rs = $conn->Execute($sSql);
		$conn->raiseErrorFn = '';
		if ($rs === FALSE)
			return FALSE;
		if ($rs->EOF) {
			$EditRow = FALSE; // Update Failed
		} else {

			// Save old values
			$rsold =& $rs->fields;
			$rsnew = array();

			// ID_USUARIO
			// DES_USUARIO

			$sec_usuarios->DES_USUARIO->SetDbValueDef($rsnew, $sec_usuarios->DES_USUARIO->CurrentValue, "", FALSE);

			// Call Row Updating event
			$bUpdateRow = $sec_usuarios->Row_Updating($rsold, $rsnew);
			if ($bUpdateRow) {
				$conn->raiseErrorFn = 'ew_ErrorFn';
				if (count($rsnew) > 0)
					$EditRow = $conn->Execute($sec_usuarios->UpdateSQL($rsnew));
				else
					$EditRow = TRUE; // No field to update
				$conn->raiseErrorFn = '';
			} else {
				if ($sec_usuarios->CancelMessage <> "") {
					$this->setFailureMessage($sec_usuarios->CancelMessage);
					$sec_usuarios->CancelMessage = "";
				} else {
					$this->setFailureMessage($Language->Phrase("UpdateCancelled"));
				}
				$EditRow = FALSE;
			}
		}

		// Call Row_Updated event
		if ($EditRow)
			$sec_usuarios->Row_Updated($rsold, $rsnew);
		$rs->Close();
		return $EditRow;
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
