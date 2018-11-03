<%@ page import="org.jdom2.*"%>
<%@ page import="org.jdom2.output.*"%>
<%@ page import="java.sql.*"
        contentType="text/html;charset=utf-8"%>

<%
        String DB_URL = "jdbc:mysql://localhost/javaServer";
        String DB_USER = "javaProjectDB";
        String DB_PASSWORD = "javaDB";
	request.setCharacterEncoding("utf-8");  //Set encoding
	String _id  =        request.getParameter("id");            
	String _pwd =     request.getParameter("pwd");

        Connection conn=DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);
	
        try{
	        Class.forName("com.mysql.jdbc.Driver");
		String query = "SELECT * from user WHERE id = ?";
		PreparedStatement pstmt=conn.prepareStatement(query);
		pstmt.setString(1,_id);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		String pass= rs.getString("password");

		if(pass.equals(_pwd)){
			try{
				query = "DELETE FROM user WHERE id = ?";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1,_id);
				pstmt.executeUpdate();
				out.println("Withdraw Success");
				
			}catch(Exception e){
				out.println(e);
			}
		}else{
			out.println("Wrong Password!");
		}
        }catch(Exception e){
                out.println(e);
        }
%>

