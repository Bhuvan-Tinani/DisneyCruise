/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.project.cruise.model.repo;

import com.project.cruise.model.data.LoginInfo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author My PC
 */
public class AuthenticationRepo implements IAuthenicationRepo{
    Connection con;

    public AuthenticationRepo(Connection con) {
        this.con=con;
    }

    @Override
    public boolean verifyUser(LoginInfo info) throws SQLException {
        //throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
        String sql="select count(*) as verfified from users where username=? and password=? and role=?";
        PreparedStatement pstmt=con.prepareCall(sql);
        pstmt.setString(1, info.getUsername());
        pstmt.setString(2, info.getPassword());
        pstmt.setString(3, info.getRole());
        ResultSet rs=pstmt.executeQuery();
        rs.next();
        int vefy=rs.getInt("verfified");
        if(vefy==1){
            return true;
        }
        return false;
    }
    
}
