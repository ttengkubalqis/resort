<%@ page session="true" %>
<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="com.mdresort.ConnectionManager" %>

<%
    // Check for active session
    if (session == null || session.getAttribute("customer_email") == null) {
        response.sendRedirect("MdResort_LOGIN.html?error=SessionExpired");
        return;
    }

    // Initialize variables
    String customerEmail = (String) session.getAttribute("customer_email");
    String firstName = null;
    String lastName = null;
    String customerPhoneNo = null;

    // Generate CSRF Token for security
    String csrfToken = UUID.randomUUID().toString();
    session.setAttribute("csrfToken", csrfToken);

    // Database connection setup
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Establishing connection with Azure DB using ConnectionManager
        conn = ConnectionManager.getConnection();

        // Query to fetch user's profile details
        String query = "SELECT firstName, lastName, customerEmail, customerPhoneNo FROM Customer WHERE customerEmail = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, customerEmail);
        rs = pstmt.executeQuery();

        // Retrieve user details if found
        if (rs.next()) {
            firstName = rs.getString("firstName");
            lastName = rs.getString("lastName");
            customerPhoneNo = rs.getString("customerPhoneNo");
        }
    } catch (SQLException e) {
        System.err.println("Error occurred while fetching user details: " + e.getMessage());
    } finally {
        // Close resources
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Your Profile - MD Resort</title>
  <style>
    /* General Styles */
    body {
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f7fa;
    }

    /* Header */
    header {
        background: linear-gradient(to bottom, #c7e2e4, #fae888);
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 15px 25px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        position: sticky;
        top: 0;
        z-index: 1000;
        width: 100%;
    }

    .header-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        max-width: 1200px;
        margin: 0 auto;
        width: 100%;
    }

    header .logo img {
        height: 40px;
        margin-right: 10px;
    }

    header .logo a {
        font-family: 'Poppins', sans-serif;
        font-size: 24px;
        font-weight: 600;
        text-decoration: none;
        color: black;
    }

    header nav ul {
        list-style: none;
        display: flex;
        margin: 0;
        padding: 0;
    }

    header nav ul li {
        margin-left: 20px;
    }

    header nav ul li a {
        text-decoration: none;
        color: black;
        font-weight: bold;
        padding: 5px 10px;
    }

    header .dropdown {
        position: relative;
    }

    header .dropdown .dropdown-room {
        display: none;
        position: absolute;
        top: 100%;
        left: 0;
        background-color: #fff;
        border-radius: 5px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        min-width: 150px;
    }

    header .dropdown:hover .dropdown-room {
        display: block;
    }

    header .dropdown-room a {
        display: block;
        padding: 10px;
        color: black;
        text-decoration: none;
    }

    header .dropdown-room a:hover {
        background-color: #f0f0f0;
    }

    /* Content Section */
    .profile-container {
        max-width: 600px;
        margin: 50px auto;
        background-color: #fff;
        padding: 30px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
    }

    .profile-container h1 {
        text-align: center;
        margin-bottom: 20px;
    }

    .profile-container p {
        margin: 10px 0;
        font-size: 16px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .edit-btn {
        background-color: #007bff;
        color: white;
        border: none;
        padding: 5px 10px;
        border-radius: 5px;
        cursor: pointer;
    }

    .delete-btn {
        background-color: #dc3545;
        color: white;
        border: none;
        padding: 10px 15px;
        border-radius: 5px;
        cursor: pointer;
        margin-top: 20px;
    }

    /* Footer */
    footer {
        background: linear-gradient(to bottom, #c7e2e4, #fae888);
        padding: 20px;
        text-align: center;
    }

    .footer-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        max-width: 1200px;
        margin: auto;
    }

    .footer-logo img {
        height: 50px;
    }

    .social-icons img {
        width: 30px;
        margin: 0 10px;
    }

    .footer-links li {
        list-style: none;
        display: inline-block;
        margin: 0 15px;
    }

    .footer-links li a {
        color: black;
        font-family: 'Poppins', sans-serif;
        font-size: 16px;
        text-decoration: none;
    }

    .footer-links li a:hover {
        color: #28a745;
        text-decoration: underline;
    }
  </style>
</head>
<body>
  <!-- Header Section -->
  <header>
    <div class="header-container">
      <div class="logo">
        <a href="MdResort_HOMEPAGE.html">
          <img src="MdResort_logo.png" alt="MD Resort Logo">
        </a>
        <a href="MdResort_HOMEPAGE.html">MD Resort</a>
      </div>
      <nav>
        <ul>
          <li><a href="MdResort_HOMEPAGE.html">HOME</a></li>
          <li class="dropdown">
            <a href="MdResort_ROOM.html">ROOM</a>
            <div class="dropdown-room">
              <a href="MdResort_ROOM_FAMILY.html">FAMILY</a>
              <a href="MdResort_ROOM_CABIN.html">CABIN</a>
              <a href="MdResort_ROOM_WOOD.html">WOOD</a>
            </div>
          </li>
          <li><a href="MdResort_FACILITIES.html">FACILITIES</a></li>
          <li><a href="MdResort_SIGNUP.html">Sign Up</a></li>
          <li><a href="MdResort_LOGIN.html">Log In</a></li>
        </ul>
      </nav>
    </div>
  </header>

  <!-- Profile Content -->
  <div class="profile-container">
    <h1>Your Profile</h1>
    <p><strong>First Name:</strong> <%= firstName %> <button class="edit-btn">Edit</button></p>
    <p><strong>Last Name:</strong> <%= lastName %> <button class="edit-btn">Edit</button></p>
    <p><strong>Email:</strong> <%= customerEmail %> <button class="edit-btn">Edit</button></p>
    <p><strong>Phone Number:</strong> <%= customerPhoneNo %> <button class="edit-btn">Edit</button></p>
    <button class="delete-btn">Delete Account</button>
  </div>

  <!-- Footer Section -->
  <footer>
    <div class="footer-container">
      <div class="footer-logo">
        <img src="MdResort_logo.png" alt="Logo">
      </div>
      <div class="social-icons">
        <a href="#"><img src="facebook_icon.png" alt="Facebook"></a>
        <a href="#"><img src="instagram_icon.png" alt="Instagram"></a>
        <a href="#"><img src="whatsapp_icon.png" alt="WhatsApp"></a>
      </div>
      <ul class="footer-links">
        <li><a href="MdResort_HOMEPAGE.html">Home</a></li>
        <li><a href="MdResort_ROOM.html">Room</a></li>
        <li><a href="MdResort_FACILITIES.html">Facilities</a></li>
      </ul>
    </div>
  </footer>
</body>
</html>
