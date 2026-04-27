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

boolean allowed = false;

try {
Connection con = DBConnection.getConnection();


PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM subscription WHERE user_email=? ORDER BY end_date DESC LIMIT 1"
);

ps.setString(1, email);
ResultSet rs = ps.executeQuery();

if (rs.next()) {
    java.sql.Date endDate = rs.getDate("end_date");

    if (endDate.getTime() >= System.currentTimeMillis()) {
        allowed = true;
    }
}


} catch (Exception e) {
e.printStackTrace();
}

if (!allowed) {
response.sendRedirect("subscription.jsp?msg=Please subscribe to continue&type=error");
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

<!-- Navbar -->

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Smart Mess - User</span>
        <a href="../logout" class="btn btn-danger">Logout</a>
    </div>
</nav>

<div class="container mt-4">


<h3 class="mb-2">Welcome, <%=session.getAttribute("user")%></h3>

<p class="text-muted">
    Subscription Status: <%= allowed ? "Active" : "Expired / Not Subscribed" %>
</p>

<div class="row mt-4">

    <div class="col-md-4 mb-3">
        <a href="view_menu.jsp" class="btn btn-primary w-100">View Menu</a>
    </div>

    <div class="col-md-4 mb-3">
        <a href="attendance.jsp" class="btn btn-success w-100">Mark Attendance</a>
    </div>

    <div class="col-md-4 mb-3">
        <a href="subscription.jsp" class="btn btn-warning w-100">Subscription</a>
    </div>

    <div class="col-md-4 mb-3">
        <a href="payment.jsp" class="btn btn-info w-100">Subscription Payment</a>
    </div>

    <div class="col-md-4 mb-3">
        <a href="view_payment.jsp" class="btn btn-secondary w-100">View Payments</a>
    </div>
<div class="col-md-4 mb-3">
    <a href="feedback.jsp" class="btn btn-dark w-100">Feedback</a>
</div>
<div class="col-md-4 mb-3">
    <a href="attendance_history.jsp" class="btn btn-dark w-100">
        Attendance History
    </a>
</div>
</div>


</div>

</body>
</html>
