<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
if (session.getAttribute("email") == null || 
    !session.getAttribute("role").equals("admin")) {
    response.sendRedirect("../login.jsp");
}
%>

<h2>Subscription Records</h2>

<table border="1">
<tr>
    <th>Email</th>
    <th>Plan</th>
    <th>Start</th>
    <th>End</th>
</tr>

<%
Connection con = DBConnection.getConnection();
Statement st = con.createStatement();
ResultSet rs = st.executeQuery("SELECT * FROM subscription");

while (rs.next()) {
%>

<tr>
    <td><%= rs.getString("user_email") %></td>
    <td><%= rs.getString("plan_type") %></td>
    <td><%= rs.getString("start_date") %></td>
    <td><%= rs.getString("end_date") %></td>
</tr>
<% } %>

</table>

<a href="dashboard.jsp">Back</a>
