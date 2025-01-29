<%@ page session="true" %>
<%@ page import="java.util.*" %>

<%
    String lastName = (session != null) ? (String) session.getAttribute("last_name") : null;
    boolean isLoggedIn = (lastName != null);
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Family Room - MD Resort</title>
  <style>
    /* General Styling */
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f7fa;
    }
    header {
        background: linear-gradient(to bottom, #c7e2e4, #fae888);
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px 25px;
    }
    .logo {
        display: flex;
        align-items: center;
    }
    .logo img {
        height: 40px;
        margin-right: 10px;
    }
    .logo a {
        font-size: 18px;
        color: black;
        text-decoration: none;
        font-weight: bold;
    }
    nav ul {
        list-style: none;
        display: flex;
        margin: 0;
        padding: 0;
    }
    nav ul li {
        margin-left: 20px;
        position: relative;
    }
    nav ul li a {
        text-decoration: none;
        color: black;
        font-weight: bold;
        padding: 5px 20px;
    }
    nav ul li a.btn {
        background: black;
        color: white;
        border-radius: 10px;
        padding: 10px 20px;
    }
    nav ul li a.btn:hover {
        background: yellow;
        color: black;
    }
    .profile-icon {
        display: flex;
        align-items: center;
        cursor: pointer;
    }
    .profile-icon img {
        height: 30px;
        width: 30px;
        border-radius: 50%;
        margin-right: 5px;
    }
    .content {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        padding: 20px;
        gap: 20px;
    }
    .details {
        flex: 2;
        background-color: #fff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    .details img.room-image {
        width: 100%;
        height: 300px;
        object-fit: cover;
        border-radius: 8px;
        margin-bottom: 15px;
    }
    .details h1 {
        font-size: 24px;
        margin-bottom: 10px;
        color: #333;
    }
    .details p {
        font-size: 16px;
        line-height: 1.6;
        color: #666;
    }
    .reservation {
        flex: 1;
        background-color: #fff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    .reservation h2 {
        font-size: 20px;
        margin-bottom: 15px;
        color: #333;
        text-align: center;
    }
    .reservation form {
        display: flex;
        flex-direction: column;
    }
    .reservation label {
        font-size: 14px;
        margin-bottom: 5px;
        color: #555;
    }
    .reservation input,
    .reservation select,
    .reservation button {
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 14px;
    }
    .reservation button {
        background-color: black;
        color: white;
        border: none;
        cursor: pointer;
        font-size: 16px;
    }
    .reservation button:hover {
        background-color: yellow;
    }
    footer {
        background: linear-gradient(to bottom, #c7e2e4, #fae888);
        text-align: center;
        padding: 20px 0;
    }
    .footer-container {
        max-width: 1200px;
        margin: 0 auto;
    }
    .footer-logo img {
        max-width: 100px;
        margin-bottom: 5px;
    }
    .social-icons {
        margin: 10px 0;
    }
    .social-icons a img {
        width: 30px;
        height: 30px;
    }
    .footer-links {
        list-style: none;
        padding: 0;
        margin-top: 10px;
        display: flex;
        justify-content: center;
        gap: 20px;
    }
    .footer-links a {
        color: black;
        text-decoration: none;
        font-size: 14px;
    }
    .footer-links a:hover {
        text-decoration: underline;
    }
  </style>
</head>
<body>
<header>
    <div class="logo">
        <img src="MdResort_logo.png" alt="MD Resort Logo">
        <a href="MdResort_HOMEPAGE.jsp">MD Resort</a>
    </div>
    <nav>
        <ul>
            <li><a href="MdResort_HOMEPAGE.jsp">HOME</a></li>
            <li class="dropdown">
                <a href="MdResort_ROOM.jsp">ROOM</a>
            </li>
            <li><a href="MdResort_FACILITIES.html">FACILITIES</a></li>
            <% if (isLoggedIn) { %>
                <li>
                    <div class="profile-icon">
                        <img src="profile-icon.png" alt="Profile">
                        <span><%= lastName %></span>
                    </div>
                </li>
            <% } else { %>
                <li><a href="MdResort_LOGIN.html" class="btn">Log In</a></li>
                <li><a href="MdResort_SIGNUP.html" class="btn">Sign Up</a></li>
            <% } %>
        </ul>
    </nav>
</header>

<div class="content">
    <div class="details">
        <h1>Family Room</h1>
        <p>From RM90 / night</p>
        <img src="familyy.jpeg" alt="Family Room" class="room-image">
        <p>All our rooms have small windows to help you take a view of the beach nearby. For this wood house, we offer a room with one single bed, one queen bed, and a bathroom completed with a hot shower, which brings relaxation to you after a long day.</p>
        <p>Fast WiFi connection, satellite TV, and standard electric socket are standard throughout the Resort.</p>
    </div>
    <div class="reservation">
        <h2>Your Reservation</h2>
        <form>
            <label for="checkin">Check In Date</label>
            <input type="date" id="checkin" name="checkin">
            <label for="checkout">Check Out Date</label>
            <input type="date" id="checkout" name="checkout">
            <label for="children">Children</label>
            <select id="children" name="children">
                <option value="0">0</option>
                <option value="1">1</option>
                <option value="2">2</option>
            </select>
            <label for="adults">Adults</label>
            <select id="adults" name="adults">
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
            </select>
            <button type="submit">Check Availability</button>
        </form>
    </div>
</div>

<footer>
    <div class="footer-container">
        <div class="footer-logo">
            <img src="MdResort_logo.png" alt="Logo">
        </div>
        <div class="social-icons">
            <a href="https://facebook.com"><img src="facebook_icon.png" alt="Facebook"></a>
            <a href="https://instagram.com"><img src="instagram_iconn.png" alt="Instagram"></a>
            <a href="https://whatsapp.com"><img src="whatsapp_icon.png" alt="WhatsApp"></a>
        </div>
        <ul class="footer-links">
            <li><a href="MdResort_HOMEPAGE.jsp">Home</a></li>
            <li><a href="MdResort_ROOM.jsp">Room</a></li>
            <li><a href="MdResort_FACILITIES.html">Facilities</a></li>
        </ul>
    </div>
</footer>
</body>
</html>
