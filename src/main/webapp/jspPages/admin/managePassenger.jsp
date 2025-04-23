<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, com.project.cruise.model.passenger.Passenger"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Passengers</title>
    
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
    <h2 class="text-center">Passenger Management</h2>
    
    <div class="mb-4">
        <a href="AdminHome" class="btn btn-primary">Back to Dashboard</a>
        <button class="btn btn-success float-end">Add New Passenger</button>
    </div>
    
    <div class="table-responsive">
        <table id="passengerTable" class="table table-striped table-hover table-bordered">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Nationality</th>
                    <th>Passport</th>
                    <th>Created</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                List<Passenger> passengers = (List<Passenger>) request.getAttribute("passenger");
                if(passengers != null) {
                    for(Passenger p : passengers) {
                %>
                <tr>
                    <td><%= p.getId() %></td>
                    <td><%= p.getFirstName() %> <%= p.getLastName() %></td>
                    <td><%= p.getEmail() %></td>
                    <td><%= p.getPhone() != null ? p.getPhone() : "-" %></td>
                    <td><%= p.getNationality() != null ? p.getNationality() : "-" %></td>
                    <td><%= p.getPassportNumber() != null ? p.getPassportNumber() : "-" %></td>
                    <td><%= p.getCreatedAt() != null ? p.getCreatedAt() : "-" %></td>
                    <td>
                        <button class="btn btn-sm btn-danger block-btn">Block</button>
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
    $('#passengerTable').DataTable({
        responsive: true,
        columnDefs: [
            { orderable: false, targets: [7] } // Disable sorting for Actions column
        ]
    });

    // Frontend-only toggle functionality
    $('.block-btn').click(function() {
        const btn = $(this);
        const isBlocked = btn.hasClass('btn-danger');
        
        btn.removeClass(isBlocked ? 'btn-danger' : 'btn-success')
           .addClass(isBlocked ? 'btn-success' : 'btn-danger')
           .text(isBlocked ? 'Unblock' : 'Block');
        
        // Just for demo - no actual backend call
        console.log(isBlocked ? 'Unblocking passenger' : 'Blocking passenger');
    });
});
</script>

</body>
</html>
