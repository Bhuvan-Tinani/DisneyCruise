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
public class PassengerProfile extends HttpServlet {

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
        RequestDispatcher rd = request.getRequestDispatcher("jspPages/passenger/profile.jsp");
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
    HttpSession session = request.getSession(false);
    String username = (String) session.getAttribute("username");

    Passenger passenger = new Passenger();
    passenger.setEmail(username);
    passenger.setFirstName(request.getParameter("first_name"));
    passenger.setLastName(request.getParameter("last_name"));
    passenger.setPhone(request.getParameter("phone"));
    passenger.setNationality(request.getParameter("nationality"));
    passenger.setPassportNumber(request.getParameter("passport_number"));

    ServletContext sc = getServletContext();
    Connection con = (Connection) sc.getAttribute("connection");

    PassengerRepo repo = new PassengerRepo(con);
    try {
        boolean success = repo.addPassenger(passenger);
        if (success) {
            // ✅ redirect to passenger dashboard or success page
            response.sendRedirect("PassengerHome");
        } else {
            // ❌ maybe show an error page or message
            request.setAttribute("error", "Profile could not be saved.");
            request.getRequestDispatcher("jspPages/passenger/profile.jsp").forward(request, response);
        }
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "An unexpected error occurred.");
        request.getRequestDispatcher("jspPages/passenger/profile.jsp").forward(request, response);
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
