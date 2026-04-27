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
<title>Feedback</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">User Feedback</span>
        <a href="dashboard.jsp" class="btn btn-light">Back</a>
    </div>
</nav>

<div class="container mt-4">

<h3>User Feedback</h3>

<table class="table table-bordered table-striped">

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


ResultSet rs = st.executeQuery("SELECT * FROM feedback ORDER BY created_at DESC");

while (rs.next()) {


%>

<tr>
    <td>Anonymous</td>
    <td><%= rs.getString("message") %></td>
    <td><%= rs.getString("created_at") %></td>
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
