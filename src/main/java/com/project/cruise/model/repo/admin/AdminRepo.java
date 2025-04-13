/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.project.cruise.model.repo.admin;

import com.project.cruise.model.data.AssignStaffRequest;
import com.project.cruise.model.data.Cruise;
import com.project.cruise.model.data.Staff;
import com.project.cruise.model.data.StaffWithAssignment;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author My PC
 */
public class AdminRepo implements IAdminRepo {

    Connection con;

    public AdminRepo(Connection con) {
        this.con = con;
    }

    @Override
    public boolean addStaff(Staff staff) throws SQLException {
        String insertQuery = "INSERT INTO staff (first_name, last_name, role, phone, email, password) VALUES (?, ?, ?, ?, ?, ?)";
        boolean isInserted = false;

        try (PreparedStatement stmt = con.prepareStatement(insertQuery)) {
            stmt.setString(1, staff.getFirstName());
            stmt.setString(2, staff.getLastName());
            stmt.setString(3, staff.getRole());
            stmt.setString(4, staff.getPhone());
            stmt.setString(5, staff.getEmail());
            stmt.setString(6, staff.getPassword()); // Consider hashing before storing

            isInserted = stmt.executeUpdate() > 0;
        }
        return isInserted;
    }

    @Override
    public ArrayList<Staff> getAllStaff() throws SQLException {
        ArrayList<Staff> staffList = new ArrayList<>();
        String query = "SELECT * FROM staff";

        try (Statement stmt = con.createStatement(); ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Staff staff = new Staff(); // Create an empty Staff object

                staff.setId(rs.getInt("id"));
                staff.setFirstName(rs.getString("first_name"));
                staff.setLastName(rs.getString("last_name"));
                staff.setRole(rs.getString("role"));
                staff.setPhone(rs.getString("phone"));
                staff.setEmail(rs.getString("email"));
                //staff.setPassword(rs.getString("password")); // Store securely in a real-world app

                staffList.add(staff); // Add staff object to list
            }
        }
        return staffList;
    }

    @Override
    public boolean addCruise(Cruise cruise) throws SQLException {
        String sql = "INSERT INTO cruises (ship_name, route, departure_date, duration_days, price, status) VALUES (?, ?, ?, ?, ?, ?)";

        PreparedStatement pstmt = con.prepareStatement(sql);

        pstmt.setString(1, cruise.getShipName());
        pstmt.setString(2, cruise.getRoute());
        pstmt.setString(3, cruise.getDepartureDate());
        pstmt.setInt(4, cruise.getDurationDays());
        pstmt.setDouble(5, cruise.getPrice());
        pstmt.setString(6, cruise.getStatus());

        int rowsAffected = pstmt.executeUpdate();
        return rowsAffected > 0; // Returns true if the cruise was added successfully

    }

    @Override
    public ArrayList<Cruise> getAllCruises() throws SQLException {
        ArrayList<Cruise> cruiseList = new ArrayList<>();
        String query = "SELECT * FROM cruises";

        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery(query);
        while (rs.next()) {
            Cruise cruise = new Cruise();

            cruise.setId(rs.getInt("id"));
            cruise.setShipName(rs.getString("ship_name"));
            cruise.setRoute(rs.getString("route"));
            cruise.setDepartureDate(rs.getString("departure_date"));
            cruise.setDurationDays(rs.getInt("duration_days"));
            cruise.setPrice(rs.getDouble("price"));
            cruise.setStatus(rs.getString("status"));

            cruiseList.add(cruise); // Add the cruise object to the list
        }
        return cruiseList;
    }

    public ArrayList<StaffWithAssignment> getAllStaffWithAssignmentStatus(int cruiseId) throws SQLException {
        ArrayList<StaffWithAssignment> result = new ArrayList<>();

        String query = "SELECT s.*, "
                + "EXISTS (SELECT 1 FROM staff_assignment sa WHERE sa.staff_id = s.id AND sa.cruise_id = ?) AS is_assigned "
                + "FROM staff s";

        try (PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, cruiseId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Staff staff = new Staff();
                    staff.setId(rs.getInt("id"));
                    staff.setFirstName(rs.getString("first_name"));
                    staff.setLastName(rs.getString("last_name"));
                    staff.setRole(rs.getString("role"));
                    staff.setPhone(rs.getString("phone"));
                    staff.setEmail(rs.getString("email"));

                    boolean isAssigned = rs.getBoolean("is_assigned");

                    result.add(new StaffWithAssignment(staff, isAssigned));
                }
            }
        }

        return result;
    }

    @Override
    public boolean assignStaffToCruise(AssignStaffRequest request) throws SQLException {
        String query = "INSERT INTO staff_assignment (staff_id, cruise_id) VALUES (?, ?)";
        try (PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setInt(1, request.getStaffId());
            stmt.setInt(2, request.getCruiseId());
            return stmt.executeUpdate() > 0;
        }
    }

}
