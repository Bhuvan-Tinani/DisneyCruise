<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/jspPages/header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Cruise Management</title>

    <!-- CSS & Font -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f4f6f9;
            padding-top: 50px;
        }
        .card {
            border-radius: 16px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .btn {
            border-radius: 30px;
            padding: 10px 20px;
            font-weight: 500;
        }
        .chart-container, .announcements, .activity {
            background: white;
            border-radius: 16px;
            padding: 20px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.06);
            margin-top: 30px;
        }
        #chatbotToggle {
            position: fixed;
            bottom: 20px;
            right: 20px;
            z-index: 1000;
            background-color: #007bff;
            color: white;
            border-radius: 50%;
            font-size: 22px;
            padding: 15px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
            transition: background 0.3s ease;
        }
        #chatbotToggle:hover {
            background-color: #0056b3;
        }
        #chatbotWindow {
            position: fixed;
            bottom: 90px;
            right: 20px;
            width: 320px;
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.3);
            display: none;
            z-index: 1001;
            overflow: hidden;
            animation: slideUp 0.3s ease-out;
        }
        @keyframes slideUp {
            from { transform: translateY(30px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        .chat-header {
            background: linear-gradient(45deg, #007bff, #00c6ff);
            color: white;
            padding: 12px 16px;
            display: flex;
            justify-content: space-between;
            font-weight: 600;
        }
        .chat-box {
            height: 260px;
            overflow-y: auto;
            padding: 12px;
            background: #f7f9fc;
            font-size: 14px;
        }
        .input-group input {
            border-radius: 20px;
        }
    </style>
</head>
<body>

<div class="container mt-5">
    <div class="text-center mb-4">
        <h2 class="font-weight-bold">🚢 Admin Dashboard</h2>
        <p class="text-muted">Overview & Management Panel</p>
    </div>

    <div class="row text-center">
        <div class="col-md-4 mb-4">
            <div class="card p-4">
                <h5>Total Passengers</h5>
                <h3 class="text-primary">${totalPassenger}</h3>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="card p-4">
                <h5>Total Staff</h5>
                <h3 class="text-warning">${totalStaff}</h3>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="card p-4">
                <h5>Total Bookings</h5>
                <h3 class="text-success">${totalBooking}</h3>
            </div>
        </div>
    </div>

    <div class="text-center mb-5">
        <a href="ManagePassenger" class="btn btn-outline-primary m-1">Manage Passengers</a>
        <a href="ManageStaff" class="btn btn-outline-warning m-1">Manage Staff</a>
        <a href="ManageBooking" class="btn btn-outline-success m-1">Manage Bookings</a>
        <a href="ManageCruise" class="btn btn-outline-info m-1">Manage Cruise</a>
    </div>

    <div class="row">
        <div class="col-md-6">
            <div class="chart-container">
                <h5>📊 Bookings Overview</h5>
                <canvas id="bookingsChart"></canvas>
            </div>
        </div>
        <div class="col-md-6">
            <div class="chart-container">
                <h5>👥 User Distribution</h5>
                <canvas id="rolesChart"></canvas>
            </div>
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-md-6">
            <div class="announcements">
                <h5><i class="fas fa-bullhorn text-danger"></i> Announcements</h5>
                <ul class="mb-0">
                    <li>🔧 Maintenance on Apr 28, 2–4 AM.</li>
                    <li>🛳 New Cruise: "Pacific Voyager".</li>
                </ul>
            </div>
        </div>
        <div class="col-md-6">
            <div class="activity">
                <h5><i class="fas fa-clock text-secondary"></i> Recent Activity</h5>
                <ul class="mb-0">
                    <li>🧑 John booked "Alaska Cruise".</li>
                    <li>⚙️ Cruise schedule updated.</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- ChatBot UI -->
<button id="chatbotToggle" onclick="toggleChatbot()">💬</button>
<div id="chatbotWindow">
    <div class="chat-header">
        CruiseBot 🤖
        <span style="cursor:pointer;" onclick="toggleChatbot()">&times;</span>
    </div>
    <div id="chatbox" class="chat-box"></div>
    <div class="input-group p-2">
        <input type="text" id="userInput" class="form-control" placeholder="Ask something...">
        <div class="input-group-append">
            <button class="btn btn-sm btn-primary" onclick="sendChat()">Send</button>
        </div>
    </div>
</div>

<script>
    function toggleChatbot() {
        const chatWindow = document.getElementById("chatbotWindow");
        chatWindow.style.display = (chatWindow.style.display === "block") ? "none" : "block";
    }

    function sendChat() {
        const input = document.getElementById("userInput");
        const msg = input.value.trim();
        if (!msg) return;

        const chatbox = document.getElementById("chatbox");
        chatbox.innerHTML += `<div><b>You:</b> ${msg}</div>`;
        input.value = "";

        setTimeout(() => {
            chatbox.innerHTML += `<div><b>CruiseBot:</b> Hello! I'm here to assist you. (Static reply)</div>`;
            chatbox.scrollTop = chatbox.scrollHeight;
        }, 500);
    }

    // Chart.js configuration
    new Chart(document.getElementById('bookingsChart'), {
        type: 'bar',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr'],
            datasets: [{
                label: 'Bookings',
                data: [120, 150, 100, 180],
                backgroundColor: '#007bff'
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: { beginAtZero: true }
            }
        }
    });

    new Chart(document.getElementById('rolesChart'), {
        type: 'doughnut',
        data: {
            labels: ['Passengers', 'Staff', 'Admins'],
            datasets: [{
                data: [${totalPassenger}, ${totalStaff}, 1],
                backgroundColor: ['#28a745', '#ffc107', '#dc3545']
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'bottom'
                }
            }
        }
    });
</script>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
