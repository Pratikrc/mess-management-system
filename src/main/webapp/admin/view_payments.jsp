<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
String role = (String) session.getAttribute("role");

// 🔒 Only admin allowed
if (role == null || !role.equals("admin")) {
response.sendRedirect("../login.jsp");
return;
}
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>View Payments</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<!-- 🔥 NAVBAR -->

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Payment Management</span>
        <a href="dashboard.jsp" class="btn btn-light">Back</a>
    </div>
</nav>

<div class="container mt-4">

<h3 class="mb-3">All Payments</h3>

<table class="table table-bordered table-striped table-hover">

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


ResultSet rs = st.executeQuery("SELECT * FROM payments ORDER BY created_at DESC");

while (rs.next()) {
    String status = rs.getString("status");


%>

<tr>
    <td><%= rs.getString("user_email") %></td>
    <td><%= rs.getString("plan") %></td>
    <td><%= rs.getString("payment_mode") %></td>
    <td>₹ <%= rs.getInt("amount") %></td>


<!-- STATUS -->
<td>
    <span class="<%= status.equals("Paid") ? "text-success" : "text-warning" %>">
        <%= status %>
    </span>
</td>

<td><%= rs.getString("created_at") %></td>

<!-- ACTION -->
<td>
    <% if (status.equals("Pending")) { %>
        <a href="<%=request.getContextPath()%>/approvePayment?id=<%= rs.getInt("id") %>"
           class="btn btn-success btn-sm">
           Approve
        </a>
    <% } else { %>
        <button class="btn btn-secondary btn-sm" disabled>
            Approved
        </button>
    <% } %>
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

</body>
</html>
