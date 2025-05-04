package com.project.cruise.model.repo.passenger;
import com.project.cruise.model.data.Cruise;
import com.project.cruise.model.data.OrderDetail;
import com.project.cruise.model.data.passenger.SignUpInfo;
import com.project.cruise.model.passenger.Passenger;
import java.sql.SQLException;
import java.util.List;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */

/**
 *
 * @author My PC
 */
public interface IPassengerRepo {
    public boolean createAccount(SignUpInfo info) throws SQLException;
    public boolean isPassenger(String username) throws SQLException;
    boolean addPassenger(Passenger passenger) throws SQLException;
    List<Cruise> getAllCruises() throws SQLException;
    public Cruise getCruiseById(int cruiseId) throws SQLException;
    public Passenger getPassengerByEmail(String email) throws SQLException;
    public int addTransactions(OrderDetail orderDetail) throws SQLException;
    public boolean updateTransactionWithPaymentId(String paymentId, String orderId) throws SQLException;
    public boolean updatePassenger(Passenger p) throws SQLException;
}
