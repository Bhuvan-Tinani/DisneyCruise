<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Staff</title>

        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

        <style>
            body {
                font-family: 'Poppins', sans-serif;
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
        <div class="header">Manage Staff</div>
        <div class="container">
            <div class="text-center mb-4">
                <a href="AdminHome" class="btn btn-secondary">Back</a>
                <a href="ManageStaff?add=true" class="btn btn-custom">Add Staff</a>
            </div>

            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Role</th>
                        <th>Phone</th>
                        <th>Email</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="staffTableBody">
                    <!-- Data will be inserted here dynamically -->
                </tbody>
            </table>
        </div>

        <!-- Bootstrap and jQuery JS (for dynamic functionality) -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
        <script>
            function loadStaff() {
                fetch("http://localhost:8080/Cruise/StaffInfo")
                        .then(response => response.json())
                        .then(data => {
                            console.log("Staff Data Received:", data); // Debugging

                            const tableBody = document.getElementById("staffTableBody");
                            tableBody.innerHTML = ""; // Clear previous data

                            if (!Array.isArray(data) || data.length === 0) {
                                tableBody.innerHTML = "<tr><td colspan='6' class='text-center'>No staff found</td></tr>";
                                return;
                            }

                            data.forEach(staff => {
                                let tr = document.createElement("tr");

                                let tdId = document.createElement("td");
                                tdId.textContent = staff.id;
                                tr.appendChild(tdId);

                                let tdName = document.createElement("td");
                                tdName.textContent = staff.firstName + " " + staff.lastName;
                                tr.appendChild(tdName);

                                let tdRole = document.createElement("td");
                                tdRole.textContent = staff.role;
                                tr.appendChild(tdRole);

                                let tdPhone = document.createElement("td");
                                tdPhone.textContent = staff.phone;
                                tr.appendChild(tdPhone);

                                let tdEmail = document.createElement("td");
                                tdEmail.textContent = staff.email;
                                tr.appendChild(tdEmail);

                                let tdActions = document.createElement("td");
                                let deleteButton = document.createElement("button");
                                deleteButton.className = "btn btn-danger btn-sm";
                                deleteButton.textContent = "Delete";
                                deleteButton.onclick = () => deleteStaff(staff.id);
                                tdActions.appendChild(deleteButton);
                                tr.appendChild(tdActions);

                                tableBody.appendChild(tr);
                            });
                        })
                        .catch(error => {
                            console.error("Error loading staff data:", error);
                            document.getElementById("staffTableBody").innerHTML =
                                    "<tr><td colspan='6' class='text-center'>Error loading staff data</td></tr>";
                        });
            }

            // Load staff on page load
            document.addEventListener("DOMContentLoaded", loadStaff);
        </script>

    </body>
</html>
