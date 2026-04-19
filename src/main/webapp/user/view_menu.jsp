<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
if (session.getAttribute("email") == null) {
    response.sendRedirect("../login.jsp");
}
%>

<h2>Today's Menu</h2>

<table border="1">
<tr>
    <th>Date</th>
    <th>Meal</th>
    <th>Description</th>
</tr>

<%
try {
Connection con = DBConnection.getConnection();
Statement st = con.createStatement();


ResultSet rs = st.executeQuery("SELECT * FROM menu");

while (rs.next()) {


%>

<tr>
    <td><%= rs.getString("meal_date") %></td>
    <td><%= rs.getString("meal_type") %></td>
    <td><%= rs.getString("description") %></td>
</tr>
<%
    }
} catch (Exception e) {
    e.printStackTrace();
}
%>

</table>

<a href="dashboard.jsp">Back</a>
