<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Passenger Home - Cruise Management System</title>

    <!-- ✅ Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
            padding-top: 60px;
        }

        .navbar {
            background-color: #007bff;
        }

        .navbar-brand, .nav-link {
            color: #fff !important;
        }

        .container {
            margin-top: 30px;
        }

        .card {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            border: none;
        }

        .card-title {
            color: #007bff;
            font-weight: bold;
        }

        .btn-custom {
            background-color: #007bff;
            color: #fff;
            border-radius: 8px;
            padding: 10px;
            width: 100%;
            transition: background-color 0.3s ease;
            border: none;
            font-size: 16px;
            font-weight: bold;
        }

        .btn-custom:hover {
            background-color: #0056b3;
        }

        .btn-outline-custom {
            border-color: #007bff;
            color: #007bff;
            border-radius: 8px;
            padding: 10px;
            width: 100%;
            transition: background-color 0.3s ease;
            font-size: 16px;
            font-weight: bold;
        }

        .btn-outline-custom:hover {
            background-color: #007bff;
            color: #fff;
        }

        .section-title {
            font-size: 24px;
            font-weight: bold;
            color: #007bff;
            margin-bottom: 15px;
        }
    </style>
</head>

<body>

<!-- ✅ Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <a class="navbar-brand" href="#">Cruise Management</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link" href="ViewCruise">Book Cruise</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="viewProfile.jsp">My Profile</a>
            </li>
            <li class="nav-item">
                <form action="Logout" method="POST">
                    <button type="submit" class="btn btn-danger">Logout</button>
                </form>
            </li>
        </ul>
    </div>
</nav>

<!-- ✅ Main Content -->
<div class="container">
    <div class="row">
        <!-- ✅ Welcome Section -->
        <div class="col-md-8 offset-md-2">
            <div class="card p-4 mb-4">
                <h2 class="card-title text-center">
                    Welcome, <c:out value="${sessionScope.username}"/>
                </h2>
                <p class="text-center">
                    Explore the world’s finest cruises and book your next adventure today!
                </p>
                <!-- ✅ Book Cruise Button -->
                <a href="ViewCruise" class="btn btn-custom mb-2">Book a Cruise</a>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- ✅ Complete Profile Section (only if NOT passenger) -->
        <c:if test="${!isPassenger}">
            <div class="col-md-6">
                <div class="card p-4 mb-4">
                    <h3 class="section-title">Complete Your Profile</h3>
                    <p>Complete your profile to make your booking process faster and smoother.</p>
                    <a href="PassengerProfile" class="btn-outline-custom">Complete Profile</a>
                </div>
            </div>
        </c:if>

        <!-- ✅ Add Family Member Section -->
        <div class="col-md-6">
            <div class="card p-4 mb-4">
                <h3 class="section-title">Add Family Member</h3>
                <p>Add details of your family members to manage group bookings easily.</p>
                <a href="addFamilyMember.jsp" class="btn-outline-custom">Add Family Member</a>
            </div>
        </div>
    </div>
</div>

<!-- ✅ Footer -->
<div class="footer text-center mt-4">
    &copy; 2025 Cruise Management System. All rights reserved.
</div>

<!-- ✅ Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
