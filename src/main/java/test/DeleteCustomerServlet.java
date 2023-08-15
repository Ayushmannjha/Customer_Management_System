package test;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteCustomerServlet")
public class DeleteCustomerServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String first_name = request.getParameter("first_name");
        String last_name = request.getParameter("last_name");

        try {
            // Replace with your database credentials
            String dbUrl = "jdbc:oracle:thin:@localhost:1521:xe";
            String dbUsername = "system";
            String dbPassword = "manager";

            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

            String deleteQuery = "DELETE FROM Customer WHERE first_name = ? AND last_name = ?";
            PreparedStatement statement = connection.prepareStatement(deleteQuery);
            statement.setString(1, first_name);
            statement.setString(2, last_name);
            int rowsDeleted = statement.executeUpdate();

            statement.close();
            connection.close();

            if (rowsDeleted > 0) {
                // Redirect back to CoustmerInfo.jsp
            	request.getRequestDispatcher("CoustmerInfo.jsp").forward(request, response);
            } else {
            	request.setAttribute("updateMessage", "Not deleted");
            	request.getRequestDispatcher("CoustmerInfo.jsp").forward(request, response);

            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred.");
        }
    }
}
