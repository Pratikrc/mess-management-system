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
<title>Payment</title>
</head>
<body>

<h2>Session Email: <%=session.getAttribute("email")%></h2>

<h2>Make Payment</h2>

<form action="<%=request.getContextPath()%>/payment" method="post">

<input type="hidden" name="email" value="<%=session.getAttribute("email")%>">

Amount: <input type="number" name="amount" required><br><br>

<label>
    <input type="radio" name="status" value="Paid"> Paid
</label>

<label>
    <input type="radio" name="status" value="Pending"> Pending
</label>

<br><br>

<button type="submit">Submit Payment</button>

</form>

<a href="dashboard.jsp">Back</a>

</body>
</html>
