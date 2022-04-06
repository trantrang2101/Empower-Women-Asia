
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<header id="navbarmenu" style="">
    <nav id="sidebar" class="navbar navbar-expand-lg navbar-light bg-light" style="z-index: 100000;">
        <div class="sidebar-header">
            <h3>Empower Women Asia</h3>
        </div>
        <ul class="list-unstyled components">
            <li class="navbar-content__icon active">
                <a href="CategoryController">Home</a>
            </li>
            <li>
                <a href="#about" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">About</a>
                <ul class="collapse list-unstyled" id="about">
                    <li>
                        <a href="about.html">About us</a>
                    </li>
                    <li>
                        <a href="#">Our team</a>
                    </li>
                    <li>
                        <a href="#">Join Us</a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="#partners" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Partners</a>
                <ul class="collapse list-unstyled" id="partners">
                    <li>
                        <a href="#">Hoa Ban Social Protecting Center</a>
                    </li>
                    <li>
                        <a href="#">Chieng Chau Co-operative</a>
                    </li>
                    <li>
                        <a href="#">White Flax Co-operative</a>
                    </li>
                    <li>
                        <a href="#">Hoang Khuong Social Center</a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="BlogController">Blogs</a>
            </li>
            <li>
                <a href="#">Press</a>
            </li>
            <li>
                <a href="#active" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Activities</a>
                <ul class="collapse list-unstyled" id="active">
                    <li>
                        <a href="#">Workshop</a>
                    </li>
                    <li>
                        <a href="#">Training</a>
                    </li>
                    <li>
                        <a href="#">Trade Promote</a>
                    </li>
                    <li>
                        <a href="#">Competition</a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="#product" data-toggle="collapse" class="dropdown-toggle">Products</a>
                <ul class="collapse list-unstyled" id="product">
                    <li>
                        <a href="ProductController">All Products</a>
                    </li>
                    <c:forEach items="${sessionScope.CATEGORY_LIST}" var="cate">
                        <c:url var="category" value="ProductController">
                            <c:param name="category" value="${cate.getID()}"></c:param>
                        </c:url>
                        <li><a href="${category}">${cate.getName()}</a></li>   
                    </c:forEach>
                </ul>
            </li>
        </ul>
        <ul class="list-unstyled CTAs row text-center components">
            <li class="navbar-content__icon col-4">
                <a href="https://www.facebook.com/EmpowerWomenAsia" class="facebook"><i class="fab fa-facebook-f"></i></a>
            </li>
            <li class="navbar-content__icon col-4">
                <a href="https://www.instagram.com/empowerwomenasia/" class="instagram"><i class="fab fa-instagram"></i></a>
            </li>
            <li class="navbar-content__icon col-4">
                <a href="https://www.youtube.com/channel/UCxeOFGCRPLff52jxVLHFong" class="youtube"><i class="fab fa-youtube"></i></a>
            </li>
        </ul>
    </nav>
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="z-index: 100000000;">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <form action="UserController" method="POST">
                        <button class="btn btn-dark" name="action" value="Logout">Logout</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <nav class="topnav navbar navbar-expand-lg navbar-light bg-light shadow justify-content-between justify-content-sm-start bg-white" style="z-index: 1000000;">
        <button type="button" id="sidebarCollapse" class="btn btn-dark">
            <i class="fas fa-align-left"></i>
        </button>
        <form class="form-inline ml-auto d-none d-lg-block me-3">
            <div class="input-group input-group-joined input-group-solid">
                <input class="form-control pe-0" type="search" placeholder="Search" aria-label="Search" />
                <div class="input-group-text"><i class="fas fa-search"></i></div>
            </div>
        </form>
        <ul class="navbar-nav align-items-center ml-auto">
            <li class="nav-item" style="margin-right: 20px;">
                <a href="cart.jsp"><i class="fas fa-shopping-cart"></i>&nbsp;Cart
                    <c:choose>
                        <c:when test="${sessionScope.CART_PRODUCTS == null||sessionScope.CART_PRODUCTS.size() == 0}">0</c:when>
                        <c:otherwise>${sessionScope.CART_PRODUCTS.size()}</c:otherwise>
                    </c:choose>
                </a>
            </li>
            <li class="nav-item dropdown show no-caret dropdown-user">
                <c:choose>
                    <c:when test="${sessionScope.LOGIN_USER!=null}">
                        <c:set var="customer" value="${sessionScope.CUSTOMER}"></c:set>
                            <a class="btn btn-light " href="#" role="button" id="navbarDropdownUserImage" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-user"></i>
                            </a>
                            <div class="dropdown-menu dropdown-menu-end dropdown-menu-right border-0 shadow animated--fade-in-up" aria-labelledby="navbarDropdownUserImage">
                                <h6 class="dropdown-header d-flex align-items-center">
                                <c:choose>
                                    <c:when test="${customer.getImg()==null}">
                                        <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="" class="dropdown-user-img">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="./assests/img/user/${customer.getImg()}" alt="" class="dropdown-user-img">
                                    </c:otherwise>
                                </c:choose>
                                <div class="dropdown-user-details">
                                    <div class="dropdown-user-details-name">${sessionScope.CUSTOMER.getFullName()}</div>
                                    <div class="dropdown-user-details-email">${sessionScope.LOGIN_USER.getUserID()}</div>
                                </div>
                            </h6>
                            <div class="dropdown-divider"></div>
                            <c:if test="${sessionScope.LOGIN_USER.getRoleID() == 'US'}">
                                <a class="dropdown-item" href="user.jsp">
                                    Account
                                </a>
                            </c:if>
                            <c:if test="${sessionScope.LOGIN_USER.getRoleID() == 'AD'}">
                                <a class="dropdown-item" href="admin.jsp">
                                    Setting
                                </a>
                            </c:if>
                            <a href="#" data-toggle="modal" class="dropdown-item" data-target="#logoutModal">
                                Logout
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a class="btn btn-light " href="#" role="button" id="navbarDropdownUserImage" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fas fa-user"></i>
                        </a>
                        <div class="dropdown-menu dropdown-menu-end dropdown-menu-right border-0 shadow animated--fade-in-up" aria-labelledby="navbarDropdownUserImage">
                            <a class="dropdown-item" href="signin.jsp">
                                <div class="dropdown-item-icon"><i data-feather="settings"></i></div>
                                Sign In
                            </a>
                            <a class="dropdown-item" href="signup.jsp">
                                <div class="dropdown-item-icon"><i data-feather="log-out"></i></div>
                                Sign Up
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </li>
        </ul>
    </nav>
</header>