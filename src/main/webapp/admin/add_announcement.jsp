<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
String role = (String) session.getAttribute("role");

if (role == null || !role.equals("admin")) {

    response.sendRedirect("../login.jsp");

    return;
}

// --- HANDLE POST (ADD) ---
String success = "";

String error = "";

if ("POST".equalsIgnoreCase(request.getMethod())) {

    String msg = request.getParameter("msg");

    if (msg != null && !msg.trim().isEmpty()) {

        try (
            Connection con = DBConnection.getConnection()
        ) {

            String messClosed = request.getParameter("mess_closed");

            String closeStart = request.getParameter("close_start");

            String closeEnd = request.getParameter("close_end");

            // 🔥 INSERT ANNOUNCEMENT
            PreparedStatement ps = con.prepareStatement(

                "INSERT INTO announcement(message, mess_closed, close_start, close_end) " +
                "VALUES(?, ?, ?, ?)"
            );

            ps.setString(1, msg.trim());

            ps.setString(2, messClosed);

            if (closeStart == null || closeStart.isEmpty()) {

                ps.setNull(3, java.sql.Types.DATE);

            } else {

                ps.setString(3, closeStart);
            }

            if (closeEnd == null || closeEnd.isEmpty()) {

                ps.setNull(4, java.sql.Types.DATE);

            } else {

                ps.setString(4, closeEnd);
            }

            ps.executeUpdate();

            // 🔥 AUTO EXTEND SUBSCRIPTIONS
            if ("Yes".equals(messClosed)
                    && closeStart != null
                    && closeEnd != null
                    && !closeStart.isEmpty()
                    && !closeEnd.isEmpty()) {

                PreparedStatement psDays = con.prepareStatement(

                    "SELECT DATEDIFF(?, ?) + 1"
                );

                psDays.setString(1, closeEnd);

                psDays.setString(2, closeStart);

                ResultSet rsDays = psDays.executeQuery();

                int totalDays = 0;

                if (rsDays.next()) {

                    totalDays = rsDays.getInt(1);
                }

                // 🔥 EXTEND SUBSCRIPTIONS
                PreparedStatement psUpdate = con.prepareStatement(

                    "UPDATE subscription " +
                    "SET end_date = DATE_ADD(end_date, INTERVAL ? DAY) " +
                    "WHERE end_date >= CURDATE()"
                );

                psUpdate.setInt(1, totalDays);

                psUpdate.executeUpdate();
            }

            response.sendRedirect(
                "add_announcement.jsp?success=added"
            );

            return;

        } catch (Exception e) {

            e.printStackTrace();

            error = "Failed to add announcement.";
        }

    } else {

        error = "Message cannot be empty.";
    }
}

// --- HANDLE DELETE ---
String deleteId = request.getParameter("deleteId");

if (deleteId != null && !deleteId.isEmpty()) {

    try (

        Connection con = DBConnection.getConnection();

        PreparedStatement psDel = con.prepareStatement(

            "DELETE FROM announcement WHERE id=?"
        )

    ) {

        psDel.setInt(1, Integer.parseInt(deleteId));

        psDel.executeUpdate();

        response.sendRedirect(
            "add_announcement.jsp?success=deleted"
        );

        return;

    } catch (Exception e) {

        e.printStackTrace();

        error = "Failed to delete announcement.";
    }
}

// --- SUCCESS MESSAGE ---
String successParam = request.getParameter("success");

if ("added".equals(successParam)) {

    success = "Announcement added successfully.";

} else if ("deleted".equals(successParam)) {

    success = "Announcement deleted successfully.";
}
%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1">

<title>Manage Announcements</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet">

<link rel="stylesheet"
      href="../css/style.css">

</head>

<body class="bg-light">

<!-- 🔥 NAVBAR -->

<nav class="navbar navbar-dark bg-dark">

<div class="container-fluid">

<span class="navbar-brand">

    📢 Manage Announcements

</span>

<a href="dashboard.jsp"
   class="btn btn-light btn-sm">

    Back

</a>

</div>

</nav>

<div class="container py-4">

<!-- 🔔 SUCCESS -->

<% if (!success.isEmpty()) { %>

<div class="alert alert-success shadow-sm">

    <%= success %>

</div>

<% } %>

<!-- 🔴 ERROR -->

<% if (!error.isEmpty()) { %>

<div class="alert alert-danger shadow-sm">

    <%= error %>

</div>

<% } %>

<div class="row">

<!-- ➕ ADD ANNOUNCEMENT -->

<div class="col-lg-4 col-md-5 col-sm-12 mb-4">

<div class="card shadow-sm border-0 h-100">

<div class="card-body">

<h4 class="mb-4 text-center">

    ➕ Post Announcement

</h4>

<form method="post">

<!-- MESSAGE -->

<div class="mb-4">

<label class="form-label fw-bold">

    Announcement Message

</label>

<textarea name="msg"
          class="form-control"
          rows="5"
          placeholder="Enter announcement message"
          required></textarea>

</div>

<!-- MESS CLOSED -->

<div class="mb-4">

<label class="form-label fw-bold">

    Mess Closed?

</label>

<select name="mess_closed"
        class="form-select"
        required>

<option value="No">

    No

</option>

<option value="Yes">

    Yes

</option>

</select>

</div>

<!-- START DATE -->

<div class="mb-4">

<label class="form-label fw-bold">

    Closure Start Date

</label>

<input type="date"
       name="close_start"
       class="form-control">

</div>

<!-- END DATE -->

<div class="mb-4">

<label class="form-label fw-bold">

    Closure End Date

</label>

<input type="date"
       name="close_end"
       class="form-control">

</div>

<!-- BUTTON -->

<button class="btn btn-primary w-100 py-2">

    Post Announcement

</button>

</form>

</div>

</div>

</div>

<!-- 📋 ANNOUNCEMENT LIST -->

<div class="col-lg-8 col-md-7 col-sm-12">

<div class="card shadow-sm border-0">

<div class="card-body">

<h4 class="mb-4 text-center text-md-start">

    📋 All Announcements

</h4>

<div class="table-responsive">

<table class="table table-bordered table-striped table-hover align-middle">

<thead class="table-dark">

<tr>

    <th>ID</th>

    <th>Message</th>

    <th>Status</th>

    <th>Closure Dates</th>

    <th>Date</th>

    <th>Action</th>

</tr>

</thead>

<tbody>

<%
try (

    Connection con = DBConnection.getConnection();

    PreparedStatement ps = con.prepareStatement(

        "SELECT * FROM announcement " +
        "ORDER BY created_at DESC"
    );

    ResultSet rs = ps.executeQuery()

) {

    boolean hasData = false;

    while (rs.next()) {

        hasData = true;

        String closed = rs.getString("mess_closed");
%>

<tr>

<!-- ID -->

<td>

    <%= rs.getInt("id") %>

</td>

<!-- MESSAGE -->

<td style="min-width:220px;">

    <%= rs.getString("message") %>

</td>

<!-- STATUS -->

<td>

<span class="badge
    <%= "Yes".equals(closed)
        ? "bg-danger"
        : "bg-success" %>">

    <%= closed.equals("Yes")
        ? "Closed"
        : "Open" %>

</span>

</td>

<!-- DATES -->

<td>

<%
if ("Yes".equals(closed)) {
%>

    <%= rs.getString("close_start") %>
    <br>
    to
    <br>
    <%= rs.getString("close_end") %>

<%
} else {
%>

    -

<%
}
%>

</td>

<!-- CREATED DATE -->

<td>

    <%= rs.getString("created_at") %>

</td>

<!-- ACTION -->

<td>

<a href="add_announcement.jsp?deleteId=<%= rs.getInt("id") %>"
   class="btn btn-danger btn-sm w-100"
   onclick="return confirm('Delete this announcement?')">

    Delete

</a>

</td>

</tr>

<%
    }

    if (!hasData) {
%>

<tr>

<td colspan="6"
    class="text-center text-danger py-4">

    No announcements found

</td>

</tr>

<%
    }

} catch (Exception e) {

    e.printStackTrace();
}
%>

</tbody>

</table>

</div>

</div>

</div>

</div>

</div>

<!-- 🔙 BACK BUTTON -->

<div class="text-center mt-4">

<a href="dashboard.jsp"
   class="btn btn-secondary w-100 w-md-auto px-4">

    Back to Dashboard

</a>

</div>

</div>

</body>
</html>