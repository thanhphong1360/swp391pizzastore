/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dal.DashboardDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import model.CategoryRevenue;
import model.RevenueByDate;
import model.TopFood;

/**
 *
 * @author HP
 */
@WebServlet(name = "DashboardFilterServlet", urlPatterns = {"/manager/dashboard/filter"})
public class DashboardFilterServlet extends HttpServlet {

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
            out.println("<title>Servlet DashboardFilterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DashboardFilterServlet at " + request.getContextPath() + "</h1>");
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
        doPost(request, response);
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
        String from = request.getParameter("fromDate");
        String to = request.getParameter("toDate");

        // Kiểm tra hợp lệ
        if (from == null || to == null || from.isEmpty() || to.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/manager/dashboard");
            return;
        }

        // ĐẢM BẢO: from <= to
        if (from.compareTo(to) > 0) {
            request.setAttribute("error", "Ngày bắt đầu phải nhỏ hơn hoặc bằng ngày kết thúc!");
            request.getRequestDispatcher("/WEB-INF/View/manager/dashboard.jsp").forward(request, response);
            return;
        }

        DashboardDAO dao = new DashboardDAO();

        // Dữ liệu theo khoảng
        double todayRevenue = dao.getTodayRevenue();
        int totalInvoices = dao.getTotalInvoicesInRange(from, to);
        int totalCustomers = dao.getTotalCustomersInRange(from, to);
        List<RevenueByDate> revenueByDate = dao.getRevenueByDate(from, to);
        List<TopFood> topFoods = dao.getTopFoods(from, to, 5);
        List<CategoryRevenue> revenueByCategory = dao.getRevenueByCategory(from, to);
        Map<String, Integer> orderChannel = dao.getOrderChannelRatio(from, to);

        // Gửi dữ liệu
        request.setAttribute("todayRevenue", todayRevenue);
        request.setAttribute("totalInvoices", totalInvoices);
        request.setAttribute("totalCustomers", totalCustomers);
        request.setAttribute("revenueByDate", revenueByDate);
        request.setAttribute("topFoods", topFoods);
        request.setAttribute("revenueByCategory", revenueByCategory);
        request.setAttribute("orderChannel", orderChannel);
        request.setAttribute("fromDate", from);
        request.setAttribute("toDate", to);

        request.setAttribute("topFoods", topFoods);
        request.setAttribute("revenueByCategory", revenueByCategory);
        request.getRequestDispatcher("/WEB-INF/View/manager/dashboard.jsp")
                .forward(request, response);
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
