/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dal.CategoryDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Category;

/**
 *
 * @author Dystopia
 */
@WebServlet(name = "EditCategoryServlet", urlPatterns = {"/manager/EditCategoryServlet"})
public class EditCategoryServlet extends HttpServlet {

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
            out.println("<title>Servlet EditCategoryServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditCategoryServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session.getAttribute("user") != null) {
            int idStr = Integer.parseInt(request.getParameter("id_edit_cate"));
            //System.out.println(idStr);
            CategoryDAO cDAO = new CategoryDAO();
            Category c;
            try {
                c = cDAO.getCategoryById(idStr);
                System.out.println(c);
                request.setAttribute("c_edit", c);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/View/manager/EditCate.jsp");
                dispatcher.forward(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(EditCategoryServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session.getAttribute("user") != null) {
            int id = Integer.parseInt(request.getParameter("edit_cate_id"));
            String cate = request.getParameter("edit_cate_name").trim();
            String des = request.getParameter("edit_cate_des").trim();
            String status = request.getParameter("edit_cate_status");

            String errorMsg = null;

            if (cate == null || cate.isEmpty()) {
                errorMsg = "Vui lòng nhập đủ tên danh mục";
            } else if (cate.length() < 2 || cate.length() > 100) {
                errorMsg = "Tên danh mục tối thiểu 2 kí tự và tối đa 100 kí tự.";
            }

            if (des == null || des.isEmpty()) {
                errorMsg = "Vui lòng nhập đủ mô tả cho danh mục";
            } else if (des.length() < 2 || des.length() > 250) {
                errorMsg = "Mô tả danh mục tối thiểu 2 kí tự và tối đa 250 kí tự.";
            }

            if (!status.equals("available") && !status.equals("unavailable")) {
                errorMsg = "Vui lòng chọn trạng thái danh mục.";
            }

            if (errorMsg != null) {
                request.setAttribute("errorMsg", errorMsg);
                request.setAttribute("oldName", cate);
                request.setAttribute("oldDes", des);
                request.setAttribute("oldStatus", status);
                request.setAttribute("categoryId", id);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/View/manager/EditCate.jsp");
                dispatcher.forward(request, response);
                return;
            }

            Category c = new Category(id, cate, des, status);
            CategoryDAO cDAO = new CategoryDAO();
            try {
                int row = cDAO.editCategory(c);
                response.sendRedirect(request.getContextPath() + "/manager/ListCategoryServlet");
            } catch (SQLException ex) {
                Logger.getLogger(EditCategoryServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
