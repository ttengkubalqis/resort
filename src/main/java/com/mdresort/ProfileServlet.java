package com.mdresort;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.UUID;

public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String customerEmail = (String) session.getAttribute("customer_email");

        if (customerEmail == null) {
            response.sendRedirect("MdResort_LOGIN.html");
            return;
        }

        String csrfToken = UUID.randomUUID().toString();
        session.setAttribute("csrfToken", csrfToken); // Prevent CSRF attacks

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Azure SQL Database connection details
            String url = "jdbc:sqlserver://mdresortdb.database.windows.net;databaseName=MDResortDB";
            String username = "mdresortadmin";
            String password = "mdresort_2024";

            conn = DriverManager.getConnection(url, username, password);

            String query = "SELECT firstName, lastName, customerEmail, customerPhoneNo, customerPassword FROM Customer WHERE customerEmail = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, customerEmail);

            rs = stmt.executeQuery();

            if (rs.next()) {
                session.setAttribute("first_name", rs.getString("firstName"));
                session.setAttribute("last_name", rs.getString("lastName"));
                session.setAttribute("customer_email", rs.getString("customerEmail"));
                session.setAttribute("customer_phoneno", rs.getString("customerPhoneNo"));
                session.setAttribute("customer_password", rs.getString("customerPassword"));
            } else {
                session.setAttribute("error_message", "User not found.");
                response.sendRedirect("MdResort_LOGIN.html");
                return;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("error_message", "An error occurred while fetching the user data.");
            response.sendRedirect("MdResort_LOGIN.html");
            return;
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/MdResort_PROFILE.jsp");
        dispatcher.forward(request, response);
    }
}
