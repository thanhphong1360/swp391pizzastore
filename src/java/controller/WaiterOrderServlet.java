/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CategoryDAO;
import dal.TableDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Table;
import model.Food;
import dal.FoodDAO;
import dal.TableDAO;
import model.Order;
import dal.OrderDAO;
import model.Invoice;
import dal.InvoiceDAO;
import model.OrderFood;
import dal.OrderFoodDAO;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.List;
import model.Category;
import model.User;

/**
 *
 * @author cungp
 */
public class WaiterOrderServlet extends HttpServlet {

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
            out.println("<title>Servlet WaiterOrderServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet WaiterOrderServlet at " + request.getContextPath() + "</h1>");
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
        if ("order".equals(action)) { //form order food
            HttpSession session = request.getSession();
            int tableId = Integer.parseInt(request.getParameter("tableId"));
            Table table = TableDAO.getTableById(tableId);
            String tableNumber = table.getTableNumber();
            //search
            int categoryId = 0;
            if (request.getParameter("categoryId") != null && !request.getParameter("categoryId").isBlank()) {
                categoryId = Integer.parseInt(request.getParameter("categoryId"));
            }
            String search = request.getParameter("search");

            request.setAttribute("tableId", tableId);
            request.setAttribute("tableNumber", tableNumber);
            ArrayList<Food> foodList = FoodDAO.getFoodsSearch(categoryId, search);
            List<Category> categoryList = CategoryDAO.getAllCategory();
            //gui lai draft order
            String[] foodIds = request.getParameterValues("foodId");
            String[] quantities = request.getParameterValues("quantity");
            String[] notes = request.getParameterValues("note");
            //cap nhat draft tren session
            if (foodIds != null && quantities != null) {
                List<OrderFood> draftList = (List<OrderFood>) session.getAttribute("orderDraft_" + tableId);
                if (draftList == null) {
                    draftList = new ArrayList<>();
                }

                if (foodIds != null && quantities != null) {
                    for (int i = 0; i < foodIds.length; i++) {
                        if (foodIds[i] == null || foodIds[i].isEmpty()) {
                            continue;
                        }
                        int id = Integer.parseInt(foodIds[i]);
                        int qty = Integer.parseInt(quantities[i]);
                        String note = (notes != null && notes.length > i) ? notes[i] : "";
                        Food f = FoodDAO.getFoodById(id);

                        // Kiểm tra nếu món đã tồn tại trong draft thì cập nhật SL
                        boolean exists = false;
                        for (OrderFood of : draftList) {
                            if (of.getFoodId() == id) {
                                of.setQuantity(qty);
                                of.setNote(note);
                                exists = true;
                                break;
                            }
                        }
                        if (!exists) {
                            BigDecimal price = f.getPrice();
                            OrderFood of = new OrderFood(0, id, qty, price);
                            of.setFoodName(f.getName());
                            of.setNote(note);
                            draftList.add(of);
                        }
                    }
                    session.setAttribute("orderDraft_" + tableId, draftList);
                }

                //gui draft den order view
                List<OrderFood> draft = (List<OrderFood>) session.getAttribute("orderDraft_" + tableId);
                request.setAttribute("draft", draft);
            }
            //gui danh sach completed/rejected foods
            Order order = OrderDAO.getPendingOrderByTableId(tableId);
            ArrayList<OrderFood> doneFoods = new ArrayList<>();
            ArrayList<OrderFood> doingFoods = OrderFoodDAO.getOrderFoodsByOrderIdAndStatus(order.getOrderId(), "doing");
            ArrayList<OrderFood> completedFoods = OrderFoodDAO.getOrderFoodsByOrderIdAndStatus(order.getOrderId(), "completed");
            ArrayList<OrderFood> rejectedFoods = OrderFoodDAO.getOrderFoodsByOrderIdAndStatus(order.getOrderId(), "rejected");
            if (doingFoods != null) {
                doneFoods.addAll(doingFoods);
                for (OrderFood orderFood : doneFoods) {
                    orderFood.includeFood();
                }
            }
            if (completedFoods != null) {
                doneFoods.addAll(completedFoods);
                for (OrderFood orderFood : doneFoods) {
                    orderFood.includeFood();
                }
            }
            if (rejectedFoods != null) {
                doneFoods.addAll(rejectedFoods);
                for (OrderFood orderFood : doneFoods) {
                    orderFood.includeFood();
                }
            }
            request.setAttribute("doneFoods", doneFoods);
            //gui danh sach pending foods
            ArrayList<OrderFood> pendingFoods = OrderFoodDAO.getOrderFoodsByOrderIdAndStatus(order.getOrderId(), "pending");
            if (pendingFoods != null) {
                for (OrderFood orderFood : pendingFoods) {
                    orderFood.includeFood();
                }
            }
            request.setAttribute("pendingFoods", pendingFoods);
            //gui danh sach menu
            request.setAttribute("foodList", foodList);
            request.setAttribute("categoryList", categoryList);
            request.getRequestDispatcher("/WEB-INF/View/Waiter/WaiterOrderFood.jsp").forward(request, response);

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
        if ("sendOrder".equals(action)) {
            request.setCharacterEncoding("UTF-8");
            HttpSession session = request.getSession();
            User waiter = (User) session.getAttribute("user");

            // 1. Lấy tableId an toàn
            String tableIdStr = request.getParameter("tableId");
            if (tableIdStr == null || tableIdStr.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu tableId");
                return;
            }
            int tableId = Integer.parseInt(tableIdStr);

            // order pending
            Order order = OrderDAO.getPendingOrderByTableId(tableId);

            // 4. Nhận danh sách món
            String[] foodIds = request.getParameterValues("foodId");
            String[] quantities = request.getParameterValues("quantity");
            String[] notes = request.getParameterValues("note");

            if (foodIds == null || quantities == null) {
                request.setAttribute("notification", "Không có món nào được gửi!");
            } else {
                BigDecimal orderPrice = BigDecimal.ZERO;

                for (int i = 0; i < foodIds.length; i++) {
                    if (foodIds[i] == null || foodIds[i].isEmpty()) {
                        continue;
                    }

                    int foodId = Integer.parseInt(foodIds[i]);
                    int qty = Integer.parseInt(quantities[i]);
                    String note = (notes != null && notes.length > i && notes[i] != null) ? notes[i] : "";

                    Food food = FoodDAO.getFoodById(foodId);
                    BigDecimal price = food.getPrice().multiply(new BigDecimal(qty));

                    orderPrice = orderPrice.add(price);

                    OrderFood orderFood = new OrderFood();
                    orderFood.setOrderId(order.getOrderId());
                    orderFood.setFoodId(foodId);
                    orderFood.setQuantity(qty);
                    orderFood.setPrice(food.getPrice());
                    orderFood.setNote(note);

                    OrderFoodDAO.createOrderFood(orderFood);
                }

                // 5. Cập nhật tổng tiền
                order.setPrice(orderPrice);
                OrderDAO.updateOrderPrice(order);
                request.setAttribute("notification", "Gửi order thành công!");
            }
            //gui danh sach done foods
            ArrayList<OrderFood> doneFoods = OrderFoodDAO.getOrderFoodsByOrderIdAndStatus(order.getOrderId(), "completed");
            if (doneFoods != null) {
                doneFoods.addAll(OrderFoodDAO.getOrderFoodsByOrderIdAndStatus(order.getOrderId(), "rejected"));
                for (OrderFood orderFood : doneFoods) {
                    orderFood.includeFood();
                }
            }
            request.setAttribute("doneFoods", doneFoods);
            //gui danh sach pending foods
            ArrayList<OrderFood> pendingFoods = OrderFoodDAO.getOrderFoodsByOrderIdAndStatus(order.getOrderId(), "pending");
            if (pendingFoods != null) {
                for (OrderFood orderFood : pendingFoods) {
                    orderFood.includeFood();
                }
            }
            request.setAttribute("pendingFoods", pendingFoods);
            // 6. Quay lại trang order JSP
            List<Category> categoryList = CategoryDAO.getAllCategory();
            ArrayList<Food> foodList = FoodDAO.getFoodsSearch(0, "");

            request.setAttribute("foodList", foodList);
            request.setAttribute("categoryList", categoryList);
            request.setAttribute("tableId", tableId);

            request.getRequestDispatcher("/WEB-INF/View/Waiter/WaiterOrderFood.jsp").forward(request, response);
        } else if ("updatePending".equals(action)) {
            request.setCharacterEncoding("UTF-8");

            HttpSession session = request.getSession();
            User waiter = (User) session.getAttribute("user");

            int tableId = Integer.parseInt(request.getParameter("tableId"));

            // Lấy order pending của bàn này
            Order order = OrderDAO.getPendingOrderByTableId(tableId);
            if (order == null) {
                request.setAttribute("notification", "Không tìm thấy order đang chờ của bàn này!");
                request.getRequestDispatcher("/WEB-INF/View/Waiter/WaiterOrderFood.jsp").forward(request, response);
                return;
            }

            // Lấy danh sách orderFood hiện có trong order này
            ArrayList<OrderFood> orderFoods = OrderFoodDAO.getOrderFoodsByOrderId(order.getOrderId());
            BigDecimal totalPrice = BigDecimal.ZERO;

            for (OrderFood of : orderFoods) {
                int orderFoodId = of.getOrderFoodId();

                // Nếu người dùng tick chọn xóa
                if (request.getParameter("remove_" + orderFoodId) != null) {
                    // Xóa món
                    OrderFoodDAO.deleteOrderFood(orderFoodId);
                    continue;
                }

                // Lấy số lượng mới (nếu có)
                String qtyStr = request.getParameter("quantity_" + orderFoodId);
                if (qtyStr != null && !qtyStr.isEmpty()) {
                    int newQty = Integer.parseInt(qtyStr);

                    // Cập nhật số lượng và giá
                    Food food = FoodDAO.getFoodById(of.getFoodId());
                    BigDecimal newPrice = food.getPrice().multiply(BigDecimal.valueOf(newQty));

                    of.setQuantity(newQty);
                    of.setPrice(food.getPrice()); // giá từng món
                    OrderFoodDAO.updateOrderFoodQuantity(of);

                    // Cộng vào tổng tiền order
                    totalPrice = totalPrice.add(newPrice);
                }
            }

            // Cập nhật lại tổng giá order
            order.setPrice(totalPrice);
            OrderDAO.updateOrderPrice(order);

            // Gửi lại dữ liệu cho JSP
            ArrayList<OrderFood> doneFoods = OrderFoodDAO.getOrderFoodsByOrderIdAndStatus(order.getOrderId(), "completed");
            if (doneFoods != null) {
                doneFoods.addAll(OrderFoodDAO.getOrderFoodsByOrderIdAndStatus(order.getOrderId(), "rejected"));
                for (OrderFood orderFood : doneFoods) {
                    orderFood.includeFood();
                }
            }
            request.setAttribute("doneFoods", doneFoods);
            ArrayList<OrderFood> pendingFoods = OrderFoodDAO.getOrderFoodsByOrderIdAndStatus(order.getOrderId(), "pending");
            if (pendingFoods != null) {
                for (OrderFood orderFood : pendingFoods) {
                    orderFood.includeFood();
                }
            }
            request.setAttribute("pendingFoods", pendingFoods);
            List<Category> categoryList = CategoryDAO.getAllCategory();
            ArrayList<Food> foodList = FoodDAO.getFoodsSearch(0, "");

            request.setAttribute("categoryList", categoryList);
            request.setAttribute("foodList", foodList);
            request.setAttribute("tableId", tableId);
            request.setAttribute("notification", "Cập nhật order thành công!");

            request.getRequestDispatcher("/WEB-INF/View/Waiter/WaiterOrderFood.jsp").forward(request, response);
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
