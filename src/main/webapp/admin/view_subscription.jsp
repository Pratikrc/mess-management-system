<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
String email = (String) session.getAttribute("email");

String role = (String) session.getAttribute("role");

if (email == null || role == null || !role.equals("admin")) {

    response.sendRedirect("../login.jsp");

    return;
}

// 🔍 FILTER VALUES
String username = request.getParameter("username");

String planFilter = request.getParameter("plan");

if (username == null) {

    username = "";
}

if (planFilter == null) {

    planFilter = "";
}
%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Subscriptions</title>

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

    Subscription Records

</span>

<a href="dashboard.jsp"
   class="btn btn-light btn-sm">

    Back

</a>

</div>

</nav>

<div class="container py-4">

<!-- 🔍 FILTER CARD -->

<div class="card shadow-sm border-0 mb-4">

<div class="card-body">

<h4 class="mb-4 text-center text-md-start">

     Filter Subscriptions

</h4>

<form method="get">

<div class="row">

<!-- USERNAME -->

<div class="col-lg-5 col-md-5 col-sm-12 mb-3">

<input type="text"
       name="username"
       class="form-control"
       placeholder="Search by Username"
       value="<%= username %>">

</div>

<!-- PLAN -->

<div class="col-lg-4 col-md-4 col-sm-12 mb-3">

<select name="plan"
        class="form-select">

<option value="">

    All Plans

</option>

<option value="Weekly"
    <%= "Weekly".equals(planFilter)
        ? "selected"
        : "" %>>

    Weekly

</option>

<option value="Monthly"
    <%= "Monthly".equals(planFilter)
        ? "selected"
        : "" %>>

    Monthly

</option>

</select>

</div>

<!-- BUTTON -->

<div class="col-lg-3 col-md-3 col-sm-12 mb-3">

<button class="btn btn-primary w-100">

    Apply Filter

</button>

</div>

</div>

</form>

</div>

</div>

<!-- 📋 SUBSCRIPTION TABLE -->

<div class="card shadow-sm border-0">

<div class="card-body">

<h4 class="mb-4 text-center text-md-start">

     Subscription Records

</h4>

<div class="table-responsive">

<table class="table table-bordered table-striped table-hover align-middle">

<thead class="table-dark">

<tr>

    <th>Username</th>

    <th>Email</th>

    <th>Phone</th>

    <th>Plan</th>

    <th>Start Date</th>

    <th>End Date</th>

    <th>Amount</th>

</tr>

</thead>

<tbody>

<%
try {

    Connection con = DBConnection.getConnection();

    String sql =

        "SELECT s.*, u.name, u.phone, p.amount " +

        "FROM subscription s " +

        "JOIN users u ON s.user_email=u.email " +

        "LEFT JOIN payments p " +

        "ON s.user_email=p.user_email " +

        "AND s.plan_type=p.plan " +

        "WHERE 1=1 ";

    // 🔍 FILTER USERNAME
    if (!username.isEmpty()) {

        sql += "AND u.name LIKE ? ";
    }

    // 🔍 FILTER PLAN
    if (!planFilter.isEmpty()) {

        sql += "AND s.plan_type=? ";
    }

    sql += "ORDER BY s.end_date DESC";

    PreparedStatement ps = con.prepareStatement(sql);

    int index = 1;

    if (!username.isEmpty()) {

        ps.setString(index++, "%" + username + "%");
    }

    if (!planFilter.isEmpty()) {

        ps.setString(index++, planFilter);
    }

    ResultSet rs = ps.executeQuery();

    boolean hasData = false;

    while (rs.next()) {

        hasData = true;
%>

<tr>

<!-- USERNAME -->

<td class="fw-semibold">

    <%= rs.getString("name") %>

</td>

<!-- EMAIL -->

<td>

    <%= rs.getString("user_email") %>

</td>

<!-- PHONE -->

<td>

<%
String phone = rs.getString("phone");

if (phone != null && !phone.isEmpty()) {
%>

    <%= phone %>

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

<!-- PLAN -->

<td>

<span class="badge
    <%= "Monthly".equals(rs.getString("plan_type"))
        ? "bg-success"
        : "bg-primary" %>">

    <%= rs.getString("plan_type") %>

</span>

</td>

<!-- START DATE -->

<td>

    <%= rs.getString("start_date") %>

</td>

<!-- END DATE -->

<td>

    <%= rs.getString("end_date") %>

</td>

<!-- AMOUNT -->

<td class="fw-bold text-success">

    ₹ <%= rs.getInt("amount") %>

</td>

</tr>

<%
    }

    if (!hasData) {
%>

<tr>

<td colspan="7"
    class="text-center text-danger py-4">

    No subscription records found

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