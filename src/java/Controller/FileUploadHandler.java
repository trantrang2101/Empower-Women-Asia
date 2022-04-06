package Controller;

import DAO.BlogDAO;
import DAO.ProductDAO;
import DAO.UserDAO;
import entity.Blog;
import entity.Customer;
import entity.ImageProduct;
import entity.Product;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class FileUploadHandler extends HttpServlet {

    private static final String ERROR = "invalid.jsp";
    private static final long serialVersionUID = 1;

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doPost(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");
        HttpSession session = request.getSession();
        String url = ERROR;
        String applicationPath = getServletContext().getRealPath("");
        Product p = (Product) session.getAttribute("PRODUCT_CHOOSE");
        Customer login = (Customer) session.getAttribute("CUSTOMER");
        Blog blog = (Blog) session.getAttribute("BLOG_CHOOSE");
        String name = "";
        String uploadPath = "";
        String build = "";
        if (p != null) {
            uploadPath = applicationPath.replace("build\\", "") + File.separator + "assests\\img\\product" + File.separator + p.getID();
            build = applicationPath + File.separator + "assests\\img\\product" + File.separator + p.getID();
        } else if (blog != null) {
            uploadPath = applicationPath.replace("build\\", "") + File.separator + "assests\\img\\blog";
            build = applicationPath + File.separator + "assests\\img\\blog";
            name = "blog"+blog.getBlogID() + ".png";
        } else if (login != null) {
            uploadPath = applicationPath.replace("build\\", "") + File.separator + "assests\\img\\user";
            build = applicationPath + File.separator + "assests\\img\\user";
            name = login.getID() + ".png";
        }
        File fileUploadDirectory = new File(uploadPath);
        if (!fileUploadDirectory.exists()) {
            fileUploadDirectory.mkdirs();
        }
        File fileBuildUploadDirectory = new File(build);
        if (!fileBuildUploadDirectory.exists()) {
            fileBuildUploadDirectory.mkdirs();
        }
        try {
            ServletFileUpload sf = new ServletFileUpload(new DiskFileItemFactory());
            List<FileItem> multifiles = sf.parseRequest(request);
            List<String> fileNames = new ArrayList<>();
            for (FileItem item : multifiles) {
                if (p != null) {
                    item.write(new File(uploadPath + File.separator + item.getName()));
                    item.write(new File(build + File.separator + item.getName()));
                    fileNames.add(item.getName());
                } else {
                    item.write(new File(uploadPath + File.separator + name));
                    item.write(new File(build + File.separator + name));
                }
            }
            if (!fileNames.isEmpty() && fileNames != null) {
                ProductDAO dao = new ProductDAO();
                boolean doneAll = false;
                for (String f : fileNames) {
                    if (dao.uploadImage(f, p.getID())) {
                        doneAll = true;
                        p.getImage().add(new ImageProduct(p.getID(), f));
                    } else {
                        doneAll = false;
                        break;
                    }
                }
                if (doneAll) {
                    url = "adminProduct.jsp";
                }
            } else {
                if (blog!=null) {
                    BlogDAO dao = new BlogDAO();
                    boolean check = dao.uploadImage(name, blog.getBlogID());
                    if (check) {
                        blog.setImage(name);
                        session.setAttribute("BLOG_CHOOSE", blog);
                        url = "adminBlogs.jsp";
                    }
                } else if (login != null) {
                    UserDAO dao = new UserDAO();
                    boolean check = dao.uploadImage(name, login.getID());
                    if (check) {
                        login.setImg(name);
                        session.setAttribute("CUSTOMER", login);
                        url = "user.jsp";
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }
}
