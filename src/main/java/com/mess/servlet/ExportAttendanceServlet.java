package com.mess.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.mess.db.DBConnection;

@WebServlet("/exportAttendance")
public class ExportAttendanceServlet extends HttpServlet {


protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    response.setContentType("text/csv");
    response.setHeader("Content-Disposition", "attachment; filename=attendance.csv");

    try {
        Connection con = DBConnection.getConnection();
        Statement st = con.createStatement();

        ResultSet rs = st.executeQuery("SELECT * FROM attendance");

        PrintWriter out = response.getWriter();

        // CSV Header
        out.println("Email,Date,Status");

        // Data rows
        while (rs.next()) {
            out.println(
                rs.getString("user_email") + "," +
                rs.getString("meal_date") + "," +
                rs.getString("status")
            );
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
}


}
