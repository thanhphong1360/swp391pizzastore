/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Scanner;

public class HashUtil {

    public static String hashPassword(String password, String salt) {
        try {
            // Ghép password với salt
            String input =  salt + password;    

            // Dùng SHA-256 để băm
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] encodedHash = digest.digest(input.getBytes(StandardCharsets.UTF_8));

            // Chuyển thành chuỗi hex dễ lưu trữ
            return bytesToHex(encodedHash);

        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Không hỗ trợ thuật toán SHA-256", e);
        }
    }

    // Chuyển byte[] thành chuỗi hex
    private static String bytesToHex(byte[] hash) {
        StringBuilder hexString = new StringBuilder();
        for (byte b : hash) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) hexString.append('0');
            hexString.append(hex);
        }
        return hexString.toString();
    }
    
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("password: ");
        String password = scanner.nextLine();
        System.out.println("salt: ");
        String salt = scanner.nextLine();
        System.out.println("hashed: " + hashPassword(password, salt));
    }
}

