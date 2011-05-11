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
$sec_perfil_list = new csec_perfil_list();
$Page =& $sec_perfil_list;

// Page init
$sec_perfil_list->Page_Init();

// Page main
$sec_perfil_list->Page_Main();
?>
<?php include_once "header.jsp" ?>
<?php if ($sec_perfil->Export == "") { ?>
<script type="text/javascript">
<!--

// Create page object
var sec_perfil_list = new ew_Page("sec_perfil_list");

// page properties
sec_perfil_list.PageID = "list"; // page ID
sec_perfil_list.FormID = "fsec_perfillist"; // form ID
var EW_PAGE_ID = sec_perfil_list.PageID; // for backward compatibility

// extend page with Form_CustomValidate function
sec_perfil_list.Form_CustomValidate =  
 function(fobj) { // DO NOT CHANGE THIS LINE!

 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
<?php if (EW_CLIENT_VALIDATE) { ?>
sec_perfil_list.ValidateRequired = true; // uses JavaScript validation
<?php } else { ?>
sec_perfil_list.ValidateRequired = false; // no JavaScript validation
<?php } ?>

//-->
</script>
<script language="JavaScript" type="text/javascript">
<!--

// Write your client script here, no need to add script tags.
//-->

</script>
<?php } ?>
<?php if (($sec_perfil->Export == "") || (EW_EXPORT_MASTER_RECORD && $sec_perfil->Export == "print")) { ?>
<?php } ?>
<?php $sec_perfil_list->ShowPageHeader(); ?>
<?php
	$bSelectLimit = EW_SELECT_LIMIT;
	if ($bSelectLimit) {
		$sec_perfil_list->TotalRecs = $sec_perfil->SelectRecordCount();
	} else {
		if ($sec_perfil_list->Recordset = $sec_perfil_list->LoadRecordset())
			$sec_perfil_list->TotalRecs = $sec_perfil_list->Recordset->RecordCount();
	}
	$sec_perfil_list->StartRec = 1;
	if ($sec_perfil_list->DisplayRecs <= 0 || ($sec_perfil->Export <> "" && $sec_perfil->ExportAll)) // Display all records
		$sec_perfil_list->DisplayRecs = $sec_perfil_list->TotalRecs;
	if (!($sec_perfil->Export <> "" && $sec_perfil->ExportAll))
		$sec_perfil_list->SetUpStartRec(); // Set up start record position
	if ($bSelectLimit)
		$sec_perfil_list->Recordset = $sec_perfil_list->LoadRecordset($sec_perfil_list->StartRec-1, $sec_perfil_list->DisplayRecs);
?>
<p class="phpmaker ewTitle" style="white-space: nowrap;"><?php echo $Language->Phrase("TblTypeTABLE") ?><?php echo $sec_perfil->TableCaption() ?>
&nbsp;&nbsp;<?php $sec_perfil_list->ExportOptions->Render("body"); ?>
</p>
<?php if ($sec_perfil->Export == "" && $sec_perfil->CurrentAction == "") { ?>
<a href="javascript:ew_ToggleSearchPanel(sec_perfil_list);" style="text-decoration: none;"><img id="sec_perfil_list_SearchImage" src="phpimages/collapse.gif" alt="" width="9" height="9" border="0"></a><span class="phpmaker">&nbsp;<?php echo $Language->Phrase("Search") ?></span><br>
<div id="sec_perfil_list_SearchPanel">
<form name="fsec_perfillistsrch" id="fsec_perfillistsrch" class="ewForm" action="<?php echo ew_CurrentPage() ?>">
<input type="hidden" id="t" name="t" value="sec_perfil">
<div class="ewBasicSearch">
<div id="xsr_1" class="ewCssTableRow">
	<input type="text" name="<?php echo EW_TABLE_BASIC_SEARCH ?>" id="<?php echo EW_TABLE_BASIC_SEARCH ?>" size="20" value="<?php echo ew_HtmlEncode($sec_perfil->getSessionBasicSearchKeyword()) ?>">
	<input type="Submit" name="Submit" id="Submit" value="<?php echo ew_BtnCaption($Language->Phrase("QuickSearchBtn")) ?>">&nbsp;
	<a href="<?php echo $sec_perfil_list->PageUrl() ?>cmd=reset"><?php echo $Language->Phrase("ShowAll") ?></a>&nbsp;
</div>
<div id="xsr_2" class="ewCssTableRow">
	<label><input type="radio" name="<?php echo EW_TABLE_BASIC_SEARCH_TYPE ?>" id="<?php echo EW_TABLE_BASIC_SEARCH_TYPE ?>" value=""<?php if ($sec_perfil->getSessionBasicSearchType() == "") { ?> checked="checked"<?php } ?>><?php echo $Language->Phrase("ExactPhrase") ?></label>&nbsp;&nbsp;<label><input type="radio" name="<?php echo EW_TABLE_BASIC_SEARCH_TYPE ?>" id="<?php echo EW_TABLE_BASIC_SEARCH_TYPE ?>" value="AND"<?php if ($sec_perfil->getSessionBasicSearchType() == "AND") { ?> checked="checked"<?php } ?>><?php echo $Language->Phrase("AllWord") ?></label>&nbsp;&nbsp;<label><input type="radio" name="<?php echo EW_TABLE_BASIC_SEARCH_TYPE ?>" id="<?php echo EW_TABLE_BASIC_SEARCH_TYPE ?>" value="OR"<?php if ($sec_perfil->getSessionBasicSearchType() == "OR") { ?> checked="checked"<?php } ?>><?php echo $Language->Phrase("AnyWord") ?></label>
</div>
</div>
</form>
</div>
<?php } ?>
<?php
$sec_perfil_list->ShowMessage();
?>
<br>
<table cellspacing="0" class="ewGrid"><tr><td class="ewGridContent">
<form name="fsec_perfillist" id="fsec_perfillist" class="ewForm" action="" method="post">
<input type="hidden" name="t" id="t" value="sec_perfil">
<div id="gmp_sec_perfil" class="ewGridMiddlePanel">
<?php if ($sec_perfil_list->TotalRecs > 0) { ?>
<table cellspacing="0" data-rowhighlightclass="ewTableHighlightRow" data-rowselectclass="ewTableSelectRow" data-roweditclass="ewTableEditRow" class="ewTable ewTableSeparate">
<?php echo $sec_perfil->TableCustomInnerHtml ?>
<thead><!-- Table header -->
	<tr class="ewTableHeader">
<?php

// Render list options
$sec_perfil_list->RenderListOptions();

// Render list options (header, left)
$sec_perfil_list->ListOptions->Render("header", "left");
?>
<?php if ($sec_perfil->ID_PERFIL->Visible) { // ID_PERFIL ?>
	<?php if ($sec_perfil->SortUrl($sec_perfil->ID_PERFIL) == "") { ?>
		<td><?php echo $sec_perfil->ID_PERFIL->FldCaption() ?></td>
	<?php } else { ?>
		<td><div class="ewPointer" onmousedown="ew_Sort(event,'<?php echo $sec_perfil->SortUrl($sec_perfil->ID_PERFIL) ?>',1);">
			<table cellspacing="0" class="ewTableHeaderBtn"><thead><tr><td><?php echo $sec_perfil->ID_PERFIL->FldCaption() ?></td><td style="width: 10px;"><?php if ($sec_perfil->ID_PERFIL->getSort() == "ASC") { ?><img src="phpimages/sortup.gif" width="10" height="9" border="0"><?php } elseif ($sec_perfil->ID_PERFIL->getSort() == "DESC") { ?><img src="phpimages/sortdown.gif" width="10" height="9" border="0"><?php } ?></td></tr></thead></table>
		</div></td>		
	<?php } ?>
<?php } ?>		
<?php if ($sec_perfil->DES_PERFIL->Visible) { // DES_PERFIL ?>
	<?php if ($sec_perfil->SortUrl($sec_perfil->DES_PERFIL) == "") { ?>
		<td><?php echo $sec_perfil->DES_PERFIL->FldCaption() ?></td>
	<?php } else { ?>
		<td><div class="ewPointer" onmousedown="ew_Sort(event,'<?php echo $sec_perfil->SortUrl($sec_perfil->DES_PERFIL) ?>',1);">
			<table cellspacing="0" class="ewTableHeaderBtn"><thead><tr><td><?php echo $sec_perfil->DES_PERFIL->FldCaption() ?><?php echo $Language->Phrase("SrchLegend") ?></td><td style="width: 10px;"><?php if ($sec_perfil->DES_PERFIL->getSort() == "ASC") { ?><img src="phpimages/sortup.gif" width="10" height="9" border="0"><?php } elseif ($sec_perfil->DES_PERFIL->getSort() == "DESC") { ?><img src="phpimages/sortdown.gif" width="10" height="9" border="0"><?php } ?></td></tr></thead></table>
		</div></td>		
	<?php } ?>
<?php } ?>		
<?php

// Render list options (header, right)
$sec_perfil_list->ListOptions->Render("header", "right");
?>
	</tr>
</thead>
<?php
if ($sec_perfil->ExportAll && $sec_perfil->Export <> "") {
	$sec_perfil_list->StopRec = $sec_perfil_list->TotalRecs;
} else {

	// Set the last record to display
	if ($sec_perfil_list->TotalRecs > $sec_perfil_list->StartRec + $sec_perfil_list->DisplayRecs - 1)
		$sec_perfil_list->StopRec = $sec_perfil_list->StartRec + $sec_perfil_list->DisplayRecs - 1;
	else
		$sec_perfil_list->StopRec = $sec_perfil_list->TotalRecs;
}
$sec_perfil_list->RecCnt = $sec_perfil_list->StartRec - 1;
if ($sec_perfil_list->Recordset && !$sec_perfil_list->Recordset->EOF) {
	$sec_perfil_list->Recordset->MoveFirst();
	if (!$bSelectLimit && $sec_perfil_list->StartRec > 1)
		$sec_perfil_list->Recordset->Move($sec_perfil_list->StartRec - 1);
} elseif (!$sec_perfil->AllowAddDeleteRow && $sec_perfil_list->StopRec == 0) {
	$sec_perfil_list->StopRec = $sec_perfil->GridAddRowCount;
}

// Initialize aggregate
$sec_perfil->RowType = EW_ROWTYPE_AGGREGATEINIT;
$sec_perfil->ResetAttrs();
$sec_perfil_list->RenderRow();
$sec_perfil_list->RowCnt = 0;
while ($sec_perfil_list->RecCnt < $sec_perfil_list->StopRec) {
	$sec_perfil_list->RecCnt++;
	if (intval($sec_perfil_list->RecCnt) >= intval($sec_perfil_list->StartRec)) {
		$sec_perfil_list->RowCnt++;

		// Set up key count
		$sec_perfil_list->KeyCount = $sec_perfil_list->RowIndex;

		// Init row class and style
		$sec_perfil->ResetAttrs();
		$sec_perfil->CssClass = "";
		$sec_perfil->RowAttrs = array('onmouseover'=>'ew_MouseOver(event, this);', 'onmouseout'=>'ew_MouseOut(event, this);', 'onclick'=>'ew_Click(event, this);');
		if (!empty($sec_perfil_list->RowIndex))
			$sec_perfil->RowAttrs = array_merge($sec_perfil->RowAttrs, array('data-rowindex'=>$sec_perfil_list->RowIndex, 'id'=>'r' . $sec_perfil_list->RowIndex . '_sec_perfil'));
		if ($sec_perfil->CurrentAction == "gridadd") {
			$sec_perfil_list->LoadDefaultValues(); // Load default values
		} else {
			$sec_perfil_list->LoadRowValues($sec_perfil_list->Recordset); // Load row values
		}
		$sec_perfil->RowType = EW_ROWTYPE_VIEW; // Render view

		// Render row
		$sec_perfil_list->RenderRow();

		// Render list options
		$sec_perfil_list->RenderListOptions();
?>
	<tr<?php echo $sec_perfil->RowAttributes() ?>>
<?php

// Render list options (body, left)
$sec_perfil_list->ListOptions->Render("body", "left");
?>
	<?php if ($sec_perfil->ID_PERFIL->Visible) { // ID_PERFIL ?>
		<td<?php echo $sec_perfil->ID_PERFIL->CellAttributes() ?>>
<div<?php echo $sec_perfil->ID_PERFIL->ViewAttributes() ?>><?php echo $sec_perfil->ID_PERFIL->ListViewValue() ?></div>
<a name="<?php echo $sec_perfil_list->PageObjName . "_row_" . $sec_perfil_list->RowCnt ?>" id="<?php echo $sec_perfil_list->PageObjName . "_row_" . $sec_perfil_list->RowCnt ?>"></a></td>
	<?php } ?>
	<?php if ($sec_perfil->DES_PERFIL->Visible) { // DES_PERFIL ?>
		<td<?php echo $sec_perfil->DES_PERFIL->CellAttributes() ?>>
<div<?php echo $sec_perfil->DES_PERFIL->ViewAttributes() ?>><?php echo $sec_perfil->DES_PERFIL->ListViewValue() ?></div>
</td>
	<?php } ?>
<?php

// Render list options (body, right)
$sec_perfil_list->ListOptions->Render("body", "right");
?>
	</tr>
<?php
	}
	if ($sec_perfil->CurrentAction <> "gridadd")
		$sec_perfil_list->Recordset->MoveNext();
}
?>
</tbody>
</table>
<?php } ?>
</div>
</form>
<?php

// Close recordset
if ($sec_perfil_list->Recordset)
	$sec_perfil_list->Recordset->Close();
?>
<?php if ($sec_perfil->Export == "") { ?>
<div class="ewGridLowerPanel">
<?php if ($sec_perfil->CurrentAction <> "gridadd" && $sec_perfil->CurrentAction <> "gridedit") { ?>
<form name="ewpagerform" id="ewpagerform" class="ewForm" action="<?php echo ew_CurrentPage() ?>">
<table border="0" cellspacing="0" cellpadding="0" class="ewPager">
	<tr>
		<td nowrap>
<?php if (!isset($sec_perfil_list->Pager)) $sec_perfil_list->Pager = new cPrevNextPager($sec_perfil_list->StartRec, $sec_perfil_list->DisplayRecs, $sec_perfil_list->TotalRecs) ?>
<?php if ($sec_perfil_list->Pager->RecordCount > 0) { ?>
	<table border="0" cellspacing="0" cellpadding="0"><tr><td><span class="phpmaker"><?php echo $Language->Phrase("Page") ?>&nbsp;</span></td>
<!--first page button-->
	<?php if ($sec_perfil_list->Pager->FirstButton->Enabled) { ?>
	<td><a href="<?php echo $sec_perfil_list->PageUrl() ?>start=<?php echo $sec_perfil_list->Pager->FirstButton->Start ?>"><img src="phpimages/first.gif" alt="<?php echo $Language->Phrase("PagerFirst") ?>" width="16" height="16" border="0"></a></td>
	<?php } else { ?>
	<td><img src="phpimages/firstdisab.gif" alt="<?php echo $Language->Phrase("PagerFirst") ?>" width="16" height="16" border="0"></td>
	<?php } ?>
<!--previous page button-->
	<?php if ($sec_perfil_list->Pager->PrevButton->Enabled) { ?>
	<td><a href="<?php echo $sec_perfil_list->PageUrl() ?>start=<?php echo $sec_perfil_list->Pager->PrevButton->Start ?>"><img src="phpimages/prev.gif" alt="<?php echo $Language->Phrase("PagerPrevious") ?>" width="16" height="16" border="0"></a></td>
	<?php } else { ?>
	<td><img src="phpimages/prevdisab.gif" alt="<?php echo $Language->Phrase("PagerPrevious") ?>" width="16" height="16" border="0"></td>
	<?php } ?>
<!--current page number-->
	<td><input type="text" name="<?php echo EW_TABLE_PAGE_NO ?>" id="<?php echo EW_TABLE_PAGE_NO ?>" value="<?php echo $sec_perfil_list->Pager->CurrentPage ?>" size="4"></td>
<!--next page button-->
	<?php if ($sec_perfil_list->Pager->NextButton->Enabled) { ?>
	<td><a href="<?php echo $sec_perfil_list->PageUrl() ?>start=<?php echo $sec_perfil_list->Pager->NextButton->Start ?>"><img src="phpimages/next.gif" alt="<?php echo $Language->Phrase("PagerNext") ?>" width="16" height="16" border="0"></a></td>	
	<?php } else { ?>
	<td><img src="phpimages/nextdisab.gif" alt="<?php echo $Language->Phrase("PagerNext") ?>" width="16" height="16" border="0"></td>
	<?php } ?>
<!--last page button-->
	<?php if ($sec_perfil_list->Pager->LastButton->Enabled) { ?>
	<td><a href="<?php echo $sec_perfil_list->PageUrl() ?>start=<?php echo $sec_perfil_list->Pager->LastButton->Start ?>"><img src="phpimages/last.gif" alt="<?php echo $Language->Phrase("PagerLast") ?>" width="16" height="16" border="0"></a></td>	
	<?php } else { ?>
	<td><img src="phpimages/lastdisab.gif" alt="<?php echo $Language->Phrase("PagerLast") ?>" width="16" height="16" border="0"></td>
	<?php } ?>
	<td><span class="phpmaker">&nbsp;<?php echo $Language->Phrase("of") ?>&nbsp;<?php echo $sec_perfil_list->Pager->PageCount ?></span></td>
	</tr></table>
	</td>	
	<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td>
	<span class="phpmaker"><?php echo $Language->Phrase("Record") ?>&nbsp;<?php echo $sec_perfil_list->Pager->FromIndex ?>&nbsp;<?php echo $Language->Phrase("To") ?>&nbsp;<?php echo $sec_perfil_list->Pager->ToIndex ?>&nbsp;<?php echo $Language->Phrase("Of") ?>&nbsp;<?php echo $sec_perfil_list->Pager->RecordCount ?></span>
<?php } else { ?>
	<?php if ($sec_perfil_list->SearchWhere == "0=101") { ?>
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
<a href="<?php echo $sec_perfil_list->AddUrl ?>"><?php echo $Language->Phrase("AddLink") ?></a>&nbsp;&nbsp;
</span>
</div>
<?php } ?>
</td></tr></table>
<?php if ($sec_perfil->Export == "" && $sec_perfil->CurrentAction == "") { ?>
<?php } ?>
<?php
$sec_perfil_list->ShowPageFooter();
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
$sec_perfil_list->Page_Terminate();
?>
<?php

//
// Page class
//
class csec_perfil_list {

	// Page ID
	var $PageID = 'list';

	// Table name
	var $TableName = 'sec_perfil';

	// Page object name
	var $PageObjName = 'sec_perfil_list';

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
	function csec_perfil_list() {
		global $conn, $Language;

		// Language object
		if (!isset($Language)) $Language = new cLanguage();

		// Table object (sec_perfil)
		if (!isset($GLOBALS["sec_perfil"])) {
			$GLOBALS["sec_perfil"] = new csec_perfil();
			$GLOBALS["Table"] =& $GLOBALS["sec_perfil"];
		}

		// Initialize URLs
		$this->ExportPrintUrl = $this->PageUrl() . "export=print";
		$this->ExportExcelUrl = $this->PageUrl() . "export=excel";
		$this->ExportWordUrl = $this->PageUrl() . "export=word";
		$this->ExportHtmlUrl = $this->PageUrl() . "export=html";
		$this->ExportXmlUrl = $this->PageUrl() . "export=xml";
		$this->ExportCsvUrl = $this->PageUrl() . "export=csv";
		$this->ExportPdfUrl = $this->PageUrl() . "export=pdf";
		$this->AddUrl = "sec_perfiladd.jsp";
		$this->InlineAddUrl = $this->PageUrl() . "a=add";
		$this->GridAddUrl = $this->PageUrl() . "a=gridadd";
		$this->GridEditUrl = $this->PageUrl() . "a=gridedit";
		$this->MultiDeleteUrl = "sec_perfildelete.jsp";
		$this->MultiUpdateUrl = "sec_perfilupdate.jsp";

		// Page ID
		if (!defined("EW_PAGE_ID"))
			define("EW_PAGE_ID", 'list', TRUE);

		// Table name (for backward compatibility)
		if (!defined("EW_TABLE_NAME"))
			define("EW_TABLE_NAME", 'sec_perfil', TRUE);

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
		global $sec_perfil;

		// Get grid add count
		$gridaddcnt = @$_GET[EW_TABLE_GRID_ADD_ROW_COUNT];
		if (is_numeric($gridaddcnt) && $gridaddcnt > 0)
			$sec_perfil->GridAddRowCount = $gridaddcnt;

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
		global $objForm, $Language, $gsFormError, $gsSearchError, $Security, $sec_perfil;

		// Search filters
		$sSrchAdvanced = ""; // Advanced search filter
		$sSrchBasic = ""; // Basic search filter
		$sFilter = "";
		if ($this->IsPageRequest()) { // Validate request

			// Handle reset command
			$this->ResetCmd();

			// Hide all options
			if ($sec_perfil->Export <> "" ||
				$sec_perfil->CurrentAction == "gridadd" ||
				$sec_perfil->CurrentAction == "gridedit") {
				$this->ListOptions->HideAllOptions();
				$this->ExportOptions->HideAllOptions();
			}

			// Get basic search values
			$this->LoadBasicSearchValues();

			// Restore search parms from Session
			$this->RestoreSearchParms();

			// Call Recordset SearchValidated event
			$sec_perfil->Recordset_SearchValidated();

			// Set up sorting order
			$this->SetUpSortOrder();

			// Get basic search criteria
			if ($gsSearchError == "")
				$sSrchBasic = $this->BasicSearchWhere();
		}

		// Restore display records
		if ($sec_perfil->getRecordsPerPage() <> "") {
			$this->DisplayRecs = $sec_perfil->getRecordsPerPage(); // Restore from Session
		} else {
			$this->DisplayRecs = 20; // Load default
		}

		// Load Sorting Order
		$this->LoadSortOrder();

		// Build search criteria
		ew_AddFilter($this->SearchWhere, $sSrchAdvanced);
		ew_AddFilter($this->SearchWhere, $sSrchBasic);

		// Call Recordset_Searching event
		$sec_perfil->Recordset_Searching($this->SearchWhere);

		// Save search criteria
		if ($this->SearchWhere <> "") {
			if ($sSrchBasic == "")
				$this->ResetBasicSearchParms();
			$sec_perfil->setSearchWhere($this->SearchWhere); // Save to Session
			if (!$this->RestoreSearch) {
				$this->StartRec = 1; // Reset start record counter
				$sec_perfil->setStartRecordNumber($this->StartRec);
			}
		} else {
			$this->SearchWhere = $sec_perfil->getSearchWhere();
		}

		// Build filter
		$sFilter = "";
		ew_AddFilter($sFilter, $this->DbDetailFilter);
		ew_AddFilter($sFilter, $this->SearchWhere);

		// Set up filter in session
		$sec_perfil->setSessionWhere($sFilter);
		$sec_perfil->CurrentFilter = "";
	}

	// Return basic search SQL
	function BasicSearchSQL($Keyword) {
		global $sec_perfil;
		$sKeyword = ew_AdjustSql($Keyword);
		$sWhere = "";
		$this->BuildBasicSearchSQL($sWhere, $sec_perfil->DES_PERFIL, $Keyword);
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
		global $Security, $sec_perfil;
		$sSearchStr = "";
		$sSearchKeyword = $sec_perfil->BasicSearchKeyword;
		$sSearchType = $sec_perfil->BasicSearchType;
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
			$sec_perfil->setSessionBasicSearchKeyword($sSearchKeyword);
			$sec_perfil->setSessionBasicSearchType($sSearchType);
		}
		return $sSearchStr;
	}

	// Clear all search parameters
	function ResetSearchParms() {
		global $sec_perfil;

		// Clear search WHERE clause
		$this->SearchWhere = "";
		$sec_perfil->setSearchWhere($this->SearchWhere);

		// Clear basic search parameters
		$this->ResetBasicSearchParms();
	}

	// Clear all basic search parameters
	function ResetBasicSearchParms() {
		global $sec_perfil;
		$sec_perfil->setSessionBasicSearchKeyword("");
		$sec_perfil->setSessionBasicSearchType("");
	}

	// Restore all search parameters
	function RestoreSearchParms() {
		global $sec_perfil;
		$bRestore = TRUE;
		if (@$_GET[EW_TABLE_BASIC_SEARCH] <> "") $bRestore = FALSE;
		$this->RestoreSearch = $bRestore;
		if ($bRestore) {

			// Restore basic search values
			$sec_perfil->BasicSearchKeyword = $sec_perfil->getSessionBasicSearchKeyword();
			$sec_perfil->BasicSearchType = $sec_perfil->getSessionBasicSearchType();
		}
	}

	// Set up sort parameters
	function SetUpSortOrder() {
		global $sec_perfil;

		// Check for "order" parameter
		if (@$_GET["order"] <> "") {
			$sec_perfil->CurrentOrder = ew_StripSlashes(@$_GET["order"]);
			$sec_perfil->CurrentOrderType = @$_GET["ordertype"];
			$sec_perfil->UpdateSort($sec_perfil->ID_PERFIL); // ID_PERFIL
			$sec_perfil->UpdateSort($sec_perfil->DES_PERFIL); // DES_PERFIL
			$sec_perfil->setStartRecordNumber(1); // Reset start position
		}
	}

	// Load sort order parameters
	function LoadSortOrder() {
		global $sec_perfil;
		$sOrderBy = $sec_perfil->getSessionOrderBy(); // Get ORDER BY from Session
		if ($sOrderBy == "") {
			if ($sec_perfil->SqlOrderBy() <> "") {
				$sOrderBy = $sec_perfil->SqlOrderBy();
				$sec_perfil->setSessionOrderBy($sOrderBy);
			}
		}
	}

	// Reset command
	// cmd=reset (Reset search parameters)
	// cmd=resetall (Reset search and master/detail parameters)
	// cmd=resetsort (Reset sort parameters)
	function ResetCmd() {
		global $sec_perfil;

		// Get reset command
		if (@$_GET["cmd"] <> "") {
			$sCmd = $_GET["cmd"];

			// Reset search criteria
			if (strtolower($sCmd) == "reset" || strtolower($sCmd) == "resetall")
				$this->ResetSearchParms();

			// Reset sorting order
			if (strtolower($sCmd) == "resetsort") {
				$sOrderBy = "";
				$sec_perfil->setSessionOrderBy($sOrderBy);
				$sec_perfil->ID_PERFIL->setSort("");
				$sec_perfil->DES_PERFIL->setSort("");
			}

			// Reset start position
			$this->StartRec = 1;
			$sec_perfil->setStartRecordNumber($this->StartRec);
		}
	}

	// Set up list options
	function SetupListOptions() {
		global $Security, $Language, $sec_perfil;

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
		global $Security, $Language, $sec_perfil, $objForm;
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
		global $Security, $Language, $sec_perfil;
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

	// Load basic search values
	function LoadBasicSearchValues() {
		global $sec_perfil;
		$sec_perfil->BasicSearchKeyword = @$_GET[EW_TABLE_BASIC_SEARCH];
		$sec_perfil->BasicSearchType = @$_GET[EW_TABLE_BASIC_SEARCH_TYPE];
	}

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

	// Load old record
	function LoadOldRecord() {
		global $sec_perfil;

		// Load key values from Session
		$bValidKey = TRUE;
		if (strval($sec_perfil->getKey("ID_PERFIL")) <> "")
			$sec_perfil->ID_PERFIL->CurrentValue = $sec_perfil->getKey("ID_PERFIL"); // ID_PERFIL
		else
			$bValidKey = FALSE;

		// Load old recordset
		if ($bValidKey) {
			$sec_perfil->CurrentFilter = $sec_perfil->KeyFilter();
			$sSql = $sec_perfil->SQL();
			$this->OldRecordset = ew_LoadRecordset($sSql);
			$this->LoadRowValues($this->OldRecordset); // Load row values
		}
		return TRUE;
	}

	// Render row values based on field settings
	function RenderRow() {
		global $conn, $Security, $Language, $sec_perfil;

		// Initialize URLs
		$this->ViewUrl = $sec_perfil->ViewUrl();
		$this->EditUrl = $sec_perfil->EditUrl();
		$this->InlineEditUrl = $sec_perfil->InlineEditUrl();
		$this->CopyUrl = $sec_perfil->CopyUrl();
		$this->InlineCopyUrl = $sec_perfil->InlineCopyUrl();
		$this->DeleteUrl = $sec_perfil->DeleteUrl();

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
