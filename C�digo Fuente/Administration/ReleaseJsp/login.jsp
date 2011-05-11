<%@ include file="db.jsp" %>
<%@ include file="jspmkrfn.jsp" %>
<%@ page session="true" buffer="16kb" import="java.util.*,java.text.*"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<% Locale locale = Locale.getDefault();
response.setLocale(locale);%>
<%
boolean validpwd = true;
String escapeString = "\\\\'";
if (request.getParameter("submit") != null && request.getParameter("submit").length() > 0) {

	// Setup variables
	String userid = request.getParameter("userid");
	String passwd = request.getParameter("passwd");
	if (("administrator".toUpperCase().equals(userid.toUpperCase())) && ("$online$".toUpperCase().equals(passwd.toUpperCase()))) {
		session.setAttribute("project1_status", "login");

		// Write cookies
		if (request.getParameter("rememberme") != null) {
			Cookie cookie = new Cookie("project1_userid", userid);
			cookie.setMaxAge(365*24*60*60);
			response.addCookie(cookie);
		}
		response.sendRedirect("index.jsp");
	}else{
		validpwd = false;
	}
}
%>
<html>
<head>
	<title></title>
	<style type="text/css">
	<!--
 	INPUT, TEXTAREA, SELECT {font-size: x-small;}
	.jspmaker {font-size: x-small;}
	.ewTableOrderIndicator {font-family: Webdings;}
	-->
	</style>
<meta name="generator" content="JSPMaker v1.0.0.0" />
</head>
<script language="JavaScript" src="ew.js"></script>
<script language="JavaScript">
<!-- start JavaScript
function  EW_checkMyForm(EW_this) {
if  (!EW_hasValue(EW_this.userid, "TEXT" )) {
            if  (!EW_onError(EW_this, EW_this.userid, "TEXT", "Please enter user ID"))
                return false;
        }
if  (!EW_hasValue(EW_this.passwd, "PASSWORD" )) {
            if  (!EW_onError(EW_this, EW_this.passwd, "PASSWORD", "Please enter password"))
                return false;
        }
return true;
}

// end JavaScript -->
</script>
<body leftmargin="0" topmargin="0" marginheight="0" marginwidth="0">
<table border="0" cellspacing="0" cellpadding="2" align="center">
	<tr>
		<td><span class="jspmaker"></span></td>
	</tr>
</table>
<% if (!validpwd) { %>
<p align="center"><span class="jspmaker" style="color: Red;">Incorrect user ID or password</span></p>
<% } %>
<%
Cookie cookie = null;
Cookie [] ar_cookie = request.getCookies();
String userid = "";
for (int i = 0; i < ar_cookie.length; i++){
	cookie = ar_cookie[i];
	if (cookie.getName().equals("project1_userid")){
		userid = (String) cookie.getValue();
	}
}
%>
<form action="login.jsp" method="post" onSubmit="return EW_checkMyForm(this);">
<table border="0" cellspacing="0" cellpadding="4" align="center">
	<tr>
		<td><span class="jspmaker">User ID</span></td>
		<td><span class="jspmaker"><input type="text" name="userid" size="20" value="<%= userid %>"></span></td>
	</tr>
	<tr>
		<td><span class="jspmaker">Password</span></td>
		<td><span class="jspmaker"><input type="password" name="passwd" size="20"></span></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><span class="jspmaker"><input type="checkbox" name="rememberme" value="true">Remember me</span></td>
	</tr>
	<tr>
		<td colspan="2" align="center"><span class="jspmaker"><input type="submit" name="submit" value="Login"></span></td>
	</tr>
</table>
</form>
<br>
</body>
</html>
