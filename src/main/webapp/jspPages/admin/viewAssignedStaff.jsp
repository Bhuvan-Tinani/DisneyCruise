<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.project.cruise.model.data.Staff" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Assigned Staff for Cruise</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 40px;
            max-width: 900px;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        h2 {
            margin-bottom: 30px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center">Assigned Staff for Cruise: <strong><%= request.getAttribute("cruiseName") != null ? request.getAttribute("cruiseName") : "N/A" %></strong></h2>

    <%
        List<Staff> staffList = (List<Staff>) request.getAttribute("staff");
        if (staffList == null || staffList.isEmpty()) {
    %>
        <div class="alert alert-warning text-center" role="alert">
            No staff assigned to this cruise.
        </div>
    <%
        } else {
    %>
    <table class="table table-striped table-bordered">
        <thead class="table-dark">
            <tr>
                <th>#</th>
                <th>Full Name</th>
                <th>Role</th>
                <th>Email</th>
                <th>Phone</th>
            </tr>
        </thead>
        <tbody>
            <%
                int count = 1;
                for (Staff staff : staffList) {
            %>
            <tr>
                <td><%= count++ %></td>
                <td><%= staff.getFirstName() %> <%= staff.getLastName() %></td>
                <td><%= staff.getRole() %></td>
                <td><%= staff.getEmail() %></td>
                <td><%= staff.getPhone() != null ? staff.getPhone() : "-" %></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
    <%
        }
    %>

    <div class="text-center mt-4">
        <a href="AdminHome" class="btn btn-primary">Back to Admin Home</a>
    </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
