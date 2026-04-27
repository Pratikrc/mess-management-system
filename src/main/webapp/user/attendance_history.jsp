<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
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
<title>Attendance History</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<!-- 🔥 NAVBAR -->

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Attendance History</span>
        <a href="dashboard.jsp" class="btn btn-light">Back</a>
    </div>
</nav>

<div class="container mt-4">

<h3 class="mb-3">Last 7 Days Attendance</h3>

<table class="table table-bordered table-striped">

<thead class="table-dark">
<tr>
    <th>Date</th>
    <th>Meal Type</th>
    <th>Status</th>
</tr>
</thead>

<tbody>

<%
try {
Connection con = DBConnection.getConnection();


PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM attendance WHERE user_email=? AND meal_date >= CURDATE() - INTERVAL 7 DAY ORDER BY meal_date DESC"
);

ps.setString(1, email);
ResultSet rs = ps.executeQuery();

boolean hasData = false;

while (rs.next()) {
    hasData = true;


%>

<tr>
    <td><%= rs.getString("meal_date") %></td>
    <td>
        <%= rs.getString("meal_type").equals("Lunch") ? "🍛 Lunch" : "🍽️ Dinner" %>
    </td>
    <td>
        <span class="<%= rs.getString("status").equals("Present") ? "text-success" : "text-danger" %>">
            <%= rs.getString("status") %>
        </span>
    </td>
</tr>

<%
}


if (!hasData) {


%>

<tr>
    <td colspan="3" class="text-center text-danger">
        No attendance records found
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
