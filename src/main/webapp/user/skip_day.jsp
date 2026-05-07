<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%
if (session.getAttribute("email") == null) {
    response.sendRedirect("../login.jsp");
    return;
}

String email = (String) session.getAttribute("email");

String message = "";

try (Connection con = DBConnection.getConnection()) {

    // 🔴 CHECK MESS CLOSURE
    PreparedStatement psClose = con.prepareStatement(

        "SELECT * FROM announcement " +
        "WHERE mess_closed='Yes' " +
        "AND CURDATE() BETWEEN close_start AND close_end " +
        "ORDER BY id DESC LIMIT 1"
    );

    ResultSet rsClose = psClose.executeQuery();

    if (rsClose.next()) {

        message = "Mess is currently closed. Skip option disabled.";

    } else {

        // 🔴 1. CHECK ATTENDANCE ALREADY MARKED TODAY
        PreparedStatement psAttend = con.prepareStatement(

            "SELECT * FROM attendance " +
            "WHERE user_email=? AND meal_date=CURDATE()"
        );

        psAttend.setString(1, email);

        ResultSet rsAttend = psAttend.executeQuery();

        if (rsAttend.next()) {

            String mealType = rsAttend.getString("meal_type");

            message = mealType +
                    " attendance already marked today. " +
                    "You cannot skip this day!";

        } else {

            // 🔴 2. CHECK SKIP COUNT (MONTHLY LIMIT)
            PreparedStatement psCount = con.prepareStatement(

                "SELECT COUNT(*) FROM skip_days " +
                "WHERE user_email=? " +
                "AND MONTH(skip_date)=MONTH(CURDATE()) " +
                "AND YEAR(skip_date)=YEAR(CURDATE())"
            );

            psCount.setString(1, email);

            ResultSet rsCount = psCount.executeQuery();

            int used = 0;

            if (rsCount.next()) {

                used = rsCount.getInt(1);
            }

            // 🔴 3. CHECK IF ALREADY SKIPPED TODAY
            PreparedStatement psCheck = con.prepareStatement(

                "SELECT * FROM skip_days " +
                "WHERE user_email=? AND skip_date=CURDATE()"
            );

            psCheck.setString(1, email);

            ResultSet rsCheck = psCheck.executeQuery();

            if (rsCheck.next()) {

                message = "You already skipped today!";

            } else if (used >= 3) {

                message = "Skip limit reached (3 per month)";

            } else {

                // 🔴 4. INSERT SKIP
                PreparedStatement psInsert = con.prepareStatement(

                    "INSERT INTO skip_days(user_email, skip_date) " +
                    "VALUES(?, CURDATE())"
                );

                psInsert.setString(1, email);

                psInsert.executeUpdate();

                // 🔴 5. EXTEND SUBSCRIPTION
                PreparedStatement psUpdate = con.prepareStatement(

                    "UPDATE subscription " +
                    "SET end_date = DATE_ADD(end_date, INTERVAL 1 DAY) " +
                    "WHERE user_email=?"
                );

                psUpdate.setString(1, email);

                psUpdate.executeUpdate();

                message = "Day skipped successfully & subscription extended!";
            }
        }
    }

} catch (Exception e) {

    e.printStackTrace();

    message = "Something went wrong!";
}
%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<title>Skip Day</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="container mt-4">

<h3 class="text-center">Skip Today</h3>

<div class="alert alert-info text-center">

    <%= message %>

</div>

<div class="text-center">

    <a href="dashboard.jsp" class="btn btn-primary">
        Back to Dashboard
    </a>

</div>

</body>
</html>