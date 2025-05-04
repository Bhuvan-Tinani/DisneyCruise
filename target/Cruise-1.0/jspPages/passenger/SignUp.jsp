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
        html, body {
            height: 100%;
            overflow: hidden;
        }

        body {
            font-family: Arial, sans-serif;
            background-image: url('images/cruise.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            min-height: 100vh;
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

        #passwordMessage {
            font-size: 0.9em;
            margin-top: 5px;
        }
    </style>

    <!-- ✅ JS Password Strength Checker -->
    <script>
        function isStrongPassword(password) {
            // At least 8 characters, 1 uppercase, 1 lowercase, 1 digit, 1 special char
            const regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
            return regex.test(password);
        }

        function checkPasswordStrength() {
            const passwordInput = document.getElementById("password");
            const submitBtn = document.getElementById("submitBtn");
            const msg = document.getElementById("passwordMessage");

            const password = passwordInput.value;

            if (!isStrongPassword(password)) {
                submitBtn.disabled = true;
                msg.innerText = "Password must be at least 8 characters with uppercase, lowercase, digit, and special character.";
                msg.style.color = "red";
            } else {
                submitBtn.disabled = false;
                msg.innerText = "Strong password ✔";
                msg.style.color = "lightgreen";
            }
        }

        document.addEventListener("DOMContentLoaded", function () {
            document.getElementById("password").addEventListener("input", checkPasswordStrength);
        });
    </script>
</head>
<body>

<div class="container">
    <h2>Create Account</h2>
    <form action="SignUp" method="POST">

        <!-- ✅ Email -->
        <div class="form-group">
            <input type="email" class="form-control" name="username" placeholder="Email" required>
        </div>

        <!-- ✅ Password -->
        <div class="form-group">
            <input type="password" class="form-control" name="password" id="password" placeholder="Password" required>
            <small id="passwordMessage"></small>
        </div>

        <!-- ✅ Submit Button -->
        <button type="submit" class="btn-custom" id="submitBtn" disabled>Create Account</button>
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
