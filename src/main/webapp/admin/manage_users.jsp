<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
String email = (String) session.getAttribute("email");

String role = (String) session.getAttribute("role");

if (email == null || role == null || !role.equals("admin")) {

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

<title>Manage Users</title>

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

    Manage Users

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

    &#128101; User List

</h3>

<!-- 🔥 USER TABLE CARD -->

<div class="card shadow-sm border-0">

<div class="card-body">

<div class="table-responsive">

<table class="table table-bordered table-striped table-hover align-middle">

<thead class="table-dark">

<tr>

    <th>Name</th>

    <th>Email</th>

    <th>Phone Number</th>

    <th>Status</th>

    <th>Action</th>

</tr>

</thead>

<tbody>

<%
try {

    Connection con = DBConnection.getConnection();

    Statement st = con.createStatement();

    // ✅ FIXED QUERY
    ResultSet rs = st.executeQuery(

        "SELECT * FROM users ORDER BY name ASC"
    );

    boolean hasData = false;

    while (rs.next()) {

        hasData = true;
%>

<tr>

<!-- NAME -->

<td class="fw-semibold">

    <%= rs.getString("name") %>

</td>

<!-- EMAIL -->

<td>

    <%= rs.getString("email") %>

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

<!-- STATUS -->

<td>

<span class="badge
    <%= rs.getString("status").equals("approved")
        ? "bg-success"
        : "bg-warning text-dark" %>">

    <%= rs.getString("status") %>

</span>

</td>

<!-- ACTION -->

<td>

<%
if (rs.getString("status").equals("pending")) {
%>

<a href="../approveUser?email=<%= rs.getString("email") %>"
   class="btn btn-success btn-sm w-100">

    Approve

</a>

<%
} else {
%>

<span class="text-success fw-bold">

    Approved

</span>

<%
}
%>

</td>

</tr>

<%
    }

    // ✅ NO DATA MESSAGE
    if (!hasData) {
%>

<tr>

<td colspan="5"
    class="text-center text-danger py-4">

    No users found

</td>

</tr>

<%
    }

} catch(Exception e) {

    out.println(

        "<tr>" +
        "<td colspan='5' class='text-danger text-center'>" +
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