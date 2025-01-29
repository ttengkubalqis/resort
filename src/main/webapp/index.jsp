<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login - MD Resort</title>
  <link rel="stylesheet" href="styles.css">
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      background-color: #f8f9fa;
      color: #728687;
    }

    .container {
      text-align: center;
    }

    .login-box {
      width: 400px;
      margin: 50px auto;
      background: white;
      border-radius: 8px;
      padding: 40px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .logo img {
      width: 100px;
      height: auto;
    }

    .logo h1 {
      font-size: 24px;
      margin: 10px 0;
      color: #728687;
    }

    .tab-menu {
      display: flex;
      justify-content: space-around;
      margin-bottom: 20px;
    }

    .tab {
      padding: 10px 20px;
      border: none;
      cursor: pointer;
      background-color: #f1f1f1;
      color: #728687;
      border-radius: 5px 5px 0 0;
      font-weight: bold;
      font-size: 16px;
    }

    .tab.active {
      background-color: white;
      border-bottom: 2px solid #728687;
    }

    .form-group {
      text-align: left;
      margin-bottom: 15px;
    }

    .form-group label {
      display: block;
      font-weight: bold;
    }

    .form-group input {
      width: 100%;
      padding: 10px;
      margin-top: 5px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }

    .forgot-password {
      float: right;
      font-size: 12px;
      color: #007bff;
      text-decoration: none;
    }

    .forgot-password:hover {
      text-decoration: underline;
    }

    .login-button, .google-button {
      width: 100%;
      padding: 10px;
      margin-top: 10px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }

    .login-button {
      background-color: #728687;
      color: white;
      font-weight: bold;
    }

    .google-button {
      background-color: #4285f4;
      color: white;
      font-weight: bold;
    }

    .separator {
      margin: 15px 0;
      font-size: 14px;
      color: #999;
    }

    .account-link {
      margin-top: 10px;
    }

    .account-link a {
      color: #4285f4;
      text-decoration: none;
    }

    footer {
      margin-top: 20px;
      font-size: 12px;
      color: #728687;
    }

    .error-message {
      color: red;
      margin-bottom: 10px;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="login-box">
      <div class="logo">
        <img src="MdResort_logo.png" alt="Resort Logo">
        <h1>MD Resort Pantai Siring Melaka</h1>
      </div>

      <div class="tab-menu">
        <button class="tab active" onclick="switchTab('Customer')">Customer</button>
        <button class="tab" onclick="switchTab('Admin')">Admin</button>
      </div>

      <!-- Error Message -->
      <div class="error-message" id="errorMessage" style="display: none;">
        Invalid login credentials. Please try again.
      </div>

      <form id="loginForm" action="/mdresort/LoginServlet" method="post">
        <div class="form-group">
          <label for="email">Email</label>
          <input type="text" id="email" name="email" placeholder="Customer Email">
        </div>

        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" placeholder="Customer Password">
          <a href="#" class="forgot-password">Forgot your password?</a>
        </div>

        <button type="submit" class="login-button">Log In</button>
      </form>

      <div class="separator">OR</div>

      <button type="button" class="google-button">Sign in with Google</button>

      <p class="account-link" id="signupLink">
        Don't have an account? <a href="MdResort_SIGNUP.html">Sign Up</a>
      </p>

      <footer>
        <p>Contact Us</p>
        <p>MD Resort: 03 - 5644 8969 / 03 - 5644 8177</p>
      </footer>
    </div>
  </div>

  <script>
    function switchTab(tabName) {
      var loginForm = document.getElementById('loginForm');
      var signupLink = document.getElementById('signupLink');

      if (tabName === 'Customer') {
        loginForm.setAttribute('action', '/mdresort/LoginServlet');
        document.getElementById('email').setAttribute('placeholder', 'Customer Email');
        document.getElementById('password').setAttribute('placeholder', 'Customer Password');
        signupLink.style.display = 'block';
      } else if (tabName === 'Admin') {
        loginForm.setAttribute('action', 'AdminLoginController');
        document.getElementById('email').setAttribute('placeholder', 'Admin Email');
        document.getElementById('password').setAttribute('placeholder', 'Admin Password');
        signupLink.style.display = 'none';
      }

      var tabs = document.getElementsByClassName('tab');
      for (var i = 0; i < tabs.length; i++) {
        tabs[i].classList.remove('active');
      }
      document.querySelector('.tab[onclick="switchTab(\'' + tabName + '\')"]').classList.add('active');
    }

    switchTab('Customer');
  </script>
</body>
</html>
