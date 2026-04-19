<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
if (session.getAttribute("email") == null || 
    !session.getAttribute("role").equals("admin")) {
    response.sendRedirect("../login.jsp");
}
%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Add Menu</title>
</head>
<body>

<h2>Add Menu</h2>

<form action="<%=request.getContextPath()%>/addMenu" method="post">
    Date: <input type="date" name="date"><br><br>


Meal Type:
<select name="meal_type">
    <option>Breakfast</option>
    <option>Lunch</option>
    <option>Dinner</option>
</select><br><br>

Description:<br>
<textarea name="description"></textarea><br><br>

<button type="submit">Add Menu</button>


</form>

<a href="dashboard.jsp">Back</a>

</body>
</html>
