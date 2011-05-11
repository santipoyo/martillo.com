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
$sis_producto_delete = new csis_producto_delete();
$Page =& $sis_producto_delete;

// Page init
$sis_producto_delete->Page_Init();

// Page main
$sis_producto_delete->Page_Main();
?>
<?php include_once "header.jsp" ?>
<script type="text/javascript">
<!--

// Create page object
var sis_producto_delete = new ew_Page("sis_producto_delete");

// page properties
sis_producto_delete.PageID = "delete"; // page ID
sis_producto_delete.FormID = "fsis_productodelete"; // form ID
var EW_PAGE_ID = sis_producto_delete.PageID; // for backward compatibility

// extend page with Form_CustomValidate function
sis_producto_delete.Form_CustomValidate =  
 function(fobj) { // DO NOT CHANGE THIS LINE!

 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
<?php if (EW_CLIENT_VALIDATE) { ?>
sis_producto_delete.ValidateRequired = true; // uses JavaScript validation
<?php } else { ?>
sis_producto_delete.ValidateRequired = false; // no JavaScript validation
<?php } ?>

//-->
</script>
<script language="JavaScript" type="text/javascript">
<!--

// Write your client script here, no need to add script tags.
//-->

</script>
<?php $sis_producto_delete->ShowPageHeader(); ?>
<?php

// Load records for display
if ($sis_producto_delete->Recordset = $sis_producto_delete->LoadRecordset())
	$sis_producto_deleteTotalRecs = $sis_producto_delete->Recordset->RecordCount(); // Get record count
if ($sis_producto_deleteTotalRecs <= 0) { // No record found, exit
	if ($sis_producto_delete->Recordset)
		$sis_producto_delete->Recordset->Close();
	$sis_producto_delete->Page_Terminate("sis_productolist.jsp"); // Return to list
}
?>
<p class="phpmaker ewTitle"><?php echo $Language->Phrase("Delete") ?>&nbsp;<?php echo $Language->Phrase("TblTypeTABLE") ?><?php echo $sis_producto->TableCaption() ?></p>
<p class="phpmaker"><a href="<?php echo $sis_producto->getReturnUrl() ?>"><?php echo $Language->Phrase("GoBack") ?></a></p>
<?php
$sis_producto_delete->ShowMessage();
?>
<form action="<?php echo ew_CurrentPage() ?>" method="post">
<p>
<input type="hidden" name="t" id="t" value="sis_producto">
<input type="hidden" name="a_delete" id="a_delete" value="D">
<?php foreach ($sis_producto_delete->RecKeys as $key) { ?>
<?php $keyvalue = is_array($key) ? implode(EW_COMPOSITE_KEY_SEPARATOR, $key) : $key; ?>
<input type="hidden" name="key_m[]" id="key_m[]" value="<?php echo ew_HtmlEncode($keyvalue) ?>">
<?php } ?>
<table class="ewGrid"><tr><td class="ewGridContent">
<div class="ewGridMiddlePanel">
<table cellspacing="0" class="ewTable ewTableSeparate">
<?php echo $sis_producto->TableCustomInnerHtml ?>
	<thead>
	<tr class="ewTableHeader">
		<td valign="top"><?php echo $sis_producto->ID_PRODUCTO->FldCaption() ?></td>
		<td valign="top"><?php echo $sis_producto->NOM_PRODUCTO->FldCaption() ?></td>
		<td valign="top"><?php echo $sis_producto->DES_PRODUCTO->FldCaption() ?></td>
	</tr>
	</thead>
	<tbody>
<?php
$sis_producto_delete->RecCnt = 0;
$i = 0;
while (!$sis_producto_delete->Recordset->EOF) {
	$sis_producto_delete->RecCnt++;

	// Set row properties
	$sis_producto->ResetAttrs();
	$sis_producto->RowType = EW_ROWTYPE_VIEW; // View

	// Get the field contents
	$sis_producto_delete->LoadRowValues($sis_producto_delete->Recordset);

	// Render row
	$sis_producto_delete->RenderRow();
?>
	<tr<?php echo $sis_producto->RowAttributes() ?>>
		<td<?php echo $sis_producto->ID_PRODUCTO->CellAttributes() ?>>
<div<?php echo $sis_producto->ID_PRODUCTO->ViewAttributes() ?>><?php echo $sis_producto->ID_PRODUCTO->ListViewValue() ?></div></td>
		<td<?php echo $sis_producto->NOM_PRODUCTO->CellAttributes() ?>>
<div<?php echo $sis_producto->NOM_PRODUCTO->ViewAttributes() ?>><?php echo $sis_producto->NOM_PRODUCTO->ListViewValue() ?></div></td>
		<td<?php echo $sis_producto->DES_PRODUCTO->CellAttributes() ?>>
<div<?php echo $sis_producto->DES_PRODUCTO->ViewAttributes() ?>><?php echo $sis_producto->DES_PRODUCTO->ListViewValue() ?></div></td>
	</tr>
<?php
	$sis_producto_delete->Recordset->MoveNext();
}
$sis_producto_delete->Recordset->Close();
?>
</tbody>
</table>
</div>
</td></tr></table>
<p>
<input type="submit" name="Action" id="Action" value="<?php echo ew_BtnCaption($Language->Phrase("DeleteBtn")) ?>">
</form>
<?php
$sis_producto_delete->ShowPageFooter();
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
$sis_producto_delete->Page_Terminate();
?>
<?php

//
// Page class
//
class csis_producto_delete {

	// Page ID
	var $PageID = 'delete';

	// Table name
	var $TableName = 'sis_producto';

	// Page object name
	var $PageObjName = 'sis_producto_delete';

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
	function csis_producto_delete() {
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
			define("EW_PAGE_ID", 'delete', TRUE);

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
		global $Language, $sis_producto;

		// Load key parameters
		$this->RecKeys = $sis_producto->GetRecordKeys(); // Load record keys
		$sFilter = $sis_producto->GetKeyFilter();
		if ($sFilter == "")
			$this->Page_Terminate("sis_productolist.jsp"); // Prevent SQL injection, return to list

		// Set up filter (SQL WHHERE clause) and get return SQL
		// SQL constructor in sis_producto class, sis_productoinfo.php

		$sis_producto->CurrentFilter = $sFilter;

		// Get action
		if (@$_POST["a_delete"] <> "") {
			$sis_producto->CurrentAction = $_POST["a_delete"];
		} else {
			$sis_producto->CurrentAction = "I"; // Display record
		}
		switch ($sis_producto->CurrentAction) {
			case "D": // Delete
				$sis_producto->SendEmail = TRUE; // Send email on delete success
				if ($this->DeleteRows()) { // delete rows
					$this->setSuccessMessage($Language->Phrase("DeleteSuccess")); // Set up success message
					$this->Page_Terminate($sis_producto->getReturnUrl()); // Return to caller
				}
		}
	}

// No functions
	// Load recordset
	function LoadRecordset($offset = -1, $rowcnt = -1) {
		global $conn, $sis_producto;

		// Call Recordset Selecting event
		$sis_producto->Recordset_Selecting($sis_producto->CurrentFilter);

		// Load List page SQL
		$sSql = $sis_producto->SelectSQL();
		if ($offset > -1 && $rowcnt > -1)
			$sSql .= " LIMIT $rowcnt OFFSET $offset";

		// Load recordset
		$rs = ew_LoadRecordset($sSql);

		// Call Recordset Selected event
		$sis_producto->Recordset_Selected($rs);
		return $rs;
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

	//
	// Delete records based on current filter
	//
	function DeleteRows() {
		global $conn, $Language, $Security, $sis_producto;
		$DeleteRows = TRUE;
		$sSql = $sis_producto->SQL();
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
				$DeleteRows = $sis_producto->Row_Deleting($row);
				if (!$DeleteRows) break;
			}
		}
		if ($DeleteRows) {
			$sKey = "";
			foreach ($rsold as $row) {
				$sThisKey = "";
				if ($sThisKey <> "") $sThisKey .= EW_COMPOSITE_KEY_SEPARATOR;
				$sThisKey .= $row['ID_PRODUCTO'];
				$conn->raiseErrorFn = 'ew_ErrorFn';
				$DeleteRows = $conn->Execute($sis_producto->DeleteSQL($row)); // Delete
				$conn->raiseErrorFn = '';
				if ($DeleteRows === FALSE)
					break;
				if ($sKey <> "") $sKey .= ", ";
				$sKey .= $sThisKey;
			}
		} else {

			// Set up error message
			if ($sis_producto->CancelMessage <> "") {
				$this->setFailureMessage($sis_producto->CancelMessage);
				$sis_producto->CancelMessage = "";
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
				$sis_producto->Row_Deleted($row);
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
