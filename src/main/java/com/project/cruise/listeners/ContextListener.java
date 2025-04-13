/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/ServletListener.java to edit this template
 */
package com.project.cruise.listeners;

import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextAttributeEvent;
import javax.servlet.ServletContextAttributeListener;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Web application lifecycle listener.
 *
 * @author My PC
 */
public class ContextListener implements ServletContextListener, ServletContextAttributeListener {

    Connection con;

    @Override
public void contextInitialized(ServletContextEvent sce) {
    ServletContext sc = sce.getServletContext();
    String url = sc.getInitParameter("url");
    String driverclass = sc.getInitParameter("driver");

    String username = null, password = null,RAZORPAY_ID=null,RAZORPAY_KEY=null;
    String email = null, emailpassword = null;
    try {
        // Load from resources folder using ClassLoader
        InputStream input = getClass().getClassLoader().getResourceAsStream("db.properties");
        if (input == null) {
            throw new IOException("db.properties file not found");
        }

        Properties properties = new Properties();
        properties.load(input);
        username = properties.getProperty("DB_USER");
        password = properties.getProperty("DB_PASSWORD");
        RAZORPAY_ID=properties.getProperty("RAZORPAY_ID");
        RAZORPAY_KEY=properties.getProperty("RAZORPAY_KEY");
        email=properties.getProperty("EMAIL");
        emailpassword=properties.getProperty("EMAILPASSWORD");
        sc.setAttribute("r_key",RAZORPAY_KEY);
        sc.setAttribute("r_id", RAZORPAY_ID);
        sc.setAttribute("email", email);
        sc.setAttribute("emailpassword", emailpassword);
        input.close();

//        System.out.println(username + " " + password);
    } catch (IOException e) {
        e.printStackTrace();
    }

    if (username != null && password != null ) {
        try {
            Class.forName(driverclass);
            con = DriverManager.getConnection(url, username, password);
            sc.setAttribute("connection", con);
//            System.out.println("Connection Created");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}


    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("Servlet Context Listener Destroyed");
        ServletContext sc = sce.getServletContext();
        sc.removeAttribute("connection");
        try {
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try {
            com.mysql.cj.jdbc.AbandonedConnectionCleanupThread.uncheckedShutdown();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void attributeAdded(ServletContextAttributeEvent event) {
        System.out.println("Attribute Added");
    }

    @Override
    public void attributeRemoved(ServletContextAttributeEvent event) {
        System.out.println("Attribute Removed");
    }

    @Override
    public void attributeReplaced(ServletContextAttributeEvent event) {
        System.out.println("Atrribute Replaced");
    }
}
