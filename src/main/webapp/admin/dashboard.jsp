<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
String role = (String) session.getAttribute("role");

if (role == null || !role.equals("admin")) {
response.sendRedirect("../login.jsp");
return;
}

// 📊 VARIABLES
int totalUsers = 0;
int activeSubs = 0;
int lunchCount = 0;
int dinnerCount = 0;

try {
Connection con = DBConnection.getConnection();
Statement st = con.createStatement();


// 👥 TOTAL USERS
ResultSet rs1 = st.executeQuery("SELECT COUNT(*) FROM users WHERE role='user'");
if (rs1.next()) totalUsers = rs1.getInt(1);

// 💳 ACTIVE SUBSCRIPTIONS
ResultSet rs2 = st.executeQuery(
    "SELECT COUNT(DISTINCT user_email) FROM subscription WHERE end_date >= CURDATE()"
);
if (rs2.next()) activeSubs = rs2.getInt(1);

// 🍛 LUNCH COUNT
ResultSet rs3 = st.executeQuery(
    "SELECT COUNT(*) FROM attendance WHERE meal_type='Lunch' AND status='Present' AND meal_date=CURDATE()"
);
if (rs3.next()) lunchCount = rs3.getInt(1);

// 🍽️ DINNER COUNT
ResultSet rs4 = st.executeQuery(
    "SELECT COUNT(*) FROM attendance WHERE meal_type='Dinner' AND status='Present' AND meal_date=CURDATE()"
);
if (rs4.next()) dinnerCount = rs4.getInt(1);


} catch (Exception e) {
e.printStackTrace();
}
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<!-- 🔥 NAVBAR -->

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Smart Mess - Admin</span>
        <a href="../logout" class="btn btn-danger">Logout</a>
    </div>
</nav>

<div class="container mt-4">

<h3>Welcome, <%= session.getAttribute("user") %></h3>

<!-- 📊 DASHBOARD STATS -->

<div class="row mt-4">


<div class="col-md-3 mb-3">
    <div class="card text-center bg-primary text-white">
        <div class="card-body">
            <h5>Total Users</h5>
            <h3><%= totalUsers %></h3>
        </div>
    </div>
</div>

<div class="col-md-3 mb-3">
    <div class="card text-center bg-success text-white">
        <div class="card-body">
            <h5>Active Subscriptions</h5>
            <h3><%= activeSubs %></h3>
        </div>
    </div>
</div>

<div class="col-md-3 mb-3">
    <div class="card text-center bg-warning text-dark">
        <div class="card-body">
            <h5>Lunch Count</h5>
            <h3><%= lunchCount %></h3>
        </div>
    </div>
</div>

<div class="col-md-3 mb-3">
    <div class="card text-center bg-danger text-white">
        <div class="card-body">
            <h5>Dinner Count</h5>
            <h3><%= dinnerCount %></h3>
        </div>
    </div>
</div>


</div>

<!-- 🔗 ACTION BUTTONS -->

<div class="row mt-4">


<div class="col-md-4 mb-3">
    <a href="manage_users.jsp" class="btn btn-primary w-100">Manage Users</a>
</div>

<div class="col-md-4 mb-3">
    <a href="add_menu.jsp" class="btn btn-success w-100">Manage Menu</a>
</div>

<div class="col-md-4 mb-3">
    <a href="view_attendance.jsp" class="btn btn-warning w-100">View Attendance</a>
</div>

<div class="col-md-4 mb-3">
    <a href="view_payments.jsp" class="btn btn-info w-100">View Payments</a>
</div>

<div class="col-md-4 mb-3">
    <a href="view_subscription.jsp" class="btn btn-secondary w-100">View Subscriptions</a>
</div>

<div class="col-md-4 mb-3">
    <a href="view_feedback.jsp" class="btn btn-dark w-100">View Feedback</a>
</div>


</div>

</div>

</body>
</html>
