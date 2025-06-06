/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.project.cruise.controller.admin;

import com.project.cruise.model.data.Staff;
import com.project.cruise.model.repo.admin.AdminRepo;
import com.project.cruise.model.repo.admin.IAdminRepo;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author My PC
 */
public class ViewAssignedStaff extends HttpServlet {

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
            out.println("<title>Servlet ViewAssignedStaff</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewAssignedStaff at " + request.getContextPath() + "</h1>");
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
        String cruiseIdStr = request.getParameter("cruise_id");
        if (cruiseIdStr != null) {
            try {
                int cruiseId = Integer.parseInt(cruiseIdStr);
                // Assuming you have a method to get a DB connection
                Connection conn = (Connection) getServletContext().getAttribute("connection");
                IAdminRepo repo = new AdminRepo(conn);
                // Fetch cruise name
                String cruiseName = repo.getCruiseName(cruiseId);
                List<Staff> staff=repo.getAssignedStaff(cruiseId);
                // Set attribute for JSP
                request.setAttribute("cruiseName", cruiseName);
                request.setAttribute("cruise_id", cruiseId);
                request.setAttribute("staff",staff);
            } catch (NumberFormatException | SQLException e) {
                e.printStackTrace();
                // Handle error, e.g., redirect or set error message
            }
        }
        // Forward to JSP
        request.getRequestDispatcher("jspPages/admin/viewAssignedStaff.jsp").forward(request, response);
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
        processRequest(request, response);
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
