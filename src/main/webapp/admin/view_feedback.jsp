<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
String role = (String) session.getAttribute("role");

if (role == null || !role.equals("admin")) {

    response.sendRedirect("../login.jsp");

    return;
}

int totalFeedback = 0;

int todayFeedback = 0;

try {

    Connection con = DBConnection.getConnection();

    // TOTAL FEEDBACK

    PreparedStatement ps1 = con.prepareStatement(

        "SELECT COUNT(*) FROM feedback"
    );

    ResultSet rs1 = ps1.executeQuery();

    if (rs1.next()) {

        totalFeedback = rs1.getInt(1);
    }

    // TODAY FEEDBACK

    PreparedStatement ps2 = con.prepareStatement(

        "SELECT COUNT(*) FROM feedback " +
        "WHERE DATE(created_at)=CURDATE()"
    );

    ResultSet rs2 = ps2.executeQuery();

    if (rs2.next()) {

        todayFeedback = rs2.getInt(1);
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

<title>User Feedback</title>

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

     Feedback Center

</h3>

<p class="text-muted mb-0">

    Review and manage user feedback

</p>

</div>

<div class="mt-2 mt-md-0">

<span class="badge bg-gradient-primary p-3">

    Support Dashboard

</span>

</div>

</div>

<!-- ===================================
     ANALYTICS CARDS
=================================== -->

<div class="row mb-4">

<!-- TOTAL FEEDBACK -->

<div class="col-lg-6 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-primary h-100">

<div class="card-body">

<h5>

     Total Feedback

</h5>

<h2>

    <%= totalFeedback %>

</h2>

<p class="mb-0">

    Total submitted feedback

</p>

</div>

</div>

</div>

<!-- TODAY FEEDBACK -->

<div class="col-lg-6 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-success h-100">

<div class="card-body">

<h5>

     Today's Feedback

</h5>

<h2>

    <%= todayFeedback %>

</h2>

<p class="mb-0">

    Feedback received today

</p>

</div>

</div>

</div>

</div>

<!-- ===================================
     FEEDBACK LIST
=================================== -->

<div class="card border-0">

<div class="card-body">

<div class="d-flex justify-content-between align-items-center flex-wrap mb-4">

<div>

<h4 class="mb-1">

     User Feedback Messages

</h4>

<p class="text-muted mb-0">

    Recent user suggestions and reports

</p>

</div>

</div>

<div class="row">

<%
try {

    Connection con = DBConnection.getConnection();

    Statement st = con.createStatement();

    ResultSet rs = st.executeQuery(

        "SELECT * FROM feedback " +
        "ORDER BY created_at DESC"
    );

    boolean hasData = false;

    int count = 1;

    while (rs.next()) {

        hasData = true;
%>

<!-- ===================================
     FEEDBACK CARD
=================================== -->

<div class="col-lg-6 mb-4">

<div class="card border shadow-sm h-100">

<div class="card-body">

<!-- HEADER -->

<div class="d-flex justify-content-between align-items-center mb-3">

<div class="d-flex align-items-center">

<div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center me-3"
     style="width:50px; height:50px; font-weight:600;">

    <%= count++ %>

</div>

<div>

<h6 class="mb-0 fw-semibold">

    Anonymous User

</h6>

<small class="text-muted">

    Smart Mess Feedback

</small>

</div>

</div>

<span class="badge bg-gradient-primary">

    Feedback

</span>

</div>

<!-- MESSAGE -->

<div class="card bg-light border-0">

<div class="card-body">

<p class="mb-0 text-muted"
   style="line-height:1.8;">

    <%= rs.getString("message") %>

</p>

</div>

</div>

<!-- FOOTER -->

<div class="d-flex justify-content-between align-items-center mt-3">

<small class="text-muted">

     <%= rs.getString("created_at") %>

</small>

<span class="text-success fw-semibold">

     Received

</span>

</div>

</div>

</div>

</div>

<%
    }

    if (!hasData) {
%>

<div class="col-12">

<div class="text-center py-5">

<div style="font-size:70px;">

    

</div>

<h3 class="mt-3">

    No Feedback Found

</h3>

<p class="text-muted">

    No user feedback has been submitted yet.

</p>

</div>

</div>

<%
    }

} catch (Exception e) {

    e.printStackTrace();
}
%>

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

<a href="manage_users.jsp"
   class="btn btn-success w-100 py-3">

     Users

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