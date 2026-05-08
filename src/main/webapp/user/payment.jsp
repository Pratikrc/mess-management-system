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

    // 🔥 SUBSCRIPTION CHECK
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

    // 🔥 PENDING PAYMENT CHECK
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

<body class="bg-light">

<div class="container py-4">

<div class="row justify-content-center">

<div class="col-lg-6 col-md-8 col-sm-12">

<div class="card shadow-sm border-0">

<div class="card-body p-4">

<!-- 🔥 TITLE -->

<h3 class="text-center mb-4">

    💳 Subscription Payment

</h3>

<!-- 🔔 MESSAGE -->

<%
String msg = request.getParameter("msg");

String type = request.getParameter("type");

if (msg != null) {
%>

<div class="alert
    <%= "success".equals(type)
        ? "alert-success"
        : "alert-danger" %>">

    <%= msg %>

</div>

<%
}
%>

<!-- ✅ ACTIVE SUBSCRIPTION -->

<% if (active) { %>

<div class="text-center">

<h4 class="text-success mb-3">

    Already Subscribed ✅

</h4>

<div class="card bg-light border-0 p-3 mb-3">

<p class="mb-2">

    <b>Plan:</b>
    <%= plan %>

</p>

<p class="mb-0">

    <b>Expiry Date:</b>
    <%= endDate %>

</p>

</div>

<a href="dashboard.jsp"
   class="btn btn-primary w-100 py-2">

    Back to Dashboard

</a>

</div>

<!-- ⏳ PENDING PAYMENT -->

<% } else if (hasPendingPayment) { %>

<div class="text-center">

<h4 class="text-warning mb-3">

    Payment Pending Approval ⏳

</h4>

<p class="mb-4">

    Please wait for admin approval.

</p>

<a href="../login.jsp"
   class="btn btn-success w-100 py-2">

    Go to Login

</a>

</div>

<!-- 💳 PAYMENT FORM -->

<% } else { %>

<form action="<%=request.getContextPath()%>/payment"
      method="post">

<!-- PLAN -->

<div class="mb-4">

<label class="form-label fw-bold">

    Select Plan

</label>

<div class="card border p-3 mb-2">

<div class="form-check">

<input class="form-check-input"
       type="radio"
       name="plan"
       value="Weekly"
       required>

<label class="form-check-label">

    Weekly (₹500 - 7 Days)

</label>

</div>

</div>

<div class="card border p-3">

<div class="form-check">

<input class="form-check-input"
       type="radio"
       name="plan"
       value="Monthly"
       required>

<label class="form-check-label">

    Monthly (₹2000 - 30 Days)

</label>

</div>

</div>

</div>

<!-- START DATE -->

<div class="mb-4">

<label class="form-label fw-bold">

    Subscription Start Date

</label>

<input type="date"
       name="startDate"
       class="form-control"
       min="<%= java.time.LocalDate.now() %>"
       required>

</div>

<!-- PAYMENT MODE -->

<div class="mb-4">

<label class="form-label fw-bold">

    Payment Mode

</label>

<div class="card border p-3 mb-2">

<div class="form-check">

<input class="form-check-input"
       type="radio"
       name="mode"
       value="Online"
       required
       onclick="showOnline()">

<label class="form-check-label">

    Online (UPI)

</label>

</div>

</div>

<div class="card border p-3">

<div class="form-check">

<input class="form-check-input"
       type="radio"
       name="mode"
       value="Offline"
       required
       onclick="showOffline()">

<label class="form-check-label">

    Offline

</label>

</div>

</div>

</div>

<!-- ONLINE BOX -->

<div id="onlineBox"
     class="text-center mb-4"
     style="display:none;">

<div class="card bg-light border-0 p-3">

<p class="fs-5 mb-2">

    <b>Scan & Pay</b>

</p>

<p>

    <b>UPI ID:</b> mess@upi

</p>

<img src="<%=request.getContextPath()%>/images/qr.png"
     class="img-fluid rounded border p-2 mx-auto d-block"
     style="max-width:220px;">

<p class="text-danger mt-3 mb-0">

    ⚠ Add your
    <b>Name</b>
    while making payment

</p>

</div>

</div>

<!-- OFFLINE BOX -->

<div id="offlineBox"
     style="display:none;"
     class="mb-4">

<div class="alert alert-warning text-center mb-0">

    Pay to mess owner.
    Waiting for admin approval.

</div>

</div>

<!-- SUBMIT -->

<button type="submit"
        class="btn btn-primary w-100 py-2">

    Submit Payment

</button>

</form>

<% } %>

</div>

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