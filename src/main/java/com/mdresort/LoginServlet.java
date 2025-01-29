package com.mdresort;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Helper method to hash the password (using SHA-256 for this example)
    private String hashPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hash = digest.digest(password.getBytes());
        StringBuilder hexString = new StringBuilder();
        for (byte b : hash) {
            hexString.append(String.format("%02x", b));
        }
        return hexString.toString();  // Return the hashed password
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters (email and password entered by the user)
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // JDBC connection details for Azure SQL Database
        String url = "jdbc:sqlserver://mdresort.database.windows.net:1433;databaseName=mdresort";
        String username = "mdresort";
        String dbPassword = "resort_2025";

        // SQL query to retrieve user data including hashed password
        String query = "SELECT customerID, customerName, customerPassword, customerPhoneNo FROM customer WHERE customerEmail = ?";
        
        try {
            // Hash the provided password before comparing to the stored one
            String hashedPassword = hashPassword(password);

            // Load the Microsoft SQL Server JDBC driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            // Establish connection to the Azure SQL database
            Connection conn = DriverManager.getConnection(url, username, dbPassword);

            // Prepare the SQL statement
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Check if the password matches
                String storedPassword = rs.getString("customerPassword");
                if (storedPassword.equals(hashedPassword)) {
                    // Password matches, set session attributes
                    HttpSession session = request.getSession();
                    session.setAttribute("customer_email", email);
                    session.setAttribute("customer_id", rs.getInt("customerID"));
                    session.setAttribute("customer_name", rs.getString("customerName"));
                    session.setAttribute("customer_phoneno", rs.getString("customerPhoneNo"));
                    
                    // Redirect to homepage after successful login
                    response.sendRedirect("MdResort_HOMEPAGE.jsp");
                } else {
                    // Invalid password, redirect to login page with an error message
                    response.sendRedirect("MdResort_LOGIN.jsp?error=invalid_credentials"); 
                }
            } else {
                // Invalid email, redirect to login page with an error message
                response.sendRedirect("MdResort_LOGIN.jsp?error=invalid_credentials");
            }

            // Close the statement and connection
            rs.close(); // Close ResultSet
            stmt.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException | NoSuchAlgorithmException e) {
            // Handle errors (database connection issues, etc.)
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<script type='text/javascript'>"
                    + "alert('Error: " + e.getMessage() + "');"
                    + "window.history.back();"
                    + "</script>");
        }
    }
}
