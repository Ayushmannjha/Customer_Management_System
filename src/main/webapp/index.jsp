<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>

<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.io.IOException"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="log.css">
</head>
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
<body>
    <div class="form-container">
        <h1>Login Page</h1>
        <form action="index.jsp" method="post">
    <!-- Your input fields here -->
    <input type="text" name="loginid" placeholder="login id" required>
    <input type="password" name="password" placeholder="Password" required>
    <input type="submit" value="Login" class="btn" style="cursor: pointer;">
</form>
<%! String status = ""; %>
      <%
     

 // Change "Password" to "password"
 if (request.getMethod().equalsIgnoreCase("post")) {
            String id = request.getParameter("loginid");
            String password = request.getParameter("password");
            System.out.println("ID: " + id);
            System.out.println("Password: " + password);
if(id!=null&&password!=null){
            try {
                // Replace these with your database credentials
                String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";
                String dbUsername = "system";
                String dbPassword = "manager";
				//Connecting with database
                Class.forName("oracle.jdbc.driver.OracleDriver");
                Connection connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
                //query to check valid credencials
                PreparedStatement statement = connection.prepareStatement("SELECT * FROM login WHERE Login_id = ? AND password = ?");
                //setting parameter values
                statement.setString(1, id);
                statement.setString(2, password); 
                ResultSet resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    // Email and password match, forward to the profile page with attributes
                    session.setAttribute("loggedIn", true);
                    request.getRequestDispatcher("CoustmerInfo.jsp").forward(request, response);
                } else {
                    // Email or password is incorrect, redirect back to the login page with an error message
                   status = "500, UUID not found";
                }

                resultSet.close();
                statement.close();
                connection.close();
            }  catch (ClassNotFoundException e) {
                // Handle ClassNotFoundException, possibly print an error message
                System.out.println("ClassNotFoundException: " + e.getMessage());
                status = "Something went wrong";
            } catch (SQLException e) {
                if(e.getErrorCode() >= 900 && e.getErrorCode() <= 999) {
                    System.out.println("Invalid column name");
                }
                // Handle other SQLExceptions and redirect back to the login page with an error message if needed
                status = "Something went wrong";
            }

}
else
{
	status = "Something went wrong 2";
	out.print(id+" "+password);
	}
 }
           %>
           <p><%= status %> <p>

    </div>
</body>
</html>