<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Cruise Management System</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('images/cruise.jpg'); /* Add an image in the 'images' folder */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            height: 100vh;
            margin: 0;
            padding: 0;
            color: #fff;
        }

        .navbar {
            background-color: rgba(0, 0, 0, 0.8);
            padding: 10px 20px;
        }

        .navbar-brand {
            color: #FFD700;
            font-size: 24px;
            font-weight: bold;
        }

        .nav-link {
            color: #fff;
            font-size: 16px;
            margin-left: 15px;
            transition: color 0.3s ease;
        }

        .nav-link:hover {
            color: #FFD700;
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
        }
    </style>
</head>
<body>

<!-- ✅ Navbar (Header) -->
<nav class="navbar navbar-expand-lg">
    <a class="navbar-brand" href="#">Cruise Management</a>
    <div class="collapse navbar-collapse">
        <ul class="navbar-nav ml-auto"> <!-- Align to right -->
            <li class="nav-item">
                <a href="Login" class="nav-link">Login</a>
            </li>
            <li class="nav-item">
                <a href="cruise-list.jsp" class="nav-link">View Cruises</a>
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

</body>
</html>
