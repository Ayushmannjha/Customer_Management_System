package test;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateServlet
 */
@WebServlet("/UpdateServlet")
public class UpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = response.getWriter();
       	 String fname = request.getParameter("fname");
				String lname = request.getParameter("lname");
				String street = request.getParameter("street");
				String address = request.getParameter("Address");
				String city = request.getParameter("city");
				String state = request.getParameter("state");
				String email = request.getParameter("email");
				String Phone = request.getParameter("phone");
				String first_name = request.getParameter("first_name");
				String last_name = request.getParameter("last_name");
				System.out.println(first_name+last_name);
				// Validate that all required fields are filled
				if (fname != null && !fname.isEmpty() &&
						lname != null && !lname.isEmpty() &&
				        email != null && !email.isEmpty() &&
				        Phone != null && !Phone.isEmpty() && // Corrected variable name
				        state != null && !state.isEmpty() &&
				        address != null && !address.isEmpty() && // Assuming address is required
				        city != null && !city.isEmpty()){
					try{
						Class.forName("oracle.jdbc.driver.OracleDriver");
			            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "manager");
			            String query = "UPDATE Customer SET FIRST_NAME = ?, LAST_NAME = ?, STREET = ?, address = ?, city = ?, state = ?, email = ?, phone = ? WHERE FIRST_NAME = ? AND LAST_NAME = ?";
						PreparedStatement pst = con.prepareStatement(query);
			            pst.setString(1,fname);
			            pst.setString(2,lname);
			            pst.setString(3,street);
			            pst.setString(4,address);
			            pst.setString(5,city);
			            pst.setString(6,state);
			            pst.setString(7,email);
			            pst.setString(8,Phone);
			            pst.setString(9,first_name);
			            
			            pst.setString(10,last_name);
			            int status = pst.executeUpdate();
			            if(status>0){
			            	request.getRequestDispatcher("CoustmerInfo.jsp").forward(request, response);  }
			            else{
			            	request.setAttribute("updateMessage", "Row not updated");
			            	request.getRequestDispatcher("edit.jsp").forward(request, response);
			            }
			            con.close();
					}catch(Exception e){
						System.out.println(e);
					}
	out.print("<p>Something went wrong</p>");
				}
	
	
	}
					
}		
        
	


