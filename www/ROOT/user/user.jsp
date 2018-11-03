<%@ page import="java.sql.*"
	contentType="text/html;charset=utf-8"%>

<%
	String DB_URL = "jdbc:mysql://localhost/javaServer";
	String DB_USER = "javaProjectDB";
	String DB_PASSWORD = "javaDB";
	Statement stmt;
	Connection conn;
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);
		stmt = conn.createStatement();
		ResultSet rs=stmt.executeQuery("select * from user");
		while(rs.next()){
			String num = rs.getString(1);
			String name = rs.getString(2);
			out.println(num);
			out.println(name+"<br></br>");
		}
		conn.close();
	}catch(Exception e){
		out.println(e);
	}
%>
