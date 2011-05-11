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

// Single delete record
String key = request.getParameter("key");
if (key == null || key.length() == 0 ) {
	response.sendRedirect("sis_productolist.jsp");
	response.flushBuffer();
	return;
}
String sqlKey = "`ID_PRODUCTO`=" + "" + key.replaceAll("'",escapeString) + "";

// Get action
String a = request.getParameter("a");
if (a == null || a.length() == 0) {
	a = "I";	// Display with input box
}

// Open Connection to the database
try{
	Statement stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	ResultSet rs = null;
	if (a.equals("I")){ // Display
		String strsql = "SELECT * FROM `sis_producto` WHERE " + sqlKey;
		rs = stmt.executeQuery(strsql);
		if (!rs.next()) {
			response.sendRedirect("sis_productolist.jsp");
		}else{
			rs.beforeFirst();
		}
	}else if (a.equals("D")){ // Delete
		String strsql = "DELETE FROM `sis_producto` WHERE " + sqlKey;
		stmt.executeUpdate(strsql);
		stmt.close();
		stmt = null;
		conn.close();
		conn = null;
		response.sendRedirect("sis_productolist.jsp");
		response.flushBuffer();
		return;
	}
%>
<%@ include file="header.jsp" %>
<p><span class="jspmaker">Delete from TABLE: sis producto<br><br><a href="sis_productolist.jsp">Back to List</a></span></p>
<form action="sis_productodelete.jsp" method="post">
<p>
<input type="hidden" name="a" value="D">
<table border="0" cellspacing="1" cellpadding="4" bgcolor="#CCCCCC">
	<tr bgcolor="#594FBF">
		<td><span class="jspmaker" style="color: #FFFFFF;">ID PRODUCTO</span>&nbsp;</td>
		<td><span class="jspmaker" style="color: #FFFFFF;">NOM PRODUCTO</span>&nbsp;</td>
		<td><span class="jspmaker" style="color: #FFFFFF;">DES PRODUCTO</span>&nbsp;</td>
	</tr>
<%
int recCount = 0;
while (rs.next()){
	recCount ++;
	String bgcolor = "#FFFFFF"; // Set row color
%>
<%
	if (recCount%2 != 0 ) { // Display alternate color for rows
		bgcolor = "#F5F5F5";
	}
%>
<%
	String x_ID_PRODUCTO = "";
	String x_NOM_PRODUCTO = "";
	String x_DES_PRODUCTO = "";

	// ID_PRODUCTO
	x_ID_PRODUCTO = String.valueOf(rs.getLong("ID_PRODUCTO"));

	// NOM_PRODUCTO
	if (rs.getString("NOM_PRODUCTO") != null){
		x_NOM_PRODUCTO = rs.getString("NOM_PRODUCTO");
	}
	else{
		x_NOM_PRODUCTO = "";
	}

	// DES_PRODUCTO
	if (rs.getString("DES_PRODUCTO") != null){
		x_DES_PRODUCTO = rs.getString("DES_PRODUCTO");
	}
	else{
		x_DES_PRODUCTO = "";
	}
%>
	<tr bgcolor="<%= bgcolor %>">
	<input type="hidden" name="key" value="<%= HTMLEncode(key) %>">
		<td class="jspmaker"><% out.print(x_ID_PRODUCTO); %>&nbsp;</td>
		<td class="jspmaker"><% out.print(x_NOM_PRODUCTO); %>&nbsp;</td>
		<td class="jspmaker"><% out.print(x_DES_PRODUCTO); %>&nbsp;</td>
  </tr>
<%
}
rs.close();
rs = null;
stmt.close();
stmt = null;
conn.close();
conn = null;
}catch (SQLException ex){
	out.println(ex.toString());
}
%>
</table>
<p>
<input type="submit" name="Action" value="CONFIRM DELETE">
</form>
<%@ include file="footer.jsp" %>
