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
	int _REVIEWD_NUM = 0;
	double AP = 0;
	String flag = "False";

        Connection conn=DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);
	Statement stmt=conn.createStatement();
	PreparedStatement pstmt = null;
	ResultSet rs = null;

        try{
		Class.forName("com.mysql.jdbc.Driver");
		String sql = "INSERT INTO reviews VALUES(?,?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,_TLT_NM);
		pstmt.setString(2,_USER);
		pstmt.setDouble(3,Double.parseDouble(_STAR_POINT));
		pstmt.setString(4,_REVIEW);
		pstmt.setTimestamp(5,new Timestamp(System.currentTimeMillis()));

		pstmt.executeUpdate();
		out.println("review success");
		
		try{
			sql = "SELECT count(*) from reviews WHERE PBCTLT_PLC_NM=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,_TLT_NM);
			rs = pstmt.executeQuery();
			while(rs.next()){
				_REVIEWD_NUM=(rs.getInt(1));
			}
			out.println(_REVIEWD_NUM);

			try{
				sql = "SELECT AVERAGE_POINT from publTolt WHERE PBCTLT_PLC_NM = '"+_TLT_NM+"'";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				rs.next();
				AP = rs.getDouble("AVERAGE_POINT");
				out.println(AP);
				AP = (AP*(_REVIEWD_NUM-1)+Double.parseDouble(_STAR_POINT)) /( _REVIEWD_NUM);
				out.println(AP);
				try{
					sql = "UPDATE publTolt SET AVERAGE_POINT=? WHERE PBCTLT_PLC_NM=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setDouble(1,AP);
					pstmt.setString(2,_TLT_NM);
					pstmt.executeUpdate();
					out.println("Update AVERGE POINT!");
				}catch(Exception e){
					out.println(e);
				}

			}catch(Exception e){
				out.println(e);
			}
		}catch(Exception e){
			out.println(e);
		}

        }catch(Exception e){
                out.println(e);
        }finally{
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
		if(conn != null) try{conn.close();}catch(SQLException sqle){}
	}
%>

