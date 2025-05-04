/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.project.cruise.model.utils;

import java.util.Random;

/**
 *
 * @author My PC
 */
public class OTPManager {
    public static String generateOTP() {
        Random rand = new Random();
        int otp = 100000 + rand.nextInt(900000); // 6-digit OTP
        return String.valueOf(otp);
    }
}
