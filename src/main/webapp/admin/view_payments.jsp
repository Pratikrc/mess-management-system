<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
String role = (String) session.getAttribute("role");

if (role == null || !role.equals("admin")) {

    response.sendRedirect("../login.jsp");

    return;
}

double totalRevenue = 0;

int totalPayments = 0;

int pendingPayments = 0;

try {

    Connection con = DBConnection.getConnection();

    // TOTAL REVENUE

    PreparedStatement ps1 = con.prepareStatement(

        "SELECT SUM(amount) FROM payments " +
        "WHERE status='Paid'"
    );

    ResultSet rs1 = ps1.executeQuery();

    if (rs1.next()) {

        totalRevenue = rs1.getDouble(1);
    }

    // TOTAL PAYMENTS

    PreparedStatement ps2 = con.prepareStatement(

        "SELECT COUNT(*) FROM payments"
    );

    ResultSet rs2 = ps2.executeQuery();

    if (rs2.next()) {

        totalPayments = rs2.getInt(1);
    }

    // PENDING PAYMENTS

    PreparedStatement ps3 = con.prepareStatement(

        "SELECT COUNT(*) FROM payments " +
        "WHERE status='Pending'"
    );

    ResultSet rs3 = ps3.executeQuery();

    if (rs3.next()) {

        pendingPayments = rs3.getInt(1);
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

<title>View Payments</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet">

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

    📊 Dashboard

</a>

<a href="manage_users.jsp"
   class="btn btn-outline-light text-start">

    👥 Manage Users

</a>

<a href="add_menu.jsp"
   class="btn btn-outline-light text-start">

    🍽️ Manage Menu

</a>

<a href="add_announcement.jsp"
   class="btn btn-outline-light text-start">

    📢 Announcement

</a>

<a href="view_attendance.jsp"
   class="btn btn-outline-light text-start">

    📋 Attendance

</a>

<a href="meal_verification.jsp"
   class="btn btn-outline-light text-start">

    ✅ Meal Verification

</a>

<a href="view_payments.jsp"
   class="btn btn-outline-light text-start">

    💳 Payments

</a>

<a href="view_subscription.jsp"
   class="btn btn-outline-light text-start">

    📅 Subscriptions

</a>

<a href="view_feedback.jsp"
   class="btn btn-outline-light text-start">

    💬 Feedback

</a>

<a href="reports.jsp"
   class="btn btn-outline-light text-start">

    📈 Reports

</a>

<a href="../logout"
   class="btn btn-danger text-start mt-3">

    🚪 Logout

</a>

</div>

</div>

<!-- ===================================
     MAIN CONTENT
=================================== -->

<div class="col-lg-10 col-md-9 p-4">
<!-- ===================================
     TOPBAR
=================================== -->

<div class="topbar d-flex justify-content-between align-items-center flex-wrap">

<div>

<h3 class="mb-1">

    💳 Payment Management

</h3>

<p class="text-muted mb-0">

    Monitor and approve user payments

</p>

</div>

<div class="mt-2 mt-md-0">

<span class="badge bg-gradient-success p-3">

    Finance Dashboard

</span>

</div>

</div>

<!-- ===================================
     ANALYTICS CARDS
=================================== -->

<div class="row mb-4">

<!-- TOTAL REVENUE -->

<div class="col-lg-4 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-success h-100">

<div class="card-body">

<h5>

    💰 Total Revenue

</h5>

<h2>

    ₹ <%= totalRevenue %>

</h2>

<p class="mb-0">

    Total approved earnings

</p>

</div>

</div>

</div>

<!-- TOTAL PAYMENTS -->

<div class="col-lg-4 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-primary h-100">

<div class="card-body">

<h5>

    📄 Transactions

</h5>

<h2>

    <%= totalPayments %>

</h2>

<p class="mb-0">

    Total payment records

</p>

</div>

</div>

</div>

<!-- PENDING -->

<div class="col-lg-4 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-warning h-100">

<div class="card-body">

<h5>

    ⏳ Pending Approvals

</h5>

<h2>

    <%= pendingPayments %>

</h2>

<p class="mb-0">

    Awaiting admin approval

</p>

</div>

</div>

</div>

</div>

<!-- ===================================
     PAYMENT TABLE
=================================== -->

<div class="card border-0">

<div class="card-body">

<div class="d-flex justify-content-between align-items-center flex-wrap mb-4">

<div>

<h4 class="mb-1">

    📋 Payment Transactions

</h4>

<p class="text-muted mb-0">

    Complete payment records

</p>

</div>

</div>

<div class="table-responsive">

<table class="table table-hover align-middle">

<thead>

<tr>

<th>User</th>

<th>Plan</th>

<th>Mode</th>

<th>Amount</th>

<th>Status</th>

<th>Date</th>

<th>Action</th>

</tr>

</thead>

<tbody>

<%
try {

    Connection con = DBConnection.getConnection();

    Statement st = con.createStatement();

    ResultSet rs = st.executeQuery(

        "SELECT * FROM payments " +
        "ORDER BY created_at DESC"
    );

    boolean hasData = false;

    while (rs.next()) {

        hasData = true;

        String status = rs.getString("status");

        String plan = rs.getString("plan");

        String email = rs.getString("user_email");
%>

<tr>

<!-- USER -->

<td>

<div class="d-flex align-items-center">

<div class="me-3">

<div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center"
     style="width:42px; height:42px; font-weight:600;">

    <%= email.substring(0,1).toUpperCase() %>

</div>

</div>

<div>

<h6 class="mb-0 fw-semibold">

    <%= email %>

</h6>

<small class="text-muted">

    Smart Mess User

</small>

</div>

</div>

</td>

<!-- PLAN -->

<td>

<span class="badge
    <%= "Monthly".equals(plan)
        ? "bg-success"
        : "bg-primary" %>">

    <%= plan %>

</span>

</td>

<!-- MODE -->

<td>

<span class="badge
    <%= "Online".equals(rs.getString("payment_mode"))
        ? "bg-info text-dark"
        : "bg-secondary" %>">

    <%= rs.getString("payment_mode") %>

</span>

</td>

<!-- AMOUNT -->

<td>

<h6 class="text-success fw-bold mb-0">

    ₹ <%= rs.getInt("amount") %>

</h6>

</td>

<!-- STATUS -->

<td>

<span class="badge
    <%= "Paid".equals(status)
        ? "bg-success"
        : "bg-warning text-dark" %>">

    <%= status %>

</span>

</td>

<!-- DATE -->

<td>

    <%= rs.getString("created_at") %>

</td>

<!-- ACTION -->

<td>

<% if ("Pending".equals(status)) { %>

<a href="<%=request.getContextPath()%>/approvePayment?id=<%= rs.getInt("id") %>"
   class="btn btn-success btn-sm px-3">

    ✅ Approve

</a>

<% } else { %>

<button class="btn btn-outline-success btn-sm"
        disabled>

    Approved

</button>

<% } %>

</td>

</tr>

<%
    }

    if (!hasData) {
%>

<tr>

<td colspan="7"
    class="text-center py-5">

<div style="font-size:60px;">

    💳

</div>

<h4 class="mt-3">

    No Payment Records Found

</h4>

<p class="text-muted">

    No payment transactions available.

</p>

</td>

</tr>

<%
    }

} catch (Exception e) {

    e.printStackTrace();
}
%>

</tbody>

</table>

</div>

</div>

</div>

<!-- ===================================
     QUICK ACTIONS
=================================== -->

<div class="card mt-4">

<div class="card-body">

<div class="row text-center">

<div class="col-md-4 mb-3 mb-md-0">

<a href="dashboard.jsp"
   class="btn btn-primary w-100 py-3">

    🏠 Dashboard

</a>

</div>

<div class="col-md-4 mb-3 mb-md-0">

<a href="manage_users.jsp"
   class="btn btn-success w-100 py-3">

    👥 Users

</a>

</div>

<div class="col-md-4">

<a href="reports.jsp"
   class="btn btn-dark w-100 py-3">

    📊 Reports

</a>

</div>

</div>

</div>

</div>

</div>

</div>

</div>

</body>
</html>