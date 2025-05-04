<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jspPages/header.jsp" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Login - Cruise Management System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- Fonts & Styles -->
        <link href="https://fonts.googleapis.com/css2?family=Macondo&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

        <style>
            html, body {
                height: 100%;
                overflow-x: hidden;
            }

            body {
                font-family: Arial, sans-serif;
                background-image: url('images/cruise.jpg');
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                color: #fff;
                padding-top: 10px; /* Create space for the fixed header */
            }

            .container-wrapper {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                padding: 40px 15px;
            }

            .form-container {
                background-color: rgba(0, 0, 0, 0.85);
                padding: 40px 30px;
                border-radius: 14px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.5);
                width: 100%;
                max-width: 420px;
                color: #ddd;
                opacity: 0;
                transform: translateY(20px);
                transition: all 0.6s ease;
            }

            .form-container.show {
                opacity: 1;
                transform: translateY(0);
            }

            .form-group {
                margin-bottom: 20px;
            }

            h2 {
                color: #FFD700;
                text-align: center;
                margin-bottom: 30px;
                font-weight: bold;
                font-family: 'Macondo', cursive;
                font-size: 30px;
            }

            input.form-control,
            select.form-control {
                height: 44px;
                padding: 10px 12px;
                font-size: 15px;
                background-color: #333;
                color: #fff;
                border: 1px solid #555;
            }

            input.form-control:focus,
            select.form-control:focus {
                background-color: #444;
                color: #fff;
                border-color: #FFD700;
            }

            .password-wrapper {
                position: relative;
            }

            .toggle-password {
                position: absolute;
                top: 44px;
                right: 12px;
                color: #FFD700;
                cursor: pointer;
                font-size: 18px;
                z-index: 10;
            }

            .btn-custom {
                background: linear-gradient(135deg, #FFD700, #FFC107);
                color: #000;
                font-weight: bold;
                border-radius: 8px;
                height: 44px;
                width: 100%;
                font-size: 16px;
                transition: all 0.3s ease;
                border: none;
                margin-top: 10px;
            }

            .btn-custom:hover {
                background: linear-gradient(135deg, #FFC300, #FFB300);
                transform: scale(1.03);
                box-shadow: 0 4px 12px rgba(255, 215, 0, 0.4);
            }

            .btn-secondary {
                background-color: #444;
                color: #fff;
                border-radius: 8px;
                height: 44px;
                width: 100%;
                font-size: 16px;
                font-weight: bold;
                margin-top: 10px;
                transition: all 0.3s ease;
                border: none;
            }

            .btn-secondary:hover {
                background-color: #666;
                transform: scale(1.03);
                box-shadow: 0 4px 12px rgba(255, 255, 255, 0.2);
            }

            /* Popup Message Styling */
            .alert-message {
                position: fixed;
                top: 20px;
                left: 50%;
                transform: translateX(-50%);
                padding: 15px 30px;
                border-radius: 10px;
                text-align: center;
                font-weight: bold;
                width: auto;
                max-width: 90%;
                font-size: 16px;
                z-index: 9999;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
                opacity: 0;
                transition: all 0.5s ease-in-out;
            }

            /* Success Message */
            .alert-success {
                background-color: #28a745;
                color: white;
            }

            /* Error Message */
            .alert-danger {
                background-color: #dc3545;
                color: white;
            }

            /* Add animation when showing the message */
            .alert-message.show {
                opacity: 1;
                transform: translateX(-50%) translateY(0);
            }

            /* Add animation for hiding the message */
            .alert-message.hide {
                opacity: 0;
                transform: translateX(-50%) translateY(-50px);
            }

            .footer {
                text-align: center;
                padding: 25px 0;
                color: #ccc;
                font-size: 14px;
            }

            @media (max-width: 576px) {
                .form-container {
                    padding: 30px 20px;
                    margin-top: 40px;
                }

                h2 {
                    font-size: 1.7rem;
                }

                .container-wrapper {
                    padding: 20px 15px;
                }
            }
        </style>
    </head>
    <body>

        <!-- ✅ Success Message -->
        <c:if test="${requestScope.inserted == true}">
            <div class="alert-message alert-success">
                <p>${requestScope.username} has registered successfully</p>
            </div>
        </c:if>

        <!-- ✅ Error Message -->
        <c:if test="${requestScope.errorMessage != null}">
            <div class="alert-message alert-danger">
                <p>${requestScope.errorMessage}</p>
            </div>
        </c:if>

        <!-- ✅ Login Form -->
        <div class="container-wrapper">
            <div class="form-container" id="loginForm">
                <h2>Login</h2>
                <form action="Login" method="POST">
                    <div class="form-group">
                        <label for="email">Username</label>
                        <input type="text" class="form-control" id="email" name="email" placeholder="Enter Email" required>
                    </div>

                    <div class="form-group password-wrapper">
                        <label for="password">Password</label>
                        <input type="password" class="form-control" id="password" name="password" placeholder="Enter Password" required>
                        <i class="fa fa-eye toggle-password" id="togglePassword"></i>
                    </div>

                    <div class="form-group">
                        <label for="role">Role</label>
                        <select class="form-control" id="role" name="role" required>
                            <option value="" disabled selected>Select Role</option>
                            <option value="passenger">Passenger</option>
                            <option value="admin">Admin</option>
                            <option value="staff">Staff</option>
                        </select>
                    </div>

                    <button type="submit" class="btn-custom">Login</button>
                </form>

                <button id="createAccountBtn" class="btn-secondary" onclick="window.location.href = 'SignUp'">Create Account</button>
            </div>
        </div>

        <!-- ✅ Scripts -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <script>
                    $(document).ready(function () {
                        // ✅ Smooth Fade-In for Login Form
                        $('#loginForm').addClass('show');

                        // ✅ Show/Hide Password Toggle
                        $('#togglePassword').on('click', function () {
                            const passwordInput = $('#password');
                            const type = passwordInput.attr('type') === 'password' ? 'text' : 'password';
                            passwordInput.attr('type', type);
                            $(this).toggleClass('fa-eye fa-eye-slash');
                        });

                        // ✅ Show success/error message with fade-in
                        if ($('.alert-message').length) {
                            $('.alert-message').addClass('show');

                            // ✅ Automatically hide the message after 4 seconds
                            setTimeout(function () {
                                $('.alert-message').removeClass('show').addClass('hide');
                            }, 2000);
                        }
                    });
        </script>

    </body>
</html>