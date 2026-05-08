<%@ page language="java"
         contentType="text/html; charset=UTF-8"
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

        "SELECT * FROM subscription " +
        "WHERE user_email=? " +
        "ORDER BY end_date DESC LIMIT 1"
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

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Subscription</title>

<!-- Bootstrap -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet">

<!-- Custom CSS -->

<link rel="stylesheet"
      href="../css/style.css">

</head>

<body class="bg-light">

<!-- 🔥 NAVBAR -->

<nav class="navbar navbar-dark bg-dark">

<div class="container-fluid">

<span class="navbar-brand">

    Subscription

</span>

<a href="dashboard.jsp"
   class="btn btn-light btn-sm">

    Back

</a>

</div>

</nav>

<div class="container py-4">

<div class="row justify-content-center">

<div class="col-lg-5 col-md-7 col-sm-12">

<!-- 🔥 SUBSCRIPTION CARD -->

<div class="card shadow-sm border-0">

<div class="card-body p-4 text-center">

<h3 class="mb-4">

    📅 Your Subscription

</h3>

<% if (plan != null) { %>

<!-- PLAN -->

<div class="card bg-light border-0 p-3 mb-3">

<p class="mb-2">

    <strong>Plan:</strong>
    <%= plan %>

</p>

<p class="mb-2">

    <strong>Start Date:</strong>
    <%= startDate %>

</p>

<p class="mb-2">

    <strong>End Date:</strong>
    <%= endDate %>

</p>

<p class="mb-0">

<strong>Status:</strong>

<span class="badge
    <%= active
        ? "bg-success"
        : "bg-danger" %>">

    <%= active
        ? "Active"
        : "Expired" %>

</span>

</p>

</div>

<% } else { %>

<div class="alert alert-danger">

    No subscription found

</div>

<% } %>

<!-- BUTTON -->

<a href="payment.jsp"
   class="btn btn-warning w-100 py-2">

    Buy / Renew Plan

</a>

<!-- BACK BUTTON -->

<a href="dashboard.jsp"
   class="btn btn-secondary w-100 py-2 mt-3">

    Back to Dashboard

</a>

</div>

</div>

</div>

</div>

</div>

</body>
</html>