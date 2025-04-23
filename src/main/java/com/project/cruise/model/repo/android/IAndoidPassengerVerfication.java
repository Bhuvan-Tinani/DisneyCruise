/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.project.cruise.model.repo.android;

import com.project.cruise.model.data.BookingDetailMeta;
import com.project.cruise.model.data.BookingDetails;
import com.project.cruise.model.data.Cruise;
import java.sql.SQLException;

/**
 *
 * @author My PC
 */
public interface IAndoidPassengerVerfication {
    public boolean checkPassengerExistInCruise(int cruiseId,int passengerId) throws SQLException;
    public String checkInStatus(int cruiseId,int passengerId) throws SQLException;
    public String checkIn(int cruiseId,int passengerId) throws SQLException;
    public void checkOut(int cruiseId,int passengerId) throws SQLException;
    public BookingDetailMeta getBookingDetails(int cruiseId, int passengerId) throws SQLException;
}
