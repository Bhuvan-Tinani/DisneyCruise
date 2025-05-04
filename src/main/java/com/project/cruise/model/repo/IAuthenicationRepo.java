/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.project.cruise.model.repo;

import com.project.cruise.model.data.LoginInfo;
import java.sql.SQLException;

/**
 *
 * @author My PC
 */
public interface IAuthenicationRepo {
    public boolean verifyUser(LoginInfo info) throws SQLException;
    public boolean isUserBlocked(LoginInfo info) throws SQLException;
}
