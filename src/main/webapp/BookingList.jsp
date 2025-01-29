<%@ page session="true" %>
<%@ page import="java.util.*" %>
<%@ page import="com.mdresort.RoomBooking" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fa;
            margin: 0;
        }
        header, footer {
            background: #003580;
            color: white;
            text-align: center;
            padding: 15px 0;
        }
        main {
            max-width: 900px;
            margin: 20px auto;
            background: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
        }
        th {
            background-color: #003580;
            color: white;
        }
        .no-data {
            color: red;
            text-align: center;
        }
        .buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .buttons button {
            padding: 10px 20px;
            background: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .buttons button:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
<header>
    <h1>Booking List</h1>
</header>
<main>
    <h2>Customer Details</h2>
    <p><strong>Name:</strong> <%= session.getAttribute("customer_name") %></p>
    <p><strong>Email:</strong> <%= session.getAttribute("customer_email") %></p>
    <p><strong>Phone Number:</strong> <%= session.getAttribute("customer_phoneno") %></p>

    <h2>Stay Details</h2>
    <p><strong>Check-In Date:</strong> <%= session.getAttribute("checkInDate") %></p>
    <p><strong>Check-Out Date:</strong> <%= session.getAttribute("checkOutDate") %></p>
    <p><strong>Adults:</strong> <%= session.getAttribute("adults") %></p>
    <p><strong>Kids:</strong> <%= session.getAttribute("kids") %></p>

    <h2>Rooms Booked</h2>
    <table>
        <thead>
            <tr>
                <th>Room Type</th>
                <th>Quantity</th>
                <th>Price Per Night</th>
                <th>Total Price</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<RoomBooking> bookingList = (List<RoomBooking>) session.getAttribute("bookingList");
                double totalCost = 0;
                if (bookingList != null && !bookingList.isEmpty()) {
                    for (RoomBooking booking : bookingList) {
                        double roomTotal = booking.getQuantity() * booking.getPrice();
                        totalCost += roomTotal;
            %>
            <tr>
                <td><%= booking.getRoomType() %></td>
                <td><%= booking.getQuantity() %></td>
                <td>RM<%= booking.getPrice() %></td>
                <td>RM<%= roomTotal %></td>
            </tr>
            <%
                    }
            %>
            <tr>
                <th colspan="3">Grand Total</th>
                <th>RM<%= totalCost %></th>
            </tr>
            <%
                } else {
            %>
            <tr>
                <td colspan="4" class="no-data">No rooms added to booking.</td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
    <div class="buttons">
        <form action="CheckAvailabilityServlet" method="GET">
            <input type="hidden" name="checkInDate" value="<%= session.getAttribute("checkInDate") %>">
            <input type="hidden" name="checkOutDate" value="<%= session.getAttribute("checkOutDate") %>">
            <input type="hidden" name="adults" value="<%= session.getAttribute("adults") %>">
            <input type="hidden" name="kids" value="<%= session.getAttribute("kids") %>">
            <button type="submit">Add More Rooms</button>
        </form>
        <form action="ConfirmBookingServlet" method="POST">
            <button type="submit">Confirm Booking</button>
        </form>
    </div>
</main>
<footer>
    <p>&copy; 2025 MD Resort</p>
</footer>
</body>
</html>
