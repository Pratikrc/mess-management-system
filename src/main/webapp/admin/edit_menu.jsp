<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
String role = (String) session.getAttribute("role");

if (role == null || !role.equals("admin")) {
response.sendRedirect("../login.jsp");
return;
}

int id = Integer.parseInt(request.getParameter("id"));

String mealType = "";
String description = "";

try {
Connection con = DBConnection.getConnection();


PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM menu WHERE id=?"
);

ps.setInt(1, id);
ResultSet rs = ps.executeQuery();

if (rs.next()) {
    mealType = rs.getString("meal_type");
    description = rs.getString("description");
}


} catch (Exception e) {
e.printStackTrace();
}
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Edit Menu</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<nav class="navbar navbar-dark bg-dark">
    <div class="container-fluid">
        <span class="navbar-brand">Edit Menu</span>
        <a href="add_menu.jsp" class="btn btn-light">Back</a>
    </div>
</nav>

<div class="container mt-4">

<div class="row justify-content-center">
<div class="col-md-5">

<div class="card shadow p-4">

<h4>Edit Menu</h4>

<form action="<%=request.getContextPath()%>/editMenu" method="post">


<input type="hidden" name="id" value="<%= id %>">

<div class="mb-3">
    <label>Meal Type</label><br>

    <input type="radio" name="meal_type" value="Lunch"
        <%= mealType.equals("Lunch") ? "checked" : "" %>> Lunch<br>

    <input type="radio" name="meal_type" value="Dinner"
        <%= mealType.equals("Dinner") ? "checked" : "" %>> Dinner
</div>

<div class="mb-3">
    <label>Description</label>
    <textarea name="description" class="form-control" required><%= description %></textarea>
</div>

<button type="submit" class="btn btn-success w-100">Update Menu</button>


</form>

</div>

</div>
</div>

</div>

</body>
</html>
