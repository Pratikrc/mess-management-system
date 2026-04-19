<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
if (session.getAttribute("email") == null) {
    response.sendRedirect("../login.jsp");
}
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>User Dashboard</title>
</head>
<body>

<h2>Welcome User 😊</h2>

<ul>
    <li><a href="view_menu.jsp">View Menu</a></li>
    <li><a href="attendance.jsp">Mark Attendance</a></li>
    <li><a href="subscription.jsp">Subscription Plan</a></li>
    <li><a href="payment.jsp">Make Payment</a></li>
    <li><a href="view_payment.jsp">View Payments</a></li>
</ul>

<a href="../logout">Logout</a>

</body>
</html>
