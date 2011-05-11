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
$sis_producto_list = new csis_producto_list();
$Page =& $sis_producto_list;

// Page init
$sis_producto_list->Page_Init();

// Page main
$sis_producto_list->Page_Main();
?>
<?php include_once "header.jsp" ?>
<?php if ($sis_producto->Export == "") { ?>
<script type="text/javascript">
<!--

// Create page object
var sis_producto_list = new ew_Page("sis_producto_list");

// page properties
sis_producto_list.PageID = "list"; // page ID
sis_producto_list.FormID = "fsis_productolist"; // form ID
var EW_PAGE_ID = sis_producto_list.PageID; // for backward compatibility

// extend page with Form_CustomValidate function
sis_producto_list.Form_CustomValidate =  
 function(fobj) { // DO NOT CHANGE THIS LINE!

 	// Your custom validation code here, return false if invalid. 
 	return true;
 }
<?php if (EW_CLIENT_VALIDATE) { ?>
sis_producto_list.ValidateRequired = true; // uses JavaScript validation
<?php } else { ?>
sis_producto_list.ValidateRequired = false; // no JavaScript validation
<?php } ?>

//-->
</script>
<script language="JavaScript" type="text/javascript">
<!--

// Write your client script here, no need to add script tags.
//-->

</script>
<?php } ?>
<?php if (($sis_producto->Export == "") || (EW_EXPORT_MASTER_RECORD && $sis_producto->Export == "print")) { ?>
<?php } ?>
<?php $sis_producto_list->ShowPageHeader(); ?>
<?php
	$bSelectLimit = EW_SELECT_LIMIT;
	if ($bSelectLimit) {
		$sis_producto_list->TotalRecs = $sis_producto->SelectRecordCount();
	} else {
		if ($sis_producto_list->Recordset = $sis_producto_list->LoadRecordset())
			$sis_producto_list->TotalRecs = $sis_producto_list->Recordset->RecordCount();
	}
	$sis_producto_list->StartRec = 1;
	if ($sis_producto_list->DisplayRecs <= 0 || ($sis_producto->Export <> "" && $sis_producto->ExportAll)) // Display all records
		$sis_producto_list->DisplayRecs = $sis_producto_list->TotalRecs;
	if (!($sis_producto->Export <> "" && $sis_producto->ExportAll))
		$sis_producto_list->SetUpStartRec(); // Set up start record position
	if ($bSelectLimit)
		$sis_producto_list->Recordset = $sis_producto_list->LoadRecordset($sis_producto_list->StartRec-1, $sis_producto_list->DisplayRecs);
?>
<p class="phpmaker ewTitle" style="white-space: nowrap;"><?php echo $Language->Phrase("TblTypeTABLE") ?><?php echo $sis_producto->TableCaption() ?>
&nbsp;&nbsp;<?php $sis_producto_list->ExportOptions->Render("body"); ?>
</p>
<?php if ($sis_producto->Export == "" && $sis_producto->CurrentAction == "") { ?>
<a href="javascript:ew_ToggleSearchPanel(sis_producto_list);" style="text-decoration: none;"><img id="sis_producto_list_SearchImage" src="phpimages/collapse.gif" alt="" width="9" height="9" border="0"></a><span class="phpmaker">&nbsp;<?php echo $Language->Phrase("Search") ?></span><br>
<div id="sis_producto_list_SearchPanel">
<form name="fsis_productolistsrch" id="fsis_productolistsrch" class="ewForm" action="<?php echo ew_CurrentPage() ?>">
<input type="hidden" id="t" name="t" value="sis_producto">
<div class="ewBasicSearch">
<div id="xsr_1" class="ewCssTableRow">
	<input type="text" name="<?php echo EW_TABLE_BASIC_SEARCH ?>" id="<?php echo EW_TABLE_BASIC_SEARCH ?>" size="20" value="<?php echo ew_HtmlEncode($sis_producto->getSessionBasicSearchKeyword()) ?>">
	<input type="Submit" name="Submit" id="Submit" value="<?php echo ew_BtnCaption($Language->Phrase("QuickSearchBtn")) ?>">&nbsp;
	<a href="<?php echo $sis_producto_list->PageUrl() ?>cmd=reset"><?php echo $Language->Phrase("ShowAll") ?></a>&nbsp;
</div>
<div id="xsr_2" class="ewCssTableRow">
	<label><input type="radio" name="<?php echo EW_TABLE_BASIC_SEARCH_TYPE ?>" id="<?php echo EW_TABLE_BASIC_SEARCH_TYPE ?>" value=""<?php if ($sis_producto->getSessionBasicSearchType() == "") { ?> checked="checked"<?php } ?>><?php echo $Language->Phrase("ExactPhrase") ?></label>&nbsp;&nbsp;<label><input type="radio" name="<?php echo EW_TABLE_BASIC_SEARCH_TYPE ?>" id="<?php echo EW_TABLE_BASIC_SEARCH_TYPE ?>" value="AND"<?php if ($sis_producto->getSessionBasicSearchType() == "AND") { ?> checked="checked"<?php } ?>><?php echo $Language->Phrase("AllWord") ?></label>&nbsp;&nbsp;<label><input type="radio" name="<?php echo EW_TABLE_BASIC_SEARCH_TYPE ?>" id="<?php echo EW_TABLE_BASIC_SEARCH_TYPE ?>" value="OR"<?php if ($sis_producto->getSessionBasicSearchType() == "OR") { ?> checked="checked"<?php } ?>><?php echo $Language->Phrase("AnyWord") ?></label>
</div>
</div>
</form>
</div>
<?php } ?>
<?php
$sis_producto_list->ShowMessage();
?>
<br>
<table cellspacing="0" class="ewGrid"><tr><td class="ewGridContent">
<form name="fsis_productolist" id="fsis_productolist" class="ewForm" action="" method="post">
<input type="hidden" name="t" id="t" value="sis_producto">
<div id="gmp_sis_producto" class="ewGridMiddlePanel">
<?php if ($sis_producto_list->TotalRecs > 0) { ?>
<table cellspacing="0" data-rowhighlightclass="ewTableHighlightRow" data-rowselectclass="ewTableSelectRow" data-roweditclass="ewTableEditRow" class="ewTable ewTableSeparate">
<?php echo $sis_producto->TableCustomInnerHtml ?>
<thead><!-- Table header -->
	<tr class="ewTableHeader">
<?php

// Render list options
$sis_producto_list->RenderListOptions();

// Render list options (header, left)
$sis_producto_list->ListOptions->Render("header", "left");
?>
<?php if ($sis_producto->ID_PRODUCTO->Visible) { // ID_PRODUCTO ?>
	<?php if ($sis_producto->SortUrl($sis_producto->ID_PRODUCTO) == "") { ?>
		<td><?php echo $sis_producto->ID_PRODUCTO->FldCaption() ?></td>
	<?php } else { ?>
		<td><div class="ewPointer" onmousedown="ew_Sort(event,'<?php echo $sis_producto->SortUrl($sis_producto->ID_PRODUCTO) ?>',1);">
			<table cellspacing="0" class="ewTableHeaderBtn"><thead><tr><td><?php echo $sis_producto->ID_PRODUCTO->FldCaption() ?></td><td style="width: 10px;"><?php if ($sis_producto->ID_PRODUCTO->getSort() == "ASC") { ?><img src="phpimages/sortup.gif" width="10" height="9" border="0"><?php } elseif ($sis_producto->ID_PRODUCTO->getSort() == "DESC") { ?><img src="phpimages/sortdown.gif" width="10" height="9" border="0"><?php } ?></td></tr></thead></table>
		</div></td>		
	<?php } ?>
<?php } ?>		
<?php if ($sis_producto->NOM_PRODUCTO->Visible) { // NOM_PRODUCTO ?>
	<?php if ($sis_producto->SortUrl($sis_producto->NOM_PRODUCTO) == "") { ?>
		<td><?php echo $sis_producto->NOM_PRODUCTO->FldCaption() ?></td>
	<?php } else { ?>
		<td><div class="ewPointer" onmousedown="ew_Sort(event,'<?php echo $sis_producto->SortUrl($sis_producto->NOM_PRODUCTO) ?>',1);">
			<table cellspacing="0" class="ewTableHeaderBtn"><thead><tr><td><?php echo $sis_producto->NOM_PRODUCTO->FldCaption() ?><?php echo $Language->Phrase("SrchLegend") ?></td><td style="width: 10px;"><?php if ($sis_producto->NOM_PRODUCTO->getSort() == "ASC") { ?><img src="phpimages/sortup.gif" width="10" height="9" border="0"><?php } elseif ($sis_producto->NOM_PRODUCTO->getSort() == "DESC") { ?><img src="phpimages/sortdown.gif" width="10" height="9" border="0"><?php } ?></td></tr></thead></table>
		</div></td>		
	<?php } ?>
<?php } ?>		
<?php if ($sis_producto->DES_PRODUCTO->Visible) { // DES_PRODUCTO ?>
	<?php if ($sis_producto->SortUrl($sis_producto->DES_PRODUCTO) == "") { ?>
		<td><?php echo $sis_producto->DES_PRODUCTO->FldCaption() ?></td>
	<?php } else { ?>
		<td><div class="ewPointer" onmousedown="ew_Sort(event,'<?php echo $sis_producto->SortUrl($sis_producto->DES_PRODUCTO) ?>',1);">
			<table cellspacing="0" class="ewTableHeaderBtn"><thead><tr><td><?php echo $sis_producto->DES_PRODUCTO->FldCaption() ?><?php echo $Language->Phrase("SrchLegend") ?></td><td style="width: 10px;"><?php if ($sis_producto->DES_PRODUCTO->getSort() == "ASC") { ?><img src="phpimages/sortup.gif" width="10" height="9" border="0"><?php } elseif ($sis_producto->DES_PRODUCTO->getSort() == "DESC") { ?><img src="phpimages/sortdown.gif" width="10" height="9" border="0"><?php } ?></td></tr></thead></table>
		</div></td>		
	<?php } ?>
<?php } ?>		
<?php

// Render list options (header, right)
$sis_producto_list->ListOptions->Render("header", "right");
?>
	</tr>
</thead>
<?php
if ($sis_producto->ExportAll && $sis_producto->Export <> "") {
	$sis_producto_list->StopRec = $sis_producto_list->TotalRecs;
} else {

	// Set the last record to display
	if ($sis_producto_list->TotalRecs > $sis_producto_list->StartRec + $sis_producto_list->DisplayRecs - 1)
		$sis_producto_list->StopRec = $sis_producto_list->StartRec + $sis_producto_list->DisplayRecs - 1;
	else
		$sis_producto_list->StopRec = $sis_producto_list->TotalRecs;
}
$sis_producto_list->RecCnt = $sis_producto_list->StartRec - 1;
if ($sis_producto_list->Recordset && !$sis_producto_list->Recordset->EOF) {
	$sis_producto_list->Recordset->MoveFirst();
	if (!$bSelectLimit && $sis_producto_list->StartRec > 1)
		$sis_producto_list->Recordset->Move($sis_producto_list->StartRec - 1);
} elseif (!$sis_producto->AllowAddDeleteRow && $sis_producto_list->StopRec == 0) {
	$sis_producto_list->StopRec = $sis_producto->GridAddRowCount;
}

// Initialize aggregate
$sis_producto->RowType = EW_ROWTYPE_AGGREGATEINIT;
$sis_producto->ResetAttrs();
$sis_producto_list->RenderRow();
$sis_producto_list->RowCnt = 0;
while ($sis_producto_list->RecCnt < $sis_producto_list->StopRec) {
	$sis_producto_list->RecCnt++;
	if (intval($sis_producto_list->RecCnt) >= intval($sis_producto_list->StartRec)) {
		$sis_producto_list->RowCnt++;

		// Set up key count
		$sis_producto_list->KeyCount = $sis_producto_list->RowIndex;

		// Init row class and style
		$sis_producto->ResetAttrs();
		$sis_producto->CssClass = "";
		$sis_producto->RowAttrs = array('onmouseover'=>'ew_MouseOver(event, this);', 'onmouseout'=>'ew_MouseOut(event, this);', 'onclick'=>'ew_Click(event, this);');
		if (!empty($sis_producto_list->RowIndex))
			$sis_producto->RowAttrs = array_merge($sis_producto->RowAttrs, array('data-rowindex'=>$sis_producto_list->RowIndex, 'id'=>'r' . $sis_producto_list->RowIndex . '_sis_producto'));
		if ($sis_producto->CurrentAction == "gridadd") {
			$sis_producto_list->LoadDefaultValues(); // Load default values
		} else {
			$sis_producto_list->LoadRowValues($sis_producto_list->Recordset); // Load row values
		}
		$sis_producto->RowType = EW_ROWTYPE_VIEW; // Render view

		// Render row
		$sis_producto_list->RenderRow();

		// Render list options
		$sis_producto_list->RenderListOptions();
?>
	<tr<?php echo $sis_producto->RowAttributes() ?>>
<?php

// Render list options (body, left)
$sis_producto_list->ListOptions->Render("body", "left");
?>
	<?php if ($sis_producto->ID_PRODUCTO->Visible) { // ID_PRODUCTO ?>
		<td<?php echo $sis_producto->ID_PRODUCTO->CellAttributes() ?>>
<div<?php echo $sis_producto->ID_PRODUCTO->ViewAttributes() ?>><?php echo $sis_producto->ID_PRODUCTO->ListViewValue() ?></div>
<a name="<?php echo $sis_producto_list->PageObjName . "_row_" . $sis_producto_list->RowCnt ?>" id="<?php echo $sis_producto_list->PageObjName . "_row_" . $sis_producto_list->RowCnt ?>"></a></td>
	<?php } ?>
	<?php if ($sis_producto->NOM_PRODUCTO->Visible) { // NOM_PRODUCTO ?>
		<td<?php echo $sis_producto->NOM_PRODUCTO->CellAttributes() ?>>
<div<?php echo $sis_producto->NOM_PRODUCTO->ViewAttributes() ?>><?php echo $sis_producto->NOM_PRODUCTO->ListViewValue() ?></div>
</td>
	<?php } ?>
	<?php if ($sis_producto->DES_PRODUCTO->Visible) { // DES_PRODUCTO ?>
		<td<?php echo $sis_producto->DES_PRODUCTO->CellAttributes() ?>>
<div<?php echo $sis_producto->DES_PRODUCTO->ViewAttributes() ?>><?php echo $sis_producto->DES_PRODUCTO->ListViewValue() ?></div>
</td>
	<?php } ?>
<?php

// Render list options (body, right)
$sis_producto_list->ListOptions->Render("body", "right");
?>
	</tr>
<?php
	}
	if ($sis_producto->CurrentAction <> "gridadd")
		$sis_producto_list->Recordset->MoveNext();
}
?>
</tbody>
</table>
<?php } ?>
</div>
</form>
<?php

// Close recordset
if ($sis_producto_list->Recordset)
	$sis_producto_list->Recordset->Close();
?>
<?php if ($sis_producto->Export == "") { ?>
<div class="ewGridLowerPanel">
<?php if ($sis_producto->CurrentAction <> "gridadd" && $sis_producto->CurrentAction <> "gridedit") { ?>
<form name="ewpagerform" id="ewpagerform" class="ewForm" action="<?php echo ew_CurrentPage() ?>">
<table border="0" cellspacing="0" cellpadding="0" class="ewPager">
	<tr>
		<td nowrap>
<?php if (!isset($sis_producto_list->Pager)) $sis_producto_list->Pager = new cPrevNextPager($sis_producto_list->StartRec, $sis_producto_list->DisplayRecs, $sis_producto_list->TotalRecs) ?>
<?php if ($sis_producto_list->Pager->RecordCount > 0) { ?>
	<table border="0" cellspacing="0" cellpadding="0"><tr><td><span class="phpmaker"><?php echo $Language->Phrase("Page") ?>&nbsp;</span></td>
<!--first page button-->
	<?php if ($sis_producto_list->Pager->FirstButton->Enabled) { ?>
	<td><a href="<?php echo $sis_producto_list->PageUrl() ?>start=<?php echo $sis_producto_list->Pager->FirstButton->Start ?>"><img src="phpimages/first.gif" alt="<?php echo $Language->Phrase("PagerFirst") ?>" width="16" height="16" border="0"></a></td>
	<?php } else { ?>
	<td><img src="phpimages/firstdisab.gif" alt="<?php echo $Language->Phrase("PagerFirst") ?>" width="16" height="16" border="0"></td>
	<?php } ?>
<!--previous page button-->
	<?php if ($sis_producto_list->Pager->PrevButton->Enabled) { ?>
	<td><a href="<?php echo $sis_producto_list->PageUrl() ?>start=<?php echo $sis_producto_list->Pager->PrevButton->Start ?>"><img src="phpimages/prev.gif" alt="<?php echo $Language->Phrase("PagerPrevious") ?>" width="16" height="16" border="0"></a></td>
	<?php } else { ?>
	<td><img src="phpimages/prevdisab.gif" alt="<?php echo $Language->Phrase("PagerPrevious") ?>" width="16" height="16" border="0"></td>
	<?php } ?>
<!--current page number-->
	<td><input type="text" name="<?php echo EW_TABLE_PAGE_NO ?>" id="<?php echo EW_TABLE_PAGE_NO ?>" value="<?php echo $sis_producto_list->Pager->CurrentPage ?>" size="4"></td>
<!--next page button-->
	<?php if ($sis_producto_list->Pager->NextButton->Enabled) { ?>
	<td><a href="<?php echo $sis_producto_list->PageUrl() ?>start=<?php echo $sis_producto_list->Pager->NextButton->Start ?>"><img src="phpimages/next.gif" alt="<?php echo $Language->Phrase("PagerNext") ?>" width="16" height="16" border="0"></a></td>	
	<?php } else { ?>
	<td><img src="phpimages/nextdisab.gif" alt="<?php echo $Language->Phrase("PagerNext") ?>" width="16" height="16" border="0"></td>
	<?php } ?>
<!--last page button-->
	<?php if ($sis_producto_list->Pager->LastButton->Enabled) { ?>
	<td><a href="<?php echo $sis_producto_list->PageUrl() ?>start=<?php echo $sis_producto_list->Pager->LastButton->Start ?>"><img src="phpimages/last.gif" alt="<?php echo $Language->Phrase("PagerLast") ?>" width="16" height="16" border="0"></a></td>	
	<?php } else { ?>
	<td><img src="phpimages/lastdisab.gif" alt="<?php echo $Language->Phrase("PagerLast") ?>" width="16" height="16" border="0"></td>
	<?php } ?>
	<td><span class="phpmaker">&nbsp;<?php echo $Language->Phrase("of") ?>&nbsp;<?php echo $sis_producto_list->Pager->PageCount ?></span></td>
	</tr></table>
	</td>	
	<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
	<td>
	<span class="phpmaker"><?php echo $Language->Phrase("Record") ?>&nbsp;<?php echo $sis_producto_list->Pager->FromIndex ?>&nbsp;<?php echo $Language->Phrase("To") ?>&nbsp;<?php echo $sis_producto_list->Pager->ToIndex ?>&nbsp;<?php echo $Language->Phrase("Of") ?>&nbsp;<?php echo $sis_producto_list->Pager->RecordCount ?></span>
<?php } else { ?>
	<?php if ($sis_producto_list->SearchWhere == "0=101") { ?>
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
<a href="<?php echo $sis_producto_list->AddUrl ?>"><?php echo $Language->Phrase("AddLink") ?></a>&nbsp;&nbsp;
</span>
</div>
<?php } ?>
</td></tr></table>
<?php if ($sis_producto->Export == "" && $sis_producto->CurrentAction == "") { ?>
<?php } ?>
<?php
$sis_producto_list->ShowPageFooter();
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
$sis_producto_list->Page_Terminate();
?>
<?php

//
// Page class
//
class csis_producto_list {

	// Page ID
	var $PageID = 'list';

	// Table name
	var $TableName = 'sis_producto';

	// Page object name
	var $PageObjName = 'sis_producto_list';

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
	function csis_producto_list() {
		global $conn, $Language;

		// Language object
		if (!isset($Language)) $Language = new cLanguage();

		// Table object (sis_producto)
		if (!isset($GLOBALS["sis_producto"])) {
			$GLOBALS["sis_producto"] = new csis_producto();
			$GLOBALS["Table"] =& $GLOBALS["sis_producto"];
		}

		// Initialize URLs
		$this->ExportPrintUrl = $this->PageUrl() . "export=print";
		$this->ExportExcelUrl = $this->PageUrl() . "export=excel";
		$this->ExportWordUrl = $this->PageUrl() . "export=word";
		$this->ExportHtmlUrl = $this->PageUrl() . "export=html";
		$this->ExportXmlUrl = $this->PageUrl() . "export=xml";
		$this->ExportCsvUrl = $this->PageUrl() . "export=csv";
		$this->ExportPdfUrl = $this->PageUrl() . "export=pdf";
		$this->AddUrl = "sis_productoadd.jsp";
		$this->InlineAddUrl = $this->PageUrl() . "a=add";
		$this->GridAddUrl = $this->PageUrl() . "a=gridadd";
		$this->GridEditUrl = $this->PageUrl() . "a=gridedit";
		$this->MultiDeleteUrl = "sis_productodelete.jsp";
		$this->MultiUpdateUrl = "sis_productoupdate.jsp";

		// Page ID
		if (!defined("EW_PAGE_ID"))
			define("EW_PAGE_ID", 'list', TRUE);

		// Table name (for backward compatibility)
		if (!defined("EW_TABLE_NAME"))
			define("EW_TABLE_NAME", 'sis_producto', TRUE);

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
		global $sis_producto;

		// Get grid add count
		$gridaddcnt = @$_GET[EW_TABLE_GRID_ADD_ROW_COUNT];
		if (is_numeric($gridaddcnt) && $gridaddcnt > 0)
			$sis_producto->GridAddRowCount = $gridaddcnt;

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
		global $objForm, $Language, $gsFormError, $gsSearchError, $Security, $sis_producto;

		// Search filters
		$sSrchAdvanced = ""; // Advanced search filter
		$sSrchBasic = ""; // Basic search filter
		$sFilter = "";
		if ($this->IsPageRequest()) { // Validate request

			// Handle reset command
			$this->ResetCmd();

			// Hide all options
			if ($sis_producto->Export <> "" ||
				$sis_producto->CurrentAction == "gridadd" ||
				$sis_producto->CurrentAction == "gridedit") {
				$this->ListOptions->HideAllOptions();
				$this->ExportOptions->HideAllOptions();
			}

			// Get basic search values
			$this->LoadBasicSearchValues();

			// Restore search parms from Session
			$this->RestoreSearchParms();

			// Call Recordset SearchValidated event
			$sis_producto->Recordset_SearchValidated();

			// Set up sorting order
			$this->SetUpSortOrder();

			// Get basic search criteria
			if ($gsSearchError == "")
				$sSrchBasic = $this->BasicSearchWhere();
		}

		// Restore display records
		if ($sis_producto->getRecordsPerPage() <> "") {
			$this->DisplayRecs = $sis_producto->getRecordsPerPage(); // Restore from Session
		} else {
			$this->DisplayRecs = 20; // Load default
		}

		// Load Sorting Order
		$this->LoadSortOrder();

		// Build search criteria
		ew_AddFilter($this->SearchWhere, $sSrchAdvanced);
		ew_AddFilter($this->SearchWhere, $sSrchBasic);

		// Call Recordset_Searching event
		$sis_producto->Recordset_Searching($this->SearchWhere);

		// Save search criteria
		if ($this->SearchWhere <> "") {
			if ($sSrchBasic == "")
				$this->ResetBasicSearchParms();
			$sis_producto->setSearchWhere($this->SearchWhere); // Save to Session
			if (!$this->RestoreSearch) {
				$this->StartRec = 1; // Reset start record counter
				$sis_producto->setStartRecordNumber($this->StartRec);
			}
		} else {
			$this->SearchWhere = $sis_producto->getSearchWhere();
		}

		// Build filter
		$sFilter = "";
		ew_AddFilter($sFilter, $this->DbDetailFilter);
		ew_AddFilter($sFilter, $this->SearchWhere);

		// Set up filter in session
		$sis_producto->setSessionWhere($sFilter);
		$sis_producto->CurrentFilter = "";
	}

	// Return basic search SQL
	function BasicSearchSQL($Keyword) {
		global $sis_producto;
		$sKeyword = ew_AdjustSql($Keyword);
		$sWhere = "";
		$this->BuildBasicSearchSQL($sWhere, $sis_producto->NOM_PRODUCTO, $Keyword);
		$this->BuildBasicSearchSQL($sWhere, $sis_producto->DES_PRODUCTO, $Keyword);
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
		global $Security, $sis_producto;
		$sSearchStr = "";
		$sSearchKeyword = $sis_producto->BasicSearchKeyword;
		$sSearchType = $sis_producto->BasicSearchType;
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
			$sis_producto->setSessionBasicSearchKeyword($sSearchKeyword);
			$sis_producto->setSessionBasicSearchType($sSearchType);
		}
		return $sSearchStr;
	}

	// Clear all search parameters
	function ResetSearchParms() {
		global $sis_producto;

		// Clear search WHERE clause
		$this->SearchWhere = "";
		$sis_producto->setSearchWhere($this->SearchWhere);

		// Clear basic search parameters
		$this->ResetBasicSearchParms();
	}

	// Clear all basic search parameters
	function ResetBasicSearchParms() {
		global $sis_producto;
		$sis_producto->setSessionBasicSearchKeyword("");
		$sis_producto->setSessionBasicSearchType("");
	}

	// Restore all search parameters
	function RestoreSearchParms() {
		global $sis_producto;
		$bRestore = TRUE;
		if (@$_GET[EW_TABLE_BASIC_SEARCH] <> "") $bRestore = FALSE;
		$this->RestoreSearch = $bRestore;
		if ($bRestore) {

			// Restore basic search values
			$sis_producto->BasicSearchKeyword = $sis_producto->getSessionBasicSearchKeyword();
			$sis_producto->BasicSearchType = $sis_producto->getSessionBasicSearchType();
		}
	}

	// Set up sort parameters
	function SetUpSortOrder() {
		global $sis_producto;

		// Check for "order" parameter
		if (@$_GET["order"] <> "") {
			$sis_producto->CurrentOrder = ew_StripSlashes(@$_GET["order"]);
			$sis_producto->CurrentOrderType = @$_GET["ordertype"];
			$sis_producto->UpdateSort($sis_producto->ID_PRODUCTO); // ID_PRODUCTO
			$sis_producto->UpdateSort($sis_producto->NOM_PRODUCTO); // NOM_PRODUCTO
			$sis_producto->UpdateSort($sis_producto->DES_PRODUCTO); // DES_PRODUCTO
			$sis_producto->setStartRecordNumber(1); // Reset start position
		}
	}

	// Load sort order parameters
	function LoadSortOrder() {
		global $sis_producto;
		$sOrderBy = $sis_producto->getSessionOrderBy(); // Get ORDER BY from Session
		if ($sOrderBy == "") {
			if ($sis_producto->SqlOrderBy() <> "") {
				$sOrderBy = $sis_producto->SqlOrderBy();
				$sis_producto->setSessionOrderBy($sOrderBy);
			}
		}
	}

	// Reset command
	// cmd=reset (Reset search parameters)
	// cmd=resetall (Reset search and master/detail parameters)
	// cmd=resetsort (Reset sort parameters)
	function ResetCmd() {
		global $sis_producto;

		// Get reset command
		if (@$_GET["cmd"] <> "") {
			$sCmd = $_GET["cmd"];

			// Reset search criteria
			if (strtolower($sCmd) == "reset" || strtolower($sCmd) == "resetall")
				$this->ResetSearchParms();

			// Reset sorting order
			if (strtolower($sCmd) == "resetsort") {
				$sOrderBy = "";
				$sis_producto->setSessionOrderBy($sOrderBy);
				$sis_producto->ID_PRODUCTO->setSort("");
				$sis_producto->NOM_PRODUCTO->setSort("");
				$sis_producto->DES_PRODUCTO->setSort("");
			}

			// Reset start position
			$this->StartRec = 1;
			$sis_producto->setStartRecordNumber($this->StartRec);
		}
	}

	// Set up list options
	function SetupListOptions() {
		global $Security, $Language, $sis_producto;

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
		global $Security, $Language, $sis_producto, $objForm;
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
		global $Security, $Language, $sis_producto;
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

	// Load basic search values
	function LoadBasicSearchValues() {
		global $sis_producto;
		$sis_producto->BasicSearchKeyword = @$_GET[EW_TABLE_BASIC_SEARCH];
		$sis_producto->BasicSearchType = @$_GET[EW_TABLE_BASIC_SEARCH_TYPE];
	}

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
		$this->ViewUrl = $sis_producto->ViewUrl();
		$this->EditUrl = $sis_producto->EditUrl();
		$this->InlineEditUrl = $sis_producto->InlineEditUrl();
		$this->CopyUrl = $sis_producto->CopyUrl();
		$this->InlineCopyUrl = $sis_producto->InlineCopyUrl();
		$this->DeleteUrl = $sis_producto->DeleteUrl();

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
