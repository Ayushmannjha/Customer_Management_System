<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Customer</title>
    <link rel="stylesheet" href="log.css">
    <style>
     p{
            opacity: 1;
            color: #fff;
            margin-top: 1rem;
        }

        p a{
            color: #fd4907;
        }
        @media (max-width:816px){
            p, a{
                font-size: .8rem;
            }
        }
</style>
    <!-- Add your CSS and other imports here -->
</head>
<body>


    <div class="container">
        <h1>Edit Customer</h1>
        <form action="UpdateServlet" method="post">
        <input type="hidden" name="first_name" value="<%= request.getParameter("first_name") %>">
        <input type="hidden" name="last_name" value="<%= request.getParameter("last_name") %>">
            <input type="text" name="fname" value="<%=request.getParameter("first_name")%>" required>
            <input type="text" name="lname" value="<%=request.getParameter("last_name")%>" required>
            <input type="text" name="street" value="<%=request.getParameter("street")%>" required>
            <input type="text" name="Address" value="<%=request.getParameter("address")%>" required>
            <input type="text" name="city" value="<%=request.getParameter("city")%>" required>
            <input type="text" name="state" value="<%=request.getParameter("state")%>" required>
			<input type="text" name="email" value="<%=request.getParameter("email")%>" required>
            <input type="text" name="phone" value="<%=request.getParameter("phone")%>" required>
            
            <!-- Other input fields here -->
            <input type="submit" value="Update" class="btn" style="cursor: pointer;">
        </form>
        
    </div>
</body>
</html>
