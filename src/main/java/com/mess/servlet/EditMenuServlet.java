package com.mess.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.mess.db.DBConnection;

@WebServlet("/editMenu")
public class EditMenuServlet extends HttpServlet {


protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws IOException {

    String role = (String) request.getSession().getAttribute("role");

    if (role == null || !role.equals("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));
    String mealType = request.getParameter("meal_type");
    String description = request.getParameter("description");

    try {
        Connection con = DBConnection.getConnection();

        PreparedStatement ps = con.prepareStatement(
            "UPDATE menu SET meal_type=?, description=? WHERE id=?"
        );

        ps.setString(1, mealType);
        ps.setString(2, description);
        ps.setInt(3, id);

        ps.executeUpdate();

        response.sendRedirect("admin/add_menu.jsp?msg=Menu Updated&type=success");

    } catch (Exception e) {
        e.printStackTrace();
    }
}


}
