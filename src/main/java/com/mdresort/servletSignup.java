package com.mdresort;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class servletSignup extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Utility method to hash the password (SHA-256 for example)
    private String hashPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hashBytes = digest.digest(password.getBytes());
        StringBuilder hexString = new StringBuilder();
        for (byte b : hashBytes) {
            hexString.append(String.format("%02x", b));
        }
        return hexString.toString();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form parameters
        String customerName = request.getParameter("customer-name");  // Changed to 'customer-name'
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phoneNo = request.getParameter("phone-no");  // Parameter for phone number

        // Azure SQL Database JDBC connection details (should be externalized)
        String url = "jdbc:sqlserver://mdresort.database.windows.net:1433;databaseName=mdresort";
        String username = "mdresort";  // Azure username
        String dbPassword = "resort_2025";  // Azure password

        // Updated SQL query to reflect the new schema
        String insertQuery = "INSERT INTO Customer (customerName, customerEmail, customerPassword, customerPhoneNo) "
                             + "VALUES (?, ?, ?, ?)";

        try {
            // Hash password before storing
            String hashedPassword = hashPassword(password);

            // Load the SQL Server JDBC driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            // Establish connection to the Azure SQL database
            try (Connection conn = DriverManager.getConnection(url, username, dbPassword);
                 PreparedStatement stmt = conn.prepareStatement(insertQuery)) {

                // Set parameters in the prepared statement
                stmt.setString(1, customerName);  // Changed to 'customerName'
                stmt.setString(2, email);
                stmt.setString(3, hashedPassword);  // Use hashed password
                stmt.setString(4, phoneNo);  // Set the phone number

                // Execute the insert query
                int rowsAffected = stmt.executeUpdate();

                // Check if insertion was successful
                if (rowsAffected > 0) {
                    // Success - Show success popup and redirect to login page
                    response.setContentType("text/html");
                    response.getWriter().println("<script type='text/javascript'>"
                            + "alert('Sign-up successful!');"
                            + "window.location.href = 'http://localhost:8080/mdresort/MdResort_LOGIN.html';"
                            + "</script>");
                } else {
                    // Failure - Show error popup and return to signup page
                    response.setContentType("text/html");
                    response.getWriter().println("<script type='text/javascript'>"
                            + "alert('Error during sign-up. Please try again.');"
                            + "window.history.back();"
                            + "</script>");
                }
            }

        } catch (SQLException | ClassNotFoundException | NoSuchAlgorithmException e) {
            // Handle errors
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().println("<script type='text/javascript'>"
                    + "alert('Error: " + e.getMessage() + "');"
                    + "window.history.back();"
                    + "</script>");
        }
    }
}
