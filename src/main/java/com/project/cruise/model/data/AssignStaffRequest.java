/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.project.cruise.model.data;

/**
 *
 * @author My PC
 */
/**
 * Represents a staff assignment to a cruise.
 */
public class AssignStaffRequest {
    private int id;
    private int staffId;
    private int cruiseId;

    // Constructors
    public AssignStaffRequest() {}

    public AssignStaffRequest(int id, int staffId, int cruiseId) {
        this.id = id;
        this.staffId = staffId;
        this.cruiseId = cruiseId;
    }

    public AssignStaffRequest(int staffId, int cruiseId) {
        this.staffId = staffId;
        this.cruiseId = cruiseId;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public int getCruiseId() {
        return cruiseId;
    }

    public void setCruiseId(int cruiseId) {
        this.cruiseId = cruiseId;
    }

    @Override
    public String toString() {
        return "StaffAssignment{" +
                "id=" + id +
                ", staffId=" + staffId +
                ", cruiseId=" + cruiseId +
                '}';
    }
}
