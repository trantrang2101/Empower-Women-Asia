/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author asus
 */
public class Cart {
    private String customerID;
    private int productID,quantity;

    public Cart() {
    }
    
    public Cart(String customerID, int productID, int quantity) {
        this.customerID = customerID;
        this.productID = productID;
        this.quantity = quantity;
    }

    public String getCustomerID() {
        return customerID;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
//    private Map<Integer, Product> cart;
//
//    public Cart() {
//    }
//
//    public Cart(Map<Integer, Product> cart) {
//        this.cart = cart;
//    }
//
//    public Map<Integer, Product> getCart() {
//        return cart;
//    }
//
//    public void setCart(Map<Integer, Product> cart) {
//        this.cart = cart;
//    }
//    public boolean add(Product tea){
//        boolean check = false;
//        try{
//            if(this.cart == null){
//                this.cart = new HashMap<>();
//            }
//            if(this.cart.containsKey(tea.getID())){
//                int currentQuantity = this.cart.get(tea.getID()).getQuantity();
//                tea.setQuantity(currentQuantity + tea.getQuantity());
//            }
//            this.cart.put(tea.getID(), tea);
//            check = true;
//        }catch(Exception e){  
//        }
//        return check;
//    }
//    public boolean remove(Integer id){
//        boolean check = false;
//        try {
//            if(this.cart != null){
//                if(this.cart.containsKey(id)){
//                    this.cart.remove(id);
//                    check = true;
//                }
//            }
//        } catch (Exception e) {
//        }
//        return check;
//    }
//    public boolean update(Integer id, Product tea){
//        boolean check = false;
//        try {
//            if(this.cart != null){
//                if(this.cart.containsKey(id)){
//                    this.cart.replace(id, tea);
//                    check = true;
//                }
//            }
//        } catch (Exception e) {
//        }
//        return check;
//    }

}
