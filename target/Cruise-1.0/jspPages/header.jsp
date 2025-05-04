<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>

<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role"); // admin, passenger, or staff
%>

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Macondo&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />

    <style>
        nav.navbar {
            font-family: 'Macondo', cursive;
            background-color: #000;
        }
        .navbar-brand span {
            font-size: 26px;
            color: white;
            transition: color 0.3s ease;
        }
        .navbar-brand:hover span {
            color: #ffcc00;
            text-shadow: 2px 2px 5px #fff;
        }
        .navbar-nav .nav-item .nav-link {
            font-size: 18px;
            padding: 10px 15px;
            transition: background-color 0.3s, color 0.3s;
            color: Red;
        }
        .navbar-nav .nav-item .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: #ffcc00;
            border-radius: 4px;
        }
    </style>
</head>

<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <a class="navbar-brand" href="<%= (role != null && role.equalsIgnoreCase("admin")) ? "AdminHome.jsp" : (role != null && role.equalsIgnoreCase("staff")) ? "StaffHome.jsp" : "index.jsp"%>">
        <span>
            <%
                if ("admin".equalsIgnoreCase(role)) {
                    out.print("Admin Dashboard");
                } else if ("staff".equalsIgnoreCase(role)) {
                    out.print("Staff Panel");
                } else {
                    out.print("Cruise Management");
                }
            %>
        </span>
    </a>

    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto d-flex align-items-center">
            <%
                if ("admin".equalsIgnoreCase(role)) {
            %>
                <!-- Admin: Only View Cruises + Logout -->
                <li class="nav-item"><a class="nav-link" href="ViewCruise"><i class="fas fa-ship mr-1"></i> View Cruises</a></li>
                <li class="nav-item">
                    <form action="Logout" method="post" class="mb-0 ml-lg-2">
                        <button type="submit" class="btn btn-danger btn-sm">Logout</button>
                    </form>
                </li>
            <%
                } else if ("staff".equalsIgnoreCase(role)) {
            %>
                <!-- Staff: Manage Bookings + Support + Logout -->
                <li class="nav-item"><a class="nav-link" href="ManageBookings.jsp">Manage Bookings</a></li>
                <li class="nav-item"><a class="nav-link" href="SupportCenter.jsp">Support</a></li>
                <li class="nav-item">
                    <form action="Logout" method="post" class="mb-0 ml-lg-2">
                        <button type="submit" class="btn btn-danger btn-sm">Logout</button>
                    </form>
                </li>
            <%
                } else {
                    if (username == null) {
            %>
                <!-- Guest: Home + View Cruises + Login -->
                <li class="nav-item"><a class="nav-link" href="../Cruise"><i class="fas fa-home mr-1"></i> Home </a></li>
                <li class="nav-item"><a class="nav-link" href="ViewCruise"><i class="fas fa-ship mr-1"></i> View Cruises</a></li>
                <li class="nav-item"><a class="nav-link" href="Login"><i class="fas fa-sign-in-alt mr-1"></i> Login</a></li>
            <%
                    } else {
            %>
                <!-- Passenger: Book Cruise + Profile + Logout -->
                <li class="nav-item"><a class="nav-link" href="ViewCruise"><i class="fas fa-ticket-alt mr-1"></i> Book Cruise</a></li>
                <li class="nav-item"><a class="nav-link" href="ViewProfile"><i class="fas fa-user mr-1"></i> My Profile</a></li>
                <li class="nav-item">
                    <form action="Logout" method="post" class="mb-0 ml-lg-2">
                        <button type="submit" class="btn btn-danger btn-sm">Logout</button>
                    </form>
                </li>
            <%
                    }
                }
            %>
        </ul>
    </div>
</nav>

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
