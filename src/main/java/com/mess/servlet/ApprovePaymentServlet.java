package com.mess.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.mess.db.DBConnection;

@WebServlet("/approvePayment")
public class ApprovePaymentServlet extends HttpServlet {


protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws IOException {

    String role = (String) request.getSession().getAttribute("role");

    // 🔒 Only admin can approve
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));

    try {
        Connection con = DBConnection.getConnection();

        // 🔍 1. GET PAYMENT DETAILS
        PreparedStatement ps1 = con.prepareStatement(
            "SELECT * FROM payments WHERE id=?"
        );
        ps1.setInt(1, id);
        ResultSet rs = ps1.executeQuery();

        if (rs.next()) {

            String email = rs.getString("user_email");
            String plan = rs.getString("plan");

            // 🔄 2. UPDATE PAYMENT STATUS → Paid
            PreparedStatement ps2 = con.prepareStatement(
                "UPDATE payments SET status='Paid' WHERE id=?"
            );
            ps2.setInt(1, id);
            ps2.executeUpdate();

            // 📅 3. CALCULATE DAYS
            int days = plan.equals("Weekly") ? 7 : 30;

            // 🧾 4. CREATE SUBSCRIPTION
            PreparedStatement ps3 = con.prepareStatement(
                "INSERT INTO subscription(user_email, plan_type, start_date, end_date) " +
                "VALUES (?, ?, CURDATE(), DATE_ADD(CURDATE(), INTERVAL ? DAY))"
            );

            ps3.setString(1, email);
            ps3.setString(2, plan);
            ps3.setInt(3, days);

            ps3.executeUpdate();
        }

        // 🔁 REDIRECT BACK
        response.sendRedirect("admin/view_payments.jsp");

    } catch (Exception e) {
        e.printStackTrace();
    }
}


}
