<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>All Movies</title>
</head>
<body>
	
	<div style="width:1200px;margin-left: auto;margin-right: auto">
           <table cellpadding="10">
               <tr>
                   <th>Movie code</th>
                   <th>Movie Name</th> 
              <th>Release date</th> 
              <th>Language</th>    
               </tr>
              
                
               
               <c:forEach items="${AllMovies}" var="p">
                   <tr>
                   		<td>${p.id}</td>
                        <td>${p.name}</td>
                         <td>${p.date}</td>
                          <td>${p.language}</td>
                   </tr>  
                   
                   
               </c:forEach>
               
           </table>
       </div>
	
	
</body>
</html>