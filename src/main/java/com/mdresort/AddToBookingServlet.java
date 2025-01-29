package com.mdresort;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.http.HttpSession;

public class AddToBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve room details from the request
            String roomType = request.getParameter("roomType");
            int roomID = Integer.parseInt(request.getParameter("roomID"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            double price = Double.parseDouble(request.getParameter("price"));

            // Retrieve stay details and customer details from the session
            HttpSession session = request.getSession();

            String checkInDate = (String) session.getAttribute("checkInDate");
            String checkOutDate = (String) session.getAttribute("checkOutDate");
            Integer adults = (Integer) session.getAttribute("adults");
            Integer kids = (Integer) session.getAttribute("kids");

            if (checkInDate == null || checkOutDate == null || adults == null || kids == null) {
                response.getWriter().println("Error: Missing stay details. Please start the booking process again.");
                return;
            }

            // Log retrieved details for debugging
            System.out.println("Stay Details:");
            System.out.println("Check-In Date: " + checkInDate);
            System.out.println("Check-Out Date: " + checkOutDate);
            System.out.println("Adults: " + adults);
            System.out.println("Kids: " + kids);

            String customerName = (String) session.getAttribute("customer_name");
            String customerEmail = (String) session.getAttribute("customer_email");
            String customerPhoneNo = (String) session.getAttribute("customer_phoneno");

            System.out.println("Customer Details:");
            System.out.println("Name: " + customerName);
            System.out.println("Email: " + customerEmail);
            System.out.println("Phone: " + customerPhoneNo);

            // Create a RoomBooking object for the new room
            RoomBooking newBooking = new RoomBooking(roomID, roomType, quantity, price);

            // Get or initialize the booking list in the session
            @SuppressWarnings("unchecked")
            List<RoomBooking> bookingList = (List<RoomBooking>) session.getAttribute("bookingList");
            if (bookingList == null) {
                bookingList = new ArrayList<>();
            }

            // Check if the room type already exists in the booking list
            boolean roomExists = false;
            for (RoomBooking booking : bookingList) {
                if (booking.getRoomType().equalsIgnoreCase(roomType)) {
                    // Update quantity for the same room type
                    booking.setQuantity(booking.getQuantity() + quantity);
                    roomExists = true;
                    break;
                }
            }

            // If the room type doesn't exist, add the new booking to the list
            if (!roomExists) {
                bookingList.add(newBooking);
            }

            // Save the updated booking list in the session
            session.setAttribute("bookingList", bookingList);

            // Debugging: Output the booking list
            System.out.println("Updated Booking List:");
            for (RoomBooking booking : bookingList) {
                System.out.println("Room Type: " + booking.getRoomType() +
                        ", Quantity: " + booking.getQuantity() +
                        ", Price: " + booking.getPrice());
            }

            // Redirect to the Booking List page
            response.sendRedirect("BookingList.jsp");
        } catch (NumberFormatException e) {
            // Handle the error gracefully
            e.printStackTrace();
            response.getWriter().println("Error: Invalid input data. Please check the values you provided.");
        }
    }
}
