/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.project.cruise.model.repo;

import com.project.cruise.model.data.LoginInfo;
import com.project.cruise.model.utils.PasswordManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author My PC
 */
public class AuthenticationRepo implements IAuthenicationRepo {

    Connection con;

    public AuthenticationRepo(Connection con) {
        this.con = con;
    }

    @Override
    public boolean verifyUser(LoginInfo info) throws SQLException {
        String sql;
        PreparedStatement pstmt;
        ResultSet rs;

        if (info.getRole().trim().equalsIgnoreCase("passenger")) {
            // For passenger: fetch hashed password from DB
            sql = "SELECT password FROM users WHERE username = ? AND role = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, info.getUsername());
            pstmt.setString(2, info.getRole());
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String storedHashWithSalt = rs.getString("password");
                String inputPassword = info.getPassword();
                return PasswordManager.verifyPassword(inputPassword, storedHashWithSalt);
            }
        } else {
            // For admin or staff: use direct match
            sql = "SELECT COUNT(*) AS verified FROM users WHERE username = ? AND password = ? AND role = ?";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, info.getUsername());
            pstmt.setString(2, info.getPassword());
            pstmt.setString(3, info.getRole());
            rs = pstmt.executeQuery();

            if (rs.next()) {
                int verified = rs.getInt("verified");
                return verified == 1;
            }
        }

        return false;
    }

    public boolean isUserBlocked(LoginInfo info) throws SQLException {
        String sql = "SELECT block FROM passengers WHERE email = ? ";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, info.getUsername());

        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            int blockStatus = rs.getInt("block");
            return blockStatus == 1;  // If block status is 1, the user is blocked
        }

        return false;  // Return false if no result found or user is not blocked
    }

}
