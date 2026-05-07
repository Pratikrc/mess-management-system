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

String search = request.getParameter("search");

if (search == null) {

    search = "";
}
%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Meal Verification</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet">

</head>

<body class="bg-light">

<!-- 🔥 NAVBAR -->

<nav class="navbar navbar-dark bg-dark">

<div class="container-fluid">

<span class="navbar-brand">

    🍽️ Meal Verification

</span>

<a href="dashboard.jsp"
   class="btn btn-light btn-sm">

    Back

</a>

</div>

</nav>

<div class="container py-4">

<!-- 🔍 SEARCH CARD -->

<div class="card shadow-sm border-0 mb-4">

<div class="card-body">

<h4 class="mb-4 text-center text-md-start">

    🔍 Search User

</h4>

<form method="get">

<div class="row">

<!-- SEARCH INPUT -->

<div class="col-lg-10 col-md-9 col-sm-12 mb-3">

<input type="text"
       name="search"
       class="form-control"
       placeholder="Enter user email"
       value="<%= search %>"
       required>

</div>

<!-- SEARCH BUTTON -->

<div class="col-lg-2 col-md-3 col-sm-12 mb-3">

<button class="btn btn-primary w-100">

    Search

</button>

</div>

</div>

</form>

</div>

</div>

<!-- 🍽️ MEAL STATUS -->

<div class="card shadow-sm border-0">

<div class="card-body">

<h4 class="mb-4 text-center text-md-start">

    🍛 Today's Meal Status

</h4>

<div class="table-responsive">

<table class="table table-bordered table-striped table-hover align-middle">

<thead class="table-dark">

<tr>

    <th>User</th>

    <th>Email</th>

    <th>Meal Type</th>

    <th>Status</th>

    <th>Served</th>

    <th>Action</th>

</tr>

</thead>

<tbody>

<%
if (!search.isEmpty()) {

    try {

        Connection con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(

            "SELECT a.*, u.name " +
            "FROM attendance a " +
            "JOIN users u ON a.user_email=u.email " +
            "WHERE a.user_email=? " +
            "AND a.meal_date=CURDATE()"
        );

        ps.setString(1, search);

        ResultSet rs = ps.executeQuery();

        boolean found = false;

        while (rs.next()) {

            found = true;

            String mealType = rs.getString("meal_type");

            String status = rs.getString("status");

            String served = rs.getString("served");
%>

<tr>

<!-- USER -->

<td class="fw-semibold">

    <%= rs.getString("name") %>

</td>

<!-- EMAIL -->

<td>

    <%= rs.getString("user_email") %>

</td>

<!-- MEAL TYPE -->

<td>

<span class="badge
    <%= "Lunch".equals(mealType)
        ? "bg-success"
        : "bg-primary" %>">

    <%= mealType %>

</span>

</td>

<!-- STATUS -->

<td>

<span class="badge
    <%= "Present".equals(status)
        ? "bg-success"
        : "bg-danger" %>">

    <%= status %>

</span>

</td>

<!-- SERVED -->

<td>

<%
if ("Yes".equals(served)) {
%>

<span class="badge bg-success">

    Served

</span>

<%
} else {
%>

<span class="badge bg-danger">

    Not Served

</span>

<%
}
%>

</td>

<!-- ACTION -->

<td>

<%
if ("No".equals(served)) {
%>

<a href="../serveMeal?id=<%= rs.getInt("id") %>"
   class="btn btn-success btn-sm w-100">

    Serve Meal

</a>

<%
} else {
%>

<button class="btn btn-secondary btn-sm w-100"
        disabled>

    Already Served

</button>

<%
}
%>

</td>

</tr>

<%
        }

        if (!found) {
%>

<tr>

<td colspan="6"
    class="text-center text-danger py-4">

    No attendance found for today

</td>

</tr>

<%
        }

    } catch (Exception e) {

        e.printStackTrace();
    }

} else {
%>

<tr>

<td colspan="6"
    class="text-center text-muted py-4">

    Search a user email to verify meals

</td>

</tr>

<%
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