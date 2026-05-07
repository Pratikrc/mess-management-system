package com.mess.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalTime;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.mess.db.DBConnection;

@WebServlet("/attendance")
public class AttendanceServlet extends HttpServlet {

protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws IOException {

    String email = (String) request.getSession().getAttribute("email");
    String mealType = request.getParameter("meal_type");
    String status = request.getParameter("status");

    try {

        Connection con = DBConnection.getConnection();

        // 🔴 CHECK MESS CLOSURE
        PreparedStatement psClose = con.prepareStatement(

            "SELECT * FROM announcement " +
            "WHERE mess_closed='Yes' " +
            "AND CURDATE() BETWEEN close_start AND close_end " +
            "ORDER BY id DESC LIMIT 1"
        );

        ResultSet rsClose = psClose.executeQuery();

        if (rsClose.next()) {

            response.sendRedirect(
                "user/attendance.jsp?msg=Mess is currently closed&type=error"
            );

            return;
        }

        // 🔴 CHECK ACTIVE SUBSCRIPTION
        PreparedStatement psSub = con.prepareStatement(
            "SELECT end_date FROM subscription WHERE user_email=? ORDER BY end_date DESC LIMIT 1"
        );

        psSub.setString(1, email);

        ResultSet rsSub = psSub.executeQuery();

        if (rsSub.next()) {

            java.sql.Date endDate = rsSub.getDate("end_date");

            if (endDate.before(new java.sql.Date(System.currentTimeMillis()))) {

                response.sendRedirect(
                    "user/attendance.jsp?msg=Subscription expired&type=error"
                );

                return;
            }

        } else {

            response.sendRedirect(
                "user/attendance.jsp?msg=No active subscription found&type=error"
            );

            return;
        }

        // 🔴 CHECK SKIP DAY
        PreparedStatement skipCheck = con.prepareStatement(
            "SELECT * FROM skip_days WHERE user_email=? AND skip_date=CURDATE()"
        );

        skipCheck.setString(1, email);

        ResultSet rsSkip = skipCheck.executeQuery();

        if (rsSkip.next()) {

            response.sendRedirect(
                "user/attendance.jsp?msg=You already selected skip for today&type=error"
            );

            return;
        }

        // ⏰ CURRENT TIME
        LocalTime currentTime = LocalTime.now();

        // ⏰ CUT-OFF TIMES
        LocalTime lunchCutoff = LocalTime.of(11, 0);

        LocalTime dinnerCutoff = LocalTime.of(18, 0);

        // ❌ BLOCK IF TIME EXCEEDED
        if (mealType.equals("Lunch")
                && currentTime.isAfter(lunchCutoff)) {

            response.sendRedirect(
                "user/attendance.jsp?msg=Lunch time closed&type=error"
            );

            return;
        }

        if (mealType.equals("Dinner")
                && currentTime.isAfter(dinnerCutoff)) {

            response.sendRedirect(
                "user/attendance.jsp?msg=Dinner time closed&type=error"
            );

            return;
        }

        // 🔍 CHECK DUPLICATE ENTRY
        PreparedStatement check = con.prepareStatement(

            "SELECT * FROM attendance " +
            "WHERE user_email=? " +
            "AND meal_date=CURDATE() " +
            "AND meal_type=?"
        );

        check.setString(1, email);

        check.setString(2, mealType);

        ResultSet rs = check.executeQuery();

        if (rs.next()) {

            response.sendRedirect(
                "user/attendance.jsp?msg=Already marked for this meal&type=warning"
            );

            return;
        }

        // 💾 INSERT ATTENDANCE
        PreparedStatement ps = con.prepareStatement(

            "INSERT INTO attendance(user_email, meal_date, meal_type, status) " +
            "VALUES (?, CURDATE(), ?, ?)"
        );

        ps.setString(1, email);

        ps.setString(2, mealType);

        ps.setString(3, status);

        ps.executeUpdate();

        response.sendRedirect(
            "user/attendance.jsp?msg=Attendance Marked Successfully&type=success"
        );

    } catch (Exception e) {

        e.printStackTrace();

        response.sendRedirect(
            "user/attendance.jsp?msg=Something went wrong&type=error"
        );
    }
}

}