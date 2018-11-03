<%@ page import="org.jdom2.*"%>
<%@ page import="org.jdom2.output.*"%>
<%@ page import="java.sql.*"
        contentType="text/html;charset=utf-8"%>

<%
        String DB_URL = "jdbc:mysql://localhost/javaServer";
        String DB_USER = "javaProjectDB";
        String DB_PASSWORD = "javaDB";
	request.setCharacterEncoding("utf-8");  //Set encoding
	String _TLT_NM  =        request.getParameter("PBCTLT_PLC_NM");

        Connection conn=DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);
	Statement stmt=conn.createStatement();
	PreparedStatement pstmt = null;
	ResultSet rs = null;

        try{
		Class.forName("com.mysql.jdbc.Driver");
		String sql = "SELECT * FROM reviews WHERE PBCTLT_PLC_NM=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,_TLT_NM);
		rs = pstmt.executeQuery();

		Element root = new Element("reviews");
		Document doc = new Document(root);
		while(rs.next()){
			Element data = new Element("review");
		
			String _USER = rs.getString(2);
			Double _STAR_POINT = rs.getDouble(3);
			String _REVIEW = rs.getString(4);
			String _DATE = rs.getString(5);

			Element tlt= new Element("PBCTLT_PLC_NM");
			tlt.setText(_TLT_NM);
	
			Element user = new Element("USER");
			user.setText(_USER);

			Element point= new Element("STAR_POINT");
			point.setText(Double.toString(_STAR_POINT));

			Element review= new Element("REVIEW");
			review.setText(_REVIEW);

			Element insertedTime= new Element("TIME");
			insertedTime.setText(_DATE);

			data.addContent(tlt);
			data.addContent(user);
			data.addContent(point);
			data.addContent(review);
			data.addContent(insertedTime);

			root.addContent(data);
		}

		XMLOutputter xout = new XMLOutputter(Format.getCompactFormat().setOmitDeclaration(true));
		Format f = xout.getFormat();
		f.setEncoding("utf-8");
		f.setIndent("\t");
		f.setLineSeparator("\r\n");
		f.setTextMode(Format.TextMode.TRIM);
		xout.setFormat(f);
		String result =xout.outputString(doc);
		out.print(result);

        }catch(Exception e){
                out.println(e);
        }finally{
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
		if(conn != null) try{conn.close();}catch(SQLException sqle){}
	}
%>

