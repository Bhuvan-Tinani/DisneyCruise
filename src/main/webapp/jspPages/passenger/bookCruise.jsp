<%@page import="com.project.cruise.model.data.Cruise"%>
<%@page import="com.project.cruise.model.passenger.Passenger"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Cruise cruise = (Cruise) request.getAttribute("cruise");
    Passenger passenger = (Passenger) request.getAttribute("passenger");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Book Cruise - Confirm</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            body {
                background-color: #eef1f7;
            }
            .container {
                max-width: 700px;
                margin-top: 50px;
                background: #fff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
            }
            .btn-book {
                background-color: #007bff;
                border: none;
                padding: 12px;
                color: white;
                font-size: 16px;
                border-radius: 6px;
                width: 100%;
            }
            .btn-book:hover {
                background-color: #0056b3;
            }
            .btn-pay {
                background-color: #28a745;
                border: none;
                padding: 12px;
                color: white;
                font-size: 16px;
                border-radius: 6px;
                width: 100%;
            }
            .btn-pay:hover {
                background-color: #218838;
            }
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
                        console.log("Order created:", response);
                        const order = JSON.parse(response);

                        var options = {
                            "key": "<%= application.getAttribute("r_id")%>",
                            "amount": order.amount,
                            "currency": order.currency,
                            "name": "Cruise Booking",
                            "description": "Payment for Cruise ID: " + cruiseId,
                            "order_id": order.id,
                            "handler": function (paymentResponse) {
                                //alert("Payment successful! Payment ID: " + paymentResponse.razorpay_payment_id);
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
                    contentType: 'application/json', // important!
                    data: JSON.stringify({
                        payment_id: paymentId,
                        order_id: orderId
                    }),
                    success: function (res) {
                        console.log("Payment update response:", res);
                        if (res.status === "success") {
                            alert("Payment recorded successfully!");
                        } else {
                            alert("Failed to update payment: " + res.message);
                        }
                    },
                    error: function (xhr) {
                        console.error("Error in updatePayment:", xhr.responseText);
                        alert("Something went wrong while updating payment.");
                    }
                });

            }


        </script>
    </head>
    <body>
        <div class="container">
            <h2 class="text-center text-primary mb-4">Confirm Your Booking</h2>

            <!-- Cruise Info -->
            <div class="mb-4">
                <h5>Cruise Details</h5>
                <ul class="list-group">
                    <li class="list-group-item"><strong>Ship:</strong> <%= cruise.getShipName()%></li>
                    <li class="list-group-item"><strong>Route:</strong> <%= cruise.getRoute()%></li>
                    <li class="list-group-item"><strong>Departure:</strong> <%= cruise.getDepartureDate()%></li>
                    <li class="list-group-item"><strong>Duration:</strong> <%= cruise.getDurationDays()%> days</li>
                    <li class="list-group-item"><strong>Price:</strong> ₹<%= cruise.getPrice()%></li>
                </ul>
            </div>

            <!-- Passenger Info -->
            <form method="post" action="BookCruise">
                <h5>Passenger Info</h5>
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" class="form-control" value="<%= passenger.getFirstName() + " " + passenger.getLastName()%>" readonly>
                </div>
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" class="form-control" value="<%= passenger.getEmail()%>" readonly>
                </div>
                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="tel" class="form-control" value="<%= passenger.getPhone()%>" readonly>
                </div>
                <div class="form-group">
                    <label>Amount</label>
                    <input type="number" id="amountInput" class="form-control" value="<%= cruise.getPrice()%>" readonly>
                </div>

                <!-- Hidden Fields -->
                <input type="hidden" name="cruiseId" value="<%= cruise.getId()%>">
                <input type="hidden" name="passengerId" value="<%= passenger.getId()%>">

                <hr>
                <button type="button" class="btn-pay mt-3"
                        onclick="initiatePayment(<%= cruise.getId()%>, <%= passenger.getId()%>)">
                    Pay ₹<%= cruise.getPrice()%> & Book Now
                </button>
            </form>
        </div>
    </body>
</html>
