package com.mess.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.mess.db.DBConnection;

@WebServlet("/approveUser")
public class ApproveUserServlet extends HttpServlet {


protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws IOException {

    String email = request.getParameter("email");

    try {
        Connection con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(
            "UPDATE users SET status='approved' WHERE email=?"
        );

        ps.setString(1, email);
        ps.executeUpdate();

        response.sendRedirect("admin/manage_users.jsp");

    } catch (Exception e) {
        e.printStackTrace();
    }
}


}
