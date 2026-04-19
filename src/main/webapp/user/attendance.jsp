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
<title>Mark Attendance</title>
</head>
<body>

<h2>Mark Today's Meal</h2>

<form action="<%=request.getContextPath()%>/attendance" method="post">

```
<input type="hidden" name="email" value="<%=session.getAttribute("user")%>">

<label>
    <input type="radio" name="status" value="Present"> Present
</label>

<label>
    <input type="radio" name="status" value="Absent"> Absent
</label>

<br><br>
<button type="submit">Submit</button>
```

</form>

<a href="dashboard.jsp">Back</a>

</body>
</html>
