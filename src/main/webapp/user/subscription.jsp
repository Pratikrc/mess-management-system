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

long daysLeft = 0;

String statusText = "Expired";

String statusClass = "danger";

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

        long diff = ed.getTime() - System.currentTimeMillis();

        daysLeft = diff / (1000 * 60 * 60 * 24);

        if (ed.getTime() >= System.currentTimeMillis()) {

            active = true;

            statusText = "Active";

            statusClass = "success";
        }
    }

} catch (Exception e) {

    e.printStackTrace();
}
%>
<%@ include file="auth_check.jsp" %>
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

<body>

<div class="container-fluid">

<div class="row">

<!-- ===================================
     SIDEBAR
=================================== -->

<div class="col-lg-2 col-md-3 bg-dark text-white min-vh-100 p-3">

<h3 class="text-center mb-4">

    Smart Mess

</h3>

<hr class="bg-light">

<div class="d-grid gap-2">

<a href="dashboard.jsp"
   class="btn btn-outline-light text-start">
            🏠 Dashboard

        </a>

        <!-- VIEW MENU -->

        <a href="view_menu.jsp"
          class="btn btn-outline-light text-start">

            🍽️ View Menu

        </a>

        <!-- ATTENDANCE -->

        <a href="attendance.jsp"
          class="btn btn-outline-light text-start">
            📋 Attendance

        </a>

        <!-- ATTENDANCE HISTORY -->

        <a href="attendance_history.jsp"
           class="btn btn-outline-light text-start">

            📊 Attendance History

        </a>

        <!-- SUBSCRIPTION -->

        <a href="subscription.jsp"
           class="btn btn-outline-light text-start">

            🗓️ Subscription

        </a>

        <!-- PAYMENTS -->

        <a href="view_payment.jsp"
           class="btn btn-outline-light text-start">

            💳 Payments

        </a>

        <!-- SKIP DAY -->

        <a href="skip_day.jsp"
          class="btn btn-outline-light text-start">

            ⏭️ Skip Day

        </a>

        <!-- FEEDBACK -->

        <a href="feedback.jsp"
           class="btn btn-outline-light text-start">

            💬 Feedback

        </a>

        <!-- LOGOUT -->

        <a href="../logout"
           class="btn btn-danger text-start mt-3">

            🚪 Logout

        </a>

    </div>

</div>

<!-- ===================================
     MAIN CONTENT
=================================== -->

<div class="col-lg-10 col-md-9 p-4 main-content">

<!-- ===================================
     TOPBAR
=================================== -->

<div class="topbar d-flex justify-content-between align-items-center flex-wrap">

<div>

<h3 class="mb-1">

    📅 Subscription Dashboard

</h3>

<p class="text-muted mb-0">

    Manage your Smart Mess membership

</p>

</div>

<div class="mt-2 mt-md-0">

<span class="badge bg-gradient-primary p-3">

    Membership Portal

</span>

</div>

</div>

<!-- ===================================
     SUBSCRIPTION OVERVIEW
=================================== -->

<div class="row mb-4">

<!-- STATUS CARD -->

<div class="col-lg-4 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-success h-100">

<div class="card-body">

<h5>

    ✅ Status

</h5>

<h2>

    <%= statusText %>

</h2>

<p class="mb-0">

    Current subscription state

</p>

</div>

</div>

</div>

<!-- PLAN CARD -->

<div class="col-lg-4 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-primary h-100">

<div class="card-body">

<h5>

    📦 Current Plan

</h5>

<h2>

    <%= plan != null ? plan : "None" %>

</h2>

<p class="mb-0">

    Active membership plan

</p>

</div>

</div>

</div>

<!-- DAYS LEFT -->

<div class="col-lg-4 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-warning h-100">

<div class="card-body">

<h5>

    ⏳ Days Remaining

</h5>

<h2>

    <%= active ? daysLeft : 0 %>

</h2>

<p class="mb-0">

    Remaining subscription validity

</p>

</div>

</div>

</div>

</div>

<!-- ===================================
     SUBSCRIPTION DETAILS
=================================== -->

<div class="row">

<div class="col-lg-8 mb-4">

<div class="card glass-card h-100">

<div class="card-body">

<h3 class="mb-4">

    📋 Subscription Details

</h3>

<% if (plan != null) { %>

<div class="row">

<!-- PLAN -->

<div class="col-md-6 mb-4">

<div class="card border-0 bg-light h-100">

<div class="card-body">

<p class="text-muted mb-2">

    Plan Type

</p>

<h4 class="text-primary">

    <%= plan %>

</h4>

</div>

</div>

</div>

<!-- STATUS -->

<div class="col-md-6 mb-4">

<div class="card border-0 bg-light h-100">

<div class="card-body">

<p class="text-muted mb-2">

    Subscription Status

</p>

<h4 class="text-<%= statusClass %>">

    <%= statusText %>

</h4>

</div>

</div>

</div>

<!-- START DATE -->

<div class="col-md-6 mb-4">

<div class="card border-0 bg-light h-100">

<div class="card-body">

<p class="text-muted mb-2">

    Start Date

</p>

<h5>

    <%= startDate %>

</h5>

</div>

</div>

</div>

<!-- END DATE -->

<div class="col-md-6 mb-4">

<div class="card border-0 bg-light h-100">

<div class="card-body">

<p class="text-muted mb-2">

    Expiry Date

</p>

<h5>

    <%= endDate %>

</h5>

</div>

</div>

</div>

</div>

<!-- PROGRESS -->

<div class="mt-3">

<h5 class="mb-3">

    Membership Progress

</h5>

<div class="progress">

<div class="progress-bar bg-success"
     style="width:<%= active ? "75" : "10" %>%">

</div>

</div>

<p class="text-muted mt-2 mb-0">

    Your subscription is currently active.

</p>

</div>

<% } else { %>

<div class="text-center py-5">

<div style="font-size:70px;">

    📭

</div>

<h3 class="mt-3 mb-3">

    No Subscription Found

</h3>

<p class="text-muted mb-4">

    Buy a subscription plan to access mess services.

</p>

<a href="payment.jsp"
   class="btn btn-primary px-5 py-3">

    Buy Subscription

</a>

</div>

<% } %>

</div>

</div>

</div>

<!-- ===================================
     QUICK ACTIONS
=================================== -->

<div class="col-lg-4 mb-4">

<div class="card h-100">

<div class="card-body">

<h3 class="mb-4">

    ⚡ Quick Actions

</h3>

<div class="d-grid gap-3">

<a href="payment.jsp"
   class="btn btn-warning py-3">

    💳 Buy / Renew Plan

</a>

<a href="view_payment.jsp"
   class="btn btn-success py-3">

    💰 Payment History

</a>

<a href="dashboard.jsp"
   class="btn btn-primary py-3">

    🏠 Dashboard

</a>

</div>

</div>

</div>

</div>

</div>

</div>

</div>

</div>

</body>
</html>