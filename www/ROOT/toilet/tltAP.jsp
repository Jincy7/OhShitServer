<%@ page import="org.jdom2.*"%>
<%@ page import="org.jdom2.output.*"%>
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
		ResultSet rs=stmt.executeQuery("select * from publTolt");
		
		Element root = new Element("toilets");
		Document doc = new Document(root);
		
		while(rs.next()){
			Element data = new Element("toilet");

			double _ap = rs.getDouble(7);
			String _name = rs.getString(1);
			String _sap = Double.toString(_ap);

			Element name=new Element("PBCTLT_PLC_NM");
			name.setText(_name);
			

			Element e_point=new Element("AVERAGE_POINT");
                        e_point.setText(_sap);
			
			data.addContent(name);
                        data.addContent(e_point);

			root.addContent(data);
		}
		XMLOutputter xout = new XMLOutputter(Format.getCompactFormat().setOmitDeclaration(true));
		Format f = xout.getFormat();
		f.setEncoding("utf-8");
		f.setIndent("\t");
		f.setLineSeparator("\r\n");
		f.setTextMode(Format.TextMode.TRIM);
		xout.setFormat(f);
		String result = xout.outputString(doc);
		out.print(result);
		conn.close();
	}catch(Exception e){
		out.println(e);
	}
%>
