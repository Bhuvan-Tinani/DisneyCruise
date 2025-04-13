package com.project.cruise.controller.admin;

import com.project.cruise.model.data.AssignStaffRequest;
import com.project.cruise.model.data.Staff;
import com.project.cruise.model.data.StaffWithAssignment;
import com.project.cruise.model.repo.admin.AdminRepo;
import com.project.cruise.model.repo.admin.IAdminRepo;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AssignStaff extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    String cruise_id = request.getParameter("cruise_id");

    if (cruise_id != null) {
        ServletConfig cnf = getServletConfig();
        ServletContext sc = cnf.getServletContext();

        try {
            Connection conn = (Connection) sc.getAttribute("connection");
            IAdminRepo repo = new AdminRepo(conn);
            int cruiseIdInt = Integer.parseInt(cruise_id);

            // Define static roles
            String[] roles = {
                "Captain", "First Officer", "Second Officer", "Chief Engineer",
                "Assistant Engineer", "Housekeeping", "Cleaner", "Chef", "Waiter",
                "Receptionist", "Security Officer", "Bartender",
                "Entertainment Manager", "Medical Staff", "Crew Member"
            };

            // Get all staff with assignment status
            ArrayList<StaffWithAssignment> allStaff = ((AdminRepo) repo).getAllStaffWithAssignmentStatus(cruiseIdInt);

            // Group staff by role
            Map<String, ArrayList<StaffWithAssignment>> staffByRole = new HashMap<>();
            for (String role : roles) {
                ArrayList<StaffWithAssignment> staffInRole = new ArrayList<>();
                for (StaffWithAssignment s : allStaff) {
                    if (s.getStaff().getRole().equalsIgnoreCase(role)) {
                        staffInRole.add(s);
                    }
                }
                staffByRole.put(role, staffInRole);
            }

            // Send data to JSP
            request.setAttribute("cruise_id", cruise_id);
            request.setAttribute("staffByRole", staffByRole);
            request.setAttribute("roles", roles);

            RequestDispatcher rd = request.getRequestDispatcher("jspPages/admin/assignStaff.jsp");
            rd.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("AdminHome");
        }
    }
}



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String cruiseId = request.getParameter("cruise_id");

        if (cruiseId != null) {
            ServletConfig cnf = getServletConfig();
            ServletContext sc = cnf.getServletContext();

            try {
                Connection conn = (Connection) sc.getAttribute("connection");
                IAdminRepo repo = new AdminRepo(conn);
                int cruiseIdInt = Integer.parseInt(cruiseId);

                // Define roles
                String[] roles = {
                    "Captain", "First Officer", "Second Officer", "Chief Engineer",
                    "Assistant Engineer", "Housekeeping", "Cleaner", "Chef", "Waiter",
                    "Receptionist", "Security Officer", "Bartender",
                    "Entertainment Manager", "Medical Staff", "Crew Member"
                };

                // Processing assigned staff
                for (String role : roles) {
                    String paramName = "staff_" + role.replace(" ", "_");
                    String[] selectedStaffIds = request.getParameterValues(paramName);

                    if (selectedStaffIds != null) {
                        for (String staffId : selectedStaffIds) {
                            int staffIdInt = Integer.parseInt(staffId);

                            // Create AssignStaffRequest object
                            AssignStaffRequest assignRequest = new AssignStaffRequest(staffIdInt, cruiseIdInt);

                            // Assign staff using repository
                            repo.assignStaffToCruise(assignRequest);
                        }
                    }
                }

                response.sendRedirect("AdminHome"); // Redirect to admin home after assignment

            } catch (SQLException e) {
                e.printStackTrace();
                //response.sendRedirect("errorPage.jsp"); // Redirect to error page on failure
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Assign Staff Servlet";
    }
}
