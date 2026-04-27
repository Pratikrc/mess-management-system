package com.mess.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.mess.db.DBConnection;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {


protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String email = request.getParameter("email");
    String password = request.getParameter("password");

    try {
        Connection con = DBConnection.getConnection();

        String query = "SELECT * FROM users WHERE email=? AND password=?";
        PreparedStatement ps = con.prepareStatement(query);

        ps.setString(1, email);
        ps.setString(2, password);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {

            String role = rs.getString("role");
            String status = rs.getString("status");

            // ❌ BLOCK ONLY USER (NOT ADMIN)
            if (role.equals("user") && !status.equals("approved")) {
                response.sendRedirect(request.getContextPath() + "/login.jsp?msg=Waiting for Admin Approval&type=error");
                return;
            }

            HttpSession session = request.getSession();

            session.setAttribute("user", rs.getString("name"));
            session.setAttribute("email", rs.getString("email"));
            session.setAttribute("role", role);

            // 🔥 ADMIN LOGIN
            if (role.equals("admin")) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
                return;
            }

            // 🔍 CHECK SUBSCRIPTION FOR USER
            PreparedStatement ps2 = con.prepareStatement(
                "SELECT * FROM subscription WHERE user_email=? ORDER BY end_date DESC LIMIT 1"
            );

            ps2.setString(1, email);
            ResultSet rs2 = ps2.executeQuery();

            boolean hasActivePlan = false;

            if (rs2.next()) {
                java.sql.Date endDate = rs2.getDate("end_date");

                if (endDate.getTime() >= System.currentTimeMillis()) {
                    hasActivePlan = true;
                }
            }

            // 🚀 REDIRECT BASED ON PLAN
            if (!hasActivePlan) {
                response.sendRedirect(request.getContextPath() + "/user/payment.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
            }

        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp?msg=Invalid Email or Password&type=error");
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
}


}
