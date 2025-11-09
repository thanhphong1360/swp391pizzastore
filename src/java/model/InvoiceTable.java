/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author cungp
 */
public class InvoiceTable {
    private int invoiceId;
    private int tableId;

    public InvoiceTable() {
    }

    public InvoiceTable(int invoiceId, int tableId) {
        this.invoiceId = invoiceId;
        this.tableId = tableId;
    }

    public int getInvoiceId() {
        return invoiceId;
    }

    public void setInvoiceId(int invoiceId) {
        this.invoiceId = invoiceId;
    }

    public int getTableId() {
        return tableId;
    }

    public void setTableId(int tableId) {
        this.tableId = tableId;
    }
    
    
}
