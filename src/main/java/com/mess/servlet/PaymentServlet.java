package com.mess.servlet;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.mess.db.DBConnection;

@WebServlet("/payment")
public class PaymentServlet extends HttpServlet {


protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws IOException {

    String email = (String) request.getSession().getAttribute("email");
    String plan = request.getParameter("plan");

    int amount = 0;
    int days = 0;

    // 💰 PLAN LOGIC
    if ("Weekly".equals(plan)) {
        amount = 500;
        days = 7;
    } else if ("Monthly".equals(plan)) {
        amount = 2000;
        days = 30;
    }

    try {
        Connection con = DBConnection.getConnection();

        // 🔍 CHECK EXISTING SUBSCRIPTION
        PreparedStatement check = con.prepareStatement(
            "SELECT * FROM subscription WHERE user_email=? ORDER BY end_date DESC LIMIT 1"
        );

        check.setString(1, email);
        ResultSet rs = check.executeQuery();

        LocalDate startDate;
        LocalDate endDate;

        if (rs.next()) {
            Date dbEnd = rs.getDate("end_date");

            // ✔ If still active → extend
            if (dbEnd.toLocalDate().isAfter(LocalDate.now())) {
                startDate = dbEnd.toLocalDate();
            } else {
                startDate = LocalDate.now();
            }

        } else {
            startDate = LocalDate.now();
        }

        endDate = startDate.plusDays(days);

        // 💾 INSERT PAYMENT
        PreparedStatement pay = con.prepareStatement(
            "INSERT INTO payments(user_email, amount, status) VALUES (?, ?, 'Paid')"
        );

        pay.setString(1, email);
        pay.setInt(2, amount);
        pay.executeUpdate();

        // 💾 INSERT SUBSCRIPTION
        PreparedStatement sub = con.prepareStatement(
            "INSERT INTO subscription(user_email, plan_type, start_date, end_date) VALUES (?, ?, ?, ?)"
        );

        sub.setString(1, email);
        sub.setString(2, plan);
        sub.setDate(3, Date.valueOf(startDate));
        sub.setDate(4, Date.valueOf(endDate));
        sub.executeUpdate();

        response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp?msg=Subscription Activated&type=success");

    } catch (Exception e) {
        e.printStackTrace();
    }
}


}
