package com.mdresort;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ReservationServiceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve reservation and customer details
        String customerName = request.getParameter("customerName");
        String customerEmail = request.getParameter("customerEmail");
        String customerPhoneNo = request.getParameter("customerPhoneNo");
        String checkInDate = request.getParameter("checkInDate");
        String checkOutDate = request.getParameter("checkOutDate");
        int totalAdults = parseOrDefault(request.getParameter("totalAdults"), 0);
        int totalKids = parseOrDefault(request.getParameter("totalKids"), 0);
        double totalPrice = parseOrDefaultDouble(request.getParameter("totalPrice"), 0.0);

        // Room details
        int roomID = parseOrDefault(request.getParameter("roomID"), 0);
        int customerID = parseOrDefault(request.getParameter("customerID"), 0);

        // Food Service details
        String menuName = request.getParameter("menuName");
        String menuPriceParam = request.getParameter("menuPrice");
        int menuQuantity = parseOrDefault(request.getParameter("menuQuantity"), 0);
        double menuPrice = parseOrDefaultDouble(menuPriceParam, 0.0);

        // Event Service details
        String venue = request.getParameter("venue");
        String eventType = request.getParameter("eventType");
        int duration = parseOrDefault(request.getParameter("duration"), 0);

        Connection conn = null;
        PreparedStatement reservationStmt = null;
        PreparedStatement serviceStmt = null;
        PreparedStatement foodServiceStmt = null;
        PreparedStatement eventServiceStmt = null;

        try {
            conn = ConnectionManager.getConnection();
            conn.setAutoCommit(false); // Enable transaction management

            // Insert into Reservation table
            String reservationInsert = "INSERT INTO Reservation (checkInDate, checkOutDate, totalAdults, totalKids, roomID, customerID, totalPayment) VALUES (?, ?, ?, ?, ?, ?, ?)";
            reservationStmt = conn.prepareStatement(reservationInsert, PreparedStatement.RETURN_GENERATED_KEYS);
            reservationStmt.setString(1, checkInDate);
            reservationStmt.setString(2, checkOutDate);
            reservationStmt.setInt(3, totalAdults);
            reservationStmt.setInt(4, totalKids);
            reservationStmt.setInt(5, roomID);
            reservationStmt.setInt(6, customerID);
            reservationStmt.setDouble(7, totalPrice);
            reservationStmt.executeUpdate();

            // Retrieve the generated reservation ID
            int reservationId = -1;
            try (var generatedKeys = reservationStmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    reservationId = generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Failed to retrieve reservation ID.");
                }
            }

            // Insert into Service table (parent table) for FoodService or EventService
            String serviceInsert = "INSERT INTO Service (serviceType) VALUES (?)";
            serviceStmt = conn.prepareStatement(serviceInsert, PreparedStatement.RETURN_GENERATED_KEYS);
            
            String serviceType = menuName != null ? "FoodService" : "EventService";
            serviceStmt.setString(1, serviceType);
            serviceStmt.executeUpdate();

            // Retrieve the generated service ID
            int serviceId = -1;
            try (var generatedKeys = serviceStmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    serviceId = generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Failed to retrieve service ID.");
                }
            }

            // Insert into FoodService table if applicable
            if (menuName != null && !menuName.isEmpty() && menuQuantity > 0) {
                String foodServiceInsert = "INSERT INTO FoodService (serviceID, menuName, menuPrice, quantityMenu) VALUES (?, ?, ?, ?)";
                foodServiceStmt = conn.prepareStatement(foodServiceInsert);
                foodServiceStmt.setInt(1, serviceId);
                foodServiceStmt.setString(2, menuName);
                foodServiceStmt.setDouble(3, menuPrice);
                foodServiceStmt.setInt(4, menuQuantity);
                foodServiceStmt.executeUpdate();
            }

            // Insert into EventService table if applicable
            if (venue != null && !venue.isEmpty() && eventType != null && !eventType.isEmpty() && duration > 0) {
                String eventServiceInsert = "INSERT INTO EventService (serviceID, venue, eventType, duration) VALUES (?, ?, ?, ?)";
                eventServiceStmt = conn.prepareStatement(eventServiceInsert);
                eventServiceStmt.setInt(1, serviceId);
                eventServiceStmt.setString(2, venue);
                eventServiceStmt.setString(3, eventType);
                eventServiceStmt.setInt(4, duration);
                eventServiceStmt.executeUpdate();
            }

            conn.commit(); // Commit transaction

            response.getWriter().println("<html><body><h3>Reservation and Services Added Successfully!</h3></body></html>");
        } catch (SQLException e) {
            // Log the full error to help with debugging
            e.printStackTrace();
            response.getWriter().println("<html><body><h3>Error: Could not save reservation or services. Please try again later.</h3></body></html>");
        } finally {
            try {
                if (reservationStmt != null) reservationStmt.close();
                if (serviceStmt != null) serviceStmt.close();
                if (foodServiceStmt != null) foodServiceStmt.close();
                if (eventServiceStmt != null) eventServiceStmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ignored) {
            }
        }
    }

    private int parseOrDefault(String value, int defaultValue) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }

    private double parseOrDefaultDouble(String value, double defaultValue) {
        if (value == null || value.trim().isEmpty()) {
            return defaultValue;
        }
        try {
            return Double.parseDouble(value);
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }
}
