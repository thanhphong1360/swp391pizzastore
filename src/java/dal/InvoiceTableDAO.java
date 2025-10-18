/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import model.InvoiceTable;

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
}
