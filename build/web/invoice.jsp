<%-- 
    Document   : invoice
    Created on : Feb 7, 2022, 4:34:34 PM
    Author     : Tran Trang
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Invoice</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500&display=swap" rel="stylesheet">
    </head>
    <body>
        <c:set var="order" value="${sessionScope.ORDER_CHOOSE}"></c:set>
        
        <div class="offset-xl-2 col-xl-8 col-lg-12 col-md-12 col-sm-12 col-12 padding" style="margin-top: 50px;">
                <div class="card">
                    <div class="card-header p-4">

                    <c:choose>
                        <c:when test="${sessionScope.LOGIN_USER.getRoleID()=='AD'}">
                            <a class="pt-2 d-inline-block text-dark" href="admin.jsp" data-abc="true"><img src="./assests/img/Logo.png" width="50" height="50">Empower Women Asia</a>
                            </c:when>
                            <c:otherwise>
                            <a class="pt-2 d-inline-block text-dark" href="home.jsp" data-abc="true"><img src="./assests/img/Logo.png" width="50" height="50">Empower Women Asia</a>
                            </c:otherwise>
                        </c:choose>
                    <div class="float-right">
                        <h3 class="mb-0">Invoice #${order.getID()}</h3>
                        Date: ${order.getOrderDate()}
                    </div>
                </div>
                <div class="card-body">
                    <div class="row mb-4">
                        <div class="col-sm-6">
                            <h5 class="mb-3">From:</h5>
                            <h3 class="text-dark mb-1">Empower Women Asia</h3>
                            <div>286 Nguyen Xien, Thanh Xuan</div>
                            <div>Ha Noi, Vietnam 10000</div>
                            <div>Phone: +84 218 855 207</div>
                        </div>
                        <div class="col-sm-6 ">
                            <h5 class="mb-3">To:</h5>
                            <h3 class="text-dark mb-1">${order.getFullName()}</h3>
                            <div>${order.getAddress()}</div>
                            <div>${order.getRegion()}, ${order.getCountry()} ${order.getPostalCode()}</div>
                            <div>Phone: ${order.getPhone()}</div>
                        </div>
                    </div>
                    <div class="table-responsive-sm">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th class="center">#</th>
                                    <th>Item</th>
                                    <th>Category</th>
                                    <th class="right">Price</th>
                                    <th class="center">Qty</th>
                                    <th class="right">Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="product" items="${sessionScope.PRODUCT_ORDER}" varStatus="counter">     
                                    <c:set var="total" value="${total + product.getPrice() * product.quantity}"/>
                                    <tr>
                                        <td class="center">${counter.count}</td>
                                        <td class="left strong">${product.getName()}</td>
                                        <td class="left">
                                            <c:forEach items="${sessionScope.CATEGORY_LIST}" var="cate">
                                                <c:if test="${cate.getID()==product.getCategoryID()}">
                                                    ${cate.getName()}
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td class="right">$${product.getPrice()}</td>
                                        <td class="center">${product.getQuantity()}</td>
                                        <td class="right">$${product.getPrice() * product.quantity}</td>
                                    </tr>
                                </c:forEach> 
                            </tbody>
                        </table>
                    </div>
                    <div class="row">
                        <div class="col-lg-4 col-sm-5">
                        </div>
                        <div class="col-lg-4 col-sm-5 ml-auto">
                            <table class="table table-clear">
                                <tbody>
                                    <tr>
                                        <td class="left">
                                            <strong class="text-dark">Subtotal</strong>
                                        </td>
                                        <td class="right">$${total}</td>
                                    </tr>
                                    <!--                                    <tr>
                                                                            <td class="left">
                                                                                <strong class="text-dark">Discount (20%)</strong>
                                                                            </td>
                                                                            <td class="right">$5,761,00</td>
                                                                        </tr>-->
                                    <!--                                    <tr>
                                                                            <td class="left">
                                                                                <strong class="text-dark">VAT (10%)</strong>
                                                                            </td>
                                                                            <td class="right">$2,304,00</td>
                                                                        </tr>-->
                                    <tr>
                                        <td class="left">
                                            <strong class="text-dark">Total</strong> </td>
                                        <td class="right">
                                            <strong class="text-dark">$${total}</strong>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="card-footer bg-white">
                    <p class="mb-0">Empower Women Asia</p>
                </div>
            </div>
            <c:choose>
                <c:when test="${sessionScope.LOGIN_USER.getRoleID()=='AD'}">
                    <a href="adminBill.jsp">Return to Bill Setting</a>
                </c:when>
                <c:otherwise>
                    <a href="home.jsp">Return to Home page</a>
                </c:otherwise>
            </c:choose>
        </div>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
