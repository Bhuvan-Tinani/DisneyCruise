package com.project.cruise.model.utils;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;

public class PasswordManager {

    // Generate SHA-256 hash with salt
    public static String hashWithSalt(String password) {
        try {
            // Generate random salt
            byte[] salt = new byte[16];
            SecureRandom sr = new SecureRandom();
            sr.nextBytes(salt);

            // Concatenate password with salt
            byte[] saltedPassword = (password + Base64.getEncoder().encodeToString(salt))
                    .getBytes(StandardCharsets.UTF_8);

            // Generate SHA-256 hash
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashed = md.digest(saltedPassword);

            // Return hash + salt (for storage/verification)
            return Base64.getEncoder().encodeToString(hashed) + ":" + Base64.getEncoder().encodeToString(salt);
        } catch (Exception e) {
            throw new RuntimeException("Error generating salted SHA-256 hash", e);
        }
    }

    public static boolean verifyPassword(String inputPassword, String storedHashWithSalt) {
        try {
            String[] parts = storedHashWithSalt.split(":");
            if (parts.length != 2) {
                return false;
            }

            String storedHash = parts[0];
            String storedSalt = parts[1];

            // Reconstruct salted password
            String saltedInput = inputPassword + storedSalt;
            byte[] saltedInputBytes = saltedInput.getBytes(StandardCharsets.UTF_8);

            // Hash the salted input password
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] inputHashBytes = md.digest(saltedInputBytes);
            String inputHash = Base64.getEncoder().encodeToString(inputHashBytes);

            // Compare hashes
            return inputHash.equals(storedHash);
        } catch (Exception e) {
            throw new RuntimeException("Error verifying password", e);
        }
    }

}
