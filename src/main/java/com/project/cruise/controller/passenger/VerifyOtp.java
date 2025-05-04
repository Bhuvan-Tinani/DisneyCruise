/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.project.cruise.controller.passenger;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author My PC
 */
public class VerifyOtp extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String enteredOtp = request.getParameter("otp");
        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("jspPages/Login.jsp");
            return;
        }

        String generatedOtp = (String) session.getAttribute("otp");
        long otpTime = (long) session.getAttribute("otpTime");
        long currentTime = System.currentTimeMillis();

        if (generatedOtp != null && generatedOtp.equals(enteredOtp) && (currentTime - otpTime <= 2 * 60 * 1000)) {
            session.removeAttribute("otp"); // Remove OTP after use
            session.removeAttribute("otpTime");
            response.sendRedirect("PassengerHome");
        } else {
            request.setAttribute("errorMessage", "Invalid or expired OTP");
            RequestDispatcher rd = request.getRequestDispatcher("jspPages/passenger/OtpPage.jsp");
            rd.forward(request, response);
        }
    }
}
