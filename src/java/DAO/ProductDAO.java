/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import entity.ImageProduct;
import entity.Product;
import entity.Timeline;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Tran Trang
 */
public class ProductDAO {

    public void getTimeLineProduct(List<Timeline> list) throws SQLException {
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                String sql = "select productID,createdAt,updatedAt from Products";
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int ID = rs.getInt(1);
                    String createdAt = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString(2)));
                    String updatedAt = rs.getString(3);
                    list.add(new Timeline(createdAt, "New product created! Product #" + ID + " is created!"));
                    if (updatedAt != null && !updatedAt.isEmpty()) {
                        list.add(new Timeline(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(updatedAt)), "A product updated! Product #" + ID + " is updated!"));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    public boolean deleteImage(String name, int ID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("delete from ImageProduct WHERE Image = ? AND productID = ?");
                stm.setString(1, name);
                stm.setInt(2, ID);
                check = stm.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean uploadImage(String path, int ID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("insert into ImageProduct (ProductID,Image) values (?,?)");
                stm.setInt(1, ID);
                stm.setString(2, path);
                check = stm.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean addProduct(Product p) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("insert into Products (ProductName,[Description],ProductInfo,CategoryID,QuantityPerUnit,UnitPrice,status) values (?,?,?,?,?,?,?)");
                stm.setString(1, p.getName());
                stm.setString(2, p.getDescribe());
                stm.setString(3, p.getProductInfo());
                stm.setInt(4, p.getCategoryID());
                stm.setInt(5, p.getQuantity());
                stm.setDouble(6, p.getPrice());
                stm.setBoolean(7, p.isStatus());
                check = stm.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean updateProduct(Product p) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("update Products set ProductName = ?,[Description]=?,ProductInfo=?,CategoryID=?,QuantityPerUnit=?,UnitPrice=?,status=?,updatedAt = getDate() where ProductID = ?");
                stm.setString(1, p.getName());
                stm.setString(2, p.getDescribe());
                stm.setString(3, p.getProductInfo());
                stm.setInt(4, p.getCategoryID());
                stm.setInt(5, p.getQuantity());
                stm.setDouble(6, p.getPrice());
                stm.setBoolean(7, p.isStatus());
                stm.setInt(8, p.getID());
                check = stm.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean deleteProduct(int productID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("UPDATE Products SET status = ? WHERE ProductID = ? ");
                stm.setBoolean(1, false);
                stm.setInt(2, productID);
                check = stm.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }

        }
        return check;
    }

    public List<ImageProduct> getProductImage(int ProductID) throws SQLException {
        List<ImageProduct> list = new ArrayList();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                String sql = "SELECT Image from ImageProduct where ProductID = ?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, ProductID);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String image = rs.getString(1);
                    list.add(new ImageProduct(ProductID, image));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public List<Product> getListProduct(int start, int record, String sort, int categoryID, boolean admin, String search, double min, double max) throws SQLException {
        List<Product> list = new ArrayList();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                String sql = "";
                if (admin) {
                    if (search != null && !search.isEmpty()) {
                        sql = "SELECT * from Products WHERE ProductName LIKE ? AND UnitPrice BETWEEN " + min + " AND " + max + " ORDER BY " + sort + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
                    } else {
                        sql = "SELECT * from Products WHERE UnitPrice BETWEEN " + min + " AND " + max + "  ORDER BY " + sort + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
                    }
                } else {
                    if (search != null && !search.isEmpty()) {
                        if (categoryID == 0) {
                            sql = "SELECT * from Products where ProductName LIKE ? AND status = 1 AND UnitPrice BETWEEN " + min + " AND " + max + " ORDER BY " + sort + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
                        } else {
                            sql = "SELECT * from Products where ProductName LIKE ?  AND status = 1 AND UnitPrice BETWEEN " + min + " AND " + max + " AND CategoryID = " + categoryID + " ORDER BY " + sort + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
                        }
                    } else {
                        if (categoryID == 0) {
                            sql = "SELECT * from Products where status = 1 AND UnitPrice BETWEEN " + min + " AND " + max + " ORDER BY " + sort + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
                        } else {
                            sql = "SELECT * from Products where status = 1 AND UnitPrice BETWEEN " + min + " AND " + max + " AND CategoryID = " + categoryID + " ORDER BY " + sort + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
                        }
                    }
                }
                stm = conn.prepareStatement(sql);
                if (search != null && !search.isEmpty()) {
                    stm.setString(1, "%" + search + "%");
                    stm.setInt(2, start);
                    stm.setInt(3, record);
                } else {
                    stm.setInt(1, start);
                    stm.setInt(2, record);
                }
                rs = stm.executeQuery();
                while (rs.next()) {
                    int ID = rs.getInt(1);
                    String name = rs.getString(2);
                    String describt = rs.getString(3);
                    String info = rs.getString(4);
                    int cate = rs.getInt(5);
                    int quantity = rs.getInt(6);
                    double price = rs.getDouble(7);
//                    String discount = rs.getString("DiscountID");
                    boolean status = rs.getBoolean(8);
                    List<ImageProduct> image = getProductImage(ID);
                    String createAt = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString(9)));
                    String updatedAt = rs.getString(10);
                    if (updatedAt != null && !updatedAt.isEmpty()) {
                        updatedAt = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(updatedAt));
                    }
                    list.add(new Product(ID, name, describt, info, cate, quantity, price, status, image, createAt, updatedAt));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public double getMaxPrice(int categoryID, String search) throws SQLException {
        double num = -1;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                if (search != null && !search.isEmpty()) {
                    if (categoryID == 0) {
                        stm = conn.prepareStatement("select top 1 UnitPrice from Products where status = 1 AND ProductName LIKE ? ORDER BY UnitPrice Desc");
                        stm.setString(1, "%" + search + "%");
                    } else {
                        stm = conn.prepareStatement("select top 1 UnitPrice from Products  where status = 1 AND CategoryID = " + categoryID + " AND ProductName LIKE ? ORDER BY UnitPrice Desc");
                        stm.setString(1, "%" + search + "%");
                    }
                } else {
                    if (categoryID == 0) {
                        stm = conn.prepareStatement("select top 1 UnitPrice from Products where status = 1 ORDER BY UnitPrice Desc");
                    } else {
                        stm = conn.prepareStatement("select top 1 UnitPrice from Products  where status = 1 AND CategoryID = " + categoryID + " ORDER BY UnitPrice Desc");
                    }
                }
                rs = stm.executeQuery();
                while (rs.next()) {
                    num = rs.getDouble(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return num;
    }

    public double getMinPrice(int categoryID, String search) throws SQLException {
        double num = -1;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                if (search != null && !search.isEmpty()) {
                    if (categoryID == 0) {
                        stm = conn.prepareStatement("select top 1 UnitPrice from Products where status = 1 AND ProductName LIKE ? ORDER BY UnitPrice ");
                        stm.setString(1, "%" + search + "%");
                    } else {
                        stm = conn.prepareStatement("select top 1 UnitPrice from Products  where status = 1 AND CategoryID = " + categoryID + " AND ProductName LIKE ? ORDER BY UnitPrice");
                        stm.setString(1, "%" + search + "%");
                    }
                } else {
                    if (categoryID == 0) {
                        stm = conn.prepareStatement("select top 1 UnitPrice from Products where status = 1 ORDER BY UnitPrice");
                    } else {
                        stm = conn.prepareStatement("select top 1 UnitPrice from Products  where status = 1 AND CategoryID = " + categoryID + " ORDER BY UnitPrice");
                    }
                }
                rs = stm.executeQuery();
                while (rs.next()) {
                    num = rs.getDouble(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return num;
    }

    public int getNumberPages(int categoryID, boolean admin, String search) throws SQLException {
        int num = -1;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                if (admin) {
                    if (search != null && !search.isEmpty()) {
                        stm = conn.prepareStatement("select count(*) as Number from Products WHERE ProductName LIKE ?");
                        stm.setString(1, "%" + search + "%");
                    } else {
                        stm = conn.prepareStatement("select count(*) as Number from Products");
                    }
                } else {
                    if (search != null && !search.isEmpty()) {
                        if (categoryID == 0) {
                            stm = conn.prepareStatement("select count(*) as Number from Products where status = 1 AND ProductName LIKE ?");
                            stm.setString(1, "%" + search + "%");
                        } else {
                            stm = conn.prepareStatement("select count(*) as Number from Products  where status = 1 AND CategoryID = " + categoryID + " AND ProductName LIKE ?");
                            stm.setString(1, "%" + search + "%");
                        }
                    } else {
                        if (categoryID == 0) {
                            stm = conn.prepareStatement("select count(*) as Number from Products where status = 1");
                        } else {
                            stm = conn.prepareStatement("select count(*) as Number from Products  where status = 1 AND CategoryID = " + categoryID);
                        }
                    }
                }
                rs = stm.executeQuery();
                while (rs.next()) {
                    num = rs.getInt("Number");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return num;
    }

    public Product getProduct(int id) throws SQLException {
        Product p = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareCall("SELECT * from Products WHERE ProductID = ?");
                stm.setInt(1, id);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String name = rs.getString("ProductName");
                    String describt = rs.getString("Description");
                    String info = rs.getString("ProductInfo");
                    int cate = rs.getInt("CategoryID");
                    int quantity = rs.getInt("QuantityPerUnit");
                    double price = rs.getDouble("UnitPrice");
//                    String discount = rs.getString("DiscountID");
                    boolean status = rs.getBoolean("status");
                    List<ImageProduct> image = getProductImage(id);
                    String createAt = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString(9)));
                    String updatedAt = rs.getString(10);
                    if (updatedAt != null && !updatedAt.isEmpty()) {
                        updatedAt = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(updatedAt));
                    }
                    p = new Product(id, name, describt, info, cate, quantity, price, status, image, createAt, updatedAt);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return p;
    }

    public boolean updateQuantity(Product p, int quantity) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareCall("UPDATE Products SET QuantityPerUnit = ? WHERE productid = ? ");
                stm.setInt(1, p.getQuantity() - quantity);
                stm.setInt(2, p.getID());
                check = stm.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public List<Product> getList() throws SQLException {
        List<Product> list = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                String sql = "";
                stm = conn.prepareStatement(sql);
//                
                rs = stm.executeQuery();
                while (rs.next()) {
                    int ID = rs.getInt("ProductID");
                    String name = rs.getString("ProductName");
                    String describt = rs.getString("Description");
                    String info = rs.getString("ProductInfo");
                    int cate = rs.getInt("CategoryID");
                    int quantity = rs.getInt("QuantityPerUnit");
                    double price = rs.getDouble("UnitPrice");
                    boolean status = rs.getBoolean("status");
                    List<ImageProduct> image = getProductImage(ID);
                    String createAt = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString(9)));
                    String updatedAt = rs.getString(10);
                    if (updatedAt != null && !updatedAt.isEmpty()) {
                        updatedAt = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(updatedAt));
                    }
                    list.add(new Product(ID, name, describt, info, cate, quantity, price, status, image, createAt, updatedAt));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }
}
