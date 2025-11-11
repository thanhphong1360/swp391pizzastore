/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
                        rs.getTimestamp("created_at") == null ? null : rs.getTimestamp("created_at").toLocalDateTime(),
                        rs.getTimestamp("paid_at") == null ? null : rs.getTimestamp("paid_at").toLocalDateTime(),
                        rs.getString("note"));
                list.add(invoice);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return list.isEmpty() ? null : list.get(0);
    }

    public static Invoice getPendingInvoiceByTableId(int tableId) {
        ArrayList<Invoice> list = new ArrayList<>();
        DBContext dbc = DBContext.getInstance();
        String sql = """
                     SELECT TOP 1 i.*
                                          FROM Invoices i
                                          JOIN InvoiceTables it ON i.invoice_id = it.invoice_id
                                          WHERE it.table_id = ?
                                            AND i.status = 'pending'
                                          ORDER BY i.created_at DESC;
                     """;
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setInt(1, tableId);
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
                        rs.getTimestamp("created_at") == null ? null : rs.getTimestamp("created_at").toLocalDateTime(),
                        rs.getTimestamp("paid_at") == null ? null : rs.getTimestamp("paid_at").toLocalDateTime(),
                        rs.getString("note"));
                list.add(invoice);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return list.isEmpty() ? null : list.get(0);
    }
    
    public static ArrayList<Invoice> getInvoicesByStatusCashier(String status) {
        ArrayList<Invoice> list = new ArrayList<>();
        DBContext dbc = DBContext.getInstance();
        String sql = """
                     SELECT i.invoice_id, i.invoice_code, i.status, i.price, i.created_at, STRING_AGG(t.table_number, ', ') AS table_numbers 
                     	 FROM Invoices i JOIN InvoiceTables it ON i.invoice_id = it.invoice_id 
                     					JOIN RestaurantTables t ON it.table_id = t.table_id 
                     					WHERE i.status = ? 
                     					GROUP BY i.invoice_id, i.invoice_code, i.status, i.price, i.created_at 
                     					ORDER BY i.created_at DESC
                     """;
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setString(1, status);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Invoice invoice = new Invoice();
                invoice.setInvoiceId(rs.getInt("invoice_id"));
                invoice.setInvoiceCode(rs.getString("invoice_code"));
                invoice.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                invoice.setTableNumbers(rs.getString("table_numbers"));
                invoice.setStatus(rs.getString("status"));
                list.add(invoice);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return list.isEmpty() ? null : list;
    }
    
    public static Invoice updateInvoicePrice(Invoice invoice) {
        DBContext dbc = DBContext.getInstance();
        int rs = 0;
        String sql = """
        UPDATE [dbo].[Invoices] 
        SET price = ?
        WHERE invoice_id = ?
    """;
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setBigDecimal(1, invoice.getPrice());
            statement.setInt(2, invoice.getInvoiceId());
            rs = statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return rs == 0 ? null : invoice;
    }
    
    public static Invoice updateInvoiceFinalPrice(Invoice invoice) {
        DBContext dbc = DBContext.getInstance();
        int rs = 0;
        String sql = """
        UPDATE [dbo].[Invoices] 
        SET final_price = ?
        WHERE invoice_id = ?
    """;
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setBigDecimal(1, invoice.getFinalPrice());
            statement.setInt(2, invoice.getInvoiceId());
            rs = statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return rs == 0 ? null : invoice;
    }
    
    public static Invoice getInvoiceById(int invoiceId) {
        ArrayList<Invoice> list = new ArrayList<>();
        DBContext dbc = DBContext.getInstance();
        String sql = "SELECT * FROM Invoices WHERE invoice_id = ?";
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setInt(1, invoiceId);
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
                        rs.getTimestamp("created_at") == null ? null : rs.getTimestamp("created_at").toLocalDateTime(),
                        rs.getTimestamp("paid_at") == null ? null : rs.getTimestamp("paid_at").toLocalDateTime(),
                        rs.getString("note"));
                list.add(invoice);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return list.isEmpty() ? null : list.get(0);
    }
    
    public static Invoice updateInvoiceStatus(Invoice invoice, String status) {
        DBContext dbc = DBContext.getInstance();
        int rs = 0;
        String sql = """
        UPDATE [dbo].[Invoices] 
        SET status = ?
        WHERE invoice_id = ?
    """;
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setString(1, status);
            statement.setInt(2, invoice.getInvoiceId());
            rs = statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return rs == 0 ? null : invoice;
    }

    public static void main(String[] args) {
        ArrayList<Invoice> list = getInvoicesByStatusCashier("pending");
//        for(Invoice invoice : list){
//            System.out.println(invoice.getStatus());
//        }
        Invoice invoice = getInvoiceById(8);
        System.out.println(invoice.getStatus());
    }
}
