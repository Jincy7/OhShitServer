<%@ page import="org.jdom2.*"%>
<%@ page import="org.jdom2.output.*"%>
<%@ page import="java.sql.*"
        contentType="text/html;charset=utf-8"%>

<%
        String DB_URL = "jdbc:mysql://localhost/javaServer";
        String DB_USER = "javaProjectDB";
        String DB_PASSWORD = "javaDB";
	request.setCharacterEncoding("utf-8");  //Set encoding
	String _PBCTLT_PLC_NM  =        request.getParameter("PBCTLT_PLC_NM");            

        Connection conn=DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);
	
        try{
	        Class.forName("com.mysql.jdbc.Driver");
		String query = "SELECT * from publTolt WHERE PBCTLT_PLC_NM  = ?";
		PreparedStatement pstmt=conn.prepareStatement(query);
		pstmt.setString(1,_PBCTLT_PLC_NM);
		ResultSet rs = pstmt.executeQuery();
		rs.next();

		double _ap = rs.getDouble(7);
		String _sap = Double.toString(_ap);

		pstmt.close();
                conn.close();
		Element root = new Element("toilets");
		Document doc = new Document(root);
		Element data = new Element("toilet");

		Element NM = new Element("PBCTLT_PLC_NM");
		NM.setText(_PBCTLT_PLC_NM);

		Element e_point = new Element("AVERAGE_POINT");
		e_point.setText(_sap);

		data.addContent(NM);
		data.addContent(e_point);

		root.addContent(data);
			
		XMLOutputter xout = new XMLOutputter(Format.getCompactFormat().setOmitDeclaration(true));
		Format f = xout.getFormat();
		f.setEncoding("utf-8");
		f.setIndent("\t");
		f.setLineSeparator("\r\n");
		f.setTextMode(Format.TextMode.TRIM);
		xout.setFormat(f);
		String result = xout.outputString(doc);

		out.print(result);

        }catch(Exception e){
                out.println(e);
        }
%>

