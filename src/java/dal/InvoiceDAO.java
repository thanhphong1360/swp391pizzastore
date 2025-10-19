/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.util.ArrayList;

import util.InvoiceCodeUtil;
import model.Invoice;

/**
 *
 * @author cungp
 */
public class InvoiceDAO {
    public static Invoice createInvoice(Invoice invoice) {
        DBContext dbc = DBContext.getInstance();
        int rs = 0;
        String sql = """
        INSERT INTO [dbo].[Invoices] (waiter_id, invoice_code)
        VALUES (?, ?)
        """;
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setInt(1, invoice.getWaiterId());
            statement.setString(2, invoice.getInvoiceCode());
            rs = statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return rs == 0 ? null : invoice;
    }
    
    public static Invoice getInvoiceByCode(String invoiceCode) {
        ArrayList<Invoice> list = new ArrayList<>();
        DBContext dbc = DBContext.getInstance();
        String sql = "SELECT * FROM Invoices WHERE invoice_code = ?";
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setString(1, invoiceCode);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Invoice invoice = new Invoice(rs.getInt("invoice_id"),
                                            rs.getString("invoice_code"),
                                            rs.getInt("discount_id"),
                                            rs.getInt("waiter_id"),
                                            rs.getInt("cashier_id"),
                                            rs.getString("status"),
                                            rs.getBigDecimal("price"),
                                            rs.getBigDecimal("final_price"),
                                            rs.getTimestamp("created_at")==null?null:rs.getTimestamp("created_at").toLocalDateTime(),
                                            rs.getTimestamp("paid_at")==null?null:rs.getTimestamp("paid_at").toLocalDateTime(),
                                            rs.getString("note"));
                list.add(invoice);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return list.isEmpty() ? null : list.get(0);
    }
    
    public static void main(String[] args) {
        Invoice invoice = getInvoiceByCode("INV20251019E7C504");
        System.out.println("invoice_id = "+invoice.getInvoiceId());
    }
}
