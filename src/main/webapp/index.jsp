<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cruise Management System</title>

    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <!-- Disney Font -->
    <link href="https://fonts.googleapis.com/css2?family=Macondo&display=swap" rel="stylesheet">

    <!-- Font Awesome (for icons) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            font-family: 'Macondo', 'Segoe UI Emoji', sans-serif;
            background-image: url('images/cruise.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            height: 100vh;
            margin: 0;
            padding: 0;
            color: #fff;
        }

        .navbar {
            background-color: #000;
        }

        .navbar-brand {
            transition: all 0.4s ease-in-out;
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 5px 10px;
            border-radius: 12px;
        }

        .navbar-brand:hover {
            transform: scale(1.05);
            background-color: rgba(255, 255, 255, 0.05);
            box-shadow: 0 0 12px #ffcc00, 0 0 20px #ff8c00;
        }

        .brand-text {
            font-family: 'Macondo', cursive;
            font-size: 26px;
            color: #fff;
            transition: color 0.3s ease;
        }

        .navbar-brand:hover .brand-text {
            color: #ffcc00;
            text-shadow: 2px 2px 5px #fff;
        }

        .navbar-nav .nav-item .nav-link {
            font-size: 18px;
            padding: 10px 15px;
            transition: background-color 0.3s, color 0.3s;
            color: white;
        }

        .navbar-nav .nav-item .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: #ffcc00;
            border-radius: 4px;
        }

        .container {
            margin-top: 120px;
            background-color: rgba(0, 0, 0, 0.7);
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
            max-width: 600px;
            text-align: center;
        }

        h1 {
            font-size: 36px;
            font-weight: bold;
            color: #FFD700;
            margin-bottom: 20px;
        }

        p {
            font-size: 18px;
            margin-bottom: 30px;
            color: #ddd;
        }

        .footer {
            text-align: center;
            margin-top: 20px;
            color: #bbb;
            text-shadow: 1px 1px 3px #000;
            font-size: 16px;
        }
    </style>
</head>
<body>

<!-- ✅ Navigation Bar (updated to Disney style, links unchanged) -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <a class="navbar-brand" href="#">
        <span class="brand-text">CRUISE MANAGEMENT</span>
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto d-flex align-items-center">
            <li class="nav-item">
                <a class="nav-link d-flex align-items-center" href="Login">
                    <i class="fas fa-sign-in-alt mr-1"></i> Login
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link d-flex align-items-center" href="ViewCruise">
                    <i class="fas fa-ship mr-1"></i> View Cruises
                </a>
            </li>
        </ul>
    </div>
</nav>

<!-- ✅ Welcome Section -->
<div class="container">
    <h1>Welcome to Cruise Management System</h1>
    <p>Explore the world’s most luxurious cruises with us!</p>
</div>

<!-- ✅ Footer -->
<div class="footer">
    &copy; 2025 Cruise Management System. All rights reserved.
</div>

<!-- ✅ Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<%
    String logoutSuccess = request.getParameter("logout");
    if ("success".equals(logoutSuccess)) {
%>
<script>
    alert('You have been successfully logged out!');
</script>
<%
    }
%>


</body>
</html>
