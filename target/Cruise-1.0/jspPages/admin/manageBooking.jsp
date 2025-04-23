<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, com.project.cruise.model.data.BookingDetails"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Bookings</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
    
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 40px;
            max-width: 1200px;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        h2 {
            margin-bottom: 30px;
            color: #2c3e50;
        }
        .table th {
            background-color: #2c3e50;
            color: white;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center">Booking Management</h2>
    
    <div class="mb-4">
        <a href="AdminHome" class="btn btn-primary">Back to Dashboard</a>
    </div>
    
    <div class="table-responsive">
        <table id="bookingTable" class="table table-striped table-hover table-bordered">
            <thead>
                <tr>
                    <th>Booking Ref</th>
                    <th>Cruise Name</th>
                    <th>Route</th>
                    <th>Departure</th>
                    <th>Duration</th>
                    <th>Price</th>
                    <th>Passenger</th>
                    <th>Email</th>
                    <th>Boarding Pass</th>
                </tr>
            </thead>
            <tbody>
                <%
                List<BookingDetails> bookings = (List<BookingDetails>) request.getAttribute("bookingDetails");
                if(bookings != null) {
                    for(BookingDetails bd : bookings) {
                %>
                <tr>
                    <td><%= bd.getBookingReference() %></td>
                    <td><%= bd.getCruiseName() %></td>
                    <td><%= bd.getCruiseRoute() %></td>
                    <td><%= bd.getDepartureDate() %></td>
                    <td><%= bd.getDurationDays() %> days</td>
                    <td>$<%= String.format("%.2f", bd.getCruisePrice()) %></td>
                    <td><%= bd.getPassengerName() %></td>
                    <td><%= bd.getPassengerEmail() %></td>
                    <td>
                        <% if(bd.getBoardingPassQr() != null) { %>
                            <span class="badge bg-success">Available</span>
                        <% } else { %>
                            <span class="badge bg-secondary">Not Generated</span>
                        <% } %>
                    </td>
                </tr>
                <% 
                    }
                }
                %>
            </tbody>
        </table>
    </div>
</div>

<!-- Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>

<!-- DataTables JS -->
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>

<script>
$(document).ready(function() {
    $('#bookingTable').DataTable({
        responsive: true,
        columnDefs: [
            { orderable: false, targets: [8] } // Disable sorting for Boarding Pass column
        ]
    });
});
</script>

</body>
</html>
