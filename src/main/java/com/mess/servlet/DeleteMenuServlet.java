package com.mess.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.mess.db.DBConnection;

@WebServlet("/deleteMenu")
public class DeleteMenuServlet extends HttpServlet {


protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws IOException {

    String role = (String) request.getSession().getAttribute("role");

    // 🔒 Only admin allowed
    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));

    try {
        Connection con = DBConnection.getConnection();

        // 🔥 DELETE MENU
        PreparedStatement ps = con.prepareStatement(
            "DELETE FROM menu WHERE id=?"
        );

        ps.setInt(1, id);
        ps.executeUpdate();

        response.sendRedirect("admin/add_menu.jsp?msg=Menu Deleted&type=success");

    } catch (Exception e) {
        e.printStackTrace();
    }
}


}
