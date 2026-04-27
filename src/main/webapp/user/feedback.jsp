<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
if (session.getAttribute("email") == null) {
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
        <span class="navbar-brand">Feedback</span>
        <a href="dashboard.jsp" class="btn btn-light">Back</a>
    </div>
</nav>

<div class="container mt-4">

<div class="row justify-content-center">
<div class="col-md-6">

<div class="card shadow p-4">

<h3 class="text-center mb-3">Give Feedback</h3>

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

<form action="<%=request.getContextPath()%>/feedback" method="post">

```
<div class="mb-3">
    <label class="form-label">Your Feedback</label>
    <textarea name="message" class="form-control" rows="4" required></textarea>
</div>

<button type="submit" class="btn btn-primary w-100">Submit</button>
```

</form>

</div>

</div>
</div>

</div>

</body>
</html>
