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

<title>User Feedback</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet">

</head>

<body class="bg-light">

<!-- 🔥 NAVBAR -->

<nav class="navbar navbar-dark bg-dark">

<div class="container-fluid">

<span class="navbar-brand">

    User Feedback

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

    💬 User Feedback

</h3>

<!-- 📋 FEEDBACK TABLE -->

<div class="card shadow-sm border-0">

<div class="card-body">

<div class="table-responsive">

<table class="table table-bordered table-striped table-hover align-middle">

<thead class="table-dark">

<tr>

    <th>User</th>

    <th>Message</th>

    <th>Date</th>

</tr>

</thead>

<tbody>

<%
try {

    Connection con = DBConnection.getConnection();

    Statement st = con.createStatement();

    ResultSet rs = st.executeQuery(

        "SELECT * FROM feedback " +
        "ORDER BY created_at DESC"
    );

    boolean hasData = false;

    while (rs.next()) {

        hasData = true;
%>

<tr>

<!-- USER -->

<td class="fw-semibold text-primary">

    Anonymous

</td>

<!-- MESSAGE -->

<td style="min-width:250px;">

    <%= rs.getString("message") %>

</td>

<!-- DATE -->

<td>

    <%= rs.getString("created_at") %>

</td>

</tr>

<%
    }

    if (!hasData) {
%>

<tr>

<td colspan="3"
    class="text-center text-danger py-4">

    No feedback found

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