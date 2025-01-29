package com.mdresort;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CheckAvailabilityServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Retrieve parameters from session or request
        String checkInDate = request.getParameter("checkInDate");
        String checkOutDate = request.getParameter("checkOutDate");
        String adultsParam = request.getParameter("adults");
        String kidsParam = request.getParameter("kids");

        // Validate and set defaults if missing
        if (checkInDate == null || checkOutDate == null || checkInDate.isEmpty() || checkOutDate.isEmpty()) {
            checkInDate = (String) session.getAttribute("checkInDate");
            checkOutDate = (String) session.getAttribute("checkOutDate");
        }
        int adults = (adultsParam != null) ? Integer.parseInt(adultsParam) : (Integer) session.getAttribute("adults");
        int kids = (kidsParam != null) ? Integer.parseInt(kidsParam) : (Integer) session.getAttribute("kids");

        // Store parameters in session
        session.setAttribute("checkInDate", checkInDate);
        session.setAttribute("checkOutDate", checkOutDate);
        session.setAttribute("adults", adults);
        session.setAttribute("kids", kids);

        // Retrieve customer details from session
        String customerName = (String) session.getAttribute("customer_name");
        String customerEmail = (String) session.getAttribute("customer_email");
        String customerPhoneNo = (String) session.getAttribute("customer_phoneno");

        // Debugging: Ensure customer details are carried correctly
        System.out.println("Customer Name: " + customerName);
        System.out.println("Customer Email: " + customerEmail);
        System.out.println("Customer Phone Number: " + customerPhoneNo);

        // Query available rooms
        List<Room> availableRooms = new ArrayList<>();
        String query = "SELECT * FROM Room WHERE roomStatus = 'Available' AND roomID NOT IN " +
                       "(SELECT roomID FROM Reservation WHERE checkinDate <= ? AND checkoutDate >= ?)";

        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, checkOutDate);
            stmt.setString(2, checkInDate);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    availableRooms.add(new Room(
                        rs.getInt("roomID"),
                        rs.getString("roomType"),
                        rs.getString("roomStatus"),
                        rs.getDouble("roomPrice"),
                        rs.getInt("staffID")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error: Database error occurred. " + e.getMessage());
            return;
        }

        // Pass available rooms and customer details to the JSP
        request.setAttribute("availableRooms", availableRooms);
        request.setAttribute("customerName", customerName);
        request.setAttribute("customerEmail", customerEmail);
        request.setAttribute("customerPhoneNo", customerPhoneNo);

        // Forward to AvailableRoom.jsp
        request.getRequestDispatcher("AvailableRoom.jsp").forward(request, response);
    }
}
