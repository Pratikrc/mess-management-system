<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
String email = (String) session.getAttribute("email");

String role = (String) session.getAttribute("role");

if (email == null || role == null || !role.equals("admin")) {

    response.sendRedirect("../login.jsp");

    return;
}

int totalUsers = 0;

int approvedUsers = 0;

int pendingUsers = 0;

try {

    Connection con = DBConnection.getConnection();

    // TOTAL USERS

    PreparedStatement ps1 = con.prepareStatement(

        "SELECT COUNT(*) FROM users"
    );

    ResultSet rs1 = ps1.executeQuery();

    if (rs1.next()) {

        totalUsers = rs1.getInt(1);
    }

    // APPROVED USERS

    PreparedStatement ps2 = con.prepareStatement(

        "SELECT COUNT(*) FROM users " +
        "WHERE status='approved'"
    );

    ResultSet rs2 = ps2.executeQuery();

    if (rs2.next()) {

        approvedUsers = rs2.getInt(1);
    }

    // PENDING USERS

    PreparedStatement ps3 = con.prepareStatement(

        "SELECT COUNT(*) FROM users " +
        "WHERE status='pending'"
    );

    ResultSet rs3 = ps3.executeQuery();

    if (rs3.next()) {

        pendingUsers = rs3.getInt(1);
    }

} catch(Exception e) {

    e.printStackTrace();
}
%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Manage Users</title>

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

     Dashboard

</a>

<a href="manage_users.jsp"
   class="btn btn-outline-light text-start">

     Manage Users

</a>

<a href="add_menu.jsp"
   class="btn btn-outline-light text-start">

     Manage Menu

</a>

<a href="add_announcement.jsp"
   class="btn btn-outline-light text-start">

     Announcement

</a>

<a href="view_attendance.jsp"
   class="btn btn-outline-light text-start">

     Attendance

</a>

<a href="meal_verification.jsp"
   class="btn btn-outline-light text-start">

     Meal Verification

</a>

<a href="view_payments.jsp"
   class="btn btn-outline-light text-start">

     Payments

</a>

<a href="view_subscription.jsp"
   class="btn btn-outline-light text-start">

     Subscriptions

</a>

<a href="view_feedback.jsp"
   class="btn btn-outline-light text-start">

     Feedback

</a>

<a href="reports.jsp"
   class="btn btn-outline-light text-start">

     Reports

</a>

<a href="../logout"
   class="btn btn-danger text-start mt-3">

     Logout

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

     User Management

</h3>

<p class="text-muted mb-0">

    Manage and approve Smart Mess users

</p>

</div>

<div class="mt-2 mt-md-0">

<span class="badge bg-gradient-primary p-3">

    Admin Control Panel

</span>

</div>

</div>

<!-- ===================================
     ANALYTICS CARDS
=================================== -->

<div class="row mb-4">

<!-- TOTAL USERS -->

<div class="col-lg-4 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-primary h-100">

<div class="card-body">

<h5>

     Total Users

</h5>

<h2>

    <%= totalUsers %>

</h2>

<p class="mb-0">

    Registered users

</p>

</div>

</div>

</div>

<!-- APPROVED -->

<div class="col-lg-4 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-success h-100">

<div class="card-body">

<h5>

     Approved Users

</h5>

<h2>

    <%= approvedUsers %>

</h2>

<p class="mb-0">

    Active approved users

</p>

</div>

</div>

</div>

<!-- PENDING -->

<div class="col-lg-4 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-warning h-100">

<div class="card-body">

<h5>

     Pending Users

</h5>

<h2>

    <%= pendingUsers %>

</h2>

<p class="mb-0">

    Awaiting admin approval

</p>

</div>

</div>

</div>

</div>

<!-- ===================================
     USER TABLE
=================================== -->

<div class="card border-0">

<div class="card-body">

<div class="d-flex justify-content-between align-items-center flex-wrap mb-4">

<div>

<h4 class="mb-1">

     User Directory

</h4>

<p class="text-muted mb-0">

    Complete registered users list

</p>

</div>

</div>

<div class="table-responsive">

<table class="table table-hover align-middle">

<thead>

<tr>

<th>Name</th>

<th>Email</th>

<th>Phone</th>

<th>Status</th>

<th>Action</th>

</tr>

</thead>

<tbody>

<%
try {

    Connection con = DBConnection.getConnection();

    Statement st = con.createStatement();

    ResultSet rs = st.executeQuery(

        "SELECT * FROM users ORDER BY name ASC"
    );

    boolean hasData = false;

    while (rs.next()) {

        hasData = true;

        String status = rs.getString("status");

        String phone = rs.getString("phone");
%>

<tr>

<!-- NAME -->

<td>

<div class="d-flex align-items-center">

<div class="me-3">

<div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center"
     style="width:45px; height:45px; font-weight:600;">

    <%= rs.getString("name").substring(0,1).toUpperCase() %>

</div>

</div>

<div>

<h6 class="mb-0 fw-semibold">

    <%= rs.getString("name") %>

</h6>

<small class="text-muted">

    Smart Mess User

</small>

</div>

</div>

</td>

<!-- EMAIL -->

<td>

    <%= rs.getString("email") %>

</td>

<!-- PHONE -->

<td>

<%
if (phone != null && !phone.isEmpty()) {
%>

<span class="fw-semibold">

    <%= phone %>

</span>

<%
} else {
%>

<span class="text-danger">

    Not Available

</span>

<%
}
%>

</td>

<!-- STATUS -->

<td>

<span class="badge
    <%= "approved".equals(status)
        ? "bg-success"
        : "bg-warning text-dark" %>">

    <%= status.toUpperCase() %>

</span>

</td>

<!-- ACTION -->

<td>

<%
if ("pending".equals(status)) {
%>

<a href="../approveUser?email=<%= rs.getString("email") %>"
   class="btn btn-success btn-sm px-4">

     Approve

</a>

<%
} else {
%>

<button class="btn btn-outline-success btn-sm"
        disabled>

    Approved

</button>

<%
}
%>

</td>

</tr>

<%
    }

    if (!hasData) {
%>

<tr>

<td colspan="5"
    class="text-center py-5">

<div style="font-size:60px;">

    

</div>

<h4 class="mt-3">

    No Users Found

</h4>

<p class="text-muted">

    No registered users available.

</p>

</td>

</tr>

<%
    }

} catch(Exception e) {

    out.println(

        "<tr>" +
        "<td colspan='5' class='text-danger text-center py-4'>" +
        "Database Error: " + e.getMessage() +
        "</td>" +
        "</tr>"
    );

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

     Dashboard

</a>

</div>

<div class="col-md-4 mb-3 mb-md-0">

<a href="view_payments.jsp"
   class="btn btn-success w-100 py-3">

     Payments

</a>

</div>

<div class="col-md-4">

<a href="reports.jsp"
   class="btn btn-dark w-100 py-3">

     Reports

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