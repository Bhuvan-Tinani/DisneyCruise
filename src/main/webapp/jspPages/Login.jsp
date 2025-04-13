<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jspPages/header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - Cruise Management System</title>
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
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
            max-width: 400px;
            color: #ddd;
        }

        h2 {
            color: #FFD700;
            text-align: center;
            margin-bottom: 20px;
            font-weight: bold;
        }

        label {
            font-weight: bold;
        }

        .form-control {
            background-color: #333;
            color: #fff;
            border: 1px solid #555;
        }

        .form-control:focus {
            background-color: #444;
            color: #fff;
            border-color: #FFD700;
        }

        .btn-custom {
            background-color: #FFD700;
            color: #000;
            font-weight: bold;
            border-radius: 8px;
            transition: background-color 0.3s ease;
            width: 100%;
            padding: 10px;
            border: none;
            margin-top: 20px;
        }

        .btn-custom:hover {
            background-color: #FFC300;
        }

        .footer {
            text-align: center;
            margin-top: 20px;
            color: #bbb;
        }

        .btn-secondary {
            background-color: #555;
            color: #fff;
            border-radius: 8px;
            padding: 10px;
            width: 100%;
            border: none;
            margin-top: 10px;
            transition: background-color 0.3s ease;
        }

        .btn-secondary:hover {
            background-color: #777;
        }

        .alert {
            text-align: center;
            margin-bottom: 20px;
            font-weight: bold;
        }
    </style>
</head>
<body>

<!-- ✅ Success Message -->
<c:if test="${requestScope.inserted == true}">
    <script>
        alert("${requestScope.username} has registered successfully");
    </script>
</c:if>

<!-- ✅ Error Message -->
<c:if test="${requestScope.errorMessage != null}">
    <div class="alert alert-danger container">${requestScope.errorMessage}</div>
</c:if>

<!-- ✅ Login Form -->
<div class="container">
    <h2>Login to Cruise Management</h2>
    <form action="Login" method="POST">

        <!-- ✅ Username -->
        <div class="form-group">
            <label for="email">Username</label>
            <input type="text" class="form-control" id="email" name="email" placeholder="Enter Email" required>
        </div>

        <!-- ✅ Password -->
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required>
        </div>

        <!-- ✅ Role Selection -->
        <div class="form-group">
            <label for="role">Role</label>
            <select class="form-control" id="role" name="role" required>
                <option value="" disabled selected>Select Role</option>
                <option value="passenger">Passenger</option>
                <option value="admin">Admin</option>
                <option value="staff">Staff</option>
            </select>
        </div>

        <!-- ✅ Login Button -->
        <button type="submit" class="btn-custom">Login</button>
    </form>

    <!-- ✅ Create Account Button -->
    <button id="createAccountBtn" class="btn-secondary">Create Account</button>
</div>

<!-- ✅ Footer -->
<div class="footer">
    &copy; 2025 Cruise Management System. All rights reserved.
</div>

<!-- ✅ jQuery & Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- ✅ jQuery Redirect Code -->
<script>
    $(document).ready(function () {
        $('#createAccountBtn').click(function () {
            window.location.href = 'SignUp'; // Redirect to SignUp page
        });
    });
</script>

</body>
</html>
