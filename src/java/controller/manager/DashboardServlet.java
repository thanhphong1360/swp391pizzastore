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
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import model.CategoryRevenue;
import model.RevenueByDate;
import model.TopFood;

/**
 *
 * @author HP
 */
@WebServlet(name = "DashboardServlet", urlPatterns = {"/manager", "/manager/", "/manager/dashboard"})
public class DashboardServlet extends HttpServlet {

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
            out.println("<title>Servlet DashboardServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DashboardServlet at " + request.getContextPath() + "</h1>");
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
        DashboardDAO dao = new DashboardDAO();

        // Tính 7 ngày gần nhất
        Calendar cal = Calendar.getInstance();
        java.sql.Date toDate = new java.sql.Date(cal.getTimeInMillis());
        cal.add(Calendar.DAY_OF_MONTH, -6);
        java.sql.Date fromDate = new java.sql.Date(cal.getTimeInMillis());

        String from = fromDate.toString();
        String to = toDate.toString();

        // Load dữ liệu
        request.setAttribute("todayRevenue", dao.getTodayRevenue());
        request.setAttribute("totalInvoices", dao.getTotalInvoicesInRange(from, to));
        request.setAttribute("totalRevenues", dao.getTotalRevenuesInRange(from, to));
        request.setAttribute("revenueByDate", dao.getRevenueByDate(from, to));
        request.setAttribute("topFoods", dao.getTopFoods(from, to, 5));
        request.setAttribute("revenueByCategory", dao.getRevenueByCategory(from, to));
        request.setAttribute("orderChannel", dao.getOrderChannelRatio(from, to));
        request.setAttribute("fromDate", from);
        request.setAttribute("toDate", to);

        request.getRequestDispatcher("/WEB-INF/View/ManagerHome.jsp").forward(request, response);
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
        doGet(request, response);
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
