/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

public class InvoiceCodeUtil {
    public static String generateInvoiceCode() {
        String datePart = new SimpleDateFormat("yyyyMMdd").format(new Date());
        String randomPart = UUID.randomUUID().toString().substring(0, 6).toUpperCase();
        return "INV" + datePart + randomPart;
    }
    
    public static void main(String[] args) {
        System.out.println(generateInvoiceCode());
    }
}
