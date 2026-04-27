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

String plan = null;
String startDate = null;
String endDate = null;
boolean active = false;

try {
Connection con = DBConnection.getConnection();


PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM subscription WHERE user_email=? ORDER BY end_date DESC LIMIT 1"
);

ps.setString(1, email);
ResultSet rs = ps.executeQuery();

if (rs.next()) {
    plan = rs.getString("plan_type");
    startDate = rs.getString("start_date");
    endDate = rs.getString("end_date");

    java.sql.Date ed = rs.getDate("end_date");

    if (ed.getTime() >= System.currentTimeMillis()) {
        active = true;
    }
}


} catch (Exception e) {
e.printStackTrace();
}
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Subscription</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Subscription</span>
        <a href="dashboard.jsp" class="btn btn-light">Back</a>
    </div>
</nav>

<div class="container mt-4">

<div class="row justify-content-center">
<div class="col-md-5">

<div class="card shadow p-4 text-center">

<h3 class="mb-3">Your Subscription</h3>

<% if (plan != null) { %>

<p><strong>Plan:</strong> <%= plan %></p>
<p><strong>Start Date:</strong> <%= startDate %></p>
<p><strong>End Date:</strong> <%= endDate %></p>

<p>
<strong>Status:</strong> 
<span class="<%= active ? "text-success" : "text-danger" %>">
    <%= active ? "Active" : "Expired" %>
</span>
</p>

<% } else { %>

<p class="text-danger">No subscription found</p>

<% } %>

<hr>

<a href="payment.jsp" class="btn btn-warning w-100">
    Buy / Renew Plan
</a>

</div>

</div>
</div>

</div>

</body>
</html>
