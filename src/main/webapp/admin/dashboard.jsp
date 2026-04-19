<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
String email = (String) session.getAttribute("email");
String role = (String) session.getAttribute("role");

if (email == null || role == null || !role.equals("admin")) {
    response.sendRedirect("../login.jsp");
}
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
</head>
<body>

<h2>Welcome Admin 👑</h2>

<ul>
    <li><a href="add_menu.jsp">Add Menu</a></li>
    <li><a href="view_attendance.jsp">View Attendance</a></li>
    <li><a href="view_subscription.jsp">View Subscriptions</a></li>
    <li><a href="view_payments.jsp">View Payments</a></li>
    <li><a href="reports.jsp">View Reports</a></li>
</ul>

<a href="../logout">Logout</a>

</body>
</html>
