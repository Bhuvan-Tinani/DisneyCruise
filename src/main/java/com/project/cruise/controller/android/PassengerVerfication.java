/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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

/**
 *
 * @author My PC
 */
public class PassengerVerfication extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PassengerVerfication</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PassengerVerfication at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");

        ServletContext sc = getServletConfig().getServletContext();
        PrintWriter out = response.getWriter();
        Gson gson = new GsonBuilder().setPrettyPrinting().create();

        try {
            Connection conn = (Connection) sc.getAttribute("connection");

            String cruiseIdStr = request.getParameter("cruiseId");
            String passengerIdStr = request.getParameter("passengerId");

            if (cruiseIdStr == null || passengerIdStr == null) {
                out.print(gson.toJson(new ErrorResponse("Missing cruiseId or passengerId")));
                return;
            }

            int cruiseId = Integer.parseInt(cruiseIdStr);
            int passengerId = Integer.parseInt(passengerIdStr);

            AndoidPassengerVerfication repo = new AndoidPassengerVerfication(conn);

            boolean exists = repo.checkPassengerExistInCruise(cruiseId, passengerId);

            if (!exists) {
                out.print(gson.toJson(new StatusResponse(false, "Passenger not found in cruise")));
            } else {
                // If exists, get check-in status
                String status = repo.checkInStatus(cruiseId, passengerId);
                out.print(gson.toJson(new CheckInStatusResponse(true, status)));
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print(gson.toJson(new ErrorResponse("Internal server error")));
        } finally {
            out.flush();
            out.close();
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

class StatusResponse {

    boolean status;
    String message;

    public StatusResponse(boolean status, String message) {
        this.status = status;
        this.message = message;
    }
}

class CheckInStatusResponse {

    boolean status;
    String checkInStatus;

    public CheckInStatusResponse(boolean status, String checkInStatus) {
        this.status = status;
        this.checkInStatus = checkInStatus;
    }
}

class ErrorResponse {

    String error;

    public ErrorResponse(String error) {
        this.error = error;
    }
}
