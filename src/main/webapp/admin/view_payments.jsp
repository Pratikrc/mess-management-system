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

<body class="bg-light">

<!-- 🔥 NAVBAR -->

<nav class="navbar navbar-dark bg-dark">

<div class="container-fluid">

<span class="navbar-brand">

    Payment Management

</span>

<a href="dashboard.jsp"
   class="btn btn-light btn-sm">

    Back

</a>

</div>

</nav>

<div class="container py-4">

<!-- 🔥 PAGE TITLE -->

<h3 class="mb-4 text-center text-md-start">

    💳 All Payments

</h3>

<!-- 📋 PAYMENT TABLE -->

<div class="card shadow-sm border-0">

<div class="card-body">

<div class="table-responsive">

<table class="table table-bordered table-striped table-hover align-middle">

<thead class="table-dark">

<tr>

    <th>Email</th>

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
%>

<tr>

<!-- EMAIL -->

<td>

    <%= rs.getString("user_email") %>

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

<td class="fw-bold text-success">

    ₹ <%= rs.getInt("amount") %>

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
   class="btn btn-success btn-sm w-100">

    Approve

</a>

<% } else { %>

<button class="btn btn-secondary btn-sm w-100"
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
    class="text-center text-danger py-4">

    No payment records found

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

<!-- 🔙 BACK BUTTON -->

<div class="text-center mt-4">

<a href="dashboard.jsp"
   class="btn btn-secondary w-100 w-md-auto px-4">

    Back to Dashboard

</a>

</div>

</div>

</body>
</html>