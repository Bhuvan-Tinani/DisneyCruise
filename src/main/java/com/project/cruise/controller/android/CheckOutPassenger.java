package com.project.cruise.controller.android;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.project.cruise.model.repo.android.AndoidPassengerVerfication;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CheckOutPassenger extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");

        ServletConfig config = getServletConfig();
        ServletContext context = config.getServletContext();

        PrintWriter out = response.getWriter();
        Gson gson = new GsonBuilder().setPrettyPrinting().create();

        try {
            Connection conn = (Connection) context.getAttribute("connection");
            int cruiseId = Integer.parseInt(request.getParameter("cruiseId"));
            int passengerId = Integer.parseInt(request.getParameter("passengerId"));

            AndoidPassengerVerfication repo = new AndoidPassengerVerfication(conn);
            repo.checkOut(cruiseId, passengerId);

            //out.print(gson.toJson(new StatusResponse(true)));

        } catch (Exception e) {
            e.printStackTrace();
            out.print(gson.toJson(new StatusResponse(false, e.getMessage())));
        } finally {
            out.flush();
            out.close();
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles passenger checkout";
    }
}
