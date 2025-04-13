/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.project.cruise.controller;

import com.project.cruise.model.data.LoginInfo;
import com.project.cruise.model.repo.AuthenticationRepo;
import com.project.cruise.model.repo.IAuthenicationRepo;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
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
public class Login extends HttpServlet {

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
            out.println("<title>Servlet Login</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Login at " + request.getContextPath() + "</h1>");
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
        RequestDispatcher rd = request.getRequestDispatcher("jspPages/Login.jsp");
        rd.forward(request, response);

        //processRequest(request, response);
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
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        LoginInfo info = new LoginInfo(username, password, role);
        ServletConfig scf = getServletConfig();
        ServletContext sc = scf.getServletContext();
        Connection con = (Connection) sc.getAttribute("connection");
        IAuthenicationRepo repo = new AuthenticationRepo(con);

        try {
            if (repo.verifyUser(info)) {
                HttpSession session = request.getSession(true);
                session.setAttribute("username", username);
                session.setMaxInactiveInterval(300);

                if (role.equals("passenger")) {
                    //RequestDispatcher rd = request.getRequestDispatcher("jspPages/passenger/home.jsp");
                    RequestDispatcher rd = request.getRequestDispatcher("PassengerHome");
                    rd.forward(request, response);
                } else if (role.equals("staff")) {
                    response.sendRedirect("jspPages/staff/home.jsp");
                } else if (role.equals("admin")) {
                    response.sendRedirect("AdminHome");
                }
            } else {
                request.setAttribute("errorMessage", "Invalid Credentials");
                RequestDispatcher rd = request.getRequestDispatcher("jspPages/Login.jsp");
                rd.forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("jspPages/Login.jsp");
            rd.forward(request, response);
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
