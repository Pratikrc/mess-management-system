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

boolean allowed = false;

try {
Connection con = DBConnection.getConnection();


PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM subscription WHERE user_email=? ORDER BY end_date DESC LIMIT 1"
);

ps.setString(1, email);
ResultSet rs = ps.executeQuery();

if (rs.next()) {
    java.sql.Date endDate = rs.getDate("end_date");

    if (endDate.getTime() >= System.currentTimeMillis()) {
        allowed = true;
    }
}


} catch (Exception e) {
e.printStackTrace();
}

if (!allowed) {
response.sendRedirect("subscription.jsp?msg=Please subscribe to continue&type=error");
return;
}
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Attendance</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Attendance</span>
        <a href="dashboard.jsp" class="btn btn-light">Back</a>
    </div>
</nav>

<div class="container mt-4">

```
<div class="row justify-content-center">
    <div class="col-md-5">

        <div class="card shadow p-4">

            <h3 class="text-center mb-3">Mark Attendance</h3>

            <%
            String msg = request.getParameter("msg");
            String type = request.getParameter("type");

            if (msg != null) {
            %>

            <div class="alert 
                <%= type.equals("success") ? "alert-success" : 
                    type.equals("warning") ? "alert-warning" : "alert-danger" %>">
                <%= msg %>
            </div>

            <%
            }
            %>
<p class="text-muted text-center">
    Lunch closes at 11 AM | Dinner closes at 6 PM
</p>

            <form action="<%=request.getContextPath()%>/attendance" method="post">

```
<div class="mb-3">
    <label class="form-label">Select Meal</label><br><br>

    <input type="radio" name="meal_type" value="Lunch" required> Lunch<br>
    <input type="radio" name="meal_type" value="Dinner" required> Dinner
</div>

<div class="mb-3">
    <label class="form-label">Select Status</label><br><br>

    <input type="radio" name="status" value="Present" required> Present<br>
    <input type="radio" name="status" value="Absent" required> Absent
</div>

<button type="submit" class="btn btn-success w-100">Submit</button>
```

</form>

        </div>

    </div>
</div>
```

</div>

</body>
</html>
