<%@ page session="true" %>
<%@ page import="java.util.*" %>

<%
    String customerName = (session != null) ? (String) session.getAttribute("customer_name") : null;
    boolean isLoggedIn = (customerName != null);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MD Resort</title>
    <style>
        /* Reset and basic styling */
        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            font-family: Arial, sans-serif;
            background-color: white;
            color: #728687;
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
        nav ul li .dropdown-menu {
            display: none;
            position: absolute;
            top: 30px;
            left: 0;
            background: #728687;
            padding: 10px 0;
            border-radius: 5px;
        }
        nav ul li .dropdown-menu a {
            display: block;
            padding: 10px 30px;
            color: white;
            text-decoration: none;
        }
        nav ul li .dropdown-menu a:hover {
            color: black;
        }
        nav ul li:hover .dropdown-menu {
            display: block;
        }

        header nav ul li a:hover {
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
        .profile-icon span {
            color: black;
            font-weight: bold;
            margin-left: 5px;
        }
        .welcome-section {
            text-align: center;
            padding: 50px 20px;
        }
        .welcome-section h2 {
            font-size: 50px;
            color: black;
        }
        .welcome-section p {
            font-size: 18px;
            color: black;
            max-width: 800px;
            margin: 20px auto;
            line-height: 1.6;
        }
        .features {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 30px;
            padding: 20px;
        }
        .feature {
            background-color: #f4f4f4;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            max-width: 300px;
            text-align: center;
        }
        .feature img {
            width: 100px;
            margin-bottom: 15px;
        }
        .feature h3 {
            font-size: 20px;
            color: black;
            margin-bottom: 10px;
        }
        .feature p {
            font-size: 16px;
            color: black;
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
                // Check if the user is logged in
                if (customerName != null) { 
            %>
                <li class="profile-icon">
                    <div style="display: flex; align-items: center; cursor: pointer;">
                        <img src="profile-icon.png" alt="Profile Icon" style="width: 30px; height: 30px; border-radius: 50%; margin-right: 10px;">
                        <span style="font-weight: bold; color: black;"><%= customerName %></span>
                        <div class="dropdown-menu" style="display: none; position: absolute; top: 40px; background: #728687; border-radius: 5px; padding: 10px;">
                            <a href="ProfileServlet" style="color: white; text-decoration: none; display: block; padding: 5px;">Profile</a>
                            <a href="BookingServlet" style="color: white; text-decoration: none; display: block; padding: 5px;">My Bookings</a>
                            <a href="SettingsServlet" style="color: white; text-decoration: none; display: block; padding: 5px;">Settings</a>
                            <a href="LogoutServlet" style="color: white; text-decoration: none; display: block; padding: 5px;">Logout</a>
                        </div>
                    </div>
                </li>
            <%
                } else {
            %>
                <li><a href="MdResort_LOGIN.html" class="btn">Log In</a></li>
                <li><a href="MdResort_SIGNUP.html" class="btn">Sign Up</a></li>
            <%
                }
            %>
        </ul>
    </nav>
</header>

    <img src="homebg.jpg" style="width:100%">
    <div class="welcome-section" style="text-align: center; padding: 50px 20px;">
    <h2 style="font-size: 2.5rem; color: black; margin-bottom: 20px;">How We Started?</h2>
    <div style="display: flex; align-items: center; justify-content: center; gap: 40px; padding: 10px;">
        <div style="flex: 0 0 200px; text-align: center;">
            <img src="MdResort_logo.png" alt="logo" style="max-width: 100%; height: auto; display: block; border-radius: 5px; margin-bottom: 20px;">
        </div>
        <div style="flex: 1; max-width: 600px; text-align: justify;">
            <p style="font-size: 1rem; line-height: 1.6; color: black;">
                MD Resort, founded by Nadirah Binti Abd Rahman in 2021, offers a peaceful retreat
                on Melaka's coastline. Initially a small project with eight rooms, it has grown into
                a thriving business with sixteen quaint rooms. MD Resort provides comfortable accommodations
                and flexible event rooms for various events. The resort offers amenities like an on-site
                restaurant, surau, and beachside BBQ. Nightly rates range from RM130 to RM230, and the staff
                maintains cleanliness. MD Resort is committed to providing individualized service and maintaining cleanliness.
            </p>
        </div>
    </div>
</div>


    <div class="features">
        <div class="feature">
            <img src="nature.png" alt="Nature">
            <h3>Live Amidst Nature</h3>
            <p>Feel and experience nature in its fullest glory to refresh yourself.</p>
        </div>
        <div class="feature">
            <img src="adventure.png" alt="Adventure">
            <h3>Adventure and Activities</h3>
            <p>Explore the natural beauty of Pantai with our guided tours.</p>
        </div>
        <div class="feature">
            <img src="family.png" alt="Family">
            <h3>Family Friendly</h3>
            <p>The calm and comfortable environment will make your family feel at home.</p>
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
