<%@ page import="java.sql.*"%>
<%
try{
	Class.forName("com.mysql.jdbc.Driver").newInstance();
}catch (Exception ex){
	out.println(ex.toString());
}
String xDb_Conn_Str = "jdbc:mysql://localhost:3306/martillo";
Connection conn = null;
try{
	conn = DriverManager.getConnection(xDb_Conn_Str,"root","$online$");
}catch (SQLException ex){
	out.println(ex.toString());
}
%>
