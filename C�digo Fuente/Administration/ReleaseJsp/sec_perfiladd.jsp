<%@ page session="true" buffer="16kb" import="java.sql.*,java.util.*,java.text.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
response.setDateHeader("Expires", 0); // date in the past
response.addHeader("Cache-Control", "no-store, no-cache, must-revalidate"); // HTTP/1.1 
response.addHeader("Cache-Control", "post-check=0, pre-check=0"); 
response.addHeader("Pragma", "no-cache"); // HTTP/1.0 
%>
<% Locale locale = Locale.getDefault();
response.setLocale(locale);%>
<% session.setMaxInactiveInterval(30*60); %>
<% 
String login = (String) session.getAttribute("project1_status");
if (login == null || !login.equals("login")) {
response.sendRedirect("login.jsp");
response.flushBuffer(); 
return; 
}%>
<%int ewAllowAdmin = 16;
int ewCurSec = 31;%>
<%@ include file="db.jsp" %>
<%@ include file="jspmkrfn.jsp" %>
<%
String tmpfld = null;
String escapeString = "\\\\'";
request.setCharacterEncoding("UTF-8");

// Get action
String a = request.getParameter("a");
String key = "";
if (a == null || a.length() == 0) {
	key = request.getParameter("key");
	if (key != null && key.length() > 0) {
		a = "C"; // Copy record
	} else {
		a = "I"; // Display blank record
	}
}
Object x_ID_PERFIL = null;
Object x_DES_PERFIL = null;

// Open Connection to the database
try{
	Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	ResultSet rs = null;
	if (a.equals("C")){ // Get a record to display
		String tkey = "" + key.replaceAll("'",escapeString) + "";
		String strsql = "SELECT * FROM `sec_perfil` WHERE `ID_PERFIL`=" + tkey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()){
			rs.close();
			rs = null;
			stmt.close();
			stmt = null;
			conn.close();
			conn = null;
			out.clear();
			response.sendRedirect("sec_perfillist.jsp");
			response.flushBuffer();
			return;
		}
		rs.first();

			// Get the field contents
	x_ID_PERFIL = String.valueOf(rs.getLong("ID_PERFIL"));
	if (rs.getString("DES_PERFIL") != null){
		x_DES_PERFIL = rs.getString("DES_PERFIL");
	}else{
		x_DES_PERFIL = "";
	}
		rs.close();
		rs = null;
	}else if (a.equals("A")) { // Add

		// Get fields from form
		if (request.getParameter("x_ID_PERFIL") != null){
			x_ID_PERFIL = (String) request.getParameter("x_ID_PERFIL");
		}else{
			x_ID_PERFIL = "";
		}
		if (request.getParameter("x_DES_PERFIL") != null){
			x_DES_PERFIL = (String) request.getParameter("x_DES_PERFIL");
		}else{
			x_DES_PERFIL = "";
		}

		// Open record
		String strsql = "SELECT * FROM `sec_perfil` WHERE 0 = 1";
		rs = stmt.executeQuery(strsql);
		rs.moveToInsertRow();

		// Field ID_PERFIL
		tmpfld = ((String) x_ID_PERFIL).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("ID_PERFIL");
		} else {
		String srchfld = tmpfld;
			srchfld = srchfld.replaceAll("'","\\\\'");
			strsql = "SELECT * FROM `sec_perfil` WHERE `ID_PERFIL` = " + srchfld;
			Statement stmtchk = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			ResultSet rschk = stmtchk.executeQuery(strsql);
			if (rschk.next()) {
				out.print("Duplicate key for ID_PERFIL, value = " + tmpfld + "<br>");
				out.print("Press [Previous Page] key to continue!");
				return;
			}
			rschk.close();
			rschk = null;
			rs.updateInt("ID_PERFIL",Integer.parseInt(tmpfld));
		}

		// Field DES_PERFIL
		tmpfld = ((String) x_DES_PERFIL);
		if (tmpfld == null || tmpfld.trim().length() == 0) {
			tmpfld = "";
		}
		if (tmpfld == null) {
			rs.updateNull("DES_PERFIL");
		}else{
			rs.updateString("DES_PERFIL", tmpfld);
		}
		rs.insertRow();
		rs.close();
		rs = null;
		stmt.close();
		stmt = null;
		conn.close();
		conn = null;
		out.clear();
		response.sendRedirect("sec_perfillist.jsp");
		response.flushBuffer();
		return;
	}
}catch (SQLException ex){
	out.println(ex.toString());
}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">Add to TABLE: sec perfil<br><br><a href="sec_perfillist.jsp">Back to List</a></span></p>
<script language="JavaScript" src="ew.js"></script>
<script language="JavaScript">
<!-- start Javascript
function  EW_checkMyForm(EW_this) {
if (EW_this.x_ID_PERFIL && !EW_hasValue(EW_this.x_ID_PERFIL, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_ID_PERFIL, "TEXT", "Incorrect integer - ID PERFIL"))
                return false; 
        }
if (EW_this.x_ID_PERFIL && !EW_checkinteger(EW_this.x_ID_PERFIL.value)) {
        if (!EW_onError(EW_this, EW_this.x_ID_PERFIL, "TEXT", "Incorrect integer - ID PERFIL"))
            return false; 
        }
if (EW_this.x_DES_PERFIL && !EW_hasValue(EW_this.x_DES_PERFIL, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_DES_PERFIL, "TEXT", "Invalid Field - DES PERFIL"))
                return false; 
        }
return true;
}

// end JavaScript -->
</script>
<form onSubmit="return EW_checkMyForm(this);"  action="sec_perfiladd.jsp" method="post">
<p>
<input type="hidden" name="a" value="A">
<table border="0" cellspacing="1" cellpadding="4" bgcolor="#CCCCCC">
	<tr>
		<td bgcolor="#594FBF"><span class="jspmaker" style="color: #FFFFFF;">ID PERFIL</span>&nbsp;</td>
		<td bgcolor="#F5F5F5"><span class="jspmaker"><input type="text" name="x_ID_PERFIL" size="30" value="<%= HTMLEncode((String)x_ID_PERFIL) %>"></span>&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#594FBF"><span class="jspmaker" style="color: #FFFFFF;">DES PERFIL</span>&nbsp;</td>
		<td bgcolor="#F5F5F5"><span class="jspmaker"><input type="text" name="x_DES_PERFIL" size="30" maxlength="50" value="<%= HTMLEncode((String)x_DES_PERFIL) %>"></span>&nbsp;</td>
	</tr>
</table>
<p>
<input type="submit" name="Action" value="ADD">
</form>
<%@ include file="footer.jsp" %>
