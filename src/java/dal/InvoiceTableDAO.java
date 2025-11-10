/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.InvoiceTable;
import model.Order;
import model.Table;

/**
 *
 * @author cungp
 */
public class InvoiceTableDAO {
    public static InvoiceTable createInvoiceTable(InvoiceTable invoiceTable) {
        DBContext dbc = DBContext.getInstance();
        int rs = 0;
        String sql = """
        INSERT INTO [dbo].[InvoiceTables] (invoice_id, table_id)
        VALUES (?, ?)
        """;
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setInt(1, invoiceTable.getInvoiceId());
            statement.setInt(2, invoiceTable.getTableId());
            rs = statement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return rs == 0 ? null : invoiceTable;
    }
    
    public static ArrayList<InvoiceTable> getTableIdsByInvoiceId(int invoiceId) {
        ArrayList<InvoiceTable> list = new ArrayList<>();
        DBContext dbc = DBContext.getInstance();
        String sql = "SELECT * FROM InvoiceTables WHERE invoice_id = ?";
        try {
            PreparedStatement statement = dbc.getConnection().prepareStatement(sql);
            statement.setInt(1, invoiceId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                InvoiceTable invoiceTable = new InvoiceTable();
                invoiceTable.setInvoiceId(rs.getInt("invoice_id"));
                invoiceTable.setTableId(rs.getInt("table_id"));
                list.add(invoiceTable);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return list.isEmpty() ? null : list;
    }
    
    public static void main(String[] args) {
        ArrayList<InvoiceTable> list = getTableIdsByInvoiceId(4);
        for(InvoiceTable ivt : list){
            System.out.println(" n "+ ivt.getTableId());
        }
    }
}
