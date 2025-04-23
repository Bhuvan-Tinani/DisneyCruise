<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Cruise Management</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
        }
        .container {
            margin-top: 50px;
        }
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-dark bg-dark">
        <a class="navbar-brand" href="#">Admin Dashboard</a>
        <a href="Logout" class="btn btn-danger">Logout</a>
    </nav>

    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <div class="card text-center p-3">
                    <h5>Total Passengers</h5>
                    <h3>150</h3>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center p-3">
                    <h5>Total Staff</h5>
                    <h3>30</h3>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center p-3">
                    <h5>Total Bookings</h5>
                    <h3>200</h3>
                </div>
            </div>
        </div>

        <div class="mt-4 text-center">
            <a href="ManagePassenger" class="btn btn-primary">Manage Passengers</a>
            <a href="ManageStaff" class="btn btn-secondary">Manage Staff</a>
            <a href="ManageBooking" class="btn btn-success">Manage Bookings</a>
            <a href="ManageCruise" class="btn btn-info">Manage Cruise</a>
        </div>
    </div>
</body>
</html>
