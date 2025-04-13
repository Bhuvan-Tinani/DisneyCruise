<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Add Staff</title>
    
    <!-- ✅ Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            padding-top: 50px;
        }

        .container {
            max-width: 500px;
            margin: auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .btn-custom {
            background-color: #007bff;
            color: #fff;
            border-radius: 8px;
            transition: background-color 0.3s ease;
            width: 100%;
            padding: 10px;
            border: none;
            font-size: 16px;
            font-weight: bold;
            margin-top: 15px;
        }

        .btn-custom:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
    <h2 class="text-center mb-4">Add Staff</h2>
    
    <form action="AddStaff" method="POST">
        <!-- ✅ First Name -->
        <div class="form-group">
            <label>First Name</label>
            <input type="text" name="first_name" class="form-control" required>
        </div>

        <!-- ✅ Last Name -->
        <div class="form-group">
            <label>Last Name</label>
            <input type="text" name="last_name" class="form-control" required>
        </div>

        <!-- ✅ Role Selection -->
        <div class="form-group">
            <label>Role</label>
            <select name="role" class="form-control" required>
                <option value="">Select Role</option>
                <option value="Captain">Captain</option>
                <option value="First Officer">First Officer</option>
                <option value="Second Officer">Second Officer</option>
                <option value="Chief Engineer">Chief Engineer</option>
                <option value="Assistant Engineer">Assistant Engineer</option>
                <option value="Housekeeping">Housekeeping</option>
                <option value="Cleaner">Cleaner</option>
                <option value="Chef">Chef</option>
                <option value="Waiter">Waiter</option>
                <option value="Receptionist">Receptionist</option>
                <option value="Security Officer">Security Officer</option>
                <option value="Bartender">Bartender</option>
                <option value="Entertainment Manager">Entertainment Manager</option>
                <option value="Medical Staff">Medical Staff</option>
                <option value="Crew Member">Crew Member</option>
            </select>
        </div>

        <!-- ✅ Phone -->
        <div class="form-group">
            <label>Phone</label>
            <input type="text" name="phone" class="form-control" required>
        </div>

        <!-- ✅ Email -->
        <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" class="form-control" required>
        </div>

        <!-- ✅ Password -->
        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>

        <!-- ✅ Submit Button -->
        <button type="submit" class="btn-custom">Add Staff</button>
    </form>
</div>

<!-- ✅ Bootstrap JS (Optional, only needed if you add JavaScript functionality) -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>

</body>
</html>