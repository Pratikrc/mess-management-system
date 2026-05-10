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

boolean active = false;

boolean hasPendingPayment = false;

String plan = "";

String endDate = "";

try {

    Connection con = DBConnection.getConnection();

    // SUBSCRIPTION CHECK

    PreparedStatement ps1 = con.prepareStatement(

        "SELECT * FROM subscription " +
        "WHERE user_email=? " +
        "ORDER BY end_date DESC LIMIT 1"
    );

    ps1.setString(1, email);

    ResultSet rs1 = ps1.executeQuery();

    if (rs1.next()) {

        plan = rs1.getString("plan_type");

        endDate = rs1.getString("end_date");

        java.sql.Date ed = rs1.getDate("end_date");

        if (ed.getTime() >= System.currentTimeMillis()) {

            active = true;
        }
    }

    // PENDING PAYMENT CHECK

    PreparedStatement ps2 = con.prepareStatement(

        "SELECT 1 FROM payments " +
        "WHERE user_email=? " +
        "AND status='Pending' LIMIT 1"
    );

    ps2.setString(1, email);

    ResultSet rs2 = ps2.executeQuery();

    if (rs2.next()) {

        hasPendingPayment = true;
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

<title>Subscription Payment</title>

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

    💳 Subscription Payment

</h3>

<p class="text-muted mb-0">

    Choose your subscription plan

</p>

</div>

<div class="mt-2 mt-md-0">

<span class="badge bg-gradient-primary p-3">

    Secure Payment Portal

</span>

</div>

</div>

<!-- MESSAGE -->

<%
String msg = request.getParameter("msg");

String type = request.getParameter("type");

if (msg != null) {
%>

<div class="alert
    <%= "success".equals(type)
        ? "alert-success"
        : "alert-danger" %> shadow-soft mb-4">

    <%= msg %>

</div>

<%
}
%>

<!-- ACTIVE PLAN -->

<% if (active) { %>

<div class="card border-0">

<div class="card-body text-center py-5">

<div style="font-size:70px;">

    ✅

</div>

<h2 class="text-success mt-3 mb-4">

    Subscription Active

</h2>

<div class="row justify-content-center">

<div class="col-md-6">

<div class="card glass-card">

<div class="card-body">

<h4 class="mb-3">

    <%= plan %> Plan

</h4>

<p class="mb-2">

    <strong>Expiry Date:</strong>

</p>

<h5 class="text-primary">

    <%= endDate %>

</h5>

</div>

</div>

</div>

</div>

<div class="mt-4">

<a href="dashboard.jsp"
   class="btn btn-primary px-5 py-3">

    Back to Dashboard

</a>

</div>

</div>

</div>

<!-- PENDING -->

<% } else if (hasPendingPayment) { %>

<div class="card border-0">

<div class="card-body text-center py-5">

<div style="font-size:70px;">

    ⏳

</div>

<h2 class="text-warning mt-3 mb-3">

    Payment Pending Approval

</h2>

<p class="text-muted mb-4">

    Please wait until admin approves your payment.

</p>

<a href="dashboard.jsp"
   class="btn btn-warning px-5 py-3">

    Back to Dashboard

</a>

</div>

</div>

<!-- PAYMENT FORM -->

<% } else { %>

<form action="<%=request.getContextPath()%>/payment"
      method="post">

<div class="row">

<!-- ===================================
     WEEKLY PLAN
=================================== -->

<div class="col-lg-6 mb-4">

<label class="w-100">

<input type="radio"
       name="plan"
       value="Weekly"
       class="d-none"
       required>

<div class="card h-100 border-0">

<div class="card-body text-center">

<div class="mb-3"
     style="font-size:55px;">

    🗓️

</div>

<h3 class="mb-3">

    Weekly Plan

</h3>

<h1 class="text-primary mb-3">

    ₹500

</h1>

<p class="text-muted mb-4">

    7 Days Access

</p>

<ul class="list-unstyled text-start">

<li class="mb-2">

    ✔ Lunch & Dinner

</li>

<li class="mb-2">

    ✔ Attendance Tracking

</li>

<li class="mb-2">

    ✔ Menu Access

</li>

<li>

    ✔ Skip Feature

</li>

</ul>

</div>

</div>

</label>

</div>

<!-- ===================================
     MONTHLY PLAN
=================================== -->

<div class="col-lg-6 mb-4">

<label class="w-100">

<input type="radio"
       name="plan"
       value="Monthly"
       class="d-none"
       required>

<div class="card h-100 border-0">

<div class="card-body text-center">

<div class="mb-3"
     style="font-size:55px;">

    📅

</div>

<h3 class="mb-3">

    Monthly Plan

</h3>

<h1 class="text-success mb-3">

    ₹2000

</h1>

<p class="text-muted mb-4">

    30 Days Access

</p>

<ul class="list-unstyled text-start">

<li class="mb-2">

    ✔ Full Meal Access

</li>

<li class="mb-2">

    ✔ Attendance History

</li>

<li class="mb-2">

    ✔ Priority Support

</li>

<li>

    ✔ Extended Validity

</li>

</ul>

</div>

</div>

</label>

</div>

</div>

<!-- START DATE -->

<div class="card border-0 mb-4">

<div class="card-body">

<h4 class="mb-4">

    📅 Subscription Start Date

</h4>

<input type="date"
       name="startDate"
       class="form-control"
       min="<%= java.time.LocalDate.now() %>"
       required>

</div>

</div>

<!-- PAYMENT MODE -->

<div class="card border-0 mb-4">

<div class="card-body">

<h4 class="mb-4">

    💳 Payment Mode

</h4>

<div class="row">

<div class="col-md-6 mb-3">

<label class="w-100">

<input type="radio"
       name="mode"
       value="Online"
       class="d-none"
       required
       onclick="showOnline()">

<div class="card border shadow-sm">

<div class="card-body text-center py-4">

<h5 class="mb-2">

    🌐 Online Payment

</h5>

<p class="text-muted mb-0">

    UPI / QR Payment

</p>

</div>

</div>

</label>

</div>

<div class="col-md-6 mb-3">

<label class="w-100">

<input type="radio"
       name="mode"
       value="Offline"
       class="d-none"
       required
       onclick="showOffline()">

<div class="card border shadow-sm">

<div class="card-body text-center py-4">

<h5 class="mb-2">

    🏢 Offline Payment

</h5>

<p class="text-muted mb-0">

    Pay to mess owner

</p>

</div>

</div>

</label>

</div>

</div>

</div>

</div>

<!-- ONLINE BOX -->

<div id="onlineBox"
     style="display:none;"
     class="card border-0 mb-4">

<div class="card-body text-center">

<h3 class="mb-3">

    📱 Scan & Pay

</h3>

<p class="text-muted">

    UPI ID:
    <strong>mess@upi</strong>

</p>

<img src="<%=request.getContextPath()%>/images/qr.png"
     class="img-fluid rounded shadow-soft p-2 bg-white"
     style="max-width:240px;">

<p class="text-danger mt-4 mb-0">

    ⚠ Add your name while making payment

</p>

</div>

</div>

<!-- OFFLINE BOX -->

<div id="offlineBox"
     style="display:none;"
     class="alert alert-warning mb-4">

    Pay directly to mess owner.
    Waiting for admin approval after submission.

</div>

<!-- SUBMIT -->

<button type="submit"
        class="btn btn-primary w-100 py-3 fs-5">

    Submit Payment Request

</button>

</form>

<% } %>

</div>

</div>

</div>

</div>

<script>

function showOnline() {

    document.getElementById("onlineBox").style.display = "block";

    document.getElementById("offlineBox").style.display = "none";
}

function showOffline() {

    document.getElementById("onlineBox").style.display = "none";

    document.getElementById("offlineBox").style.display = "block";
}

</script>

</body>
</html>