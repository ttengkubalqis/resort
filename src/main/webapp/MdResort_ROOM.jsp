<%@ page session="true" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MD Resort - Room</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: white;
        }
        header {
            background: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 25px;
            font-size: 18px;
            color: #728687;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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
            color: #728687;
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
            color: #728687;
            font-weight: bold;
            padding: 5px 20px;
        }
        nav ul li a.btn {
            background: #728687;
            color: white;
            border-radius: 10px;
            padding: 13px 25px;
        }
        nav ul li a.btn:hover {
            background: #04aa6d;
            color: white;
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
        .profile-icon span {
            color: black;
            font-weight: bold;
            margin-left: 5px;
        }
        .reservation-form {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px;
            margin: 20px auto;
            max-width: 900px;
            background-color: #f4f7fa;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
        }
        .reservation-form input, .reservation-form select {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
            flex: 1;
            text-align: center;
        }
        .reservation-form button {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }
        .reservation-form button:hover {
            background-color: #0056b3;
        }
        .main-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            padding: 20px;
        }
        .content3 {
            background-color: #f4f4f4;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            padding: 15px;
        }
        .content3 img.room-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            margin-top: 10px;
            background-color: #007BFF;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-weight: bold;
        }
        .button:hover {
            background-color: #0056b3;
        }
        footer {
            background: #728687;
            color: white;
            text-align: center;
            padding: 10px 0;
            margin-top: auto;
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
        .social-icons a {
            margin: 0 10px;
            display: inline-block;
        }
        .social-icons a img {
            width: 30px;
            height: 30px;
        }
        .footer-links {
            list-style: none;
            padding: 0;
            margin-top: 10px;
            border-top: 1px solid #8B6A50;
            display: flex;
            justify-content: center;
            gap: 20px;
            padding-top: 10px;
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
        <img src="MdResort_logo.png" alt="Logo">
        <a href="MdResort_HOMEPAGE.jsp">MD Resort</a>
    </div>
    <nav>
        <ul>
            <li><a href="MdResort_HOMEPAGE.jsp">HOME</a></li>
            <li><a href="MdResort_ROOM.jsp">ROOM</a></li>
            <li><a href="MdResort_FACILITIES.html">FACILITIES</a></li>
            <% 
                String customerName = (String) session.getAttribute("customer_name");
                if (customerName != null) {
            %>
            <li><div class="profile-icon">
                <img src="profile-icon.png" alt="Profile">
                <span>Welcome, <%= customerName %>!</span>
            </div></li>
            <li><a href="LogoutServlet" style="color: red;">Logout</a></li>
            <% } else { %>
            <li><a href="MdResort_LOGIN.html" class="btn">Log In</a></li>
            <li><a href="MdResort_SIGNUP.html" class="btn">Sign Up</a></li>
            <% } %>
        </ul>
    </nav>
</header>
<img src="room_front.png" style="width: 100%;">
<div class="reservation-form">
    <form action="CheckAvailabilityServlet" method="GET">
        <input type="date" name="checkInDate" required>
        <input type="date" name="checkOutDate" required>
        <select name="adults">
            <option value="1">1 adult</option>
            <option value="2">2 adults</option>
            <option value="3">3 adults</option>
        </select>
        <select name="kids">
            <option value="0">0 kids</option>
            <option value="1">1 kid</option>
            <option value="2">2 kids</option>
        </select>
        <button type="submit">Check Availability</button>
    </form>
</div>
<main class="main-content">
    <div class="content3">
        <h2>Family Room</h2>
        <img src="family-room.jpg" alt="Family Room" class="room-image">
        <p>From RM150 / night</p>
        <a href="MdResort_ROOM_FAMILY.jsp" class="button">More</a>
    </div>
    <div class="content3">
        <h2>Cabin Room</h2>
        <img src="cabin-room.jpg" alt="Cabin Room" class="room-image">
        <p>From RM100 / night</p>
        <a href="MdResort_ROOM_CABIN.jsp" class="button">More</a>
    </div>
    <div class="content3">
        <h2>Wood Room</h2>
        <img src="wood-room.jpg" alt="Wood Room" class="room-image">
        <p>From RM150 / night</p>
        <a href="MdResort_ROOM_WOOD.jsp" class="button">More</a>
    </div>
</main>
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
