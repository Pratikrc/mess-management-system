<%@ page import="java.sql.*" %>
<%@ page import="com.mess.db.DBConnection" %>

<%

String sessionEmail =
    (String) session.getAttribute("email");

if(sessionEmail == null){

    response.sendRedirect(
        request.getContextPath() +
        "/login.jsp"
    );

    return;
}

boolean hasActivePlan = false;

try{

    Connection con =
        DBConnection.getConnection();

    PreparedStatement ps =
        con.prepareStatement(

        "SELECT * FROM subscription " +
        "WHERE user_email=? " +
        "ORDER BY end_date DESC LIMIT 1"
    );

    ps.setString(1, sessionEmail);

    ResultSet rs =
        ps.executeQuery();

    if(rs.next()){

        java.sql.Date subscriptionEndDate =
            rs.getDate("end_date");

        if(subscriptionEndDate.getTime() >=
                System.currentTimeMillis()){

            hasActivePlan = true;
        }
    }

}catch(Exception e){

    e.printStackTrace();
}

if(!hasActivePlan){

    response.sendRedirect(

        request.getContextPath() +

        "/user/payment.jsp?msg=Please wait for admin approval&type=error"
    );

    return;
}

%>