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
$sec_perfil_delete = new csec_perfil_delete();
$Page =& $sec_perfil_delete;

// Page init
$sec_perfil_delete->Page_Init();

// Page main
$sec_perfil_delete->Page_Main();
?>
<?php include_once "header.jsp" ?>
<script type="text/javascript">
<!--

// Create page object
var sec_perfil_delete = new ew_Page("sec_perfil_delete");

// page properties
sec_perfil_delete.PageID = "delete"; // page ID
sec_perfil_delete.FormID = "fsec_perfildelete"; // form ID
var EW_PAGE_ID = sec_perfil_delete.PageID; // for backward compatibility

// extend page with Form_CustomValidate function
sec_perfil_delete.Form_CustomValidate =  
 function(fobj) { // DO NOT CHANGE THIS LINE!

 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
<?php if (EW_CLIENT_VALIDATE) { ?>
sec_perfil_delete.ValidateRequired = true; // uses JavaScript validation
<?php } else { ?>
sec_perfil_delete.ValidateRequired = false; // no JavaScript validation
<?php } ?>

//-->
</script>
<script language="JavaScript" type="text/javascript">
<!--

// Write your client script here, no need to add script tags.
//-->

</script>
<?php $sec_perfil_delete->ShowPageHeader(); ?>
<?php

// Load records for display
if ($sec_perfil_delete->Recordset = $sec_perfil_delete->LoadRecordset())
	$sec_perfil_deleteTotalRecs = $sec_perfil_delete->Recordset->RecordCount(); // Get record count
if ($sec_perfil_deleteTotalRecs <= 0) { // No record found, exit
	if ($sec_perfil_delete->Recordset)
		$sec_perfil_delete->Recordset->Close();
	$sec_perfil_delete->Page_Terminate("sec_perfillist.jsp"); // Return to list
}
?>
<p class="phpmaker ewTitle"><?php echo $Language->Phrase("Delete") ?>&nbsp;<?php echo $Language->Phrase("TblTypeTABLE") ?><?php echo $sec_perfil->TableCaption() ?></p>
<p class="phpmaker"><a href="<?php echo $sec_perfil->getReturnUrl() ?>"><?php echo $Language->Phrase("GoBack") ?></a></p>
<?php
$sec_perfil_delete->ShowMessage();
?>
<form action="<?php echo ew_CurrentPage() ?>" method="post">
<p>
<input type="hidden" name="t" id="t" value="sec_perfil">
<input type="hidden" name="a_delete" id="a_delete" value="D">
<?php foreach ($sec_perfil_delete->RecKeys as $key) { ?>
<?php $keyvalue = is_array($key) ? implode(EW_COMPOSITE_KEY_SEPARATOR, $key) : $key; ?>
<input type="hidden" name="key_m[]" id="key_m[]" value="<?php echo ew_HtmlEncode($keyvalue) ?>">
<?php } ?>
<table class="ewGrid"><tr><td class="ewGridContent">
<div class="ewGridMiddlePanel">
<table cellspacing="0" class="ewTable ewTableSeparate">
<?php echo $sec_perfil->TableCustomInnerHtml ?>
	<thead>
	<tr class="ewTableHeader">
		<td valign="top"><?php echo $sec_perfil->ID_PERFIL->FldCaption() ?></td>
		<td valign="top"><?php echo $sec_perfil->DES_PERFIL->FldCaption() ?></td>
	</tr>
	</thead>
	<tbody>
<?php
$sec_perfil_delete->RecCnt = 0;
$i = 0;
while (!$sec_perfil_delete->Recordset->EOF) {
	$sec_perfil_delete->RecCnt++;

	// Set row properties
	$sec_perfil->ResetAttrs();
	$sec_perfil->RowType = EW_ROWTYPE_VIEW; // View

	// Get the field contents
	$sec_perfil_delete->LoadRowValues($sec_perfil_delete->Recordset);

	// Render row
	$sec_perfil_delete->RenderRow();
?>
	<tr<?php echo $sec_perfil->RowAttributes() ?>>
		<td<?php echo $sec_perfil->ID_PERFIL->CellAttributes() ?>>
<div<?php echo $sec_perfil->ID_PERFIL->ViewAttributes() ?>><?php echo $sec_perfil->ID_PERFIL->ListViewValue() ?></div></td>
		<td<?php echo $sec_perfil->DES_PERFIL->CellAttributes() ?>>
<div<?php echo $sec_perfil->DES_PERFIL->ViewAttributes() ?>><?php echo $sec_perfil->DES_PERFIL->ListViewValue() ?></div></td>
	</tr>
<?php
	$sec_perfil_delete->Recordset->MoveNext();
}
$sec_perfil_delete->Recordset->Close();
?>
</tbody>
</table>
</div>
</td></tr></table>
<p>
<input type="submit" name="Action" id="Action" value="<?php echo ew_BtnCaption($Language->Phrase("DeleteBtn")) ?>">
</form>
<?php
$sec_perfil_delete->ShowPageFooter();
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
$sec_perfil_delete->Page_Terminate();
?>
<?php

//
// Page class
//
class csec_perfil_delete {

	// Page ID
	var $PageID = 'delete';

	// Table name
	var $TableName = 'sec_perfil';

	// Page object name
	var $PageObjName = 'sec_perfil_delete';

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
	function csec_perfil_delete() {
		global $conn, $Language;

		// Language object
		if (!isset($Language)) $Language = new cLanguage();

		// Table object (sec_perfil)
		if (!isset($GLOBALS["sec_perfil"])) {
			$GLOBALS["sec_perfil"] = new csec_perfil();
			$GLOBALS["Table"] =& $GLOBALS["sec_perfil"];
		}

		// Page ID
		if (!defined("EW_PAGE_ID"))
			define("EW_PAGE_ID", 'delete', TRUE);

		// Table name (for backward compatibility)
		if (!defined("EW_TABLE_NAME"))
			define("EW_TABLE_NAME", 'sec_perfil', TRUE);

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
	var $TotalRecs = 0;
	var $RecCnt;
	var $RecKeys = array();
	var $Recordset;

	//
	// Page main
	//
	function Page_Main() {
		global $Language, $sec_perfil;

		// Load key parameters
		$this->RecKeys = $sec_perfil->GetRecordKeys(); // Load record keys
		$sFilter = $sec_perfil->GetKeyFilter();
		if ($sFilter == "")
			$this->Page_Terminate("sec_perfillist.jsp"); // Prevent SQL injection, return to list

		// Set up filter (SQL WHHERE clause) and get return SQL
		// SQL constructor in sec_perfil class, sec_perfilinfo.php

		$sec_perfil->CurrentFilter = $sFilter;

		// Get action
		if (@$_POST["a_delete"] <> "") {
			$sec_perfil->CurrentAction = $_POST["a_delete"];
		} else {
			$sec_perfil->CurrentAction = "I"; // Display record
		}
		switch ($sec_perfil->CurrentAction) {
			case "D": // Delete
				$sec_perfil->SendEmail = TRUE; // Send email on delete success
				if ($this->DeleteRows()) { // delete rows
					$this->setSuccessMessage($Language->Phrase("DeleteSuccess")); // Set up success message
					$this->Page_Terminate($sec_perfil->getReturnUrl()); // Return to caller
				}
		}
	}

// No functions
	// Load recordset
	function LoadRecordset($offset = -1, $rowcnt = -1) {
		global $conn, $sec_perfil;

		// Call Recordset Selecting event
		$sec_perfil->Recordset_Selecting($sec_perfil->CurrentFilter);

		// Load List page SQL
		$sSql = $sec_perfil->SelectSQL();
		if ($offset > -1 && $rowcnt > -1)
			$sSql .= " LIMIT $rowcnt OFFSET $offset";

		// Load recordset
		$rs = ew_LoadRecordset($sSql);

		// Call Recordset Selected event
		$sec_perfil->Recordset_Selected($rs);
		return $rs;
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

	//
	// Delete records based on current filter
	//
	function DeleteRows() {
		global $conn, $Language, $Security, $sec_perfil;
		$DeleteRows = TRUE;
		$sSql = $sec_perfil->SQL();
		$conn->raiseErrorFn = 'ew_ErrorFn';
		$rs = $conn->Execute($sSql);
		$conn->raiseErrorFn = '';
		if ($rs === FALSE) {
			return FALSE;
		} elseif ($rs->EOF) {
			$this->setFailureMessage($Language->Phrase("NoRecord")); // No record found
			$rs->Close();
			return FALSE;
		}
		$conn->BeginTrans();

		// Clone old rows
		$rsold = ($rs) ? $rs->GetRows() : array();
		if ($rs)
			$rs->Close();

		// Call row deleting event
		if ($DeleteRows) {
			foreach ($rsold as $row) {
				$DeleteRows = $sec_perfil->Row_Deleting($row);
				if (!$DeleteRows) break;
			}
		}
		if ($DeleteRows) {
			$sKey = "";
			foreach ($rsold as $row) {
				$sThisKey = "";
				if ($sThisKey <> "") $sThisKey .= EW_COMPOSITE_KEY_SEPARATOR;
				$sThisKey .= $row['ID_PERFIL'];
				$conn->raiseErrorFn = 'ew_ErrorFn';
				$DeleteRows = $conn->Execute($sec_perfil->DeleteSQL($row)); // Delete
				$conn->raiseErrorFn = '';
				if ($DeleteRows === FALSE)
					break;
				if ($sKey <> "") $sKey .= ", ";
				$sKey .= $sThisKey;
			}
		} else {

			// Set up error message
			if ($sec_perfil->CancelMessage <> "") {
				$this->setFailureMessage($sec_perfil->CancelMessage);
				$sec_perfil->CancelMessage = "";
			} else {
				$this->setFailureMessage($Language->Phrase("DeleteCancelled"));
			}
		}
		if ($DeleteRows) {
			$conn->CommitTrans(); // Commit the changes
		} else {
			$conn->RollbackTrans(); // Rollback changes
		}

		// Call Row Deleted event
		if ($DeleteRows) {
			foreach ($rsold as $row) {
				$sec_perfil->Row_Deleted($row);
			}
		}
		return $DeleteRows;
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
