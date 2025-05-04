<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Complete Your Profile</title>
    
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
    <h2 class="text-center mb-4">Complete Your Profile</h2>

    <!-- ✅ Show Error Message -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">
            ${error}
        </div>
    </c:if>

    <!-- ✅ Show Success Message -->
    <c:if test="${not empty success}">
        <div class="alert alert-success" role="alert">
            ${success}
        </div>
    </c:if>

    <form action="PassengerProfile" method="POST">
        <!-- Hidden Field to Identify Insert/Update -->
        <input type="hidden" name="action" value="${not empty passenger ? 'update' : 'insert'}" />

        <!-- ✅ First Name -->
        <div class="form-group">
            <label>First Name</label>
            <input type="text" name="first_name" class="form-control" value="${passenger != null ? passenger.firstName : ''}" required>
        </div>

        <!-- ✅ Last Name -->
        <div class="form-group">
            <label>Last Name</label>
            <input type="text" name="last_name" class="form-control" value="${passenger != null ? passenger.lastName : ''}" required>
        </div>

        <!-- ✅ Phone -->
        <div class="form-group">
            <label>Phone</label>
            <input type="text" name="phone" class="form-control" value="${passenger != null ? passenger.phone : ''}" required>
        </div>

        <!-- ✅ Nationality (Fetched from API) -->
        <div class="form-group">
            <label>Nationality</label>
            <select id="nationality" name="nationality" class="form-control" required>
                <option value="">Select Nationality</option>
                <c:forEach items="${countries}" var="country">
                    <option value="${country}" ${passenger != null && country == passenger.nationality ? 'selected' : ''}>${country}</option>
                </c:forEach>
            </select>
        </div>

        <!-- ✅ Passport Number -->
        <div class="form-group">
            <label>Passport Number</label>
            <input type="text" name="passport_number" class="form-control" value="${passenger != null ? passenger.passportNumber : ''}" required>
        </div>

        <!-- ✅ Submit Button -->
        <button type="submit" class="btn-custom">${passenger != null ? 'Update Profile' : 'Save Profile'}</button>
    </form>
</div>

<!-- ✅ jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<!-- ✅ Fetch Nationality from RestCountries API -->
<script>
    $(document).ready(function () {
        $.ajax({
            url: 'https://restcountries.com/v3.1/all',
            method: 'GET',
            success: function(data) {
                data.forEach(country => {
                    if (country.name && country.name.common) {
                        $('#nationality').append(
                            "<option value="+country.name.common+">"+country.name.common+"</option>"
                        );
                    }
                });
            },
            error: function(error) {
                console.error("Error fetching countries:", error);
            }
        });
    });
</script>

</body>
</html>