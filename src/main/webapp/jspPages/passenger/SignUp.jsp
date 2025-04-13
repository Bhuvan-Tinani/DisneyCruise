<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jspPages/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - Cruise Management</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('images/cruise.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            height: 100vh;
            margin: 0;
            padding: 0;
            color: #fff;
        }

        .container {
            margin-top: 100px;
            background-color: rgba(0, 0, 0, 0.8);
            padding: 40px;
            border-radius: 12px;
            max-width: 400px;
            color: #ddd;
        }

        h2 {
            color: #FFD700;
            text-align: center;
            margin-bottom: 20px;
        }

        .btn-custom {
            background-color: #FFD700;
            color: #000;
            border-radius: 8px;
            padding: 10px;
            width: 100%;
            margin-top: 20px;
            border: none;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .btn-custom:hover {
            background-color: #FFC300;
        }

        .btn-secondary {
            background-color: #555;
            color: #fff;
            border-radius: 8px;
            padding: 10px;
            width: 100%;
            margin-top: 10px;
            border: none;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .btn-secondary:hover {
            background-color: #777;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Create Account</h2>
    <form action="SignUp" method="POST">

<!--         ✅ First Name 
        <div class="form-group">
            <input type="text" class="form-control" name="first_name" placeholder="First Name" required>
        </div>

         ✅ Last Name 
        <div class="form-group">
            <input type="text" class="form-control" name="last_name" placeholder="Last Name" required>
        </div>-->

        <!-- ✅ Email -->
        <div class="form-group">
            <input type="email" class="form-control" name="username" placeholder="Email" required>
        </div>

        <!-- ✅ Password -->
        <div class="form-group">
            <input type="password" class="form-control" name="password" placeholder="Password" required>
        </div>

        <!-- ✅ Submit Button -->
        <button type="submit" class="btn-custom">Create Account</button>
    </form>

    <!-- ✅ Login Button -->
    <form action="Login" method="GET">
        <button type="submit" class="btn-secondary">Already have an account? Login</button>
    </form>
</div>

<!-- ✅ Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
