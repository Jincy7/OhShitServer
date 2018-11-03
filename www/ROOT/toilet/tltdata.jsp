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

			String _name = rs.getString(1);
			String _addr = rs.getString(2);
			String _telno = rs.getString(3);
			String _opentm = rs.getString(4);
			String _lat = rs.getString(5);
			String _long = rs.getString(6);

			Element name=new Element("PBCTLT_PLC_NM");
			name.setText(_name);
			
			Element addr=new Element("REFINE_ROADNM_ADDR");
			addr.setText(_addr);

			Element telno=new Element("MANAGE_INST_TELNO");
                        telno.setText(_telno);

			Element opentm=new Element("OPEN_TM_INFO");
                        opentm.setText(_opentm);

			Element e_lat=new Element("REFINE_WGS84_LAT");
                        e_lat.setText(_lat);

			Element e_long=new Element("REFINE_WGS84_LONG");
                        e_long.setText(_long);
			
			data.addContent(name);
                        data.addContent(addr);
                        data.addContent(telno);
                        data.addContent(opentm);
                        data.addContent(e_lat);
                        data.addContent(e_long);

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
