<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="main.java.com.psl.jdbc.Movie"%>
    <%@page import="main.java.com.psl.jdbc.dataAccess"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	
	<%
			String movie_code=request.getParameter("movie_code"); 
           String movie_name=request.getParameter("movie_name");
           String rdate=request.getParameter("rdate");
           String language=request.getParameter("language");
           
            Movie m=new Movie(movie_code,movie_name,rdate,language);
            dataAccess da=new dataAccess();
            da.addNew(m);
            response.sendRedirect("AllMovies");
           
            %>
	
</body>
</html>