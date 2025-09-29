/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import dal.UserDAO;

import model.Role;
import dal.RoleDAO;
import util.HashUtil;

/**
 *
 * @author HP
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/Login"})
public class LoginServlet extends HttpServlet {

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
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
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
        String email = request.getParameter("username");
        String password = request.getParameter("password");
        String alertMsg = "";

        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            alertMsg = "Email and password can't be empty!";
            request.setAttribute("alert", alertMsg);
            request.getRequestDispatcher("/view/client/pages/login.jsp").forward(request, response);
            return;
        }
        
        User user = UserDAO.login(email, password);
        

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            Role role = RoleDAO.getRoleById(user.getRoleId());
            session.setAttribute("role", role.getRoleName());
            if ("Manager".equals(role.getRoleName())) {
                response.sendRedirect(request.getContextPath() + "/AdminServlet");
            } else if ("Cashier".equals(role.getRoleName())) {
                
            }else if ("Chef".equals(role.getRoleName())) {
                
            }else if ("Waiter".equals(role.getRoleName())) {
                
            }else if ("DeliveryStaff".equals(role.getRoleName())) {
                
            }else if ("Customer".equals(role.getRoleName())) {
                response.sendRedirect(request.getContextPath() + "/Home");
            }

        } else {
            alertMsg = "Email or password is not correct!";
            request.setAttribute("alert", alertMsg);
            request.getRequestDispatcher("/view/client/pages/login.jsp").forward(request, response);
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
