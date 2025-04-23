<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList, java.util.Map, java.util.List, com.project.cruise.model.data.Staff"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assign Staff</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Custom Styles -->
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 900px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top: 30px;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .form-select {
            width: 100%;
        }
        .btn-assign {
            background: #007bff;
            color: white;
            font-weight: bold;
            transition: 0.3s;
        }
        .btn-assign:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center text-primary mb-4">Assign Staff to Cruise</h2>

    <form action="AssignStaff" method="POST">
        <input type="hidden" name="cruise_id" value="<%= request.getAttribute("cruise_id") %>">

        <table class="table table-bordered table-striped text-center">
            <thead class="table-dark">
                <tr>
                    <th>Role</th>
                    <th>Assign Staff</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Staff> unAssignedStaff = (List<Staff>) request.getAttribute("unAssignedStaff");
                    String[] roles = (String[]) request.getAttribute("roles");
                    
                    // Roles allowing only one selection
                    String[] singleSelectRoles = { "Captain", "First Officer", "Second Officer", "Chief Engineer", "Assistant Engineer" };

                    for (String role : roles) {
                        List<Staff> staffInRole = new ArrayList<>();
                        for (Staff staff : unAssignedStaff) {
                            if (staff.getRole().equalsIgnoreCase(role)) {
                                staffInRole.add(staff);
                            }
                        }
                        boolean isSingleSelect = java.util.Arrays.asList(singleSelectRoles).contains(role);
                %>
                <tr>
                    <td class="fw-bold"><%= role %></td>
                    <td>
                        <select class="form-select" name="staff_<%= role.replace(" ", "_") %>" <%= isSingleSelect ? "" : "multiple" %>>
                            <% if (!staffInRole.isEmpty()) {
                                for (Staff staff : staffInRole) { %>
                                    <option value="<%= staff.getId() %>">
                                        <%= staff.getFirstName() %> <%= staff.getLastName() %>
                                    </option>
                                <% }
                            } else { %>
                                <option disabled>No available staff</option>
                            <% } %>
                        </select>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <div class="text-center">
            <button type="submit" class="btn btn-assign px-4 py-2">Assign Staff</button>
        </div>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
