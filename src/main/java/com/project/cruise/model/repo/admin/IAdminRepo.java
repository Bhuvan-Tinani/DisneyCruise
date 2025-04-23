/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.project.cruise.model.repo.admin;

import com.project.cruise.model.data.AssignStaffRequest;
import com.project.cruise.model.data.BookingDetails;
import com.project.cruise.model.data.Cruise;
import com.project.cruise.model.data.Staff;
import com.project.cruise.model.data.StaffWithAssignment;
import com.project.cruise.model.passenger.Passenger;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author My PC
 */
public interface IAdminRepo {

    public boolean addStaff(Staff staff) throws SQLException;

    public ArrayList<Staff> getAllStaff() throws SQLException;

    public boolean addCruise(Cruise cruise) throws SQLException;

    public ArrayList<Cruise> getAllCruises() throws SQLException;

//    public ArrayList<StaffWithAssignment> getAllStaffWithAssignmentStatus(int cruiseid) throws SQLException;
//
//    boolean assignStaffToCruise(AssignStaffRequest request) throws SQLException;
    
    boolean isStaffAssigned(int cruiseId) throws SQLException;
    
    List<Staff> getAllUnAssignedStaff() throws SQLException;
    void assignStaff(List<Integer> passenger,int cruiseId) throws SQLException;
    List<Staff> getAssignedStaff(int cruiseId) throws SQLException;
    String getCruiseName(int cruiseId) throws SQLException;
    List<Passenger> getAllPassenger() throws SQLException;
    List<BookingDetails> getAllBokingDetail() throws SQLException;
    
}
