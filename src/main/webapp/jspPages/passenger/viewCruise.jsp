<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.project.cruise.model.data.Cruise" %>
<!DOCTYPE html>
<html>
<head>
    <title>Available Cruises</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
            padding: 30px;
        }

        .cruise-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        .cruise-header {
            font-size: 1.5rem;
            font-weight: 600;
            color: #007bff;
        }

        .cruise-detail {
            font-size: 1rem;
            margin-bottom: 8px;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 12px;
            font-size: 0.9rem;
            font-weight: bold;
        }

        .status-scheduled {
            background-color: #ffc107;
            color: #212529;
        }

        .status-ongoing {
            background-color: #28a745;
            color: white;
        }

        .btn-book {
            margin-top: 15px;
            background-color: #007bff;
            color: white;
            font-weight: 500;
            border-radius: 8px;
            display: inline-block;
            text-align: center;
            padding: 10px 20px;
            text-decoration: none;
        }

        .btn-book:hover {
            background-color: #0056b3;
            color: white;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center mb-5">🌊 Available Cruises</h2>

    <div class="row">
        <%
            List<Cruise> cruiseList = (List<Cruise>) request.getAttribute("cruiseList");
            if (cruiseList != null && !cruiseList.isEmpty()) {
                for (Cruise cruise : cruiseList) {
                    String statusClass = "status-scheduled";
                    if ("Ongoing".equalsIgnoreCase(cruise.getStatus())) {
                        statusClass = "status-ongoing";
                    }
        %>
        <div class="col-md-6">
            <div class="card cruise-card">
                <div class="card-body">
                    <h4 class="cruise-header"><%= cruise.getShipName() %></h4>
                    <p class="cruise-detail"><strong>Route:</strong> <%= cruise.getRoute() %></p>
                    <p class="cruise-detail"><strong>Departure:</strong> <%= cruise.getDepartureDate() %></p>
                    <p class="cruise-detail"><strong>Duration:</strong> <%= cruise.getDurationDays() %> days</p>
                    <p class="cruise-detail"><strong>Price:</strong> $<%= cruise.getPrice() %></p>
                    <span class="status-badge <%= statusClass %>">
                        <%= cruise.getStatus() %>
                    </span>

                    <!-- Book Now Link with query parameter -->
                    <a href="BookCruise?cruiseId=<%= cruise.getId() %>" class="btn-book d-block mt-3 text-center">🚢 Book Now</a>

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
