package com.project.cruise.controller.android;

import com.google.gson.Gson;
import com.project.cruise.model.data.BookingDetailMeta;
import com.project.cruise.model.repo.android.AndoidPassengerVerfication;
import com.project.cruise.model.repo.android.IAndoidPassengerVerfication;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.ServletContext;

public class PassengerBookingInfo extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Enable CORS
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setContentType("application/json;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            int cruiseId = Integer.parseInt(request.getParameter("cruiseId"));
            int passengerId = Integer.parseInt(request.getParameter("passengerId"));
            ServletContext sc = getServletConfig().getServletContext();

            try (Connection con = (Connection) sc.getAttribute("connection")) {
                IAndoidPassengerVerfication repo = new AndoidPassengerVerfication(con);
                BookingDetailMeta bookingDetails = repo.getBookingDetails(cruiseId, passengerId);

                if (bookingDetails != null) {
                    Gson gson = new Gson();
                    String json = gson.toJson(bookingDetails);
                    out.print(json);
                } else {
                    out.print("{\"status\":\"not_found\"}");
                }

            } catch (Exception e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print("{\"error\":\"" + e.getMessage() + "\"}");
            }
        }
    }

    @Override
    protected void doOptions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle preflight CORS requests
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type");
        response.setStatus(HttpServletResponse.SC_OK);
    }
}
