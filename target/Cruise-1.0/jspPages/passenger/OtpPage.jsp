<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Enter OTP - Cruise Management</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-image: url('images/cruise.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
        }

        .otp-container {
            background: linear-gradient(135deg, rgba(0,0,0,0.92), rgba(30,30,30,0.92));
            padding: 40px 30px 30px 30px;
            border-radius: 18px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.7);
            max-width: 400px;
            width: 100%;
            text-align: center;
            border: 2px solid #FFD700;
        }

        .otp-container h2 {
            color: #FFD700;
            margin-bottom: 10px;
            font-weight: 700;
            letter-spacing: 1.2px;
        }

        .welcome-msg {
            color: #ddd;
            font-size: 16px;
            margin-bottom: 20px;
        }

        .form-control {
            background-color: #222;
            color: #fff;
            border: 1.5px solid #555;
            border-radius: 8px;
            padding: 12px 15px;
            font-size: 16px;
            transition: border-color 0.3s ease, background-color 0.3s ease;
        }

        .form-control:focus {
            background-color: #333;
            color: #fff;
            border-color: #FFD700;
            box-shadow: 0 0 8px #FFD700;
            outline: none;
        }

        .btn-verify {
            background-color: #FFD700;
            color: #000;
            font-weight: 700;
            border: none;
            border-radius: 8px;
            padding: 12px;
            width: 100%;
            margin-top: 25px;
            cursor: pointer;
            transition: background-color 0.4s ease, transform 0.2s ease;
        }

        .btn-verify:hover {
            background-color: #FFC300;
            transform: scale(1.05);
        }

        #timer {
            display: none; /* hide timer from user */
        }

        .alert-danger {
            margin-top: 15px;
            font-weight: 600;
        }
    </style>
</head>
<body>
<div class="otp-container">
    <h2>Enter OTP</h2>

    <!-- Show welcome message with username -->
    <div class="welcome-msg">
        Welcome, <strong>${username}</strong>! Please enter the OTP sent to your email.
    </div>

    <!-- Show error message if any -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>

    <form action="VerifyOtp" method="POST">
        <div class="form-group">
            <input type="text" name="otp" class="form-control" placeholder="Enter OTP" required>
        </div>
        <button type="submit" class="btn btn-verify">Verify</button>
    </form>

    <!-- Hidden timer (only used for redirect logic) -->
    <div id="timer">OTP expires in: 2:00</div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        let timeLeft = 120; // 2 minutes
        const timerElement = document.getElementById("timer");

        const countdown = setInterval(() => {
            if (timeLeft <= 0) {
                clearInterval(countdown);
                timerElement.innerHTML = "OTP has expired. Redirecting to login...";
                document.querySelector("button[type='submit']").disabled = true;

                // Redirect to login page after 3 seconds
                setTimeout(() => {
                    window.location.href = "Login"; // Change if your login page is named differently
                }, 3000);
            } else {
                let minutes = Math.floor(timeLeft / 60);
                let seconds = timeLeft % 60;
                timerElement.innerHTML = `OTP expires in: ${minutes}:${seconds < 10 ? '0' : ''}${seconds}`;
                timeLeft--;
            }
        }, 1000);
    });
</script>

</body>
</html>
