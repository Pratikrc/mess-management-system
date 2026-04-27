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

boolean active = false;
java.sql.Date endDate = null;

try {
Connection con = DBConnection.getConnection();


PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM subscription WHERE user_email=? ORDER BY end_date DESC LIMIT 1"
);

ps.setString(1, email);
ResultSet rs = ps.executeQuery();

if (rs.next()) {
    endDate = rs.getDate("end_date");

    if (endDate.getTime() >= System.currentTimeMillis()) {
        active = true;
    }
}


} catch (Exception e) {
e.printStackTrace();
}
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Subscription Payment</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Subscription Payment</span>
        <a href="dashboard.jsp" class="btn btn-light">Back</a>
    </div>
</nav>

<div class="container mt-4">

<div class="row justify-content-center">
<div class="col-md-5">

<div class="card shadow p-4">

<h3 class="text-center mb-3">Pay Subscription</h3>

<%
String msg = request.getParameter("msg");
String type = request.getParameter("type");

if (msg != null) {
%>

<div class="alert <%= type.equals("success") ? "alert-success" : "alert-danger" %>">
    <%= msg %>
</div>

<%
}
%>

<% if (active) { %>

<div class="alert alert-success text-center">
    You already have an active subscription until <%= endDate %>
</div>

<button class="btn btn-secondary w-100" disabled>
    Already Subscribed
</button>

<% } else { %>

<form action="<%=request.getContextPath()%>/payment" method="post">


<div class="mb-3">
    <label class="form-label">Select Plan</label><br><br>

    <input type="radio" name="plan" value="Weekly" required> Weekly (₹500)<br>
    <input type="radio" name="plan" value="Monthly" required> Monthly (₹2000)
</div>

<button type="submit" class="btn btn-primary w-100">Pay Now</button>


</form>

<% } %>

</div>

</div>
</div>

</div>

</body>
</html>
