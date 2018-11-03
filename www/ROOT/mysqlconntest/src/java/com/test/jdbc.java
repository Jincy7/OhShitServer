package java.com.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class jdbc {
	public static void main(String[] args){
		try{
			Class.forName("mysql.Driver");
			System.out.println("jdbc driver loading");
		}catch(ClassNotFoundException e){
			System.out.println(e.getMessage());
		}
		try{
		String url = "jdbc:mysql://localhost/mysql";
		Connection con = DriverManager.getConnection(url,"root","");
		System.out.println("Mysql Connected!");
		}catch(java.lang.Exception ex){
			ex.printStackTrace();
		}
		
	}
}
