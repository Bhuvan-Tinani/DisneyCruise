<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Manage Cruises</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
            }
            .header {
                background: linear-gradient(90deg, #007bff, #0056b3);
                color: white;
                padding: 20px;
                text-align: center;
                font-size: 24px;
                font-weight: bold;
            }
            .container {
                max-width: 900px;
                margin: 30px auto;
                background: #fff;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 6px 12px rgba(0,0,0,0.1);
            }
            .btn-custom {
                background-color: #28a745;
                color: #fff;
                border-radius: 6px;
                transition: all 0.3s ease;
                padding: 10px 20px;
                font-size: 16px;
                font-weight: bold;
            }
            .btn-custom:hover {
                background-color: #218838;
            }
            table {
                width: 100%;
                margin-top: 20px;
            }
            th, td {
                padding: 12px;
                text-align: left;
                border-bottom: 2px solid #ddd;
            }
            th {
                background-color: #0056b3;
                color: white;
                font-weight: bold;
                text-transform: uppercase;
            }
            tbody tr:hover {
                background-color: #f1f1f1;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <div class="header">Manage Cruises</div>
        <div class="container">
            <div class="text-center mb-4">
                <a href="ManageCruise?add=true" class="btn btn-custom">Add Cruise</a>
            </div>
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Destination</th>
                        <th>Capacity</th>
                        <th>Price</th>
                        <th>Assign</th>
                    </tr>
                </thead>
                <tbody id="cruiseTableBody">
                    <!-- Cruise data will be inserted dynamically -->
                </tbody>
            </table>
            <div class="text-center mt-3">
                <a href="AdminHome" class="btn btn-secondary">Back to Dashboard</a>
            </div>
        </div>

        <!-- Bootstrap and jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
        <script>
            function loadCruises() {
                fetch("AllCruise")
                    .then(response => response.json())
                    .then(data => {
                        const tableBody = document.getElementById("cruiseTableBody");
                        tableBody.innerHTML = "";

                        if (!Array.isArray(data) || data.length === 0) {
                            tableBody.innerHTML = "<tr><td colspan='6' class='text-center'>No cruises found</td></tr>";
                            return;
                        }

                        data.forEach(cruise => {
                            let tr = document.createElement("tr");

                            let tdId = document.createElement("td");
                            tdId.textContent = cruise.id;
                            tr.appendChild(tdId);

                            let tdName = document.createElement("td");
                            tdName.textContent = cruise.shipName;
                            tr.appendChild(tdName);

                            let tdDestination = document.createElement("td");
                            tdDestination.textContent = cruise.route;
                            tr.appendChild(tdDestination);

                            let tdCapacity = document.createElement("td");
                            tdCapacity.textContent = cruise.durationDays + " days";
                            tr.appendChild(tdCapacity);

                            let tdPrice = document.createElement("td");
                            tdPrice.textContent = "$" + cruise.price;
                            tr.appendChild(tdPrice);

                            // Assign Staff Column
                            let tdAssignStaff = document.createElement("td");

                            if (cruise.isAssigned === false) {
                                let assignStaffLink = document.createElement("a");
                                assignStaffLink.href = "AssignStaff?cruise_id=" + cruise.id;
                                assignStaffLink.className = "btn btn-info btn-sm";
                                assignStaffLink.textContent = "Assign Staff";
                                tdAssignStaff.appendChild(assignStaffLink);
                            } else {
                                let viewStaffLink = document.createElement("a");
                                viewStaffLink.href = "ViewAssignedStaff?cruise_id=" + cruise.id;
                                viewStaffLink.className = "btn btn-secondary btn-sm mr-2";
                                viewStaffLink.textContent = "View Staff";
                                tdAssignStaff.appendChild(viewStaffLink);

                                let updateStaffLink = document.createElement("a");
                                updateStaffLink.href = "AssignStaff?cruise_id=" + cruise.id;
                                updateStaffLink.className = "btn btn-warning btn-sm";
                                updateStaffLink.textContent = "Update Staff";
                                tdAssignStaff.appendChild(updateStaffLink);
                            }

                            tr.appendChild(tdAssignStaff);

                            tableBody.appendChild(tr);
                        });
                    })
                    .catch(error => {
                        console.error("Error loading cruise data:", error);
                        document.getElementById("cruiseTableBody").innerHTML =
                            "<tr><td colspan='6' class='text-center'>Error loading cruise data</td></tr>";
                    });
            }

            document.addEventListener("DOMContentLoaded", loadCruises);
        </script>
    </body>
</html>
