/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.project.cruise.controller.passenger;

import com.project.cruise.model.passenger.Passenger;
import com.project.cruise.model.repo.passenger.PassengerRepo;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author My PC
 */
public class ViewProfile extends HttpServlet {

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
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet PassengerProfile</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet PassengerProfile at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
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
        //processRequest(request, response);
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("username"); // email stored in session

        ServletContext sc = getServletContext();
        Connection con = (Connection) sc.getAttribute("connection");

        PassengerRepo repo = new PassengerRepo(con);
        try {
            Passenger passenger = repo.getPassengerByEmail(username);
            request.setAttribute("passenger", passenger);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to load profile.");
        }

        RequestDispatcher rd = request.getRequestDispatcher("jspPages/passenger/viewProfile.jsp");
        rd.forward(request, response);
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

        // Get the session, and create one if it doesn't exist
        HttpSession session = request.getSession(false); // Try to get an existing session
        if (session == null) {
            // If the session is null, redirect to the login page
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve the username (assumed to be stored in session)
        String username = (String) session.getAttribute("username");
        if (username == null) {
            // If the username is null, it indicates the user is not logged in, redirect to login
            response.sendRedirect("login.jsp");
            return;
        }

        // Create and populate Passenger object
        Passenger passenger = new Passenger();
        passenger.setEmail(username);  // Use the username as the email
        passenger.setFirstName(request.getParameter("first_name"));
        passenger.setLastName(request.getParameter("last_name"));
        passenger.setPhone(request.getParameter("phone"));
        passenger.setNationality(request.getParameter("nationality"));
        passenger.setPassportNumber(request.getParameter("passport_number"));

        // Retrieve action parameter
        String action = request.getParameter("action");

        // Validate the action
        if (action == null || (!action.equalsIgnoreCase("insert") && !action.equalsIgnoreCase("update"))) {
            request.setAttribute("error", "Invalid action.");
            request.setAttribute("passenger", passenger);
            request.getRequestDispatcher("jspPages/passenger/viewProfile.jsp").forward(request, response);
            return;
        }

        // Retrieve the database connection
        ServletContext sc = getServletContext();
        Connection con = (Connection) sc.getAttribute("connection");
        if (con == null) {
            request.setAttribute("error", "Database connection is not available.");
            request.setAttribute("passenger", passenger);
            request.getRequestDispatcher("jspPages/passenger/viewProfile.jsp").forward(request, response);
            return;
        }

        // Initialize the PassengerRepo to interact with the database
        PassengerRepo repo = new PassengerRepo(con);
        try {
            boolean success = false;

            // Perform the action (insert or update)
            if ("insert".equalsIgnoreCase(action)) {
                success = repo.addPassenger(passenger);
            } else if ("update".equalsIgnoreCase(action)) {
                success = repo.updatePassenger(passenger);
            }

            // Redirect to the profile page if the operation was successful
            if (success) {
                response.sendRedirect("PassengerProfile");
            } else {
                // If there was an issue, set error and forward
                request.setAttribute("error", "Profile could not be saved.");
                request.setAttribute("passenger", passenger);
                request.getRequestDispatcher("jspPages/passenger/viewProfile.jsp").forward(request, response);
            }

        } catch (Exception e) {
            // Log the exception and show an error message
            e.printStackTrace();
            request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
            request.setAttribute("passenger", passenger);
            request.getRequestDispatcher("jspPages/passenger/viewProfile.jsp").forward(request, response);
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
