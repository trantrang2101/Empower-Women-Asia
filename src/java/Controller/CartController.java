/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.CartDAO;
import DAO.ProductDAO;
import entity.Cart;
import entity.Customer;
import entity.Product;
import java.io.IOException;
import java.util.ArrayList;
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
public class CartController extends HttpServlet {

    private static final String INVALID = "invalid.jsp";

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
        String url = INVALID;
        HttpSession session = request.getSession();
        try {
            String action = request.getParameter("action");
            List<Cart> cart = (List) session.getAttribute("CART");
            ProductDAO dao = new ProductDAO();
            CartDAO cartDAO = new CartDAO();
            int productID = Integer.parseInt(request.getParameter("productID"));
            Customer cus = (Customer) session.getAttribute("CUSTOMER");
            String customerID = "";
            if (cus!=null) {
                customerID=cus.getID();
            }
            if (action == null) {
                url = "ProductController";
            } else {
                if (action.equalsIgnoreCase("add")) {
                    Product p = dao.getProduct(productID);
                    try {
                        int quantity = 1;
                        if (cart == null) {
                            cart = new ArrayList<>();
                        }
                        if (quantity <= p.getQuantity()) {
                            boolean exist = false;
                            for (Cart c : cart) {
                                if (c.getProductID() == productID) {
                                    c.setQuantity(c.getQuantity() + quantity);
                                    exist = true;
                                    break;
                                }
                            }
                            if (!exist) {
                                if (customerID != null && !customerID.isEmpty()) {
                                    Cart x = new Cart(customerID, productID, quantity);
                                    boolean check = cartDAO.addCart(x);
                                    if (check) {
                                        cart.add(x);
                                    }
                                } else {
                                    cart.add(new Cart(customerID, productID, quantity));
                                }
                                List<Product> list = (List) session.getAttribute("CART_PRODUCTS");
                                if (list == null) {
                                    list = new ArrayList<>();
                                    session.setAttribute("TOTAL_CART", 0);
                                }
                                List<Boolean> check = (List) session.getAttribute("CART_CHECK");
                                if (check == null) {
                                    check = new ArrayList<>();
                                }
                                check.add(false);
                                p.setQuantity(quantity);
                                list.add(p);
                                session.setAttribute("CART_CHECK", check);
                                session.setAttribute("CART_PRODUCTS", list);
                            }
                            session.setAttribute("CART", cart);
                            String previous = request.getParameter("previous");
                            if (previous == null || "".equals(previous)) {
                                url = "ProductController";
                            } else {
                                url = previous;
                            }
                        } else {
                            request.setAttribute("ERROR", p.getName() + " has only maximum " + p.getQuantity() + " in store.");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                } else if (action.equalsIgnoreCase("Remove")) {
                    boolean check = false;
                    if (customerID != null && !customerID.isEmpty()) {
                        for (Cart c : cart) {
                            if (c.getProductID() == productID) {
                                check = cartDAO.deleteCart(c);
                                if (check) {
                                    check = cart.remove(c);
                                    break;
                                }
                            }
                        }
                    } else {
                        check = true;
                    }
                    if (check) {
                        int total = (int) session.getAttribute("TOTAL_CART");
                        List<Product> list = (List<Product>) session.getAttribute("CART_PRODUCTS");
                        List<Product> chooseCart = (List) session.getAttribute("CHOOSE_CART");
                        List<Boolean> listCheck = (List) session.getAttribute("CART_CHECK");
                        if (chooseCart != null) {
                            for (Product product : chooseCart) {
                                if (product.getID() == productID) {
                                    total -= product.getQuantity() * product.getPrice();
                                    chooseCart.remove(product);
                                    session.setAttribute("TOTAL_CART", total);
                                    session.setAttribute("CHOOSE_CART", list);
                                    break;
                                }
                            }
                        }
                        for (int i = 0; i < list.size(); i++) {
                            Product product = list.get(i);
                            if (product.getID() == productID) {
                                listCheck.remove(i);
                                list.remove(product);
                                break;
                            }
                        }
                        session.setAttribute("CART_PRODUCTS", list);
                        url = "cart.jsp";
                    }
                } else if (action.equalsIgnoreCase("Update")) {
                    Product p = dao.getProduct(productID);
                    boolean check = false;
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    if (quantity > p.getQuantity()) {
                        request.setAttribute("ERROR", p.getName() + " has only maximum " + p.getQuantity() + " in store.");
                    } else {
                        if (customerID != null && !customerID.isEmpty()) {
                            for (Cart c : cart) {
                                if (c.getProductID() == productID) {
                                    c.setQuantity(quantity);
                                    check = cartDAO.updateQuantity(c);
                                }
                            }
                        } else {
                            check = true;
                        }
                        if (check) {
                            int total = (int) session.getAttribute("TOTAL_CART");
                            List<Product> list = (List<Product>) session.getAttribute("CART_PRODUCTS");
                            List<Product> chooseCart = (List) session.getAttribute("CHOOSE_CART");
                            if (chooseCart != null) {
                                for (Product product : chooseCart) {
                                    if (product.getID() == productID) {
                                        total += (quantity - product.getQuantity()) * product.getPrice();
                                        product.setQuantity(quantity);
                                        session.setAttribute("CHOOSE_CART", list);
                                        session.setAttribute("TOTAL_CART", total);
                                        break;
                                    }
                                }
                            }
                            for (Product product : list) {
                                if (product.getID() == productID) {
                                    product.setQuantity(quantity);
                                    break;
                                }
                            }
                            
                            session.setAttribute("CART", cart);
                            session.setAttribute("CART_PRODUCTS", list);
                        }
                    }
                    url = "cart.jsp";
                } else if (action.equalsIgnoreCase("check")) {
                    boolean get = request.getParameter("get") != null && request.getParameter("get").equals("on");
                    int total = (int) session.getAttribute("TOTAL_CART");
                    List<Product> chooseCart = (List) session.getAttribute("CHOOSE_CART");
                    List<Boolean> check = (List) session.getAttribute("CART_CHECK");
                    boolean exist = false;
                    if (chooseCart != null) {
                        for (Product product : chooseCart) {
                            if (product.getID() == productID) {
                                exist = true;
                                break;
                            }
                        }
                    } else {
                        chooseCart = new ArrayList<>();
                    }
                    if (get) {
                        if (!exist) {
                            List<Product> list = (List<Product>) session.getAttribute("CART_PRODUCTS");
                            for (int i = 0; i < list.size(); i++) {
                                Product product = list.get(i);
                                if (product.getID() == productID) {
                                    chooseCart.add(product);
                                    total += product.getPrice() * product.getQuantity();
                                    check.set(i, true);
                                    break;
                                }
                            }
                            session.setAttribute("TOTAL_CART", total);
                            session.setAttribute("CHOOSE_CART", chooseCart);
                        }
                    } else {
                        List<Product> list = (List<Product>) session.getAttribute("CART_PRODUCTS");
                        for (int i = 0; i < list.size(); i++) {
                            Product product = list.get(i);
                            if (product.getID() == productID) {
                                chooseCart.remove(product);
                                total -= product.getPrice() * product.getQuantity();
                                check.set(i, false);
                                break;
                            }
                        }
                        session.setAttribute("TOTAL_CART", total);
                        session.setAttribute("CHOOSE_CART", chooseCart);
                    }
                    url = "cart.jsp";
                }else if (action.equalsIgnoreCase("Checkout")) {
                    
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {

            request.getRequestDispatcher(url).forward(request, response);
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
