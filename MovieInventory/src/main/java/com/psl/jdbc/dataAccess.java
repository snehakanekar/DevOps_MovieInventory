package main.java.com.psl.jdbc;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;



public class dataAccess {
	
	public boolean checkDuplicateCode(String code) throws ClassNotFoundException {
		
		List<String> ls=new LinkedList<String>();
        
        try {
            ResultSet rs=  (ResultSet) DBUtils.getPreparedStatement("select m.movieCode from movie m","root").executeQuery();
            while(rs.next())
            {
                
                ls.add(rs.getString(1));
            
            }
          //  System.out.println(code+" "+ls.contains(code));
            if(ls.contains(code))
            	return false;
            
        } catch (SQLException ex) {
            Logger.getLogger(dataAccess.class.getName()).log(Level.SEVERE, null, ex);
        }
        
		
		return true;
	}

	public boolean checkDate(String date){
		try {
		    DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		    formatter.setLenient(false);
		    Date date1 = formatter.parse(date);
		} catch (ParseException e) { 
		   // e.printStackTrace();
		    return false;
		}
		return true;
	}
	
	public void addNew(Movie m) throws ClassNotFoundException
    {
        try 
        {
            if(checkDate(m.getDate()) && checkDuplicateCode(m.getId()))
            {
            	
            PreparedStatement ps=DBUtils.getPreparedStatement("insert into movie values(?,?,?,?)","root");
            
            ps.setString(1, m.getId());
            ps.setString(2, m.getName());
            ps.setString(3, m.getDate());
            ps.setString(4, m.getLanguage());
            ps.executeUpdate();
            }
        } 
        catch (SQLException ex) 
        {
            System.out.printf("Movie record already exists");
            Logger.getLogger(dataAccess.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
	
	public static List<Movie> getAll() throws ClassNotFoundException
    {
        List<Movie> ls=new LinkedList<Movie>();
        
        try {
            ResultSet rs=  (ResultSet) DBUtils.getPreparedStatement("select m.movieCode,m.movieName,m.showDate,m.lang from movie m","root").executeQuery();
            while(rs.next())
            {
                Movie movie=new Movie(rs.getString(1),rs.getString(2),rs.getString(3),rs.getString(4));
                ls.add(movie);
            
            }
        } catch (SQLException ex) {
            Logger.getLogger(dataAccess.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ls;
    }
}
