/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.CartDAO;
import DAO.OrderDAO;
import DAO.ProductDAO;
import DAO.UserDAO;
import entity.Blog;
import entity.Cart;
import entity.Category;
import entity.Customer;
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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Tran Trang
 */
public class UserController extends HttpServlet {

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
        String url = ERROR;
        String error = "";
        HttpSession session = request.getSession();
        List<Timeline> timeline = (List<Timeline>) session.getAttribute("TIMELINE");
        if (timeline == null) {
            timeline = new ArrayList<>();
        }
        try {
            String action = request.getParameter("action");
            String userID = request.getParameter("userID");
            CartDAO cartDAO = new CartDAO();
            UserDAO dao = new UserDAO();
            OrderDAO orderDAO = new OrderDAO();
            if (action.equals("Login")) {
                String password = request.getParameter("password");
                User user = dao.login(userID, password);
                if (user != null) {
                    session.setAttribute("LOGIN_USER", user);
                    if ("AD".equalsIgnoreCase(user.getRoleID())) {
                        List<User> list = dao.getListUser();
                        for (User u : list) {
                            timeline.add(new Timeline(u.getCreateAt(), "New User regeisted! User #" + u.getUserID() + " is welcome!"));
                            u.setCreateAt(new SimpleDateFormat("dd MMM,yyyy").format(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").parse(u.getCreateAt())));
                            if (u.getUpdateAt() != null && !u.getUpdateAt().isEmpty()) {
                                timeline.add(new Timeline(u.getUpdateAt(), "An user has changed! User #" + u.getUserID() + " is changed!"));
                            }
                        }
                        session.setAttribute("LIST_USER", list);
                        session.setAttribute("PREVIOUS", "admin.jsp");
                        url = "ProductController";
                    } else if ("US".equalsIgnoreCase(user.getRoleID())) {
                        Customer cus = dao.getCus(userID);
                        List<Cart> listCart = cartDAO.getListCart(userID);
                        List<Product> listWish = new ArrayList<>();
                        List<Boolean> check = new ArrayList<>();
                        if (listCart == null) {
                            listCart = new ArrayList<>();
                        } else {
                            ProductDAO prDAO = new ProductDAO();
                            for (Cart cart : listCart) {
                                Product p = prDAO.getProduct(cart.getProductID());
                                if (p.getQuantity() - cart.getQuantity() <= 0) {
                                    if (cartDAO.deleteCart(cart)) {
                                        listCart.remove(cart);
                                    }
                                } else {
                                    p.setQuantity(cart.getQuantity());
                                    listWish.add(p);
                                }
                                check.add(false);
                            }
                        }
                        session.setAttribute("CART_CHECK", check);
                        session.setAttribute("CART_PRODUCTS", listWish);
                        session.setAttribute("CART", listCart);
                        session.setAttribute("TOTAL_CART", 0);
                        session.setAttribute("CUSTOMER", cus);
                        List<Order> list = orderDAO.getOrder(userID);
                        session.setAttribute("ORDER_LIST", list);
                        String previous = request.getParameter("previous");
                        if (previous == null) {
                            url = "CategoryController";
                        } else {
                            url = previous;
                        }
                    } else {
                        error = "Your role is not support";
                    }
                } else {
                    error = "Incorrect userID or Password";
                    url = "signin.jsp";
                }
            } else if (action.equalsIgnoreCase("Logout")) {
                if (session != null) {
                    session.invalidate();
                    session = request.getSession();
                    url = "CategoryController";
                }
            } else if (action.equalsIgnoreCase("Register")) {
                String previous = request.getParameter("page");
                String password = request.getParameter("password");
                String confirm = request.getParameter("confirm");
                String agreeTerm = request.getParameter("agree-term");
                boolean checkValidation = true;
                if (userID.length() < 5 || userID.length() > 20) {
                    checkValidation = false;
                    error = "UserID must be [5,10]!";
                }
                if (dao.checkDuplicate(userID)) {
                    checkValidation = false;
                    error += "<br>Have existed this UserID!";
                }
                if (!password.equals(confirm)) {
                    checkValidation = false;
                    error += "<br>Confim password is not same";
                }
                if (agreeTerm == null) {
                    checkValidation = false;
                    error += "<br>You have not agree with our terms";
                }
                if (checkValidation) {
                    User user = new User(userID, password, "US", true, "", "");
                    Customer customer = new Customer(userID, "", "", true, "", "", "", "", "");
                    boolean checkInsert = dao.insertUser(user);
                    if (checkInsert) {
                        session.setAttribute("LOGIN_USER", user);
                        session.setAttribute("CUSTOMER", customer);
                    }
                    if (previous == null) {
                        url = "user.jsp";
                    } else {
                        url = previous;
                    }
                    timeline.add(new Timeline(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()), "New User regeisted! User #" + userID + " is welcome!"));
                } else {
                    if (previous == null) {
                        url = "signup.jsp";
                    } else {
                        url = previous;
                    }
                }
            } else if (action.equalsIgnoreCase("changeInf")) {
                String fullName = request.getParameter("fullName");
                String address = request.getParameter("address");
                String phone = request.getParameter("phone");
                Boolean gender = Integer.parseInt(request.getParameter("gender")) == 1;
                String country = request.getParameter("countries");
                String region = request.getParameter("region");
                String postalCode = request.getParameter("zip");
                Customer c = new Customer(userID, fullName, null, gender, address, region, postalCode, country, phone);
                User user = (User) session.getAttribute("LOGIN_USER");
                boolean check = dao.updateInfo(c);
                if (check) {
                    c.setFullName(fullName);
                    session.setAttribute("CUSTOMER", c);
                    session.setAttribute("LOGIN_USER", user);
                    timeline.add(new Timeline(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()), "An user has changed! User #" + userID + " is changed!"));
                    url = "user.jsp";
                }
            } else if (action.equalsIgnoreCase("Delete")) {
                User loginUser = (User) session.getAttribute("LOGIN_USER");
                if (userID.equals(loginUser.getUserID())) {
                    error = "User dang login, khong the update!";
                } else {
                    boolean check = dao.deleteUser(userID);
                    if (check) {
                        List<User> list = (List<User>) session.getAttribute("LIST_USER");
                        for (User u : list) {
                            if (u.getUserID().equals(userID)) {
                                u.setStatus(false);
                                timeline.add(new Timeline(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()), "An user has deleted! User #" + userID + " is deleted!"));
                                break;
                            }
                        }
                        session.setAttribute("LIST_USER", list);
                        url = "adminUser.jsp";
                    }
                }
            } else if (action.equalsIgnoreCase("Update")) {
                User loginUser = (User) session.getAttribute("LOGIN_USER");
                if (userID.equals(loginUser.getUserID())) {
                    error = "User dang login, khong the update!";
                } else if (userID.equals("admin")) {
                    error = "Day la thang trum khong duoc update!";
                } else {
                    String roleID = request.getParameter("roleID");
                    boolean check = dao.updateUser(userID, roleID);
                    boolean change = false;
                    if (check) {
                        List<User> list = (List<User>) session.getAttribute("LIST_USER");
                        for (User u : list) {
                            if (u.getUserID().equals(userID)) {
                                if ("AD".equals(u.getRoleID()) && "US".equals(roleID)) {
                                    change = dao.removeCustomer(userID);
                                } else if ("US".equals(u.getRoleID()) && "AD".equals(roleID)) {
                                    change = dao.insertCustomer(userID);
                                }
                                if (change) {
                                    timeline.add(new Timeline(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()), "An user has changed! User #" + userID + " is changed!"));
                                    u.setRoleID(roleID);
                                }
                                break;
                            }
                        }
                        if (change) {
                            session.setAttribute("LIST_USER", list);
                            url = "adminUser.jsp";
                        }
                    }
                }
            } else if (action.equalsIgnoreCase("changePW")) {
                String currentPassword = request.getParameter("currentPassword");
                User user = (User) session.getAttribute("LOGIN_USER");
                if (user.getPassword().equals(currentPassword)) {
                    String password = request.getParameter("password");
                    String confirm = request.getParameter("confirm");
                    boolean checkValidation = true;
                    if (!password.equals(confirm)) {
                        checkValidation = false;
                        error = "Confim password is not same";
                    }
                    if (checkValidation) {
                        boolean checkChange = dao.changePassword(userID, password);
                        if (checkChange) {
                            timeline.add(new Timeline(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()), "An user has changed! User #" + userID + " is changed!"));
                            session.setAttribute("LOGIN_USER", user);
                        }
                    }
                } else {
                    error = "Wrong current password!";
                }
                url = "user.jsp";
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            bubbleSort(timeline);
            session.setAttribute("TIMELINE", timeline);
            request.setAttribute("ERROR", error);
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
