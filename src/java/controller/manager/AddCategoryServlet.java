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
import model.Category;

/**
 *
 * @author Dystopia
 */
@WebServlet(name = "AddCategoryServlet", urlPatterns = {"/manager/AddCategoryServlet"})
public class AddCategoryServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddCategoryServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddCategoryServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session.getAttribute("user") != null) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/View/manager/AddCate.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session.getAttribute("user") != null) {
            String cate = request.getParameter("add_cate_name");
            String des = request.getParameter("add_cate_des");
            String status = request.getParameter("add_cate_status");

            if (cate != null) {
                cate = cate.trim();
            }
            if (des != null) {
                des = des.trim();
            }

            String errorMsg = null;

            if (cate == null || cate.isEmpty()) {
                errorMsg = "Vui lòng nhập đủ tên danh mục";
            } else if (cate.length() < 2 || cate.length() > 100) {
                errorMsg = "Tên danh mục tối thiểu 2 kí tự và tối đa 100 kí tự.";
            }

            if (errorMsg == null) {
                CategoryDAO categoryDAO = new CategoryDAO();
                if (categoryDAO.checkCategoryExists(cate)) {
                    errorMsg = "Danh mục này đã tồn tại. Vui lòng chọn tên khác.";
                }
            }

            if (des == null || des.isEmpty()) {
                errorMsg = "Vui lòng nhập đủ mô tả cho danh mục";
            } else if (des.length() < 2 || des.length() > 250) {
                errorMsg = "Mô tả danh mục tối thiểu 2 kí tự và tối đa 100 kí tự.";
            }

            if (errorMsg != null) {
                request.setAttribute("errorMsg", errorMsg);
                request.setAttribute("oldName", cate);
                request.setAttribute("oldDes", des);

                RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/View/manager/AddCate.jsp");
                dispatcher.forward(request, response);
                return;
            }

            Category c = new Category(cate, des, status);

            CategoryDAO cDAO = new CategoryDAO();
            cDAO.addCategory(c);
            response.sendRedirect(request.getContextPath() + "/manager/ListCategoryServlet");
        }
    }
}
