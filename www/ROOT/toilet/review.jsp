<%@ page import="java.sql.*"
        contentType="text/html;charset=utf-8"%>

<%
        String DB_URL = "jdbc:mysql://localhost/javaServer";
        String DB_USER = "javaProjectDB";
        String DB_PASSWORD = "javaDB";
	request.setCharacterEncoding("utf-8");  //Set encoding
	String _TLT_NM  =        request.getParameter("PBCTLT_PLC_NM");
	String _USER =   request.getParameter("id");
	String _STAR_POINT =     request.getParameter("STAR_POINT");
	String _REVIEW  =   request.getParameter("LINE_REVIEW");
	String flag = "False";

        Connection conn=DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);
	Statement stmt=conn.createStatement();
	PreparedStatement pstmt = null;

        try{
		int _DWORD_STAR_POINT = Integer.parseInt(_STAR_POINT);
	        Class.forName("com.mysql.jdbc.Driver");
		String sql = "INSERT INTO reviews VALUES(?,?,?,?.?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,_TLT_NM);
		pstmt.setString(2,_USER);
		pstmt.setInt(3,_DWORD_STAR_POINT);
		pstmt.setString(4,_REVIEW);
		pstmt.setTimestamp(5,new Timestamp(System.currentTimeMillis()));
		out.println(_TLT_NM);
		out.println(_USER);
		out.println(_STAR_POINT);
		out.println(_REVIEW);
		try{
			out.println("In try");
			pstmt.executeUpdate();
			out.println("review inserted");
		}catch(SQLException e){
			e.printStackTrace();
		}

		String query = "SELECT AVERAGE_POINT from publTolt WHERE PBCTLT_PLC_NM = '"+_TLT_NM+"'";
		pstmt = conn.prepareStatement(query);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		Double AP = rs.getDouble("AVERAGE_POINT");
		out.println(AP);
		pstmt.close();
		stmt.close();
                conn.close();
        }catch(Exception e){
                out.println(e);
        }
%>

