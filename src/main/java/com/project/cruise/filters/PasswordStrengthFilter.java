/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/AdvancedFilter.java to edit this template
 */
package com.project.cruise.filters;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

/**
 *
 * @author My PC
 */
public class PasswordStrengthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }

    @Override
    public void doFilter(ServletRequest sr, ServletResponse sr1, FilterChain fc) throws IOException, ServletException {
        //throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
        fc.doFilter(sr, sr1);
    }

    @Override
    public void destroy() {
        Filter.super.destroy(); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }

//    private static final Pattern PASSWORD_PATTERN = Pattern.compile(
//        "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
//    );
//
//    @Override
//    public void init(FilterConfig filterConfig) throws ServletException {
//        // Initialization if needed
//    }
//
//    @Override
//    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
//            throws IOException, ServletException {
//
//        HttpServletRequest httpRequest = (HttpServletRequest) request;
//        String password = request.getParameter("password");
//        String path = httpRequest.getServletPath();
//
//        if (password != null && ("/SignUp".equals(path) || "/Login".equals(path))) {
//            if (!PASSWORD_PATTERN.matcher(password).matches()) {
//                request.setAttribute("errorMessage", "Password is too weak. Must contain at least 8 characters, uppercase, lowercase, digit, and special character.");
//                RequestDispatcher rd = request.getRequestDispatcher("jspPages/Login");
//                rd.forward(request, response);
//                return;
//            }
//        }
//
//        // If valid, continue to next filter or servlet
//        chain.doFilter(request, response);
//    }
//
//    @Override
//    public void destroy() {
//        // Cleanup if needed
//    }
}