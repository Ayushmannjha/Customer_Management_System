<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Info</title>
 <link rel="stylesheet" href="log.css">
 <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f2f2f2;
        }

        h1 {
            text-align: center;
            margin: 20px 0;
        }

        table {
            width: 100%;
            margin: 0 auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        a {
            text-decoration: none;
            color: #007bff;
        }
        #ne{
        padding: 10px 12px;
        background-color: white;
        border: 1px solid gray;
        border-radius: 10px;
        }
        #ne:hover{
        background-color: #d3dbd5;
      
        }
    </style>
</head>
<body>
    <%
    // Check if the user is authenticated (logged in)
    if (session.getAttribute("loggedIn") == null) {
    // User is not authenticated, redirect to the login page
    response.sendRedirect("index.jsp");
    return; // Stop further processing of the JSP page
} else {
        // User is authenticated, display the customer information
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "manager");
            String query = "SELECT * FROM Customer";
            PreparedStatement pst = con.prepareStatement(query);
            
            ResultSet rs = pst.executeQuery();
            
            %>
            <table>
                <button id="ne"><a href="create.jsp">Add an employee</a></button>
                <tr>
                    <th>first_name</th>
                    <th>last_name</th>
                    <th>street</th>
                    <th>address</th>
                    <th>city</th>
                    <th>state</th>
                    <th>email</th>
                    <th>phone</th>
                    <th>Action</th>
                </tr>
                
                <%
                while (rs.next()) {
                    String first_name = rs.getString(1);
                    String last_name = rs.getString(2);
                    String street = rs.getString(3);
                    String address = rs.getString(4);
                    String city = rs.getString(5);
                    String state = rs.getString(6);
                    String email = rs.getString(7);
                    String phone = rs.getString(8);
            %>
            
            <tr>
                <td><%=first_name%></td>
                <td><%=last_name%></td>
                <td><%=street%></td>
                <td><%=address%></td>
                <td><%=city%></td>
                <td><%=state%></td>
                <td><%=email%></td>
                <td><%=phone%></td>
                <td>
    <a href="edit.jsp?first_name=<%=first_name%>&last_name=<%=last_name%>&street=<%=street%>&address=<%=address%>&city=<%=city%>&state=<%=state%>&email=<%=email%>&phone=<%=phone%>">Edit</a>
    <a href="DeleteCustomerServlet?first_name=<%=first_name%>&last_name=<%=last_name%>&street=<%=street%>&address=<%=address%>&city=<%=city%>&state=<%=state%>&email=<%=email%>&phone=<%=phone%>">Delete</a>
</td>

            </tr>
            
            <%
                }
                pst.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            %>
        </table>
    <%
    }
    %>
</body>
</html>
