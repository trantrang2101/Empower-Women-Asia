/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.CategoryDAO;
import DAO.ProductDAO;
import entity.Category;
import entity.ImageProduct;
import entity.Product;
import entity.Timeline;
import entity.User;
import java.io.File;
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
public class ProductController extends HttpServlet {

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
        ProductDAO dao = new ProductDAO();
        List<Timeline> timeline = (List<Timeline>) session.getAttribute("TIMELINE");
        if (timeline == null) {
            timeline = new ArrayList<>();
        }
        try {
            String action = request.getParameter("action");
            int page = 1;
            int recordsPerPage = 9;
            int numSort = 0;
            double min = Double.MIN_VALUE, max = Double.MAX_VALUE;
            User loginUser = (User) session.getAttribute("LOGIN_USER");
            int categoryID = 0;
            while (true) {
                List<Product> productList = (List<Product>) session.getAttribute("PRODUCT_LIST");
                String search = request.getParameter("search");
                if (action != null && action.equalsIgnoreCase("Edit")) {
                    int productID = Integer.parseInt(request.getParameter("productID"));
                    String name = request.getParameter("name");
                    int category = Integer.parseInt(request.getParameter("category"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    double price = Double.parseDouble(request.getParameter("price"));
                    boolean status = Boolean.parseBoolean(request.getParameter("status"));
                    String describe = request.getParameter("describe");
                    String info = request.getParameter("productInfo");
                    Product p = dao.getProduct(productID);
                    Product edit = new Product(productID, name, describe, info, category, quantity, price, status, p.getImage(), "", new SimpleDateFormat("dd MMM,yyyy").format(new Date()));
                    boolean check = dao.updateProduct(edit);
                    if (check) {
                        for (int i = 0; i < productList.size(); i++) {
                            Product get = productList.get(i);
                            if (get.getID() == productID) {
                                productList.set(i, edit);
                                break;
                            }
                        }
                        session.setAttribute("PRODUCT_LIST", productList);
                        session.setAttribute("PRODUCT_CHOOSE", edit);
                        timeline.add(new Timeline(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()), "A product changed! Product #" + p.getID() + " is changed!"));
                        url = "adminProduct.jsp";
                    }
                    break;
                } else if (action != null && action.equalsIgnoreCase("addProduct")) {
                    String name = request.getParameter("name");
                    int category = Integer.parseInt(request.getParameter("category"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    double price = Double.parseDouble(request.getParameter("price"));
                    boolean status = Boolean.parseBoolean(request.getParameter("status"));
                    String describe = request.getParameter("describe");
                    String info = request.getParameter("productInfo");
                    int productNum = (int) session.getAttribute("PRODUCT_NUMBER");
                    Product p = new Product(productNum + 1, name, describe, info, category, quantity, price, status, new ArrayList<>(), new java.sql.Timestamp(new java.util.Date().getTime()).toString(), "");
                    boolean check = dao.addProduct(p);
                    if (check) {
                        File f = new File(getServletContext().getRealPath("/").replace("build\\", "") + "\\assests\\img\\product\\" + "\\" + (productNum + 1));
                        f.mkdir();
                        page = (int) session.getAttribute("NUMBER_PAGES");
                        session.setAttribute("PRODUCT_CHOOSE", p);
                        action = "Product";
                        timeline.add(new Timeline(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()), "New product created! Product #" + p.getID() + " is created!"));
                    }
                } else if (action != null && action.equalsIgnoreCase("Close")) {
                    session.setAttribute("PRODUCT_CHOOSE", null);
                    action = "";
                } else if (action != null && action.equalsIgnoreCase("updateImg")) {
                    Product p = (Product) session.getAttribute("PRODUCT_CHOOSE");
                    String fileName = request.getParameter("fileName");
                    for (ImageProduct image : p.getImage()) {
                        if (image.getImage().equalsIgnoreCase(fileName)) {
                            String uploadPath = getServletContext().getRealPath("").replace("build\\", "") + File.separator + "assests\\img\\product" + File.separator + p.getID() + File.separator + fileName;
                            String buildPath = getServletContext().getRealPath("") + File.separator + "assests\\img\\product" + File.separator + p.getID() + File.separator + fileName;
                            File upload = new File(uploadPath);
                            File build = new File(buildPath);
                            if (upload.delete() && build.delete() && dao.deleteImage(fileName, p.getID())) {
                                p.getImage().remove(image);
                                session.setAttribute("PRODUCT_CHOOSE", p);
                            }
                            break;
                        }
                    }
                    url = "adminProduct.jsp";
                    break;
                } else if (action != null && action.equalsIgnoreCase("detail")) {
                    int productID = Integer.parseInt(request.getParameter("productID"));
                    Product p = dao.getProduct(productID);
                    if (p.getImage() == null) {
                        p.setImage(new ArrayList<>());
                    }
                    session.setAttribute("PRODUCT_CHOOSE", p);
                    if (loginUser != null && loginUser.getRoleID().equalsIgnoreCase("AD")) {
                        url = url.equals(ERROR) ? "adminProduct.jsp" : url;
                    } else {
                        url = "productDetail.jsp";
                    }
                    break;
                } else if (action != null && action.equalsIgnoreCase("Delete")) {
                    int productID = Integer.parseInt(request.getParameter("productID"));
                    boolean check = dao.deleteProduct(productID);
                    if (check) {
                        for (Product p : productList) {
                            if (p.getID() == productID) {
                                p.setStatus(false);
                                break;
                            }
                        }
                        session.setAttribute("PRODUCT_LIST", productList);
                        session.setAttribute("PRODUCT_CHOOSE", null);
                        page = (int) session.getAttribute("CURRENT_PAGE");
                        timeline.add(new Timeline(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date()), "A product deleted! Product #" + productID + " is deleted!"));
                        url = "adminProduct.jsp";
                        action = null;
                    }
                } else {
                    List<Category> listCate = (List<Category>) session.getAttribute("CATEGORY_LIST");
                    if (listCate==null||listCate.size()<1) {
                        CategoryDAO cateDAO = new CategoryDAO();
                        listCate=cateDAO.getListCategory();
                    }
                    String[] sortList = {"Sorted", "Newest", "Price (low to high)", "Price (high to low)", "Name A-Z", "Name Z-A"};
                    boolean admin = false;
                    if (request.getParameter("page") != null && !request.getParameter("page").isEmpty()) {
                        page = Integer.parseInt(request.getParameter("page"));
                    }
                    if (request.getParameter("sort") != null && !request.getParameter("sort").isEmpty()) {
                        numSort = Integer.parseInt(request.getParameter("sort"));
                    }
                    if (request.getParameter("category") != null && !request.getParameter("category").isEmpty()) {
                        categoryID = Integer.parseInt(request.getParameter("category"));
                    }
                    if (request.getParameter("min") != null && !request.getParameter("min").isEmpty()) {
                        min = Double.parseDouble(request.getParameter("min"));
                    } else {
                        min = dao.getMinPrice(categoryID, search);
                    }
                    if (request.getParameter("max") != null && !request.getParameter("max").isEmpty()) {
                        max = Double.parseDouble(request.getParameter("max"));
                    } else {
                        max = dao.getMaxPrice(categoryID, search);
                    }
                    String sort = "";
                    switch (numSort) {
                        case 0:
                            sort = "ProductID";
                            break;
                        case 1:
                            sort = "ProductID Desc";
                            break;
                        case 2:
                            sort = "UnitPrice";
                            break;
                        case 3:
                            sort = "UnitPrice Desc";
                            break;
                        case 4:
                            sort = "ProductName";
                            break;
                        case 5:
                            sort = "ProductName Desc";
                            break;
                        default:
                            break;
                    }
                    if (loginUser == null) {
                        url = "product.jsp";
                    } else {
                        if (loginUser.getRoleID().equalsIgnoreCase("AD")) {
                            String previous = (String) session.getAttribute("PREVIOUS");
                            url = previous == null ? "adminProduct.jsp" : "CategoryController";
                            dao.getTimeLineProduct(timeline);
                            admin = true;
                        } else {
                            url = "product.jsp";
                        }
                    }
                    int numPro = dao.getNumberPages(categoryID, admin, search);
                    productList = dao.getListProduct((page - 1) * recordsPerPage, recordsPerPage, sort, categoryID, admin, search, min, max);
                    int noPages = (int) Math.ceil(numPro * 1.0 / recordsPerPage);
                    session.setAttribute("NUMBER_PAGES", noPages);
                    session.setAttribute("CURRENT_PAGE", page);
                    session.setAttribute("PRODUCT_LIST", productList);
                    session.setAttribute("SORT", numSort);
                    session.setAttribute("CATEGORY_LIST", listCate);
                    session.setAttribute("CATEGORY_ID", categoryID);
                    session.setAttribute("SORT_LIST", sortList);
                    session.setAttribute("PRODUCT_NUMBER", numPro);
                    session.setAttribute("MIN_PRICE", min);
                    session.setAttribute("MAX_PRICE", max);
                    break;
                }
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
