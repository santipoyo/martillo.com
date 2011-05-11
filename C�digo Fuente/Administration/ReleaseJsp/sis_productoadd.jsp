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
Object x_ID_PRODUCTO = null;
Object x_NOM_PRODUCTO = null;
Object x_DES_PRODUCTO = null;

// Open Connection to the database
try{
	Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	ResultSet rs = null;
	if (a.equals("C")){ // Get a record to display
		String tkey = "" + key.replaceAll("'",escapeString) + "";
		String strsql = "SELECT * FROM `sis_producto` WHERE `ID_PRODUCTO`=" + tkey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()){
			rs.close();
			rs = null;
			stmt.close();
			stmt = null;
			conn.close();
			conn = null;
			out.clear();
			response.sendRedirect("sis_productolist.jsp");
			response.flushBuffer();
			return;
		}
		rs.first();

			// Get the field contents
	x_ID_PRODUCTO = String.valueOf(rs.getLong("ID_PRODUCTO"));
	if (rs.getString("NOM_PRODUCTO") != null){
		x_NOM_PRODUCTO = rs.getString("NOM_PRODUCTO");
	}else{
		x_NOM_PRODUCTO = "";
	}
	if (rs.getString("DES_PRODUCTO") != null){
		x_DES_PRODUCTO = rs.getString("DES_PRODUCTO");
	}else{
		x_DES_PRODUCTO = "";
	}
		rs.close();
		rs = null;
	}else if (a.equals("A")) { // Add

		// Get fields from form
		if (request.getParameter("x_ID_PRODUCTO") != null){
			x_ID_PRODUCTO = (String) request.getParameter("x_ID_PRODUCTO");
		}else{
			x_ID_PRODUCTO = "";
		}
		if (request.getParameter("x_NOM_PRODUCTO") != null){
			x_NOM_PRODUCTO = (String) request.getParameter("x_NOM_PRODUCTO");
		}else{
			x_NOM_PRODUCTO = "";
		}
		if (request.getParameter("x_DES_PRODUCTO") != null){
			x_DES_PRODUCTO = (String) request.getParameter("x_DES_PRODUCTO");
		}else{
			x_DES_PRODUCTO = "";
		}

		// Open record
		String strsql = "SELECT * FROM `sis_producto` WHERE 0 = 1";
		rs = stmt.executeQuery(strsql);
		rs.moveToInsertRow();

		// Field ID_PRODUCTO
		tmpfld = ((String) x_ID_PRODUCTO).trim();
		if (!IsNumeric(tmpfld)) { tmpfld = "0";}
		if (tmpfld == null) {
			rs.updateNull("ID_PRODUCTO");
		} else {
		String srchfld = tmpfld;
			srchfld = srchfld.replaceAll("'","\\\\'");
			strsql = "SELECT * FROM `sis_producto` WHERE `ID_PRODUCTO` = " + srchfld;
			Statement stmtchk = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			ResultSet rschk = stmtchk.executeQuery(strsql);
			if (rschk.next()) {
				out.print("Duplicate key for ID_PRODUCTO, value = " + tmpfld + "<br>");
				out.print("Press [Previous Page] key to continue!");
				return;
			}
			rschk.close();
			rschk = null;
			rs.updateInt("ID_PRODUCTO",Integer.parseInt(tmpfld));
		}

		// Field NOM_PRODUCTO
		tmpfld = ((String) x_NOM_PRODUCTO);
		if (tmpfld == null || tmpfld.trim().length() == 0) {
			tmpfld = "";
		}
		if (tmpfld == null) {
			rs.updateNull("NOM_PRODUCTO");
		}else{
			rs.updateString("NOM_PRODUCTO", tmpfld);
		}

		// Field DES_PRODUCTO
		tmpfld = ((String) x_DES_PRODUCTO);
		if (tmpfld == null || tmpfld.trim().length() == 0) {
			tmpfld = "";
		}
		if (tmpfld == null) {
			rs.updateNull("DES_PRODUCTO");
		}else{
			rs.updateString("DES_PRODUCTO", tmpfld);
		}
		rs.insertRow();
		rs.close();
		rs = null;
		stmt.close();
		stmt = null;
		conn.close();
		conn = null;
		out.clear();
		response.sendRedirect("sis_productolist.jsp");
		response.flushBuffer();
		return;
	}
}catch (SQLException ex){
	out.println(ex.toString());
}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">Add to TABLE: sis producto<br><br><a href="sis_productolist.jsp">Back to List</a></span></p>
<script language="JavaScript" src="ew.js"></script>
<script language="JavaScript">
<!-- start Javascript
function  EW_checkMyForm(EW_this) {
if (EW_this.x_ID_PRODUCTO && !EW_hasValue(EW_this.x_ID_PRODUCTO, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_ID_PRODUCTO, "TEXT", "Incorrect integer - ID PRODUCTO"))
                return false; 
        }
if (EW_this.x_ID_PRODUCTO && !EW_checkinteger(EW_this.x_ID_PRODUCTO.value)) {
        if (!EW_onError(EW_this, EW_this.x_ID_PRODUCTO, "TEXT", "Incorrect integer - ID PRODUCTO"))
            return false; 
        }
if (EW_this.x_NOM_PRODUCTO && !EW_hasValue(EW_this.x_NOM_PRODUCTO, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_NOM_PRODUCTO, "TEXT", "Invalid Field - NOM PRODUCTO"))
                return false; 
        }
if (EW_this.x_DES_PRODUCTO && !EW_hasValue(EW_this.x_DES_PRODUCTO, "TEXT" )) {
            if (!EW_onError(EW_this, EW_this.x_DES_PRODUCTO, "TEXT", "Invalid Field - DES PRODUCTO"))
                return false; 
        }
return true;
}

// end JavaScript -->
</script>
<form onSubmit="return EW_checkMyForm(this);"  action="sis_productoadd.jsp" method="post">
<p>
<input type="hidden" name="a" value="A">
<table border="0" cellspacing="1" cellpadding="4" bgcolor="#CCCCCC">
	<tr>
		<td bgcolor="#594FBF"><span class="jspmaker" style="color: #FFFFFF;">ID PRODUCTO</span>&nbsp;</td>
		<td bgcolor="#F5F5F5"><span class="jspmaker"><input type="text" name="x_ID_PRODUCTO" size="30" value="<%= HTMLEncode((String)x_ID_PRODUCTO) %>"></span>&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#594FBF"><span class="jspmaker" style="color: #FFFFFF;">NOM PRODUCTO</span>&nbsp;</td>
		<td bgcolor="#F5F5F5"><span class="jspmaker"><input type="text" name="x_NOM_PRODUCTO" size="30" maxlength="50" value="<%= HTMLEncode((String)x_NOM_PRODUCTO) %>"></span>&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#594FBF"><span class="jspmaker" style="color: #FFFFFF;">DES PRODUCTO</span>&nbsp;</td>
		<td bgcolor="#F5F5F5"><span class="jspmaker"><input type="text" name="x_DES_PRODUCTO" size="30" maxlength="100" value="<%= HTMLEncode((String)x_DES_PRODUCTO) %>"></span>&nbsp;</td>
	</tr>
</table>
<p>
<input type="submit" name="Action" value="ADD">
</form>
<%@ include file="footer.jsp" %>
