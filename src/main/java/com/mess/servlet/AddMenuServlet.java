package com.mess.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.mess.db.DBConnection;

@WebServlet("/addMenu")
public class AddMenuServlet extends HttpServlet {


protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String date = request.getParameter("date");
    String mealType = request.getParameter("meal_type");
    String description = request.getParameter("description");

    try {
        Connection con = DBConnection.getConnection();

        String query = "INSERT INTO menu(meal_date, meal_type, description) VALUES (?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);

        ps.setString(1, date);
        ps.setString(2, mealType);
        ps.setString(3, description);

        ps.executeUpdate();

        response.sendRedirect("admin/dashboard.jsp");

    } catch (Exception e) {
        e.printStackTrace();
    }
}


}
