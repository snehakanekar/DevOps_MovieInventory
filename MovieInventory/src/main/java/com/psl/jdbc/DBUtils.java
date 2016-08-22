/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package main.java.com.psl.jdbc;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Lipi Patel
 */
public class DBUtils
{
    public static PreparedStatement getPreparedStatement(String sql,String password) throws ClassNotFoundException, SQLException{
    PreparedStatement ps =  null;
    
    Class.forName("com.mysql.jdbc.Driver");  
    String url = "jdbc:mysql://10.51.237.131:6603/onlinemoviebookingsystem";
	String username = "root";
	//String password = "root";
	
	
     Connection con = DriverManager.getConnection(url, username, password);
      ps = con.prepareStatement(sql);
    return ps;
    }
    
    /* public static void main(String[] args) throws ClassNotFoundException, SQLException {
     getPreparedStatement("select * from Employee"); 
  } */
}
