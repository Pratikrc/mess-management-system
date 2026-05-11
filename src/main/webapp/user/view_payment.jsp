<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
if (session.getAttribute("email") == null) {

    response.sendRedirect("../login.jsp");

    return;
}

String email = (String) session.getAttribute("email");

double totalPaid = 0;

int totalTransactions = 0;

int successfulPayments = 0;

try {

    Connection con = DBConnection.getConnection();

    // 🔥 TOTAL PAID

    PreparedStatement psTotal = con.prepareStatement(

        "SELECT SUM(amount) FROM payments " +
        "WHERE user_email=? " +
        "AND status='Paid'"
    );

    psTotal.setString(1, email);

    ResultSet rsTotal = psTotal.executeQuery();

    if (rsTotal.next()) {

        totalPaid = rsTotal.getDouble(1);
    }

    // 🔥 TOTAL TRANSACTIONS

    PreparedStatement psCount = con.prepareStatement(

        "SELECT COUNT(*) FROM payments " +
        "WHERE user_email=?"
    );

    psCount.setString(1, email);

    ResultSet rsCount = psCount.executeQuery();

    if (rsCount.next()) {

        totalTransactions = rsCount.getInt(1);
    }

    // 🔥 SUCCESSFUL PAYMENTS

    PreparedStatement psSuccess = con.prepareStatement(

        "SELECT COUNT(*) FROM payments " +
        "WHERE user_email=? " +
        "AND status='Paid'"
    );

    psSuccess.setString(1, email);

    ResultSet rsSuccess = psSuccess.executeQuery();

    if (rsSuccess.next()) {

        successfulPayments = rsSuccess.getInt(1);
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

<title>Your Payments</title>

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

        <!-- VIEW MENU -->

        <a href="view_menu.jsp"
          class="btn btn-outline-light text-start">

             View Menu

        </a>

        <!-- ATTENDANCE -->

        <a href="attendance.jsp"
          class="btn btn-outline-light text-start">
             Attendance

        </a>

        <!-- ATTENDANCE HISTORY -->

        <a href="attendance_history.jsp"
           class="btn btn-outline-light text-start">

             Attendance History

        </a>

        <!-- SUBSCRIPTION -->

        <a href="subscription.jsp"
           class="btn btn-outline-light text-start">

             Subscription

        </a>

        <!-- PAYMENTS -->

        <a href="view_payment.jsp"
           class="btn btn-outline-light text-start">

             Payments

        </a>

        <!-- SKIP DAY -->

        <a href="skip_day.jsp"
          class="btn btn-outline-light text-start">

             Skip Day

        </a>

        <!-- FEEDBACK -->

        <a href="feedback.jsp"
           class="btn btn-outline-light text-start">

             Feedback

        </a>

        <!-- LOGOUT -->

        <a href="../logout"
           class="btn btn-danger text-start mt-3">

             Logout

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

     Payment History

</h3>

<p class="text-muted mb-0">

    Track all your subscription payments

</p>

</div>

<div class="mt-2 mt-md-0">

<span class="badge bg-gradient-success p-3">

    Secure Transactions

</span>

</div>

</div>

<!-- ===================================
     ANALYTICS CARDS
=================================== -->

<div class="row mb-4">

<!-- TOTAL PAID -->

<div class="col-lg-4 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-success h-100">

<div class="card-body">

<h5>

    Total Paid

</h5>

<h2>

     <%= totalPaid %>

</h2>

<p class="mb-0">

    Total successful payments

</p>

</div>

</div>

</div>

<!-- TRANSACTIONS -->

<div class="col-lg-4 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-primary h-100">

<div class="card-body">

<h5>

    Transactions

</h5>

<h2>

    <%= totalTransactions %>

</h2>

<p class="mb-0">

    Total payment attempts

</p>

</div>

</div>

</div>

<!-- SUCCESS RATE -->

<div class="col-lg-4 col-md-6 mb-4">

<div class="card dashboard-card bg-gradient-warning h-100">

<div class="card-body">

<h5>

     Successful

</h5>

<h2>

    <%= successfulPayments %>

</h2>

<p class="mb-0">

    Approved payments

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

     Transaction Records

</h4>

<p class="text-muted mb-0">

    Complete payment history

</p>

</div>

</div>

<div class="table-responsive">

<table class="table table-hover align-middle">

<thead>

<tr>

<th>#</th>

<th>Amount</th>

<th>Status</th>

<th>Date</th>

</tr>

</thead>

<tbody>

<%
try {

    Connection con = DBConnection.getConnection();

    PreparedStatement ps = con.prepareStatement(

        "SELECT * FROM payments " +
        "WHERE user_email=? " +
        "ORDER BY payment_date DESC"
    );

    ps.setString(1, email);

    ResultSet rs = ps.executeQuery();

    boolean hasData = false;

    int count = 1;

    while (rs.next()) {

        hasData = true;

        String status = rs.getString("status");
%>

<tr>

<!-- NUMBER -->

<td class="fw-semibold">

    <%= count++ %>

</td>

<!-- AMOUNT -->

<td>

<h6 class="text-success fw-bold mb-0">

     <%= rs.getString("amount") %>

</h6>

</td>

<!-- STATUS -->

<td>

<span class="badge
    <%= "Paid".equalsIgnoreCase(status)
        ? "bg-success"
        : "bg-warning text-dark" %>">

    <%= status %>

</span>

</td>

<!-- DATE -->

<td>

    <%= rs.getString("payment_date") %>

</td>

</tr>

<%
    }

    if (!hasData) {
%>

<tr>

<td colspan="4"
    class="text-center py-5">

<div style="font-size:60px;">

    

</div>

<h4 class="mt-3">

    No Payment Records Found

</h4>

<p class="text-muted">

    You have not made any payments yet.

</p>

<a href="payment.jsp"
   class="btn btn-primary mt-3 px-4">

    Make Payment

</a>

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

<a href="payment.jsp"
   class="btn btn-success w-100 py-3">

     New Payment

</a>

</div>

<div class="col-md-4 mb-3 mb-md-0">

<a href="subscription.jsp"
   class="btn btn-dark w-100 py-3">

     Subscription

</a>

</div>

<div class="col-md-4">

<a href="dashboard.jsp"
   class="btn btn-primary w-100 py-3">

     Dashboard

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