<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.project.cruise.model.data.Cruise" %>
<%@ include file="../header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Cruises</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    
    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Macondo&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Macondo', cursive;
            background: linear-gradient(135deg, #e0f7fa, #ffffff);
            padding-top: 80px;
        }

        .container {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 4px 24px rgba(0, 0, 0, 0.08);
        }

        .cruise-card {
            border-radius: 18px;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .cruise-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 14px 28px rgba(0, 0, 0, 0.1);
        }

        .cruise-image {
            height: 200px;
            object-fit: cover;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 14px;
        }

        .status-scheduled {
            background-color: #d0f8ce;
            color: #256029;
        }

        .status-ongoing {
            background-color: #fff3cd;
            color: #856404;
        }

        .btn-book {
            background: linear-gradient(to right, #36d1dc, #5b86e5);
            color: white;
            font-weight: bold;
            border-radius: 50px;
            padding: 10px 24px;
            font-size: 16px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
            border: none;
        }

        .btn-book:hover {
            background: linear-gradient(to right, #5b86e5, #36d1dc);
            transform: scale(1.05);
            color: #fff;
        }

        .page-title {
            font-size: 28px;
            font-weight: bold;
            padding: 12px 24px;
            background: linear-gradient(135deg, #a1c4fd, #c2e9fb);
            border-radius: 20px;
            display: inline-block;
            color: #003366;
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
        }

        @media (max-width: 768px) {
            .cruise-image {
                height: 160px;
            }
        }

        @media (max-width: 576px) {
            .page-title {
                font-size: 22px;
                padding: 10px 18px;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="text-center mb-5">
            <h2 class="page-title">🌴 Available Cruises 🚢</h2>
        </div>

        <div class="row">
            <%
                List<Cruise> cruiseList = (List<Cruise>) request.getAttribute("cruiseList");
                if (cruiseList != null && !cruiseList.isEmpty()) {
                    for (Cruise cruise : cruiseList) {
                        String statusClass = "status-scheduled";
                        if ("Ongoing".equalsIgnoreCase(cruise.getStatus())) {
                            statusClass = "status-ongoing";
                        }
                        String cruiseImageUrl = "images/cruise.jpg";
            %>
            <div class="col-md-6 col-lg-4 mb-4">
                <div class="card cruise-card shadow-sm h-100">
                    <img src="<%= cruiseImageUrl%>" class="card-img-top cruise-image" alt="Cruise Image">
                    <div class="card-body text-center d-flex flex-column justify-content-between">
                        <div>
                            <h4 class="mb-3"><%= cruise.getShipName()%></h4>
                            <p><strong>Route:</strong> <%= cruise.getRoute()%></p>
                            <p><strong>Departure:</strong> <%= cruise.getDepartureDate()%></p>
                            <p><strong>Duration:</strong> <%= cruise.getDurationDays()%> days</p>
                            <p><strong>Price:</strong> $<%= cruise.getPrice()%></p>
                            <span class="status-badge <%= statusClass %> mt-2 mb-3 d-inline-block">
                                <%= cruise.getStatus()%>
                            </span>
                        </div>
                        <a href="BookCruise?cruiseId=<%= cruise.getId()%>" class="btn btn-book mt-auto">🚢 Book Now</a>
                    </div>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="col-12 text-center">
                <h5>No cruises available right now.</h5>
            </div>
            <%
                }
            %>
        </div>
    </div>

</body>
</html>
