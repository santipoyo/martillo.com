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
$sec_usuarios_list = new csec_usuarios_list();
$Page =& $sec_usuarios_list;

// Page init
$sec_usuarios_list->Page_Init();

// Page main
$sec_usuarios_list->Page_Main();
?>
<?php include_once "header.jsp" ?>
<?php if ($sec_usuarios->Export == "") { ?>
<script type="text/javascript">
<!--

// Create page object
var sec_usuarios_list = new ew_Page("sec_usuarios_list");

// page properties
sec_usuarios_list.PageID = "list"; // page ID
sec_usuarios_list.FormID = "fsec_usuarioslist"; // form ID
var EW_PAGE_ID = sec_usuarios_list.PageID; // for backward compatibility

// extend page with Form_CustomValidate function
sec_usuarios_list.Form_CustomValidate =  
 function(fobj) { // DO NOT CHANGE THIS LINE!

 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
<?php if (EW_CLIENT_VALIDATE) { ?>
sec_usuarios_list.ValidateRequired = true; // uses JavaScript validation
<?php } else { ?>
sec_usuarios_list.ValidateRequired = false; // no JavaScript validation
<?php } ?>

//-->
</script>
<script language="JavaScript" type="text/javascript">
<!--

// Write your client script here, no need to add script tags.
//-->

</script>
<?php } ?>
<?php if (($sec_usuarios->Export == "") || (EW_EXPORT_MASTER_RECORD && $sec_usuarios->Export == "print")) { ?>
<?php } ?>
<?php $sec_usuarios_list->ShowPageHeader(); ?>
<?php
	$bSelectLimit = EW_SELECT_LIMIT;
	if ($bSelectLimit) {
		$sec_usuarios_list->TotalRecs = $sec_usuarios->SelectRecordCount();
	} else {
		if ($sec_usuarios_list->Recordset = $sec_usuarios_list->LoadRecordset())
			$sec_usuarios_list->TotalRecs = $sec_usuarios_list->Recordset->RecordCount();
	}
	$sec_usuarios_list->StartRec = 1;
	if ($sec_usuarios_list->DisplayRecs <= 0 || ($sec_usuarios->Export <> "" && $sec_usuarios->ExportAll)) // Display all records
		$sec_usuarios_list->DisplayRecs = $sec_usuarios_list->TotalRecs;
	if (!($sec_usuarios->Export <> "" && $sec_usuarios->ExportAll))
		$sec_usuarios_list->SetUpStartRec(); // Set up start record position
	if ($bSelectLimit)
		$sec_usuarios_list->Recordset = $sec_usuarios_list->LoadRecordset($sec_usuarios_list->StartRec-1, $sec_usuarios_list->DisplayRecs);
?>
<p class="phpmaker ewTitle" style="white-space: nowrap;"><?php echo $Language->Phrase("TblTypeTABLE") ?><?php echo $sec_usuarios->TableCaption() ?>
&nbsp;&nbsp;<?php $sec_usuarios_list->ExportOptions->Render("body"); ?>
</p>
<?php if ($sec_usuarios->Export == "" && $sec_usuarios->CurrentAction == "") { ?>
<a href="javascript:ew_ToggleSearchPanel(sec_usuarios_list);" style="text-decoration: none;"><img id="sec_usuarios_list_SearchImage" src="phpimages/collapse.gif" alt="" width="9" height="9" border="0"></a><span class="phpmaker">&nbsp;<?php echo $Language->Phrase("Search") ?></span><br>
<div id="sec_usuarios_list_SearchPanel">
<form name="fsec_usuarioslistsrch" id="fsec_usuarioslistsrch" class="ewForm" action="<?php echo ew_CurrentPage() ?>">
<input type="hidden" id="t" name="t" value="sec_usuarios">
<div class="ewBasicSearch">
<div id="xsr_1" class="ewCssTableRow">
	<input type="text" name="<?php echo EW_TABLE_BASIC_SEARCH ?>" id="<?php echo EW_TABLE_BASIC_SEARCH ?>" size="20" value="<?php echo ew_HtmlEncode($sec_usuarios->getSessionBasicSearchKeyword()) ?>">
	<input type="Submit" name="Submit" id="Submit" value="<?php echo ew_BtnCaption($Language->Phrase("QuickSearchBtn")) ?>">&nbsp;
	<a href="<?php echo $sec_usuarios_list->PageUrl() ?>cmd=reset"><?php echo $Language->Phrase("ShowAll") ?></a>&nbsp;
</div>
<div id="xsr_2" class="ewCssTableRow">
	<label><input type="radio" name="<?php echo EW_TABLE_BASIC_SEARCH_TYPE ?>" id="<?php echo EW_TABLE_BASIC_SEARCH_TYPE ?>" value=""<?php if ($sec_usuarios->getSessionBasicSearchType() == "") { ?> checked="checked"<?php } ?>><?php echo $Language->Phrase("ExactPhrase") ?></label>&nbsp;&nbsp;<label><input type="radio" name="<?php echo EW_TABLE_BASIC_SEARCH_TYPE ?>" id="<?php echo EW_TABLE_BASIC_SEARCH_TYPE ?>" value="AND"<?php if ($sec_usuarios->getSessionBasicSearchType() == "AND") { ?> checked="checked"<?php } ?>><?php echo $Language->Phrase("AllWord") ?></label>&nbsp;&nbsp;<label><input type="radio" name="<?php echo EW_TABLE_BASIC_SEARCH_TYPE ?>" id="<?php echo EW_TABLE_BASIC_SEARCH_TYPE ?>" value="OR"<?php if ($sec_usuarios->getSessionBasicSearchType() == "OR") { ?> checked="checked"<?php } ?>><?php echo $Language->Phrase("AnyWord") ?></label>
</div>
</div>
</form>
</div>
<?php } ?>
<?php
$sec_usuarios_list->ShowMessage();
?>
<br>
<table cellspacing="0" class="ewGrid"><tr><td class="ewGridContent">
<form name="fsec_usuarioslist" id="fsec_usuarioslist" class="ewForm" action="" method="post">
<input type="hidden" name="t" id="t" value="sec_usuarios">
<div id="gmp_sec_usuarios" class="ewGridMiddlePanel">
<?php if ($sec_usuarios_list->TotalRecs > 0) { ?>
<table cellspacing="0" data-rowhighlightclass="ewTableHighlightRow" data-rowselectclass="ewTableSelectRow" data-roweditclass="ewTableEditRow" class="ewTable ewTableSeparate">
<?php echo $sec_usuarios->TableCustomInnerHtml ?>
<thead><!-- Table header -->
	<tr class="ewTableHeader">
<?php

// Render list options
$sec_usuarios_list->RenderListOptions();

// Render list options (header, left)
$sec_usuarios_list->ListOptions->Render("header", "left");
?>
<?php if ($sec_usuarios->ID_USUARIO->Visible) { // ID_USUARIO ?>
	<?php if ($sec_usuarios->SortUrl($sec_usuarios->ID_USUARIO) == "") { ?>
		<td><?php echo $sec_usuarios->ID_USUARIO->FldCaption() ?></td>
	<?php } else { ?>
		<td><div class="ewPointer" onmousedown="ew_Sort(event,'<?php echo $sec_usuarios->SortUrl($sec_usuarios->ID_USUARIO) ?>',1);">
			<table cellspacing="0" class="ewTableHeaderBtn"><thead><tr><td><?php echo $sec_usuarios->ID_USUARIO->FldCaption() ?></td><td style="width: 10px;"><?php if ($sec_usuarios->ID_USUARIO->getSort() == "ASC") { ?><img src="phpimages/sortup.gif" width="10" height="9" border="0"><?php } elseif ($sec_usuarios->ID_USUARIO->getSort() == "DESC") { ?><img src="phpimages/sortdown.gif" width="10" height="9" border="0"><?php } ?></td></tr></thead></table>
		</div></td>		
	<?php } ?>
<?php } ?>		
<?php if ($sec_usuarios->DES_USUARIO->Visible) { // DES_USUARIO ?>
	<?php if ($sec_usuarios->SortUrl($sec_usuarios->DES_USUARIO) == "") { ?>
		<td><?php echo $sec_usuarios->DES_USUARIO->FldCaption() ?></td>
	<?php } else { ?>
		<td><div class="ewPointer" onmousedown="ew_Sort(event,'<?php echo $sec_usuarios->SortUrl($sec_usuarios->DES_USUARIO) ?>',1);">
			<table cellspacing="0" class="ewTableHeaderBtn"><thead><tr><td><?php echo $sec_usuarios->DES_USUARIO->FldCaption() ?><?php echo $Language->Phrase("SrchLegend") ?></td><td style="width: 10px;"><?php if ($sec_usuarios->DES_USUARIO->getSort() == "ASC") { ?><img src="phpimages/sortup.gif" width="10" height="9" border="0"><?php } elseif ($sec_usuarios->DES_USUARIO->getSort() == "DESC") { ?><img src="phpimages/sortdown.gif" width="10" height="9" border="0"><?php } ?></td></tr></thead></table>
		</div></td>		
	<?php } ?>
<?php } ?>		
<?php

// Render list options (header, right)
$sec_usuarios_list->ListOptions->Render("header", "right");
?>
	</tr>
</thead>
<?php
if ($sec_usuarios->ExportAll && $sec_usuarios->Export <> "") {
	$sec_usuarios_list->StopRec = $sec_usuarios_list->TotalRecs;
} else {

	// Set the last record to display
	if ($sec_usuarios_list->TotalRecs > $sec_usuarios_list->StartRec + $sec_usuarios_list->DisplayRecs - 1)
		$sec_usuarios_list->StopRec = $sec_usuarios_list->StartRec + $sec_usuarios_list->DisplayRecs - 1;
	else
		$sec_usuarios_list->StopRec = $sec_usuarios_list->TotalRecs;
}
$sec_usuarios_list->RecCnt = $sec_usuarios_list->StartRec - 1;
if ($sec_usuarios_list->Recordset && !$sec_usuarios_list->Recordset->EOF) {
	$sec_usuarios_list->Recordset->MoveFirst();
	if (!$bSelectLimit && $sec_usuarios_list->StartRec > 1)
		$sec_usuarios_list->Recordset->Move($sec_usuarios_list->StartRec - 1);
} elseif (!$sec_usuarios->AllowAddDeleteRow && $sec_usuarios_list->StopRec == 0) {
	$sec_usuarios_list->StopRec = $sec_usuarios->GridAddRowCount;
}

// Initialize aggregate
$sec_usuarios->RowType = EW_ROWTYPE_AGGREGATEINIT;
$sec_usuarios->ResetAttrs();
$sec_usuarios_list->RenderRow();
$sec_usuarios_list->RowCnt = 0;
while ($sec_usuarios_list->RecCnt < $sec_usuarios_list->StopRec) {
	$sec_usuarios_list->RecCnt++;
	if (intval($sec_usuarios_list->RecCnt) >= intval($sec_usuarios_list->StartRec)) {
		$sec_usuarios_list->RowCnt++;

		// Set up key count
		$sec_usuarios_list->KeyCount = $sec_usuarios_list->RowIndex;

		// Init row class and style
		$sec_usuarios->ResetAttrs();
		$sec_usuarios->CssClass = "";
		$sec_usuarios->RowAttrs = array('onmouseover'=>'ew_MouseOver(event, this);', 'onmouseout'=>'ew_MouseOut(event, this);', 'onclick'=>'ew_Click(event, this);');
		if (!empty($sec_usuarios_list->RowIndex))
			$sec_usuarios->RowAttrs = array_merge($sec_usuarios->RowAttrs, array('data-rowindex'=>$sec_usuarios_list->RowIndex, 'id'=>'r' . $sec_usuarios_list->RowIndex . '_sec_usuarios'));
		if ($sec_usuarios->CurrentAction == "gridadd") {
			$sec_usuarios_list->LoadDefaultValues(); // Load default values
		} else {
			$sec_usuarios_list->LoadRowValues($sec_usuarios_list->Recordset); // Load row values
		}
		$sec_usuarios->RowType = EW_ROWTYPE_VIEW; // Render view

		// Render row
		$sec_usuarios_list->RenderRow();

		// Render list options
		$sec_usuarios_list->RenderListOptions();
?>
	<tr<?php echo $sec_usuarios->RowAttributes() ?>>
<?php

// Render list options (body, left)
$sec_usuarios_list->ListOptions->Render("body", "left");
?>
	<?php if ($sec_usuarios->ID_USUARIO->Visible) { // ID_USUARIO ?>
		<td<?php echo $sec_usuarios->ID_USUARIO->CellAttributes() ?>>
<div<?php echo $sec_usuarios->ID_USUARIO->ViewAttributes() ?>><?php echo $sec_usuarios->ID_USUARIO->ListViewValue() ?></div>
<a name="<?php echo $sec_usuarios_list->PageObjName . "_row_" . $sec_usuarios_list->RowCnt ?>" id="<?php echo $sec_usuarios_list->PageObjName . "_row_" . $sec_usuarios_list->RowCnt ?>"></a></td>
	<?php } ?>
	<?php if ($sec_usuarios->DES_USUARIO->Visible) { // DES_USUARIO ?>
		<td<?php echo $sec_usuarios->DES_USUARIO->CellAttributes() ?>>
<div<?php echo $sec_usuarios->DES_USUARIO->ViewAttributes() ?>><?php echo $sec_usuarios->DES_USUARIO->ListViewValue() ?></div>
</td>
	<?php } ?>
<?php

// Render list options (body, right)
$sec_usuarios_list->ListOptions->Render("body", "right");
?>
	</tr>
<?php
	}
	if ($sec_usuarios->CurrentAction <> "gridadd")
		$sec_usuarios_list->Recordset->MoveNext();
}
?>
</tbody>
</table>
<?php } ?>
</div>
</form>
<?php

// Close recordset
if ($sec_usuarios_list->Recordset)
	$sec_usuarios_list->Recordset->Close();
?>
<?php if ($sec_usuarios->Export == "") { ?>
<div class="ewGridLowerPanel">
<?php if ($sec_usuarios->CurrentAction <> "gridadd" && $sec_usuarios->CurrentAction <> "gridedit") { ?>
<form name="ewpagerform" id="ewpagerform" class="ewForm" action="<?php echo ew_CurrentPage() ?>">
<table border="0" cellspacing="0" cellpadding="0" class="ewPager">
	<tr>
		<td nowrap>
<?php if (!isset($sec_usuarios_list->Pager)) $sec_usuarios_list->Pager = new cPrevNextPager($sec_usuarios_list->StartRec, $sec_usuarios_list->DisplayRecs, $sec_usuarios_list->TotalRecs) ?>
<?php if ($sec_usuarios_list->Pager->RecordCount > 0) { ?>
	<table border="0" cellspacing="0" cellpadding="0"><tr><td><span class="phpmaker"><?php echo $Language->Phrase("Page") ?>&nbsp;</span></td>
<!--first page button-->
	<?php if ($sec_usuarios_list->Pager->FirstButton->Enabled) { ?>
	<td><a href="<?php echo $sec_usuarios_list->PageUrl() ?>start=<?php echo $sec_usuarios_list->Pager->FirstButton->Start ?>"><img src="phpimages/first.gif" alt="<?php echo $Language->Phrase("PagerFirst") ?>" width="16" height="16" border="0"></a></td>
	<?php } else { ?>
	<td><img src="phpimages/firstdisab.gif" alt="<?php echo $Language->Phrase("PagerFirst") ?>" width="16" height="16" border="0"></td>
	<?php } ?>
<!--previous page button-->
	<?php if ($sec_usuarios_list->Pager->PrevButton->Enabled) { ?>
	<td><a href="<?php echo $sec_usuarios_list->PageUrl() ?>start=<?php echo $sec_usuarios_list->Pager->PrevButton->Start ?>"><img src="phpimages/prev.gif" alt="<?php echo $Language->Phrase("PagerPrevious") ?>" width="16" height="16" border="0"></a></td>
	<?php } else { ?>
	<td><img src="phpimages/prevdisab.gif" alt="<?php echo $Language->Phrase("PagerPrevious") ?>" width="16" height="16" border="0"></td>
	<?php } ?>
<!--current page number-->
	<td><input type="text" name="<?php echo EW_TABLE_PAGE_NO ?>" id="<?php echo EW_TABLE_PAGE_NO ?>" value="<?php echo $sec_usuarios_list->Pager->CurrentPage ?>" size="4"></td>
<!--next page button-->
	<?php if ($sec_usuarios_list->Pager->NextButton->Enabled) { ?>
	<td><a href="<?php echo $sec_usuarios_list->PageUrl() ?>start=<?php echo $sec_usuarios_list->Pager->NextButton->Start ?>"><img src="phpimages/next.gif" alt="<?php echo $Language->Phrase("PagerNext") ?>" width="16" height="16" border="0"></a></td>	
	<?php } else { ?>
	<td><img src="phpimages/nextdisab.gif" alt="<?php echo $Language->Phrase("PagerNext") ?>" width="16" height="16" border="0"></td>
	<?php } ?>
<!--last page button-->
	<?php if ($sec_usuarios_list->Pager->LastButton->Enabled) { ?>
	<td><a href="<?php echo $sec_usuarios_list->PageUrl() ?>start=<?php echo $sec_usuarios_list->Pager->LastButton->Start ?>"><img src="phpimages/last.gif" alt="<?php echo $Language->Phrase("PagerLast") ?>" width="16" height="16" border="0"></a></td>	
	<?php } else { ?>
	<td><img src="phpimages/lastdisab.gif" alt="<?php echo $Language->Phrase("PagerLast") ?>" width="16" height="16" border="0"></td>
	<?php } ?>
	<td><span class="phpmaker">&nbsp;<?php echo $Language->Phrase("of") ?>&nbsp;<?php echo $sec_usuarios_list->Pager->PageCount ?></span></td>
	</tr></table>
	</td>	
	<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td>
	<span class="phpmaker"><?php echo $Language->Phrase("Record") ?>&nbsp;<?php echo $sec_usuarios_list->Pager->FromIndex ?>&nbsp;<?php echo $Language->Phrase("To") ?>&nbsp;<?php echo $sec_usuarios_list->Pager->ToIndex ?>&nbsp;<?php echo $Language->Phrase("Of") ?>&nbsp;<?php echo $sec_usuarios_list->Pager->RecordCount ?></span>
<?php } else { ?>
	<?php if ($sec_usuarios_list->SearchWhere == "0=101") { ?>
	<span class="phpmaker"><?php echo $Language->Phrase("EnterSearchCriteria") ?></span>
	<?php } else { ?>
	<span class="phpmaker"><?php echo $Language->Phrase("NoRecord") ?></span>
	<?php } ?>
<?php } ?>
		</td>
	</tr>
</table>
</form>
<?php } ?>
<span class="phpmaker">
<a href="<?php echo $sec_usuarios_list->AddUrl ?>"><?php echo $Language->Phrase("AddLink") ?></a>&nbsp;&nbsp;
</span>
</div>
<?php } ?>
</td></tr></table>
<?php if ($sec_usuarios->Export == "" && $sec_usuarios->CurrentAction == "") { ?>
<?php } ?>
<?php
$sec_usuarios_list->ShowPageFooter();
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
$sec_usuarios_list->Page_Terminate();
?>
<?php

//
// Page class
//
class csec_usuarios_list {

	// Page ID
	var $PageID = 'list';

	// Table name
	var $TableName = 'sec_usuarios';

	// Page object name
	var $PageObjName = 'sec_usuarios_list';

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
	function csec_usuarios_list() {
		global $conn, $Language;

		// Language object
		if (!isset($Language)) $Language = new cLanguage();

		// Table object (sec_usuarios)
		if (!isset($GLOBALS["sec_usuarios"])) {
			$GLOBALS["sec_usuarios"] = new csec_usuarios();
			$GLOBALS["Table"] =& $GLOBALS["sec_usuarios"];
		}

		// Initialize URLs
		$this->ExportPrintUrl = $this->PageUrl() . "export=print";
		$this->ExportExcelUrl = $this->PageUrl() . "export=excel";
		$this->ExportWordUrl = $this->PageUrl() . "export=word";
		$this->ExportHtmlUrl = $this->PageUrl() . "export=html";
		$this->ExportXmlUrl = $this->PageUrl() . "export=xml";
		$this->ExportCsvUrl = $this->PageUrl() . "export=csv";
		$this->ExportPdfUrl = $this->PageUrl() . "export=pdf";
		$this->AddUrl = "sec_usuariosadd.jsp";
		$this->InlineAddUrl = $this->PageUrl() . "a=add";
		$this->GridAddUrl = $this->PageUrl() . "a=gridadd";
		$this->GridEditUrl = $this->PageUrl() . "a=gridedit";
		$this->MultiDeleteUrl = "sec_usuariosdelete.jsp";
		$this->MultiUpdateUrl = "sec_usuariosupdate.jsp";

		// Page ID
		if (!defined("EW_PAGE_ID"))
			define("EW_PAGE_ID", 'list', TRUE);

		// Table name (for backward compatibility)
		if (!defined("EW_TABLE_NAME"))
			define("EW_TABLE_NAME", 'sec_usuarios', TRUE);

		// Start timer
		if (!isset($GLOBALS["gTimer"])) $GLOBALS["gTimer"] = new cTimer();

		// Open connection
		if (!isset($conn)) $conn = ew_Connect();

		// List options
		$this->ListOptions = new cListOptions();

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

		// Get grid add count
		$gridaddcnt = @$_GET[EW_TABLE_GRID_ADD_ROW_COUNT];
		if (is_numeric($gridaddcnt) && $gridaddcnt > 0)
			$sec_usuarios->GridAddRowCount = $gridaddcnt;

		// Set up list options
		$this->SetupListOptions();

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

	// Class variables
	var $ListOptions; // List options
	var $ExportOptions; // Export options
	var $DisplayRecs = 20;
	var $StartRec;
	var $StopRec;
	var $TotalRecs = 0;
	var $RecRange = 10;
	var $SearchWhere = ""; // Search WHERE clause
	var $RecCnt = 0; // Record count
	var $EditRowCnt;
	var $RowCnt;
	var $RowIndex = 0; // Row index
	var $KeyCount = 0; // Key count
	var $RowAction = ""; // Row action
	var $RecPerRow = 0;
	var $ColCnt = 0;
	var $DbMasterFilter = ""; // Master filter
	var $DbDetailFilter = ""; // Detail filter
	var $MasterRecordExists;	
	var $MultiSelectKey;
	var $RestoreSearch;
	var $Recordset;
	var $OldRecordset;

	//
	// Page main
	//
	function Page_Main() {
		global $objForm, $Language, $gsFormError, $gsSearchError, $Security, $sec_usuarios;

		// Search filters
		$sSrchAdvanced = ""; // Advanced search filter
		$sSrchBasic = ""; // Basic search filter
		$sFilter = "";
		if ($this->IsPageRequest()) { // Validate request

			// Handle reset command
			$this->ResetCmd();

			// Hide all options
			if ($sec_usuarios->Export <> "" ||
				$sec_usuarios->CurrentAction == "gridadd" ||
				$sec_usuarios->CurrentAction == "gridedit") {
				$this->ListOptions->HideAllOptions();
				$this->ExportOptions->HideAllOptions();
			}

			// Get basic search values
			$this->LoadBasicSearchValues();

			// Restore search parms from Session
			$this->RestoreSearchParms();

			// Call Recordset SearchValidated event
			$sec_usuarios->Recordset_SearchValidated();

			// Set up sorting order
			$this->SetUpSortOrder();

			// Get basic search criteria
			if ($gsSearchError == "")
				$sSrchBasic = $this->BasicSearchWhere();
		}

		// Restore display records
		if ($sec_usuarios->getRecordsPerPage() <> "") {
			$this->DisplayRecs = $sec_usuarios->getRecordsPerPage(); // Restore from Session
		} else {
			$this->DisplayRecs = 20; // Load default
		}

		// Load Sorting Order
		$this->LoadSortOrder();

		// Build search criteria
		ew_AddFilter($this->SearchWhere, $sSrchAdvanced);
		ew_AddFilter($this->SearchWhere, $sSrchBasic);

		// Call Recordset_Searching event
		$sec_usuarios->Recordset_Searching($this->SearchWhere);

		// Save search criteria
		if ($this->SearchWhere <> "") {
			if ($sSrchBasic == "")
				$this->ResetBasicSearchParms();
			$sec_usuarios->setSearchWhere($this->SearchWhere); // Save to Session
			if (!$this->RestoreSearch) {
				$this->StartRec = 1; // Reset start record counter
				$sec_usuarios->setStartRecordNumber($this->StartRec);
			}
		} else {
			$this->SearchWhere = $sec_usuarios->getSearchWhere();
		}

		// Build filter
		$sFilter = "";
		ew_AddFilter($sFilter, $this->DbDetailFilter);
		ew_AddFilter($sFilter, $this->SearchWhere);

		// Set up filter in session
		$sec_usuarios->setSessionWhere($sFilter);
		$sec_usuarios->CurrentFilter = "";
	}

	// Return basic search SQL
	function BasicSearchSQL($Keyword) {
		global $sec_usuarios;
		$sKeyword = ew_AdjustSql($Keyword);
		$sWhere = "";
		$this->BuildBasicSearchSQL($sWhere, $sec_usuarios->DES_USUARIO, $Keyword);
		return $sWhere;
	}

	// Build basic search SQL
	function BuildBasicSearchSql(&$Where, &$Fld, $Keyword) {
		$sFldExpression = ($Fld->FldVirtualExpression <> "") ? $Fld->FldVirtualExpression : $Fld->FldExpression;
		$lFldDataType = ($Fld->FldIsVirtual) ? EW_DATATYPE_STRING : $Fld->FldDataType;
		if ($lFldDataType == EW_DATATYPE_NUMBER) {
			$sWrk = $sFldExpression . " = " . ew_QuotedValue($Keyword, $lFldDataType);
		} else {
			$sWrk = $sFldExpression . ew_Like(ew_QuotedValue("%" . $Keyword . "%", $lFldDataType));
		}
		if ($Where <> "") $Where .= " OR ";
		$Where .= $sWrk;
	}

	// Return basic search WHERE clause based on search keyword and type
	function BasicSearchWhere() {
		global $Security, $sec_usuarios;
		$sSearchStr = "";
		$sSearchKeyword = $sec_usuarios->BasicSearchKeyword;
		$sSearchType = $sec_usuarios->BasicSearchType;
		if ($sSearchKeyword <> "") {
			$sSearch = trim($sSearchKeyword);
			if ($sSearchType <> "") {
				while (strpos($sSearch, "  ") !== FALSE)
					$sSearch = str_replace("  ", " ", $sSearch);
				$arKeyword = explode(" ", trim($sSearch));
				foreach ($arKeyword as $sKeyword) {
					if ($sSearchStr <> "") $sSearchStr .= " " . $sSearchType . " ";
					$sSearchStr .= "(" . $this->BasicSearchSQL($sKeyword) . ")";
				}
			} else {
				$sSearchStr = $this->BasicSearchSQL($sSearch);
			}
		}
		if ($sSearchKeyword <> "") {
			$sec_usuarios->setSessionBasicSearchKeyword($sSearchKeyword);
			$sec_usuarios->setSessionBasicSearchType($sSearchType);
		}
		return $sSearchStr;
	}

	// Clear all search parameters
	function ResetSearchParms() {
		global $sec_usuarios;

		// Clear search WHERE clause
		$this->SearchWhere = "";
		$sec_usuarios->setSearchWhere($this->SearchWhere);

		// Clear basic search parameters
		$this->ResetBasicSearchParms();
	}

	// Clear all basic search parameters
	function ResetBasicSearchParms() {
		global $sec_usuarios;
		$sec_usuarios->setSessionBasicSearchKeyword("");
		$sec_usuarios->setSessionBasicSearchType("");
	}

	// Restore all search parameters
	function RestoreSearchParms() {
		global $sec_usuarios;
		$bRestore = TRUE;
		if (@$_GET[EW_TABLE_BASIC_SEARCH] <> "") $bRestore = FALSE;
		$this->RestoreSearch = $bRestore;
		if ($bRestore) {

			// Restore basic search values
			$sec_usuarios->BasicSearchKeyword = $sec_usuarios->getSessionBasicSearchKeyword();
			$sec_usuarios->BasicSearchType = $sec_usuarios->getSessionBasicSearchType();
		}
	}

	// Set up sort parameters
	function SetUpSortOrder() {
		global $sec_usuarios;

		// Check for "order" parameter
		if (@$_GET["order"] <> "") {
			$sec_usuarios->CurrentOrder = ew_StripSlashes(@$_GET["order"]);
			$sec_usuarios->CurrentOrderType = @$_GET["ordertype"];
			$sec_usuarios->UpdateSort($sec_usuarios->ID_USUARIO); // ID_USUARIO
			$sec_usuarios->UpdateSort($sec_usuarios->DES_USUARIO); // DES_USUARIO
			$sec_usuarios->setStartRecordNumber(1); // Reset start position
		}
	}

	// Load sort order parameters
	function LoadSortOrder() {
		global $sec_usuarios;
		$sOrderBy = $sec_usuarios->getSessionOrderBy(); // Get ORDER BY from Session
		if ($sOrderBy == "") {
			if ($sec_usuarios->SqlOrderBy() <> "") {
				$sOrderBy = $sec_usuarios->SqlOrderBy();
				$sec_usuarios->setSessionOrderBy($sOrderBy);
			}
		}
	}

	// Reset command
	// cmd=reset (Reset search parameters)
	// cmd=resetall (Reset search and master/detail parameters)
	// cmd=resetsort (Reset sort parameters)
	function ResetCmd() {
		global $sec_usuarios;

		// Get reset command
		if (@$_GET["cmd"] <> "") {
			$sCmd = $_GET["cmd"];

			// Reset search criteria
			if (strtolower($sCmd) == "reset" || strtolower($sCmd) == "resetall")
				$this->ResetSearchParms();

			// Reset sorting order
			if (strtolower($sCmd) == "resetsort") {
				$sOrderBy = "";
				$sec_usuarios->setSessionOrderBy($sOrderBy);
				$sec_usuarios->ID_USUARIO->setSort("");
				$sec_usuarios->DES_USUARIO->setSort("");
			}

			// Reset start position
			$this->StartRec = 1;
			$sec_usuarios->setStartRecordNumber($this->StartRec);
		}
	}

	// Set up list options
	function SetupListOptions() {
		global $Security, $Language, $sec_usuarios;

		// "view"
		$item =& $this->ListOptions->Add("view");
		$item->CssStyle = "white-space: nowrap;";
		$item->Visible = TRUE;
		$item->OnLeft = FALSE;

		// "edit"
		$item =& $this->ListOptions->Add("edit");
		$item->CssStyle = "white-space: nowrap;";
		$item->Visible = TRUE;
		$item->OnLeft = FALSE;

		// "copy"
		$item =& $this->ListOptions->Add("copy");
		$item->CssStyle = "white-space: nowrap;";
		$item->Visible = TRUE;
		$item->OnLeft = FALSE;

		// "delete"
		$item =& $this->ListOptions->Add("delete");
		$item->CssStyle = "white-space: nowrap;";
		$item->Visible = TRUE;
		$item->OnLeft = FALSE;

		// Call ListOptions_Load event
		$this->ListOptions_Load();
	}

	// Render list options
	function RenderListOptions() {
		global $Security, $Language, $sec_usuarios, $objForm;
		$this->ListOptions->LoadDefault();

		// "view"
		$oListOpt =& $this->ListOptions->Items["view"];
		if ($oListOpt->Visible)
			$oListOpt->Body = "<a href=\"" . $this->ViewUrl . "\">" . $Language->Phrase("ViewLink") . "</a>";

		// "edit"
		$oListOpt =& $this->ListOptions->Items["edit"];
		if ($oListOpt->Visible) {
			$oListOpt->Body = "<a href=\"" . $this->EditUrl . "\">" . $Language->Phrase("EditLink") . "</a>";
		}

		// "copy"
		$oListOpt =& $this->ListOptions->Items["copy"];
		if ($oListOpt->Visible) {
			$oListOpt->Body = "<a href=\"" . $this->CopyUrl . "\">" . $Language->Phrase("CopyLink") . "</a>";
		}

		// "delete"
		$oListOpt =& $this->ListOptions->Items["delete"];
		if ($oListOpt->Visible)
			$oListOpt->Body = "<a" . "" . " href=\"" . $this->DeleteUrl . "\">" . $Language->Phrase("DeleteLink") . "</a>";
		$this->RenderListOptionsExt();

		// Call ListOptions_Rendered event
		$this->ListOptions_Rendered();
	}

	function RenderListOptionsExt() {
		global $Security, $Language, $sec_usuarios;
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

	// Load basic search values
	function LoadBasicSearchValues() {
		global $sec_usuarios;
		$sec_usuarios->BasicSearchKeyword = @$_GET[EW_TABLE_BASIC_SEARCH];
		$sec_usuarios->BasicSearchType = @$_GET[EW_TABLE_BASIC_SEARCH_TYPE];
	}

	// Load recordset
	function LoadRecordset($offset = -1, $rowcnt = -1) {
		global $conn, $sec_usuarios;

		// Call Recordset Selecting event
		$sec_usuarios->Recordset_Selecting($sec_usuarios->CurrentFilter);

		// Load List page SQL
		$sSql = $sec_usuarios->SelectSQL();
		if ($offset > -1 && $rowcnt > -1)
			$sSql .= " LIMIT $rowcnt OFFSET $offset";

		// Load recordset
		$rs = ew_LoadRecordset($sSql);

		// Call Recordset Selected event
		$sec_usuarios->Recordset_Selected($rs);
		return $rs;
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

	// Load old record
	function LoadOldRecord() {
		global $sec_usuarios;

		// Load key values from Session
		$bValidKey = TRUE;
		if (strval($sec_usuarios->getKey("ID_USUARIO")) <> "")
			$sec_usuarios->ID_USUARIO->CurrentValue = $sec_usuarios->getKey("ID_USUARIO"); // ID_USUARIO
		else
			$bValidKey = FALSE;

		// Load old recordset
		if ($bValidKey) {
			$sec_usuarios->CurrentFilter = $sec_usuarios->KeyFilter();
			$sSql = $sec_usuarios->SQL();
			$this->OldRecordset = ew_LoadRecordset($sSql);
			$this->LoadRowValues($this->OldRecordset); // Load row values
		}
		return TRUE;
	}

	// Render row values based on field settings
	function RenderRow() {
		global $conn, $Security, $Language, $sec_usuarios;

		// Initialize URLs
		$this->ViewUrl = $sec_usuarios->ViewUrl();
		$this->EditUrl = $sec_usuarios->EditUrl();
		$this->InlineEditUrl = $sec_usuarios->InlineEditUrl();
		$this->CopyUrl = $sec_usuarios->CopyUrl();
		$this->InlineCopyUrl = $sec_usuarios->InlineCopyUrl();
		$this->DeleteUrl = $sec_usuarios->DeleteUrl();

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

	// Form Custom Validate event
	function Form_CustomValidate(&$CustomError) {

		// Return error message in CustomError
		return TRUE;
	}

	// ListOptions Load event
	function ListOptions_Load() {

		// Example:
		//$opt =& $this->ListOptions->Add("new");
		//$opt->Header = "xxx";
		//$opt->OnLeft = TRUE; // Link on left
		//$opt->MoveTo(0); // Move to first column

	}

	// ListOptions Rendered event
	function ListOptions_Rendered() {

		// Example: 
		//$this->ListOptions->Items["new"]->Body = "xxx";

	}
}
?>
