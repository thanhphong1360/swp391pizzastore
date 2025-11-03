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
import model.Table;

/**
 *
 * @author HP
 */
@WebServlet(name = "DeleteTableServlet", urlPatterns = {"/manager/table/delete"})
public class DeleteTableServlet extends HttpServlet {

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
            out.println("<title>Servlet DeleteTableServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteTableServlet at " + request.getContextPath() + "</h1>");
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
        response.sendRedirect(request.getContextPath() + "/manager/table/list");
//        String idParam = request.getParameter("id");
//        if (idParam == null || idParam.trim().isEmpty()) {
//            response.sendRedirect(request.getContextPath() + "/manager/table/list");
//            return;
//        }
//
//        try {
//            int id = Integer.parseInt(idParam);
//            Table table = new TableDAO().getTableById(id);
//            if (table == null) {
//                request.setAttribute("error", "Table not found!");
//                request.getRequestDispatcher("/manager/table/list").forward(request, response);
//                return;
//            }
//            request.setAttribute("table", table);
//            request.getRequestDispatcher("/WEB-INF/View/manager/table/confirm-delete-table.jsp").forward(request, response);
//        } catch (NumberFormatException e) {
//            request.setAttribute("error", "Invalid Table ID.");
//            request.getRequestDispatcher("/manager/table/list").forward(request, response);
//        }
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

        // Kiểm tra ID
        if (idStr == null || idStr.trim().isEmpty()) {
            request.setAttribute("error", "Table ID is required.");
            request.getRequestDispatcher("/manager/table/list").forward(request, response);
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            new TableDAO().deleteTable(id);
            response.sendRedirect(request.getContextPath() + "/manager/table/list");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid Table ID.");
            request.getRequestDispatcher("/manager/table/list").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Failed to delete table: " + e.getMessage());
            request.getRequestDispatcher("/manager/table/list").forward(request, response);
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
