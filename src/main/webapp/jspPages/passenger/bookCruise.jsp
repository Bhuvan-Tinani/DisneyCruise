<%@page import="com.project.cruise.model.data.Cruise"%>
<%@page import="com.project.cruise.model.passenger.Passenger"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Cruise cruise = (Cruise) request.getAttribute("cruise");
    Passenger passenger = (Passenger) request.getAttribute("passenger");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Cruise - Confirm</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap & Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Macondo&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            font-family: 'Macondo', cursive;
            background: linear-gradient(to bottom right, #eef2f3, #d9e2ec);
            margin: 0;
            padding-top: 90px; /* Space to prevent overlap with fixed navbar */
        }

        .navbar {
            background-color: #000;
            position: fixed; /* Fix the navbar to the top */
            top: 0;
            width: 100%;
            z-index: 1000; /* Make sure the navbar stays on top of other content */
        }

        .navbar-brand {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 5px 10px;
            border-radius: 12px;
            transition: all 0.4s ease-in-out;
        }

        .navbar-brand:hover {
            transform: scale(1.05);
            background-color: rgba(255, 255, 255, 0.05);
            box-shadow: 0 0 12px #ffcc00, 0 0 20px #ff8c00;
        }

        .brand-text {
            font-size: 26px;
            color: #fff;
            transition: color 0.3s ease;
        }

        .navbar-brand:hover .brand-text {
            color: #ffcc00;
            text-shadow: 2px 2px 5px #fff;
        }

        .nav-link {
            font-size: 18px;
            padding: 10px 15px;
            transition: background-color 0.3s, color 0.3s;
            color: white !important;
        }

        .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: #ffcc00 !important;
            border-radius: 4px;
        }

        .container {
            max-width: 700px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .btn-pay {
            background-color: #28a745;
            border: none;
            padding: 12px;
            color: white;
            font-size: 16px;
            border-radius: 6px;
            width: 100%;
            margin-top: 20px;
        }

        .btn-pay:hover {
            background-color: #218838;
        }

        h2, h5 {
            font-weight: bold;
        }

        .list-group-item {
            border: none;
            background: #f8f9fa;
        }

        @media (max-width: 576px) {
            .container {
                padding: 20px;
            }

            .brand-text {
                font-size: 20px;
            }

            .nav-link {
                font-size: 16px;
            }
        }
        /* Spinner overlay styles */
        #loadingOverlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background: rgba(255, 255, 255, 0.85);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 1050;
            flex-direction: column;
        }

        #loadingOverlay .spinner-border {
            width: 3rem;
            height: 3rem;
        }

        #loadingOverlay p {
            margin-top: 15px;
            font-size: 1.2rem;
            color: #28a745;
        }
    </style>
    </style>

    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        function initiatePayment(cruiseId, passengerId) {
            var amount = $('#amountInput').val();

            $.ajax({
                url: 'CreatePayment',
                type: 'POST',
                data: {
                    cruise_id: cruiseId,
                    passenger_id: passengerId,
                    amount: amount
                },
                success: function (response) {
                    const order = JSON.parse(response);

                    var options = {
                        "key": "<%= application.getAttribute("r_id")%>",
                        "amount": order.amount,
                        "currency": order.currency,
                        "name": "Cruise Booking",
                        "description": "Payment for Cruise ID: " + cruiseId,
                        "order_id": order.id,
                        "handler": function (paymentResponse) {
                            document.getElementById("loadingOverlay").style.display = "flex";
                            updatePayment(paymentResponse.razorpay_payment_id, order.id);
                           
                        },
                        "prefill": {
                            "email": "<%= passenger.getEmail()%>",
                            "contact": "<%= passenger.getPhone()%>"
                        },
                        "theme": {
                            "color": "#007bff"
                        }
                    };

                    var rzp1 = new Razorpay(options);
                    rzp1.open();
                }
            });
        }

        function updatePayment(paymentId, orderId) {
            $.ajax({
                url: 'CreatePayment',
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify({
                    payment_id: paymentId,
                    order_id: orderId
                }),
                success: function (res) {
                    if (res.status === "success") {
                        alert("Payment recorded successfully!");
                        location.href = "PassengerHome";
                    } else {
                        alert("Failed to update payment: " + res.message);
                    }
                },
                error: function (xhr) {
                    alert("Something went wrong while updating payment.");
                }
            });
        }
    </script>
</head>

<body>

<!-- ✅ Updated Navigation Bar with Fixed Position -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <a class="navbar-brand" href="#">CRUISE MANAGEMENT</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto d-flex align-items-center">
            <li class="nav-item">
                <a class="nav-link d-flex align-items-center" href="ViewCruise">
                    <i class="fas fa-ticket-alt mr-1"></i> Book Cruise
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link d-flex align-items-center" href="viewProfile.jsp">
                    <i class="fas fa-user mr-1"></i> My Profile
                </a>
            </li>
            <li class="nav-item d-flex align-items-center">
                <form action="Logout" method="POST" class="mb-0 ml-lg-2">
                    <button type="submit" class="btn btn-danger btn-sm">Logout</button>
                </form>
            </li>
        </ul>
    </div>
</nav>

<!-- ✅ Booking Confirmation Section -->
<div class="container">
    <h2 class="text-center text-primary mb-4">Confirm Your Booking</h2>

    <!-- Cruise Info -->
    <div class="mb-4">
        <h5>Cruise Details</h5>
        <ul class="list-group">
            <li class="list-group-item"><strong>Ship:</strong> <%= cruise.getShipName() %></li>
            <li class="list-group-item"><strong>Route:</strong> <%= cruise.getRoute() %></li>
            <li class="list-group-item"><strong>Departure:</strong> <%= cruise.getDepartureDate() %></li>
            <li class="list-group-item"><strong>Duration:</strong> <%= cruise.getDurationDays() %> days</li>
            <li class="list-group-item"><strong>Price:</strong> ₹<%= cruise.getPrice() %></li>
        </ul>
    </div>

    <!-- Passenger Info -->
    <form method="post" action="BookCruise">
        <h5>Passenger Info</h5>
        <div class="form-group">
            <label>Full Name</label>
            <input type="text" class="form-control" value="<%= passenger.getFirstName() + " " + passenger.getLastName() %>" readonly>
        </div>
        <div class="form-group">
            <label>Email Address</label>
            <input type="email" class="form-control" value="<%= passenger.getEmail() %>" readonly>
        </div>
        <div class="form-group">
            <label>Phone Number</label>
            <input type="tel" class="form-control" value="<%= passenger.getPhone() %>" readonly>
        </div>
        <div class="form-group">
            <label>Amount</label>
            <input type="number" id="amountInput" class="form-control" value="<%= cruise.getPrice() %>" readonly>
        </div>

        <!-- Hidden Fields -->
        <input type="hidden" name="cruiseId" value="<%= cruise.getId() %>">
        <input type="hidden" name="passengerId" value="<%= passenger.getId() %>">

        <!-- Payment Button -->
        <button type="button" class="btn-pay"
                onclick="initiatePayment(<%= cruise.getId() %>, <%= passenger.getId() %>)">
            Pay ₹<%= cruise.getPrice() %> & Book Now
        </button>
    </form>
</div>
 
        <!-- Spinner Overlay -->
<div id="loadingOverlay">
    <div class="spinner-border text-success" role="status">
        <span class="sr-only">Processing...</span>
    </div>
    <p>Processing your payment...</p>
</div>

<!-- Success Modal -->
<div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content text-center">
      <div class="modal-header bg-success text-white">
        <h5 class="modal-title" id="successModalLabel">Success!</h5>
      </div>
      <div class="modal-body">
        <p class="lead">Payment recorded successfully! 🎉</p>
      </div>
      <div class="modal-footer">
        <a href="PassengerHome" class="btn btn-success">Continue</a>
      </div>
    </div>
  </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
