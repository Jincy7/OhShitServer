<%@ page import="java.sql.*"
        contentType="text/html;charset=utf-8"%>

<%
        String DB_URL = "jdbc:mysql://localhost/javaServer";
        String DB_USER = "javaProjectDB";
        String DB_PASSWORD = "javaDB";
	request.setCharacterEncoding("utf-8");  //Set encoding
	String _id  =        request.getParameter("id");            
	String _name =   request.getParameter("name");
	String _pwd =     request.getParameter("pwd");
	String _email  =   request.getParameter("email");
	String flag = "False";

        Connection conn=DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);
	Statement stmt=conn.createStatement();	
        try{
	        Class.forName("com.mysql.jdbc.Driver");
                String sql = "select id from user";
		try{

			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()){
				if(rs.getString("id").equals(_id)){
					flag = "True";
				}
			}
		}catch(SQLException e){
			e.printStackTrace();
		}

		String query = "INSERT INTO user VALUES('"+_id+"','"+_name+"','"+_pwd+"','"+_email+"')";	
		if(_id.equals("null")){
			out.println("id is null");
		}else if(_name.equals("null")){
			out.println("name is null");
		}else if(_pwd.equals("null")){
			out.println("pwd is null");
		}else if(_email.equals("null")){
			out.println("email is null");
		}else{		
			if(flag.equals("False")){
				stmt.executeUpdate(query);
				out.println("Join Success");
			}else{
				out.println("Already exist id");
			}
		}
		stmt.close();
                conn.close();
        }catch(Exception e){
                out.println(e);
        }
%>

