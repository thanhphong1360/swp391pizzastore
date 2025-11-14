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

/**
 *
 * @author HP
 */
@WebServlet(name = "AddTableServlet", urlPatterns = {"/manager/table/add"})
public class AddTableServlet extends HttpServlet {

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
            out.println("<title>Servlet AddTableServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddTableServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("/WEB-INF/View/manager/table/add-table.jsp").forward(request, response);
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
        String number = request.getParameter("table_number");
        String capacityStr = request.getParameter("capacity");
        String status = request.getParameter("status");
        String location = request.getParameter("location");

        // === VALIDATION ===
        if (number == null || number.trim().isEmpty()
                || capacityStr == null || capacityStr.trim().isEmpty()) {

            request.setAttribute("error", "Vui lòng điền đầy đủ các trường bắt buộc.");
            request.setAttribute("param", request.getParameterMap()); // giữ lại dữ liệu đã nhập
            request.getRequestDispatcher("/WEB-INF/View/manager/table/add-table.jsp").forward(request, response);
            return;
        }

        try {
            int capacity = Integer.parseInt(capacityStr);

            if (capacity <= 0) {
                request.setAttribute("error", "Sức chứa phải lớn hơn 0.");
                request.setAttribute("param", request.getParameterMap());
                request.getRequestDispatcher("/WEB-INF/View/manager/table/add-table.jsp").forward(request, response);
                return;
            }

            // Tạo đối tượng bàn mới
            RestaurantTable t = new RestaurantTable(
                    0,
                    number.trim(),
                    capacity,
                    status != null && !status.isEmpty() ? status : "Available",
                    location != null ? location.trim() : ""
            );

            TableDAO dao = new TableDAO();
            boolean added = dao.addTable(t); 

            if (added) {
                response.sendRedirect(request.getContextPath() + "/manager/table/list?msg=added");
            } else {
                response.sendRedirect(request.getContextPath() + "/manager/table/list?error=add_failed");
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Sức chứa phải là một số hợp lệ.");
            request.setAttribute("param", request.getParameterMap());
            request.getRequestDispatcher("/WEB-INF/View/manager/table/add-table.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/manager/table/list?error=exception");
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
