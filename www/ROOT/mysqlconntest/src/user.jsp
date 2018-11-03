<%@ page import="java.sql.*"
	contentType="text/html;charset=utf-8"%>

<%
	String DB_URL = "jdbc:mysql//localhost/mysql";
	String DB_USER = "javaProjectDB";
	String DB_PASSWORD = "javaDB";
	Connection conn;
	Statement stmt;
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);
		stmt = conn.createStatement();
		conn.close();
		out.println("MYSQL connection Success!");
	}catch(Exception e){
		out.println(e);
	}
%>
