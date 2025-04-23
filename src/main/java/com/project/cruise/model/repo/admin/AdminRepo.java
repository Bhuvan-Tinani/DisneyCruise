/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.project.cruise.model.repo.admin;

import com.project.cruise.model.data.AssignStaffRequest;
import com.project.cruise.model.data.BookingDetails;
import com.project.cruise.model.data.Cruise;
import com.project.cruise.model.data.Staff;
import com.project.cruise.model.data.StaffWithAssignment;
import com.project.cruise.model.passenger.Passenger;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
            cruise.setIsAssigned(isStaffAssigned(rs.getInt("id")));

            cruiseList.add(cruise); // Add the cruise object to the list
        }
        return cruiseList;
    }

    @Override
    public boolean isStaffAssigned(int cruiseId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM staff WHERE cruise_id = ?";
        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, cruiseId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0;
            }
        }
        return false;
    }

    @Override
    public List<Staff> getAllUnAssignedStaff() throws SQLException {
        List<Staff> unassignedStaff = new ArrayList<>();

        String sql = "SELECT * FROM staff WHERE cruise_id IS NULL";

        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Staff staff = new Staff();
            staff.setId(rs.getInt("id"));
            staff.setFirstName(rs.getString("first_name"));
            staff.setLastName(rs.getString("last_name"));
            staff.setRole(rs.getString("role"));
            staff.setPhone(rs.getString("phone"));
            staff.setEmail(rs.getString("email"));
            // Not setting password or cruise_id unless needed
            unassignedStaff.add(staff);
        }

        return unassignedStaff;
    }

    @Override
    public void assignStaff(List<Integer> staffIds, int cruiseId) throws SQLException {
        if (staffIds == null || staffIds.isEmpty()) {
            return; // Nothing to assign
        }

        String sql = "UPDATE staff SET cruise_id = ? WHERE id = ?";

        PreparedStatement pstmt = con.prepareStatement(sql);
        for (Integer staffId : staffIds) {
            pstmt.setInt(1, cruiseId);
            pstmt.setInt(2, staffId);
            pstmt.addBatch();
        }

        pstmt.executeBatch();
    }

    @Override
    public List<Staff> getAssignedStaff(int cruiseId) throws SQLException {
        List<Staff> assignedStaff = new ArrayList<>();
        String sql = "SELECT id, first_name, last_name, email, phone, role, password FROM staff WHERE cruise_id = ?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, cruiseId);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            Staff staff = new Staff();
            staff.setId(rs.getInt("id"));
            staff.setFirstName(rs.getString("first_name"));
            staff.setLastName(rs.getString("last_name"));
            staff.setEmail(rs.getString("email"));
            staff.setPhone(rs.getString("phone"));
            staff.setRole(rs.getString("role"));
            staff.setPassword(rs.getString("password"));
            assignedStaff.add(staff);

        }
        return assignedStaff;
    }

    @Override
    public String getCruiseName(int cruiseId) throws SQLException {
        String cruiseName = null;
        String sql = "SELECT ship_name FROM cruises WHERE id = ?";
        try (PreparedStatement pstmt = con.prepareStatement(sql)) {
            pstmt.setInt(1, cruiseId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    cruiseName = rs.getString("ship_name");
                }
            }
        }
        return cruiseName;
    }

    @Override
    public List<Passenger> getAllPassenger() throws SQLException {
        List<Passenger> passengers = new ArrayList<>();
        String sql = "SELECT id, first_name, last_name, email, phone, nationality, passport_number, created_at FROM passengers";
        PreparedStatement pstmt = con.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            Passenger p = new Passenger();
            p.setId(rs.getInt("id"));
            p.setFirstName(rs.getString("first_name"));
            p.setLastName(rs.getString("last_name"));
            p.setEmail(rs.getString("email"));
            p.setPhone(rs.getString("phone"));
            p.setNationality(rs.getString("nationality"));
            p.setPassportNumber(rs.getString("passport_number"));
            p.setCreatedAt(rs.getTimestamp("created_at"));
            passengers.add(p);
        }

        return passengers;
    }

    @Override
    public List<BookingDetails> getAllBokingDetail() throws SQLException {
        List<BookingDetails> bookingDetailsList = new ArrayList<>();
        String sql = "SELECT "
                + "b.booking_reference, "
                + "c.ship_name AS cruise_name, "
                + "c.route AS cruise_route, "
                + "c.departure_date, "
                + "c.duration_days, "
                + "c.price AS cruise_price, "
                + "bp.qr_code AS boarding_pass_qr, "
                + "CONCAT(p.first_name, ' ', p.last_name) AS passenger_name, "
                + "p.email AS passenger_email "
                + "FROM bookings b "
                + "JOIN cruises c ON b.cruise_id = c.id "
                + "JOIN booking_passengers bpass ON bpass.booking_id = b.id "
                + "JOIN passengers p ON bpass.passenger_id = p.id "
                + "LEFT JOIN boardingpass bp ON bp.booking_passenger_id = bpass.id";

        PreparedStatement pstmt = con.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            BookingDetails bd = new BookingDetails();
            bd.setBookingReference(rs.getString("booking_reference"));
            bd.setCruiseName(rs.getString("cruise_name"));
            bd.setCruiseRoute(rs.getString("cruise_route"));
            bd.setDepartureDate(rs.getString("departure_date"));
            bd.setDurationDays(rs.getInt("duration_days"));
            bd.setCruisePrice(rs.getDouble("cruise_price"));
            bd.setBoardingPassQr(rs.getString("boarding_pass_qr"));
            bd.setPassengerName(rs.getString("passenger_name"));
            bd.setPassengerEmail(rs.getString("passenger_email"));
            bookingDetailsList.add(bd);
        }

        rs.close();
        pstmt.close();
        return bookingDetailsList;
    }

}
