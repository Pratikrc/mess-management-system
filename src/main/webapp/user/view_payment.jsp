<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
if (session.getAttribute("email") == null) {

    response.sendRedirect("../login.jsp");

    return;
}

String email = (String) session.getAttribute("email");
%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Your Payments</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet">

</head>

<body class="bg-light">

<!-- 🔥 NAVBAR -->

<nav class="navbar navbar-dark bg-dark">

    <div class="container-fluid">

        <span class="navbar-brand">
            Your Payments
        </span>

        <a href="dashboard.jsp"
           class="btn btn-light btn-sm">

            Back

        </a>

    </div>

</nav>

<div class="container py-4">

<!-- 🔥 PAGE TITLE -->

<h3 class="text-center mb-4">

    💳 Payment History

</h3>

<!-- 🔥 PAYMENT CARD -->

<div class="card shadow-sm border-0">

<div class="card-body">

<div class="table-responsive">

<table class="table table-bordered table-striped table-hover align-middle text-center">

<thead class="table-dark">

<tr>

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

    while (rs.next()) {

        hasData = true;

        String status = rs.getString("status");
%>

<tr>

    <!-- AMOUNT -->

    <td class="fw-bold text-success">

        ₹ <%= rs.getString("amount") %>

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

    <td colspan="3"
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