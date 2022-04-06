/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.CartDAO;
import DAO.OrderDAO;
import DAO.ProductDAO;
import entity.Cart;
import entity.Order;
import entity.OrderDetail;
import entity.Product;
import entity.Timeline;
import entity.User;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Tran Trang
 */
public class OrderController extends HttpServlet {

    private static final String ERROR = "invalid.jsp";

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
        String action = request.getParameter("action");
        String url = ERROR;
        HttpSession session = request.getSession();
        OrderDAO dao = new OrderDAO();
        ProductDAO prDAO = new ProductDAO();
        CartDAO cartDAO = new CartDAO();
        List<Timeline> timeline = (List<Timeline>) session.getAttribute("TIMELINE");
        if (timeline == null) {
            timeline = new ArrayList<>();
        }
        try {
            if (action.equalsIgnoreCase("Detail")) {
                int orderID = Integer.parseInt(request.getParameter("orderID"));
                List<Order> list = (List<Order>) session.getAttribute("ORDER_LIST");
                for (Order x : list) {
                    if (x.getID() == orderID) {
                        List<Product> test = new ArrayList<>();
                        for (OrderDetail detail : x.getList()) {
                            Product p = prDAO.getProduct(detail.getProductID());
                            p.setQuantity(detail.getQuantity());
                            if (p != null) {
                                test.add(p);
                            }
                        }
                        session.setAttribute("PRODUCT_ORDER", test);
                        session.setAttribute("ORDER_CHOOSE", x);
                        url = "invoice.jsp";
                        break;
                    }
                }
            } else if (action.equals("Checkout")) {
                String userID = request.getParameter("userID");
                String name = request.getParameter("FullName");
                String address = request.getParameter("Address");
                String phone = request.getParameter("Phone");
                String country = request.getParameter("Country");
                String region = request.getParameter("Region");
                String postalCode = request.getParameter("Zip");
                String pay = request.getParameter("payment");
                String note = request.getParameter("Note");
                Boolean prepay = !pay.equalsIgnoreCase("cod");
                List<OrderDetail> list = new ArrayList<>();
                Order o = new Order(0, userID, name, new SimpleDateFormat("yyyy-MM-dd").format(new Date()), address, region, postalCode, country, phone, note, prepay, false, 1, list, "");
                List<Product> chooseCart = (List) session.getAttribute("CHOOSE_CART");
                List<Cart> cart = (List) session.getAttribute("CART");
                List<Product> listCart = (List) session.getAttribute("CART_PRODUCTS");
                if (chooseCart != null) {
                    int orderID = dao.createNewShopping(o);
                    if (orderID >= 0) {
                        o.setOrderDate(new SimpleDateFormat("dd MMM,yyyy").format(new SimpleDateFormat("yyyy-MM-dd").parse(o.getOrderDate())));
                        o.setID(orderID);
                        boolean check = false;
                        for (int i = 0; i < chooseCart.size(); i++) {
                            Product p = chooseCart.get(i);
                            Product product = prDAO.getProduct(p.getID());
                            if (dao.createOrderDetail(orderID, p) && prDAO.updateQuantity(product, p.getQuantity())) {
                                if (product.getQuantity() - p.getQuantity() == 0) {
                                    if (prDAO.deleteProduct(p.getID())) {
                                        List<Product> productList = (List<Product>) session.getAttribute("PRODUCT_LIST");
                                        if (productList != null) {
                                            for (Product pro : productList) {
                                                if (pro.getID() == p.getID()) {
                                                    pro.setStatus(false);
                                                    break;
                                                }
                                            }
                                        }
                                        session.setAttribute("PRODUCT_LIST", productList);
                                    }
                                }
                                list.add(new OrderDetail(orderID, p.getID(), p.getQuantity(), p.getPrice()));
                                Cart obj = new Cart(userID, p.getID(), p.getQuantity());
                                if (cartDAO.checkCart(obj)) {
                                    check = cartDAO.deleteCart(obj);
                                    if (check) {
                                        for (Cart c : cart) {
                                            if (c.getProductID() == p.getID()) {
                                                check = cart.remove(c);
                                                break;
                                            }
                                        }
                                    }
                                } 
                                for (Product pro : listCart) {
                                    if (pro.getID() == p.getID()) {
                                        check = listCart.remove(pro);
                                        break;
                                    }
                                }
                            }
                            if (!check) {
                                break;
                            }
                        }
                        if (check) {
                            url = "OrderController?orderID=" + orderID + "&action=Detail";
                            List<Order> order = (List<Order>) session.getAttribute("ORDER_LIST");
                            if (order == null) {
                                order = new ArrayList<>();
                            }
                            order.add(o);
                            session.setAttribute("ORDER_LIST", order);
                            session.setAttribute("CART", cart);
                            session.setAttribute("CHOOSE_CART", null);
                            session.setAttribute("TOTAL_CART", 0);
                        }
                        timeline.add(new Timeline(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()), "New order checkout! Order #" + orderID + " is checkout!"));
                    }
                }
            }else if (action.equalsIgnoreCase("cancelBill")) {
                int orderID = Integer.parseInt(request.getParameter("orderID"));
                boolean check = dao.deleteOrder(orderID);
                if (check) {
                    url="home.jsp";
                }else{
                    url="user.jsp";
                }
            }  else if (action.equalsIgnoreCase("Update")) {
                int orderID = Integer.parseInt(request.getParameter("orderID"));
                boolean checkPay = request.getParameter("checkPay") != null && request.getParameter("checkPay").equals("on");
                int done = (request.getParameter("done") != null && request.getParameter("done").equals("on"))?1:0;
                boolean check = dao.updateOrder(orderID, checkPay, done);
                if (check) {
                    List<Order> list = (List<Order>) session.getAttribute("ORDER_LIST");
                    for (Order x : list) {
                        if (x.getID() == orderID) {
                            x.setCheckpay(checkPay);
                            x.setDone(2);
                            break;
                        }
                    }
                    timeline.add(new Timeline(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()), "An order changed! Order #" + orderID + " is changed!"));
                    session.setAttribute("ORDER_LIST", list);
                }
                url = "adminBill.jsp";
            } else {
                User loginUser = (User) session.getAttribute("LOGIN_USER");
                List<Order> order = dao.getOrder();
                int total[] = new int[12];
                int sum = 0;
                for (Order t : order) {
                    Date date = new Date();
                    Date orderDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(t.getOrderDate());
                    if (date.getYear() == orderDate.getYear()) {
                        for (OrderDetail oD : t.getList()) {
                            total[orderDate.getMonth()] += oD.getPrice() * oD.getQuantity();
                        }
                        timeline.add(new Timeline(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(orderDate), "New order checkout! Order #" + t.getID() + " is checkouted!"));
                        t.setOrderDate(new SimpleDateFormat("dd MMM,yyyy").format(orderDate));
                        if (t.getUpdateAt() != null && !t.getUpdateAt().isEmpty()) {
                            timeline.add(new Timeline(t.getUpdateAt(), "An order updated! Order #" + t.getID() + " is updated!"));
                        }
                    }
                }
                for (int i = 0; i < 12; i++) {
                    sum += total[i];
                }
                String get = String.format("%,d", sum);
                session.setAttribute("LINE_CHART", total);
                session.setAttribute("ORDER_LIST", order);
                session.setAttribute("ORDER_TOTAL", get);
                if (loginUser.getRoleID().equalsIgnoreCase("AD")) {
                    String previous = (String) session.getAttribute("PREVIOUS");
                    url = previous == null ? "adminBlogs.jsp" : previous;
                    session.setAttribute("PREVIOUS", null);
                } else {
                    url = "user.jsp";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            bubbleSort(timeline);
            session.setAttribute("TIMELINE", timeline);
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    private void bubbleSort(List<Timeline> arr) {
        int n = arr.size();
        boolean check = false;
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (arr.get(j).getRecord() > arr.get(j + 1).getRecord()) {
                    swap(arr, j, j + 1);
                    check = true;
                }
            }
            if (check == false) {
                break;
            }
        }
    }

    private void swap(List<Timeline> arr, int i, int min_index) {
        Timeline temp = arr.get(min_index);
        arr.set(min_index, arr.get(i));
        arr.set(i, temp);
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
        processRequest(request, response);
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
        processRequest(request, response);
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
