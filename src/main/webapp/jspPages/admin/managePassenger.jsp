<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, com.project.cruise.model.passenger.Passenger"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Manage Passengers</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

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
            .form-check-input:checked {
                background-color: #dc3545;
                border-color: #dc3545;
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
                            <th>Blocked</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Passenger> passengers = (List<Passenger>) request.getAttribute("passenger");
                            if (passengers != null) {
                                for (Passenger p : passengers) {
                        %>
                        <tr>
                            <td><%= p.getId()%></td>
                            <td><%= p.getFirstName()%> <%= p.getLastName()%></td>
                            <td><%= p.getEmail()%></td>
                            <td><%= p.getPhone() != null ? p.getPhone() : "-"%></td>
                            <td><%= p.getNationality() != null ? p.getNationality() : "-"%></td>
                            <td><%= p.getPassportNumber() != null ? p.getPassportNumber() : "-"%></td>
                            <td><%= p.getCreatedAt() != null ? p.getCreatedAt() : "-"%></td>
                            <td>
                                <div class="form-check form-switch">
                                    <input class="form-check-input block-toggle" type="checkbox"
                                           data-id="<%= p.getId()%>" <%= p.getBlock() == 1 ? "checked" : ""%> />
                                </div>
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

        <!-- Bootstrap Bundle -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>

        <!-- DataTables -->
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>

        <script>
            $(document).ready(function () {
                // Initialize DataTable
                $('#passengerTable').DataTable({
                    responsive: true,
                    columnDefs: [
                        { orderable: false, targets: [7] }
                    ]
                });

                // Handle toggle switch change event
                $('.block-toggle').on('change', function () {  // Fixed the class name here
                    const isChecked = $(this).is(':checked');
                    const passengerId = $(this).data('id');

                    // 🔁 Call backend to update block status (make this Servlet/URL in your app)
                    $.ajax({
                        url: 'ToggleBlockStatus', // Ensure this matches your servlet mapping
                        method: 'POST',
                        data: {
                            id: passengerId,
                            block: isChecked ? 1 : 0
                        },
                        success: function () {
                            if(isChecked){
                                alert("passenger id "+passengerId+" is blocked")
                            }else{
                                alert("passenger id "+passengerId+" is unblocked")
                            }
                        },
                        error: function () {
                            alert('Failed to update block status.');
                        }
                    });
                });
            });
        </script>

    </body>
</html>
