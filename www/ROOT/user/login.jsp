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
		String _name= rs.getString("name");
		String _email= rs.getString("email");
		pstmt.close();
                conn.close();
		if(pass.equals(_pwd)){
			Element root = new Element("authUser");
			Document doc = new Document(root);

			Element data = new Element("user");

			Element id = new Element("id");
			id.setText(_id);
			
			Element name = new Element("name");
			name.setText(_name);

			Element email = new Element("email");
			email.setText(_email);

			data.addContent(id);
			data.addContent(name);
			data.addContent(email);

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

		}else{
			out.println("Wrong Password!");
		}
        }catch(Exception e){
                out.println(e);
        }
%>

