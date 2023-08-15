<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.util.regex.Matcher"%>
<%@ page import="java.util.regex.Pattern"%>
<%@ page import="java.sql.PreparedStatement"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <link rel="stylesheet" href="./style.css">
<title>Coustmer details</title>
</head>
<body>
	<div class="container">
		

		<div class="form-container">
			<h1>Coustmer details</h1>
			<form action="create.jsp" method="post">
				<input type="text" name="first_name" placeholder="first_name" required>
            <input type="text" name = "last_name" placeholder="last_name " required>
            
            <input type="text" name = "street" placeholder="street" required>
            <input type="text" name = "address" placeholder="Address" required>
			<input type="text" name="city" placeholder="City" required>
            <input type="text" name="state" placeholder="State" required>
            
            <input type="email" name="email" placeholder="Email" required>
            <input type="tel" name="Phone_number" placeholder="Phone_number" required>
           
            <input type="submit" value="Submit" class="btn " style="cursor: pointer;">
			</form>
			
			<%!public static boolean validPhone(String s) {
		Pattern p = Pattern.compile("(0|91)?[6-9][0-9]{9}");
		Matcher m = p.matcher(s);
		if (m.find() && m.group().equals(s)) {
			return true;
		} else {
			return false;
		}
	}

	public static boolean validName(String s) {
		Pattern p = Pattern.compile("^[a-zA-Z]+(?:[\\s-][a-zA-Z]+)*$");
		Matcher m = p.matcher(s);
		if (m.find() && m.group().equals(s)) {
			return true;
		} else {
			return false;
		}
	}
	
	public static boolean validPassword(String s) {
		String passwordRegex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,}$";

		Pattern p = Pattern.compile(passwordRegex);
		Matcher m = p.matcher(s);
		if (m.find() && m.group().equals(s)) {
			return true;
		} else {
			return false;
		}
	}
	%>
			<%
			String succfail = "";
			String anyissue = "";

			// Check if the form has been submitted
			if (request.getMethod().equalsIgnoreCase("post")) {
				String first_name = request.getParameter("first_name");
				String last_name = request.getParameter("last_name");
				String street = request.getParameter("street");
				String address = request.getParameter("address");
				String city = request.getParameter("city");
				String state = request.getParameter("state");
				String email = request.getParameter("email");
				String Phone = request.getParameter("Phone_number");
				// Validate that all required fields are filled
				if (first_name != null && !first_name.isEmpty() &&
				        last_name != null && !last_name.isEmpty() &&
				        email != null && !email.isEmpty() &&
				        Phone != null && !Phone.isEmpty() && // Corrected variable name
				        state != null && !state.isEmpty() &&
				        address != null && !address.isEmpty() && // Assuming address is required
				        city != null && !city.isEmpty()){

					try {
				Class.forName("oracle.jdbc.driver.OracleDriver");
				Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system",
						"manager");
				PreparedStatement pst = con.prepareStatement(
						"INSERT INTO Customer VALUES(?, ?, ?, ?, ?, ?,?,?)");
				
				// Validate name and phone using the regex patterns
				if (validName(first_name)&&validName(last_name)) {
					pst.setString(1, first_name);
					pst.setString(2, last_name);
				} else {
					anyissue = ("<p>Invalid name</p>");
					first_name = request.getParameter("name");
					last_name = request.getParameter("name");
				}

				pst.setString(3, street);
				pst.setString(4, address);
				pst.setString(5, city);
				pst.setString(6, state);
				pst.setString(7, email);
				
				if (validPhone(Phone)) {
					pst.setString(8, Phone);
				} else {
					anyissue = ("<p>Invalid phone number</p>");
					Phone = request.getParameter("Phone");
				}

				
				int status = pst.executeUpdate();
			
				pst.close();
			
				con.close();

				if (status > 0) {
					anyissue = "Details submitted successfully";
				} else {
					out.println("<p>Something went wrong. Please try again.</p>");
				}
					} catch (java.sql.SQLIntegrityConstraintViolationException e) {
				out.println("<p>User already exists.</p>");
					} catch (Exception e) {
						 e.printStackTrace();
				out.println("<p>Something went wrong. Please try again.</p>");
					}
				} else {
					out.println("<p>Please fill all the required fields.</p>");
					System.out.println(first_name +" "+ last_name +" "+street+ " "+ address + " "+state+ " "+ city+" " +email+" "+Phone);
				}
			}
			%>
			<p id="acstatus"><%=succfail%></p>
			<p id="acstatus"><%=anyissue%></p>
			
		</div>
	</div>
</body>
</html>
