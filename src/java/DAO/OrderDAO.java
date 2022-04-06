/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import entity.Order;
import entity.OrderDetail;
import entity.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Tran Trang
 */
public class OrderDAO {

    public int createNewShopping(Order c) throws SQLException {
        int check = -1;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                String sql = "insert Orders (CustomerID,fullName,[Address],Region,PostalCode,Country,Phone,prepayment,note) values (?,?,?,?,?,?,?,?,?)";
                stm = conn.prepareStatement(sql);
                stm.setString(1, c.getCustomerID());
                stm.setString(2, c.getFullName());
                stm.setString(3, c.getAddress());
                stm.setString(4, c.getRegion());
                stm.setString(5, c.getPostalCode());
                stm.setString(6, c.getCountry());
                stm.setString(7, c.getPhone());
                stm.setBoolean(8, c.isPrepay());
                stm.setString(9, c.getNote());
                boolean test = stm.executeUpdate() > 0;
                if (test) {
                    sql = "SELECT top 1 orderID from Orders order by orderID desc";
                    stm = conn.prepareCall(sql);
                    rs = stm.executeQuery();
                    if (rs.next()) {
                        check = rs.getInt(1);
                    }
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
        return check;
    }

    public boolean createOrderDetail(int orderID, Product p) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                String sql = "insert [OrderDetails] values (?,?,?,?)";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, orderID);
                stm.setInt(2, p.getID());
                stm.setInt(3, p.getQuantity());
                stm.setDouble(4, p.getPrice());
//                stm.setString(4, p.getDiscountID());
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

    public boolean deleteOrder(int orderID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("update Orders set Done=0,updateAt=getDate() where orderID = ?");
                stm.setInt(1, orderID);
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

    public boolean updateOrder(int orderID, boolean checkPay, int done) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                if (checkPay != false) {
                    stm = conn.prepareStatement("update Orders set checkPay = ?,Done=?,updateAt=getDate() where orderID = ?");
                    stm.setBoolean(1, checkPay);
                    stm.setInt(2, done);
                    stm.setInt(3, orderID);
                } else {
                    stm = conn.prepareStatement("update Orders set checkPay = ?,Done=?,updateAt=getDate() where orderID = ?");
                    stm.setBoolean(1, true);
                    stm.setInt(2, done);
                    stm.setInt(3, orderID);
                }
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

    public List<Order> getOrder(String userID) throws SQLException {
        List<Order> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                String sql = "select * from Orders where customerID = '" + userID + "'";
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int orderID = rs.getInt(1);
                    String customerID = rs.getString(2);
                    String fullName = rs.getString(3);
                    String orderDate = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(rs.getString(4)));
                    String address = rs.getString(5);
                    String Region = rs.getString(6);
                    String postalCode = rs.getString(7);
                    String country = rs.getString(8);
                    String phone = rs.getString(9);
                    String note = rs.getString(10);
                    Boolean prepay = rs.getBoolean(11);
                    Boolean check = rs.getBoolean(12);
                    int done = rs.getInt(13);
                    List<OrderDetail> detail = getOrderDetail(orderID);
                    String updateAt = rs.getString(14);
                    if (updateAt != null && !updateAt.isEmpty()) {
                        updateAt = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(updateAt));
                    }
                    list.add(new Order(orderID, customerID, fullName, orderDate, address, Region, postalCode, country, phone, note, prepay, check, done, detail, updateAt));
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

    public List<OrderDetail> getOrderDetail(int OrderID) throws SQLException {
        List<OrderDetail> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                String sql = "select * from OrderDetails where OrderID=" + OrderID;
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int productID = rs.getInt(2);
                    int quantity = rs.getInt(3);
                    double price = rs.getDouble(4);
                    list.add(new OrderDetail(OrderID, productID, quantity, price));
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

    public List<Order> getOrder() throws SQLException {
        List<Order> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                String sql = "select * from Orders";
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int orderID = rs.getInt(1);
                    String customerID = rs.getString(2);
                    String fullName = rs.getString(3);
                    String orderDate = rs.getString(4);
                    String address = rs.getString(5);
                    String Region = rs.getString(6);
                    String postalCode = rs.getString(7);
                    String country = rs.getString(8);
                    String phone = rs.getString(9);
                    String note = rs.getString(10);
                    Boolean prepay = rs.getBoolean(11);
                    Boolean check = rs.getBoolean(12);
                    int done = rs.getInt(13);
                    List<OrderDetail> detail = getOrderDetail(orderID);
                    String updateAt = rs.getString(14);
                    if (updateAt != null && !updateAt.isEmpty()) {
                        updateAt = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(updateAt));
                    }
                    list.add(new Order(orderID, customerID, fullName, orderDate, address, Region, postalCode, country, phone, note, prepay, check, done, detail, updateAt));
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
