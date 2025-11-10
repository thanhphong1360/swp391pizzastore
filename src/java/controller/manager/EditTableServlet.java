/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dal.TableDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.RestaurantTable;
import model.Table;

/**
 *
 * @author HP
 */
@WebServlet(name = "EditTableServlet", urlPatterns = {"/manager/table/edit"})
public class EditTableServlet extends HttpServlet {

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
            out.println("<title>Servlet EditTableServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditTableServlet at " + request.getContextPath() + "</h1>");
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
        String idParam = request.getParameter("id");
        // SỬA: Kiểm tra ID
        if (idParam == null || idParam.trim().isEmpty()) {
            request.setAttribute("error", "Table ID is required.");
            request.getRequestDispatcher("/manager/table/list").forward(request, response);
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            Table table = new TableDAO().getTableById(id);
            // SỬA: Xử lý RestaurantTable not found
            if (table == null) {
                request.setAttribute("error", "Table not found!");
                request.getRequestDispatcher("/manager/table/list").forward(request, response);
                return;
            }
            request.setAttribute("table", table);
            request.getRequestDispatcher("/WEB-INF/View/manager/table/edit-table.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid Table ID.");
            request.getRequestDispatcher("/manager/table/list").forward(request, response);
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
        String idStr = request.getParameter("table_id");
        String number = request.getParameter("table_number");
        String capacityStr = request.getParameter("capacity");
        String status = request.getParameter("status");
        String location = request.getParameter("location");

        // SỬA: Kiểm tra dữ liệu
        if (idStr == null || number == null || number.trim().isEmpty() || capacityStr == null || capacityStr.trim().isEmpty()) {
            request.setAttribute("error", "Please fill out all required fields.");
            request.getRequestDispatcher("/WEB-INF/View/manager/table/edit-table.jsp").forward(request, response);
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            int capacity = Integer.parseInt(capacityStr);
            if (capacity <= 0) {
                request.setAttribute("error", "Capacity must be positive.");
                request.getRequestDispatcher("/WEB-INF/View/manager/table/edit-table.jsp").forward(request, response);
                return;
            }

            RestaurantTable t = new RestaurantTable(id, number.trim(), capacity, status != null ? status : "Available", location);
            boolean success = new TableDAO().updateTable(t);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/manager/table/list");
            } else {
                request.setAttribute("error", "Failed to update table.");
                request.setAttribute("table", t);
                request.getRequestDispatcher("/WEB-INF/View/manager/table/edit-table.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/View/manager/table/edit-table.jsp").forward(request, response);
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
