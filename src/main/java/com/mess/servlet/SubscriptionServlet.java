package com.mess.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.mess.db.DBConnection;

@WebServlet("/subscribe")
public class SubscriptionServlet extends HttpServlet {


protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

	String email = (String) request.getSession().getAttribute("email");
	String plan = request.getParameter("plan");

	try {
	Connection con = DBConnection.getConnection();

	
	// 📅 Auto dates
	java.time.LocalDate startDate = java.time.LocalDate.now();
	java.time.LocalDate endDate;

	if (plan.equals("Weekly")) {
	    endDate = startDate.plusDays(7);
	} else {
	    endDate = startDate.plusDays(30);
	}

	String query = "INSERT INTO subscription(user_email, plan_type, start_date, end_date) VALUES (?, ?, ?, ?)";
	PreparedStatement ps = con.prepareStatement(query);

	ps.setString(1, email);
	ps.setString(2, plan);
	ps.setDate(3, java.sql.Date.valueOf(startDate));
	ps.setDate(4, java.sql.Date.valueOf(endDate));

	ps.executeUpdate();

	response.sendRedirect(request.getContextPath() + "/user/subscription.jsp?msg=Subscription Successful&type=success");
	

	} catch (Exception e) {
	e.printStackTrace();
	}

}


}
