<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jspPages/header.jsp" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Passenger Home - Cruise Magic</title>

        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

        <!-- Disney Font -->
        <link href="https://fonts.googleapis.com/css2?family=Macondo&display=swap" rel="stylesheet">

        <!-- Font Awesome (for icons) -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

        <style>
            body {
                font-family: 'Macondo', 'Segoe UI Emoji', sans-serif;
                background: url('images/cruise.jpg');
                background-size: cover;
                background-position: center;
                background-attachment: fixed;
                color: #333;
                padding-top: 80px; /* Adjust this value based on the header height */
            }

            .container {
                margin-top: 30px; /* Additional margin for spacing */
            }

            .card {
                border-radius: 16px;
                background-color: #000000b8;
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
                color: #fff;
                border: 2px solid #fff;
                margin-top: 10px;
            }

            .card-title, .section-title {
                color: #fff700;
                font-size: 26px;
                font-weight: bold;
            }

            .pencil-card {
                border-radius: 25px;
                background: linear-gradient(145deg, #fbeeff, #ffe6ec);
                color: #333;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            }

            .pencil-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(255, 105, 180, 0.4);
            }

            .btn-custom {
                background-color: #ff8c00;
                color: #fff;
                border-radius: 12px;
                padding: 12px;
                font-size: 18px;
                font-weight: bold;
                transition: all 0.3s ease;
            }

            .btn-custom:hover {
                background-color: #ffcc00;
                box-shadow: 0 0 12px #ffcc00;
            }

            .btn-outline-custom {
                border: 2px solid #ff8c00;
                color: #ff8c00;
                border-radius: 12px;
                padding: 12px;
                font-size: 18px;
                background-color: transparent;
                transition: all 0.3s ease;
            }

            .btn-outline-custom:hover {
                background-color: #ff8c00;
                color: #fff;
                box-shadow: 0 0 12px #ff8c00;
            }
            .navbar-brand:hover .mickey-sparkle .head {
                transform: scale(1.2) translateX(-50%);
                box-shadow: 0 0 12px #ffcc00, 0 0 24px #ff8c00;
            }

            .navbar-brand:hover .mickey-sparkle .ear {
                transform: scale(1.2);
            }

            @keyframes sparkle {
                0% {
                    box-shadow: 0 0 5px #fff, 0 0 10px #ffcc00;
                }
                100% {
                    box-shadow: 0 0 10px #fff, 0 0 20px #ff33cc;
                }
            }

            .footer {
                color: whitesmoke;
                text-shadow: 1px 1px 3px #000;
                font-size: 16px;
                margin-top: 40px;
            }
        </style>
    </head>

    <body>
        <!-- Main Content -->
        <div class="container">
            <div class="row">
                <div class="col-md-8 offset-md-2">
                    <div class="card p-4 mb-4 text-center">
                        <h2 class="card-title sparkle">
                            Welcome, <c:out value="${sessionScope.username}"/>
                        </h2>
                        <p>Experience the magic of the seas with Disney-style adventures.</p>
                        <a href="ViewCruise" class="btn btn-custom mb-2">Book a Cruise</a>
                    </div>
                </div>
            </div>

            <div class="row">
                <c:if test="${!isPassenger}">
                    <div class="col-md-6 col-sm-12">
                        <div class="card p-4 mb-4">
                            <h3 class="section-title"><i class="fas fa-id-card mr-2"></i>Complete Your Profile</h3>
                            <p>Let’s complete your enchanted profile to make booking smoother.</p>
                            <a href="PassengerProfile" class="btn-outline-custom">Complete Profile</a>
                        </div>
                    </div>
                </c:if>

                <div class="col-md-4 offset-md-4">
                    <div class="card p-3 mb-4 text-center pencil-card">
                        <div class="mb-2">
                            <i class="fas fa-user-plus fa-2x text-danger"></i>
                        </div>
                        <h5 class="mb-2 font-weight-bold">Add Family Member</h5>
                        <p class="small text-muted">Bring your Disney crew on board!</p>
                        <a href="addFamilyMember.jsp" class="btn btn-sm btn-outline-danger rounded-pill px-3">Add</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <div class="footer text-center">
            &copy; 2025 Cruise Magic. Where dreams sail on the sea
        </div>

        <!-- Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>