<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.project.cruise.model.passenger.Passenger" %>
<%
    Passenger passenger = (Passenger) request.getAttribute("passenger");
%>
<html>
<head>
    <title>Passenger Profile</title>

    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.5.0/css/flag-icon.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Macondo', cursive;
            background: url('images/cruise.jpg') no-repeat center center fixed;
            background-size: cover;
            color: #fff;
            padding-top: 80px;
        }

        .container {
            padding-top: 40px;
            max-width: 850px;
        }

        .card {
            background: rgb(31 27 27 / 71%);
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 20px;
            padding: 30px;
            color: #fff;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
        }

        .form-control[readonly], .form-control:disabled {
            background-color: transparent;
            color: #fff;
            border: 1px solid #ccc;
        }

        label {
            font-weight: 500;
        }

        .btn-primary, .btn-secondary, .btn-success {
            border-radius: 50px;
            padding: 10px 20px;
        }

        .btn:hover {
            opacity: 0.9;
        }

        /* Modal: Edit (Simplified) Styles */
        #editModal .modal-dialog {
            max-width: 600px; /* Adjust as needed */
            margin: 1.75rem auto; /* Default Bootstrap margin */
        }

        #editModal .modal-content {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: #fff;
            border-radius: 20px;
        }

        #editModal .modal-body {
            /* Existing padding */
        }

        #editModal select.form-control {
            background-color: #ffffff;
            color: #000000;
            border: 1px solid #ced4da;
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            padding: 0.375rem 2.25rem 0.375rem 0.75rem; /* Default Bootstrap padding */
            background-image: url('data:image/svg+xml,%3csvg xmlns=%27http://www.w3.org/2000/svg%27 viewBox=%270 0 16 16%27 fill=%27%23343a40%27%3e%3cpath fill-rule=%27evenodd%27 d=%27M1.5 5.5a.5.5 0 0 1 .5-.5h12a.5.5 0 0 1 0 1H2a.5.5 0 0 1-.5-.5z%27/%3e%3cpath d=%27M7 10a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 0 1h-1a.5.5 0 0 1-.5-.5z%27/%3e%3c/svg%3e'); /* Default Bootstrap arrow */
            background-repeat: no-repeat;
            background-position: right 0.75rem center;
            background-size: 16px 12px;
        }

        #editModal select.form-control:focus {
            border-color: #80bdff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }

        #editModal select.form-control option {
            background-color: #ffffff;
            color: #000000;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card shadow-lg">
        <div class="card-body">
            <h2 class="text-center mb-4">Passenger Profile</h2>

            <div id="messageArea"></div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label>First Name:</label>
                    <input id="firstNameDisplay" class="form-control" value="<%= passenger.getFirstName()%>" readonly>
                </div>
                <div class="col-md-6 mb-3">
                    <label>Last Name:</label>
                    <input id="lastNameDisplay" class="form-control" value="<%= passenger.getLastName()%>" readonly>
                </div>
                <div class="col-md-6 mb-3">
                    <label>Email:</label>
                    <input class="form-control" value="<%= passenger.getEmail()%>" readonly>
                </div>
                <div class="col-md-6 mb-3">
                    <label>Phone:</label>
                    <input class="form-control" value="<%= passenger.getPhone()%>" readonly>
                </div>
                <div class="col-md-6 mb-3">
                    <label>Nationality:</label>
                    <input id="nationalityDisplay" class="form-control" value="<%= passenger.getNationality()%>" readonly>
                </div>
                <div class="col-md-6 mb-3">
                    <label>Passport Number:</label>
                    <input id="passportDisplay" class="form-control" value="<%= passenger.getPassportNumber()%>" readonly>
                </div>
            </div>

            <div class="d-flex justify-content-between mt-4">
                <button class="btn btn-secondary" onclick="history.back()">
                    <i class="fas fa-arrow-left"></i> Back
                </button>
                <button class="btn btn-primary" data-toggle="modal" data-target="#editModal">
                    <i class="fas fa-edit"></i> Edit Profile
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <form id="editForm" class="modal-content">
            <div class="modal-header border-0">
                <h5 class="modal-title" id="editModalLabel">Edit Profile</h5>
                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body row px-4">
                <input type="hidden" name="email" value="<%= passenger.getEmail()%>">
                <div class="col-md-6 mb-3">
                    <label>First Name</label>
                    <input type="text" name="first_name" class="form-control" value="<%= passenger.getFirstName()%>">
                </div>
                <div class="col-md-6 mb-3">
                    <label>Last Name</label>
                    <input type="text" name="last_name" class="form-control" value="<%= passenger.getLastName()%>">
                </div>
                <div class="col-md-6 mb-3">
                    <label>Nationality</label>
                    <select name="nationality" id="editNationality" class="form-control">
                        <option value="">Select</option>
                    </select>
                </div>
                <div class="col-md-6 mb-3">
                    <label>Passport Number</label>
                    <input type="text" name="passport_number" class="form-control" value="<%= passenger.getPassportNumber()%>">
                </div>
            </div>
            <div class="modal-footer border-0 d-flex justify-content-between px-4 pb-4">
                <button type="button" class="btn btn-secondary" data-dismiss="modal"><i class="fas fa-times"></i> Cancel</button>
                <button type="submit" class="btn btn-success"><i class="fas fa-save"></i> Save</button>
            </div>
        </form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>

<script>
    $(document).ready(function () {
        fetch('https://restcountries.com/v3.1/all')
            .then(res => res.json())
            .then(data => {
                const sortedCountries = data
                    .map(c => ({ name: c.name.common, code: c.cca2.toLowerCase() }))
                    .filter(Boolean)
                    .sort((a, b) => a.name.localeCompare(b));

                sortedCountries.forEach(country => {
                    const flag = "<span class='"+"flag-icon flag-icon-"+"country.code'></span> ";
                    $('#editNationality').append("<option value='"+country.name+"'>"+flag+" "+country.name+"</option>");
                });

                $('#editNationality').val('<%= passenger.getNationality()%>');
            })
            .catch(err => {
                console.error('Failed to load countries:', err);
                $('#editNationality').append(`<option value="">Could not load countries</option>`);
            });

        $('#editForm').on('submit', function (e) {
            e.preventDefault();
            $.ajax({
                url: 'PassengerProfile',
                type: 'POST',
                data: $(this).serialize(),
                success: function () {
                    $('#editModal').modal('hide');
                    $('#messageArea').html(`<div class="alert alert-success">Profile updated successfully!</div>`).fadeIn(500).delay(3000).fadeOut(500);

                    $('#firstNameDisplay').val($('input[name="first_name"]').val());
                    $('#lastNameDisplay').val($('input[name="last_name"]').val());
                    $('#nationalityDisplay').val($('#editNationality').val());
                    $('#passportDisplay').val($('input[name="passport_number"]').val());
                },
                error: function () {
                    $('#messageArea').html(`<div class="alert alert-danger">Update failed. Try again.</div>`).fadeIn(500).delay(3000).fadeOut(500);
                }
            });
        });
    });
</script>

</body>
</html>