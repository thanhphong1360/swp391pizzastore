/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.InvoiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

import util.InvoiceCodeUtil;
import model.Invoice;
import model.Table;
import dal.TableDAO;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import model.User;
import dal.UserDAO;
import model.InvoiceTable;
import dal.InvoiceTableDAO;

/**
 *
 * @author cungp
 */
public class WaiterTableServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet WaiterTableServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet WaiterTableServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("open".equals(action)) {
            ArrayList<Table> tableList = TableDAO.getAllTable();
            request.setAttribute("tableList", tableList);
            request.getRequestDispatcher("/WEB-INF/View/Waiter/WaiterOpenTable.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("open".equals(action)) {
            //lay du lieu ve dung
            boolean isError = false;
            HttpSession session = request.getSession();
            User waiter = (User) session.getAttribute("user");
            int tableId = Integer.parseInt(request.getParameter("tableId"));
            //thay doi trang thai table
            Table tableToOpen = TableDAO.getTableById(tableId);
            tableToOpen = TableDAO.updateTableStatus(tableToOpen, "occupied");
            if(tableToOpen ==null){
                isError = true;
            }
            //tao invoice
            String invoiceCode = InvoiceCodeUtil.generateInvoiceCode();
            Invoice invoice = new Invoice();
            invoice.setInvoiceCode(invoiceCode);
            invoice.setWaiterId(waiter.getUserId());
            InvoiceDAO.createInvoice(invoice);
            if(invoice ==null){
                isError = true;
            }
            //gan table vao invoice
            int invoiceId = InvoiceDAO.getInvoiceByCode(invoiceCode).getInvoiceId();
            InvoiceTable invoiceTable = new InvoiceTable(invoiceId, tableId);
            invoiceTable = InvoiceTableDAO.createInvoiceTable(invoiceTable);
            if(invoiceTable ==null){
                isError = true;
            }
            
            if (!isError) {
                request.setAttribute("message", "Mở bàn thành công!");
            } else {
                request.setAttribute("message", "Mở bàn thất bại!");
            }
            ArrayList<Table> tableList = TableDAO.getAllTable();
            request.setAttribute("tableList", tableList);
            String contextPath = request.getContextPath();
            request.getRequestDispatcher("/WEB-INF/View/Waiter/WaiterOpenTable.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
