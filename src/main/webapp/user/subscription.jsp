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
<title>Subscription</title>
</head>
<body>

<h2>Choose Subscription Plan</h2>

<form action="<%=request.getContextPath()%>/subscribe" method="post">

```
<input type="hidden" name="email" value="<%=session.getAttribute("user")%>">

<label>
    <input type="radio" name="plan" value="Weekly"> Weekly
</label>

<label>
    <input type="radio" name="plan" value="Monthly"> Monthly
</label>

<br><br>

Start Date: <input type="date" name="start_date"><br><br>

End Date: <input type="date" name="end_date"><br><br>

<button type="submit">Subscribe</button>
```

</form>

<a href="dashboard.jsp">Back</a>

</body>
</html>
