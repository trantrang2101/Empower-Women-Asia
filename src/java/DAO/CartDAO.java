/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import entity.Cart;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Tran Trang
 */
public class CartDAO {
    
    public List<Cart> getListCart(String userID) throws SQLException {
        List<Cart> cus = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                String sql = "SELECT * from Cart WHERE CustomerID = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, userID);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int ProductID = rs.getInt(2);
                    int quantity = rs.getInt(3);
                    Cart x = new Cart(userID, ProductID, quantity);
                    cus.add(x);
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
        return cus;
    }
    
    public boolean updateQuantity(Cart c) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareCall("UPDATE Cart SET Quantity= ? WHERE productid = ? AND CustomerID = ?");
                stm.setInt(1, c.getQuantity());
                stm.setInt(2, c.getProductID());
                stm.setString(3, c.getCustomerID());
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
    
    public boolean checkCart(Cart c) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("select * from Cart WHERE CustomerID = ? AND ProductID = ?");
                stm.setString(1, c.getCustomerID());
                stm.setInt(2, c.getProductID());
                rs = stm.executeQuery();
                if (rs.next()) {
                    check = rs.getInt(3)>0;
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
    
    public boolean deleteCart(Cart c) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("delete from Cart WHERE CustomerID = ? AND ProductID = ?");
                stm.setString(1, c.getCustomerID());
                stm.setInt(2, c.getProductID());
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
    
    public boolean addCart(Cart c) throws SQLException{
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = model.ConnectDB.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("insert into Cart (CustomerID,ProductID,Quantity) values (?,?,?)");
                stm.setString(1, c.getCustomerID());
                stm.setInt(2, c.getProductID());
                stm.setInt(3, c.getQuantity());
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
}
