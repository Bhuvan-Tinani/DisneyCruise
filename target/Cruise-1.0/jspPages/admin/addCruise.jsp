<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Add Cruise</title>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #eef2f7;
            }
            .container {
                max-width: 600px;
                margin-top: 50px;
                background: #fff;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .btn-custom {
                background-color: #007bff;
                color: white;
                font-weight: bold;
                border-radius: 5px;
                transition: 0.3s;
            }
            .btn-custom:hover {
                background-color: #0056b3;
            }
            label {
                font-weight: bold;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h2 class="text-center mb-4">Add New Cruise</h2>
            <form action="AddCruise" method="post" onsubmit="return validateForm()">

                <!-- ✅ Ship Name -->
                <div class="form-group">
                    <label for="ship_name">Ship Name:</label>
                    <input type="text" class="form-control" id="ship_name" name="ship_name" required>
                </div>

                <!-- ✅ Route -->
                <div class="form-group">
                    <label for="route">Route:</label>
                    <input type="text" class="form-control" id="route" name="route" required>
                </div>

                <!-- ✅ Departure Date -->
                <div class="form-group">
                    <label for="departure_date">Departure Date:</label>
                    <input type="date" class="form-control" id="departure_date" name="departure_date" required>
                </div>

                <!-- ✅ Duration (Days) -->
                <div class="form-group">
                    <label for="duration_days">Duration (Days):</label>
                    <input type="number" class="form-control" id="duration_days" name="duration_days" min="1" required>
                </div>

                <!-- ✅ Price -->
                <div class="form-group">
                    <label for="price">Price ($):</label>
                    <input type="number" class="form-control" id="price" name="price" step="0.01" min="0" required>
                </div>

                <!-- ✅ Status -->
                <div class="form-group">
                    <label for="status">Status:</label>
                    <select class="form-control" id="status" name="status" required>
                        <option value="Scheduled">Scheduled</option>
                        <option value="Ongoing">Ongoing</option>
                        <option value="Completed">Completed</option>
                    </select>
                </div>



                <!-- ✅ Submit & Back Buttons -->
                <button type="submit" class="btn btn-custom btn-block">Add Cruise</button>
                <a href="ManageCruise" class="btn btn-secondary btn-block">Back</a>
            </form>
        </div>

        <!-- ✅ JavaScript Validation -->
        <script>
            function validateForm() {
                let price = document.getElementById("price").value;
                let duration = document.getElementById("duration_days").value;

                if (price < 0) {
                    alert("Price cannot be negative.");
                    return false;
                }
                if (duration < 1) {
                    alert("Duration must be at least 1 day.");
                    return false;
                }
                return true;
            }
        </script>

    </body>
</html>
