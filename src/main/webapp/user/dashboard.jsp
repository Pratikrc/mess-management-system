<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
if (session.getAttribute("email") == null) {
response.sendRedirect("../login.jsp");
return;
}

String email = (String) session.getAttribute("email");

String plan = "None";
String endDate = "";
boolean active = false;

// 🔥 NEW VARIABLES
boolean expiringSoon = false;
String expiryMessage = "";

try {
Connection con = DBConnection.getConnection();


PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM subscription WHERE user_email=? ORDER BY end_date DESC LIMIT 1"
);

ps.setString(1, email);
ResultSet rs = ps.executeQuery();

if (rs.next()) {
    plan = rs.getString("plan_type");
    endDate = rs.getString("end_date");

    java.sql.Date ed = rs.getDate("end_date");

    long diff = ed.getTime() - System.currentTimeMillis();
    long daysLeft = diff / (1000 * 60 * 60 * 24);

    if (ed.getTime() >= System.currentTimeMillis()) {
        active = true;

        // 🔥 EXPIRY LOGIC
        if (daysLeft == 0) {
            expiringSoon = true;
            expiryMessage = "⚠ Expires today!";
        } else if (daysLeft == 1) {
            expiringSoon = true;
            expiryMessage = "⚠ Expires in 1 day";
        } else if (daysLeft == 2) {
            expiringSoon = true;
            expiryMessage = "⚠ Expires in 2 days";
        }
    }
}


} catch (Exception e) {
e.printStackTrace();
}

// 🚫 STRICT MODE (BLOCK IF EXPIRED)
if (!active) {
response.sendRedirect("payment.jsp?msg=Please subscribe to continue&type=error");
return;
}
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>User Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<!-- NAVBAR -->

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Smart Mess - User</span>
        <a href="../logout" class="btn btn-danger">Logout</a>
    </div>
</nav>

<div class="container mt-4">

<h3>Welcome, <%= session.getAttribute("user") %></h3>

<!-- 🔥 SUBSCRIPTION CARD -->

<div class="card shadow p-3 mb-4 text-center">

<h5>Subscription Status</h5>

<p><b>Plan:</b> <%= plan %></p>
<p><b>Expiry Date:</b> <%= endDate %></p>

<p>
<b>Status:</b>
<span class="text-success">Active</span>
</p>

</div>

<!-- 🔥 EXPIRY WARNING -->

<% if (expiringSoon) { %>

<div class="alert alert-warning text-center">
    <%= expiryMessage %> Please renew to avoid interruption.
</div>
<% } %>

<!-- DASHBOARD BUTTONS -->

<div class="row">

<div class="col-md-4 mb-3">
    <a href="view_menu.jsp" class="btn btn-primary w-100">View Menu</a>
</div>

<div class="col-md-4 mb-3">
    <a href="attendance.jsp" class="btn btn-success w-100">Mark Attendance</a>
</div>

<div class="col-md-4 mb-3">
    <a href="attendance_history.jsp" class="btn btn-dark w-100">Attendance History</a>
</div>

<div class="col-md-4 mb-3">
    <a href="payment.jsp" class="btn btn-warning w-100">Subscription / Payment</a>
</div>

<div class="col-md-4 mb-3">
    <a href="view_payment.jsp" class="btn btn-info w-100">View Payments</a>
</div>

<div class="col-md-4 mb-3">
    <a href="feedback.jsp" class="btn btn-secondary w-100">Give Feedback</a>
</div>

</div>

</div>

</body>
</html>
