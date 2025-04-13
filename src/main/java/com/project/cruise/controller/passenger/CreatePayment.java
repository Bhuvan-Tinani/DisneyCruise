/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.project.cruise.controller.passenger;

import com.google.zxing.WriterException;
import com.itextpdf.text.DocumentException;
import com.project.cruise.model.data.BookingDetails;
import com.project.cruise.model.data.OrderDetail;
import com.project.cruise.model.utils.*;
import com.project.cruise.model.repo.passenger.PassengerRepo;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;

/**
 *
 * @author My PC
 */
public class CreatePayment extends HttpServlet {

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
            out.println("<title>Servlet CreatePayment</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreatePayment at " + request.getContextPath() + "</h1>");
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
        ServletContext sc = getServletContext();
        Connection con = (Connection) sc.getAttribute("connection");
        PrintWriter out = response.getWriter();
        int cruise_id = Integer.parseInt(request.getParameter("cruise_id"));
        int passenger_id = Integer.parseInt(request.getParameter("passenger_id"));
        double amt = Double.parseDouble(request.getParameter("amount"));
        int amountInPaise = (int) (amt * 100); // Razorpay requires amount in paise

        LocalDate currentDate = LocalDate.now();
        String date = currentDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        LocalTime currentTime = LocalTime.now();
        String time = currentTime.format(DateTimeFormatter.ofPattern("HH:mm:ss"));
        try {
            RazorpayClient payment = new RazorpayClient(sc.getAttribute("r_id").toString(), sc.getAttribute("r_key").toString());
            JSONObject orderRequest = new JSONObject();
            orderRequest.put("amount", amountInPaise); // amount in the smallest currency unit
            orderRequest.put("currency", "INR");
            orderRequest.put("receipt", "order_rcptid_11");
            Order order = payment.Orders.create(orderRequest);
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setAmount(order.get("amount") + "");
            orderDetail.setOrder_id(order.get("id") + "");
            orderDetail.setPayment_id(null);
            orderDetail.setStatus("created");
            orderDetail.setReceipt(order.get("receipt") + "");
            orderDetail.setCruise_id(cruise_id);
            orderDetail.setPassenger_id(passenger_id);
            orderDetail.setDate(date);
            orderDetail.setTime(time);
            PassengerRepo repo = new PassengerRepo(con);

            int row = repo.addTransactions(orderDetail);
            out.println(order);
        } catch (SQLException ex) {
            System.out.println(ex);
            Logger.getLogger(CreatePayment.class.getName()).log(Level.SEVERE, null, ex);
        } catch (RazorpayException ex) {
            System.out.println(ex);
            Logger.getLogger(CreatePayment.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ServletContext sc = getServletContext();
        Connection con = (Connection) sc.getAttribute("connection");
        PrintWriter out = response.getWriter();
        response.setContentType("application/json");

        StringBuilder jsonBuffer = new StringBuilder();
        String line;
        BufferedReader reader = request.getReader();
        while ((line = reader.readLine()) != null) {
            jsonBuffer.append(line);
        }

        try {
            JSONObject json = new JSONObject(jsonBuffer.toString());
            String paymentId = json.getString("payment_id");
            String orderId = json.getString("order_id");

            System.out.println("Payment ID: " + paymentId + ", Order ID: " + orderId);

            PassengerRepo repo = new PassengerRepo(con);
            boolean updated = repo.updateTransactionWithPaymentId(paymentId, orderId);

            if (updated) {
                finalizeBooking(orderId, paymentId, repo,sc);
                out.write("{\"status\":\"success\", \"message\":\"Payment ID updated successfully\"}");
                //request.getRequestDispatcher("FinalizeBooking").forward(request, response);
            } else {
                out.write("{\"status\":\"error\", \"message\":\"Failed to update payment ID\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"status\":\"error\", \"message\":\"Exception occurred while updating\"}");
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

    private void finalizeBooking(String orderId, String paymentId, PassengerRepo repo, ServletContext sc) throws SQLException, IOException {
        int passengerId = repo.setTransactionDetails(orderId, paymentId);
        if (passengerId != -1) {
            BookingDetails bd = repo.fetchBookingDetails(passengerId);
            try {
                // Generate PDF as byte array
                byte[] pdfBytes = BookingPdfGenerator.generatePdf(bd);

                // Retrieve email and password from ServletContext
                String senderEmail = (String) sc.getAttribute("email");
                String senderPassword = (String) sc.getAttribute("emailpassword");

                if (senderEmail != null && senderPassword != null) {
                    // Send email with PDF attachment
                    EmailSender sender = new EmailSender();
                    sender.sendEmail(bd, pdfBytes, senderEmail, senderPassword);
                } else {
                    throw new IllegalStateException("Email or Password is not set in ServletContext.");
                }
            } catch (DocumentException | WriterException ex) {
                Logger.getLogger(CreatePayment.class.getName()).log(Level.SEVERE, null, ex);
            } catch (MessagingException ex) {
                Logger.getLogger(CreatePayment.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            throw new SQLException("Passenger not found");
        }
    }

}
