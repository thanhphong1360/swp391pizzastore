/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;

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
}
