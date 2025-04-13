/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.project.cruise.controller.admin;

import com.project.cruise.model.data.Cruise;
import com.project.cruise.model.repo.admin.AdminRepo;
import com.project.cruise.model.repo.admin.IAdminRepo;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
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
public class AddCruise extends HttpServlet {

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
            out.println("<title>Servlet AddCruise</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddCruise at " + request.getContextPath() + "</h1>");
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
        //processRequest(request, response);
        // Fetching form data
        String shipName = request.getParameter("ship_name");
        String route = request.getParameter("route");
        String departureDate = request.getParameter("departure_date");
        int durationDays = Integer.parseInt(request.getParameter("duration_days"));
        double price = Double.parseDouble(request.getParameter("price"));
        String status = request.getParameter("status");

        // Creating Cruise object
        Cruise cruise = new Cruise();
        cruise.setShipName(shipName);
        cruise.setRoute(route);
        cruise.setDepartureDate(departureDate);
        cruise.setDurationDays(durationDays);
        cruise.setPrice(price);
        cruise.setStatus(status);
        ServletConfig cnf = getServletConfig();
        ServletContext sc = cnf.getServletContext();
        try {
            Connection conn = (Connection) sc.getAttribute("connection");
            IAdminRepo repo = new AdminRepo(conn);
            boolean success = repo.addCruise(cruise);
            //response.sendRedirect("ManageCruise");
        } catch (SQLException e) {
            e.printStackTrace();
            //response.sendRedirect("ManageCruise");
        }
        response.sendRedirect("ManageCruise");
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
