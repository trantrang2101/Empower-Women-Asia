<%-- 
    Document   : admin
    Created on : Jan 26, 2022, 5:18:24 PM
    Author     : Tran Trang
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <title>Tables - SB Admin Pro</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link rel="icon" type="image/x-icon" href="assests/img/Logo.png" />
        <script data-search-pseudo-elements defer src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.28.0/feather.min.js" crossorigin="anonymous"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500&display=swap" rel="stylesheet">
        <link href="./assests/css/style.css" rel="stylesheet" />
    </head>
    <body class="nav-fixed" style="font-family: 'Poppins', sans-serif;">
        <c:set var="loginUser" value="${sessionScope.LOGIN_USER}"></c:set>
        <c:if test="${loginUser == null ||  loginUser.roleID ne 'AD'}">
            <c:redirect url="home.jsp"></c:redirect>
        </c:if>
        <jsp:include page="./included/adminNavbar.jsp"/>
        <div class="modal fade" id="uploadImage" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <c:set var="product" value="${sessionScope.PRODUCT_CHOOSE}"></c:set>
                <div class="modal-dialog modal-xl" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="uploadImage">Change Your Image</h5>
                            <button type="button" class="btn btn-light" aria-label="Close" data-bs-dismiss="modal">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body row" style="padding: 0;width: 100%;object-fit: cover;">
                            <div id="result" class="col-md-9 row">
                            <c:if test="${product.getImage()!=null&&product.getImage().size()>0}">
                                <c:forEach var="image" items="${product.getImage()}">
                                    <div class="col-md-4">
                                        <form action="ProductController" method="POST">
                                            <img src="./assests/img/product/${product.getID()}/${image.getImage()}" style="width: 100%;object-fit: cover;" class="product-image">
                                            <p class="text-center">${image.getImage()}</p>
                                            <input type="hidden" name="fileName" value="${image.getImage()}">
                                            <button class="btn btn-outline-danger delete-image" type="submit" name="action" value="updateImg">×</button>
                                        </form>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </div>
                        <div class="col-md-3" style="background: #dfe0e2;display: flex;flex-direction: column;align-content: center;justify-content: flex-start;padding-top: 50px;">
                            <form action="FileUploadHandler" id="myForm" method="POST" enctype="multipart/form-data">
                                <input type="file" class="account-settings-fileinput" id="files" multiple=true name="file" style="display: none;" accept="image/*">
                                <label for="files" class="btn btn-outline-primary">
                                    Upload new photo
                                </label> &nbsp;<input type="submit" class="btn btn-primary" value="Upload">
                                <div class="text-dark small mt-1">Allowed JPG, GIF or PNG. Max size of 800K</div>
                            </form>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                        <button class="btn btn-dark" type="submit">Save Changes</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="add" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="uploadImage">Add new Product</h5>
                        <button type="button" class="btn btn-light" aria-label="Close" data-bs-dismiss="modal">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <form action="ProductController" method="POST">
                        <div class="modal-body row" style="padding: 0;width: 100%;object-fit: cover;">
                            <div class="row">
                                <div class="form-group col-md-3">
                                    <label class="form-label">Product ID</label>
                                    <input type="number" class="form-control mb-1" value="${sessionScope.PRODUCT_NUMBER+1}" disabled>
                                </div>
                                <div class="form-group col-md-9">
                                    <label class="form-label">Product Name</label>
                                    <input type="text" name="name" class="form-control mb-1" value="">
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col">
                                    <label class="form-label">Category</label>
                                    <select name="category" class="form-control">
                                        <c:forEach items="${sessionScope.CATEGORY_LIST}" var="cate">
                                            <c:choose>
                                                <c:when test="${cate.getID()==product.getCategoryID()}">
                                                    <option selected="" value="${cate.getID()}"> ${cate.getName()}</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${cate.getID()}"> ${cate.getName()}</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group col">
                                    <label class="form-label">Quantity</label>
                                    <input type="number" class="form-control mb-1" name="quantity" value="">
                                </div>
                                <div class="form-group col">
                                    <label class="form-label">Price</label>
                                    <input type="number" class="form-control mb-1" name="price" step="any" value="">
                                </div>
                                <div class="form-group col">
                                    <label class="form-label">Status</label>
                                    <select name="status" class="form-control">
                                        <c:choose>
                                            <c:when test="${product.isStatus() == true}">
                                                <option value="true" selected="selected">On</option>
                                                <option value="false">Off</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="false" selected="selected">Off</option>
                                                <option value="true">On</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </select>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col">
                                    <label class="form-label">Describe</label>
                                    <textarea class="form-control mb-1" rows="20" name="describe"></textarea>
                                </div>
                                <div class="form-group col">
                                    <label class="form-label">Product Information</label>
                                    <textarea class="form-control mb-1" rows="20" name="productInfo"></textarea>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input name="sort" type="hidden" value="${param.sort}"/>
                            <input name="page" type="hidden" value="${param.page}"/>
                            <input name="search" value="${param.search}" type="hidden"/>
                            <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                            <button class="btn btn-dark" name="action" value="addProduct">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sidenav shadow-right sidenav-light">
                    <div class="sidenav-menu">
                        <div class="nav accordion" id="accordionSidenav">
                            <div class="sidenav-menu-heading d-sm-none">Account</div>
                            <a class="nav-link d-sm-none" href="#!">
                                <div class="nav-link-icon"><i data-feather="mail"></i></div>
                                Messages
                                <span class="badge bg-success-soft text-success ms-auto">2 New!</span>
                            </a>
                            <div class="sidenav-menu-heading">Overall</div>
                            <a class="nav-link" href="admin.jsp">
                                <div class="nav-link-icon"><i data-feather="activity"></i></div>
                                Overall
                            </a>
                            <div class="sidenav-menu-heading">Admin Controller</div>
                            <a class="nav-link" href="adminUser.jsp">
                                <div class="nav-link-icon"><i data-feather="globe"></i></div>
                                User
                            </a>
                            <a class="nav-link collapsed" href="javascript:void(0);" data-bs-toggle="collapse" data-bs-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                                <div class="nav-link-icon"><i data-feather="grid"></i></div>
                                Product
                                <div class="sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapsePages" data-bs-parent="#productController">
                                <nav class="sidenav-menu-nested nav accordion" id="productController">
                                    <a class="nav-link" href="adminCategory.jsp">Category</a>
                                    <a class="nav-link" href="adminProduct.jsp">Product</a>
                                </nav>
                            </div>
                            <a class="nav-link" href="adminBlogs.jsp">
                                <div class="nav-link-icon"><i data-feather="file-text"></i></div>
                                Blogs
                            </a>
                            <a class="nav-link" href="adminBill.jsp">
                                <div class="nav-link-icon"><i data-feather="globe"></i></div>
                                Bill
                            </a>
                            <div class="sidenav-menu-heading">Admin Controller</div>
                            <a class="nav-link collapsed" href="javascript:void(0);" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="nav-link-icon"><i data-feather="layout"></i></div>
                                Layout
                                <div class="sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts" data-bs-parent="#accordionSidenav">
                                <nav class="sidenav-menu-nested nav accordion" id="accordionSidenavLayout">
                                    <!-- Nested Sidenav Accordion (Layout -> Navigation)-->
                                    <a class="nav-link collapsed" href="javascript:void(0);" data-bs-toggle="collapse" data-bs-target="#collapseLayoutSidenavVariations" aria-expanded="false" aria-controls="collapseLayoutSidenavVariations">
                                        Navigation
                                        <div class="sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="collapseLayoutSidenavVariations" data-bs-parent="#accordionSidenavLayout">
                                        <nav class="sidenav-menu-nested nav">
                                            <a class="nav-link" href="layout-static.html">Static Sidenav</a>
                                            <a class="nav-link" href="layout-dark.html">Dark Sidenav</a>
                                            <a class="nav-link" href="layout-rtl.html">RTL Layout</a>
                                        </nav>
                                    </div>
                                    <!-- Nested Sidenav Accordion (Layout -> Container Options)-->
                                    <a class="nav-link collapsed" href="javascript:void(0);" data-bs-toggle="collapse" data-bs-target="#collapseLayoutContainers" aria-expanded="false" aria-controls="collapseLayoutContainers">
                                        Container Options
                                        <div class="sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="collapseLayoutContainers" data-bs-parent="#accordionSidenavLayout">
                                        <nav class="sidenav-menu-nested nav">
                                            <a class="nav-link" href="layout-boxed.html">Boxed Layout</a>
                                            <a class="nav-link" href="layout-fluid.html">Fluid Layout</a>
                                        </nav>
                                    </div>
                                    <!-- Nested Sidenav Accordion (Layout -> Page Headers)-->
                                    <a class="nav-link collapsed" href="javascript:void(0);" data-bs-toggle="collapse" data-bs-target="#collapseLayoutsPageHeaders" aria-expanded="false" aria-controls="collapseLayoutsPageHeaders">
                                        Page Headers
                                        <div class="sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="collapseLayoutsPageHeaders" data-bs-parent="#accordionSidenavLayout">
                                        <nav class="sidenav-menu-nested nav">
                                            <a class="nav-link" href="header-simplified.html">Simplified</a>
                                            <a class="nav-link" href="header-compact.html">Compact</a>
                                            <a class="nav-link" href="header-overlap.html">Content Overlap</a>
                                            <a class="nav-link" href="header-breadcrumbs.html">Breadcrumbs</a>
                                            <a class="nav-link" href="header-light.html">Light</a>
                                        </nav>
                                    </div>
                                    <!-- Nested Sidenav Accordion (Layout -> Starter Layouts)-->
                                    <a class="nav-link collapsed" href="javascript:void(0);" data-bs-toggle="collapse" data-bs-target="#collapseLayoutsStarterTemplates" aria-expanded="false" aria-controls="collapseLayoutsStarterTemplates">
                                        Starter Layouts
                                        <div class="sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="collapseLayoutsStarterTemplates" data-bs-parent="#accordionSidenavLayout">
                                        <nav class="sidenav-menu-nested nav">
                                            <a class="nav-link" href="starter-default.html">Default</a>
                                            <a class="nav-link" href="starter-minimal.html">Minimal</a>
                                        </nav>
                                    </div>
                                </nav>
                            </div>
                        </div>
                    </div>
                    <!-- Sidenav Footer-->
                    <div class="sidenav-footer">
                        <div class="sidenav-footer-content">
                            <div class="sidenav-footer-subtitle">Logged in as:</div>
                            <div class="sidenav-footer-title">${sessionScope.LOGIN_USER.getUserID()}</div>
                        </div>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <header class="page-header page-header-dark bg-gradient-primary-to-secondary pb-10">
                        <div class="container-xl px-4">
                            <div class="page-header-content pt-4">
                                <div class="row align-items-center justify-content-between">
                                    <div class="col-auto mt-4">
                                        <h1 class="page-header-title">
                                            <div class="page-header-icon"><i data-feather="filter"></i></div>
                                            Products
                                        </h1>
                                        <div class="page-header-subtitle">Products in Empower Women Asia is ${sessionScope.PRODUCT_NUMBER}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </header>
                    <div class="container-xl px-4 mt-n10">
                        <c:if test="${sessionScope.PRODUCT_CHOOSE!=null}">
                            <c:set var="product" value="${sessionScope.PRODUCT_CHOOSE}"></c:set>
                                <div class="mb-4">
                                    <div class="card card-header-actions h-100">
                                        <div class="card-header">
                                            <div>Edit Product #${product.getID()}</div>
                                        <form action="ProductController" method="POST">
                                            <input type="hidden" name="previous" value="adminProduct.jsp">
                                            <button class="btn btn-light" name="action" value="close">×</button>
                                        </form>
                                    </div>
                                    <div class="card-body row">
                                        <div class="media align-items-center col-md-3">
                                            <c:if test="${product.getImage()!=null&&product.getImage().size()>0}">
                                                <div id="carouselExampleDark" class="carousel carousel-dark slide" data-bs-ride="carousel">
                                                    <div class="carousel-inner">
                                                        <div class="carousel-item active">
                                                            <img src="./assests/img/product/${product.ID}/${product.getImage().get(0).getImage()}" class="product-image" alt="" style="width: 300px;object-fit: cover"/>
                                                        </div>
                                                        <c:forEach items="${product.getImage()}" var="image">
                                                            <div class="carousel-item">
                                                                <img src="./assests/img/product/${product.ID}/${image.getImage()}" class="product-image" alt="" style="width: 300px;object-fit: cover"/>
                                                            </div>
                                                        </c:forEach>
                                                    </div>
                                                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
                                                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                                        <span class="visually-hidden">Previous</span>
                                                    </button>
                                                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
                                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                                        <span class="visually-hidden">Next</span>
                                                    </button>
                                                </div>
                                            </c:if>
                                            <div class="media-body ml-4">
                                                <button class="dropdown-item" data-bs-toggle="modal" data-bs-target="#uploadImage">
                                                    Edit Image
                                                </button>
                                            </div>
                                        </div>
                                        <div class="media col-md-9">
                                            <form action="ProductController" method="POST">
                                                <div class="row">
                                                    <div class="form-group col-md-3">
                                                        <label class="form-label">Product ID</label>
                                                        <input hidden name="productID" value="${product.ID}">
                                                        <input type="number" class="form-control mb-1" value="${product.getID()}" disabled>
                                                    </div>
                                                    <div class="form-group col-md-9">
                                                        <label class="form-label">Product Name</label>
                                                        <input type="text" name="name" class="form-control mb-1" value="${product.getName()}">
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="form-group col">
                                                        <label class="form-label">Category</label>
                                                        <select name="category" class="form-control">
                                                            <c:forEach items="${sessionScope.CATEGORY_LIST}" var="cate">
                                                                <c:choose>
                                                                    <c:when test="${cate.getID()==product.getCategoryID()}">
                                                                        <option selected="" value="${cate.getID()}"> ${cate.getName()}</option>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <option value="${cate.getID()}"> ${cate.getName()}</option>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <div class="form-group col">
                                                        <label class="form-label">Quantity</label>
                                                        <input type="number" class="form-control mb-1" name="quantity" value="${product.getQuantity()}">
                                                    </div>
                                                    <div class="form-group col">
                                                        <label class="form-label">Price</label>
                                                        <input type="number" class="form-control mb-1" name="price" step="any" value="${product.getPrice()}">
                                                    </div>
                                                    <div class="form-group col">
                                                        <label class="form-label">Status</label>
                                                        <select name="status" class="form-control">
                                                            <c:choose>
                                                                <c:when test="${product.isStatus() == true}">
                                                                    <option value="true" selected="selected">On</option>
                                                                    <option value="false">Off</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="false" selected="selected">Off</option>
                                                                    <option value="true">On</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="form-group col">
                                                        <label class="form-label">Describe</label>
                                                        <textarea class="form-control mb-1" rows="8" name="describe">${product.getDescribe()}</textarea>
                                                    </div>
                                                    <div class="form-group col">
                                                        <label class="form-label">Product Information</label>
                                                        <textarea class="form-control mb-1" rows="8" name="productInfo">${product.getProductInfo()}</textarea>
                                                    </div>
                                                </div>
                                                <div class="d-flex flex-row-reverse">
                                                    <input name="sort" type="hidden" value="${param.sort}"/>
                                                    <input name="page" type="hidden" value="${param.page}"/>
                                                    <input name="search" value="${param.search}" type="hidden"/>
                                                    <button class="btn btn-primary" name="action" value="Edit">Save Change</button>
                                                    <input type="reset" class="btn btn-default" value="Cancel">
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <div class="card mb-4">
                            <div class="card card-header-actions h-100">
                                <div class="card-header">
                                    <div>Product Table</div>
                                    <button class="btn btn-light" data-bs-toggle="modal" data-bs-target="#add">+</button>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <c:if test="${sessionScope.PRODUCT_LIST!=null}">
                                            <div class="row">
                                                <nav class="col" aria-label="Page navigation sample">
                                                    <ul class="pagination">
                                                        <c:forEach begin="1" end="${sessionScope.NUMBER_PAGES}" var="i">
                                                            <c:choose>
                                                                <c:when test="${currentPage eq i}">
                                                                    <c:url var="thisPage" value="ProductController">
                                                                        <c:if test="${param.search!=null && param.search!=''}">                          
                                                                            <c:param name="search" value="${param.search}"></c:param>                                        
                                                                        </c:if>
                                                                        <c:if test="${param.sort!=null && param.sort!=0}">
                                                                            <c:param name="sort" value="${param.sort}"></c:param>
                                                                        </c:if>

                                                                        <c:param name="page" value="${i}"></c:param>
                                                                    </c:url>
                                                                    <li class="page-item active"><a class="page-link" href="${thisPage}" hidden="">${i}</a></li>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <c:url var="choosePage" value="ProductController">
                                                                            <c:if test="${param.search!=null && param.search!=''}">                                              
                                                                                <c:param name="search" value="${param.search}"></c:param>                                         
                                                                            </c:if>
                                                                            <c:if test="${param.sort!=null && param.sort!=0}">
                                                                                <c:param name="sort" value="${param.sort}"></c:param>
                                                                            </c:if>
                                                                            <c:if test="${param.category!=null && param.category!=0}">
                                                                                <c:param name="category" value="${param.category}"></c:param>
                                                                            </c:if>

                                                                        <c:param name="page" value="${i}"></c:param>
                                                                    </c:url>
                                                                    <li class="page-item"><a class="page-link" href="${choosePage}">${i}</a></li>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:forEach>
                                                    </ul>
                                                </nav>
                                                <div class="col ms-auto" style="margin-left: 100px;">
                                                    <select class="form-control" onchange="handleSelect(this)">
                                                        <c:set var="sortList" value="${sessionScope.SORT_LIST}"/>
                                                        <c:forEach begin="0" end="${ fn:length(sortList) }" var="i">
                                                            <c:url var="sort" value="ProductController">
                                                                <c:if test="${param.search!=null && param.search!=''}"> 
                                                                    <c:param name="search" value="${param.search}"></c:param>   
                                                                </c:if>

                                                                <c:param name="sort" value="${i}"></c:param>
                                                            </c:url>
                                                            <c:choose>
                                                                <c:when test="${i==sessionScope.SORT}">
                                                                    <option selected="" value="${sort}">${sortList[i]}</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="${sort}">${sortList[i]}</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <header class="col ml-auto">
                                                    <div class="form-inline">
                                                        <form class="mr-md-auto">
                                                            <div class="input-group">
                                                                <div class="input-group input-group-joined input-group-solid">
                                                                    <form action="ProductController" method="POST">
                                                                        <input type="text" class="form-control pe-0" name="search" value="${param.search}"/>
                                                                        <button class="btn btn-light input-group-text">
                                                                            <i class="fas fa-search"></i>
                                                                        </button>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </header>
                                            </div>
                                            <table border="1" class="table table-striped col-lg-11">
                                                <thead class="thead-dark text-center">
                                                    <tr>
                                                        <th>Name</th>
                                                        <th>Description</th>
                                                        <th>Product Info</th>
                                                        <th>Category</th>
                                                        <th>Quantity</th>
                                                        <th>Price</th>
                                                        <th>Status</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="product" items="${sessionScope.PRODUCT_LIST}">
                                                    <form action="ProductController" method="POST">
                                                        <tr>
                                                            <td>${product.getName()}</td>
                                                            <td>${product.getDescribe()}</td>
                                                            <td>${product.getProductInfo()}</td>
                                                            <td>
                                                                <c:forEach items="${sessionScope.CATEGORY_LIST}" var="cate">
                                                                    <c:if test="${cate.getID()==product.getCategoryID()}">
                                                                        ${cate.getName()}
                                                                    </c:if>
                                                                </c:forEach>
                                                            </td>
                                                            <td>${product.getQuantity()}</td>
                                                            <td>${product.getPrice()}</td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${product.isStatus()==true}">
                                                                        <div class="badge bg-primary text-white rounded-pill">On Stock</div>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div class="badge bg-warning rounded-pill">Out Stock</div>
                                                                    </c:otherwise>
                                                                </c:choose>

                                                            </td>
                                                            <td>
                                                                <button name="action" value="detail" class="btn btn-datatable btn-icon btn-transparent-dark me-2">
                                                                    <div class="dropdown-item-icon"><i data-feather="edit"></i></div>
                                                                </button>
                                                                <input name="sort" type="hidden" value="${param.sort}"/>
                                                                <input name="page" type="hidden" value="${param.page}"/>
                                                                <input name="search" value="${param.search}" type="hidden"/>
                                                                <input hidden name="productID" value="${product.ID}">
                                                                <button name="action" value="delete" class="btn btn-datatable btn-icon btn-transparent-dark"><i data-feather="trash-2"></i></button>
                                                            </td>
                                                        </tr>
                                                    </form>
                                                </c:forEach>
                                                </tbody>
                                            </table>
                                            <div class="col-lg-1"></div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                </main>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="assests/javscript/scripts.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/litepicker/dist/bundle.js" crossorigin="anonymous"></script>
        <script src="assests/javscript/litepicker.js"></script>
        <script>
                                                        window.addEventListener('DOMContentLoaded', event => {
                                                            // Simple-DataTables
                                                            // https://github.com/fiduswriter/Simple-DataTables/wiki

                                                            const tableProduct = document.getElementById('tableProduct');
                                                            if (tableProduct) {
                                                                new simpleDatatables.DataTable(tableProduct);
                                                            }
                                                        });
                                                        function handleSelect(elm)
                                                        {
                                                            window.location = elm.value;
                                                        }
                                                        var image = document.getElementsByClassName('product-image');
                                                        for (var i = 0; i < image.length; i++) {
                                                            image[i].style.height = image[i].style.width;
                                                        }
                                                        var output = document.getElementById("result");
                                                        $('input[type="file"]').change(function () {
                                                            $.each(this.files, function () {
                                                                readURL(this);
                                                            });
                                                        });

                                                        function readURL(file) {
                                                            var reader = new FileReader();
                                                            reader.onload = function (e) {
                                                                var div = document.createElement("div");
                                                                var input = document.createElement("input");
                                                                div.classList.add('col-md-4');
                                                                var image = document.createElement("img");
                                                                var form = document.createElement("form");
                                                                form.action = "ProductController";
                                                                form.method = "POST"
                                                                image.src = e.target.result;
                                                                image.style.width = "100%";
                                                                image.style.objectFit = "cover";
                                                                input.type = "hidden";
                                                                input.name = "fileName";
                                                                input.value = file.name;
                                                                var name = document.createElement('p');
                                                                name.innerHTML = file.name;
                                                                name.style.textAlign = "center";
                                                                var close = document.createElement('button');
                                                                close.type = "button";
                                                                close.classList.add("btn");
                                                                close.classList.add("btn-outline-danger");
                                                                close.classList.add("delete-image");
                                                                close.name = "action";
                                                                close.value = "updateImg";
                                                                close.innerHTML = "×";
                                                                form.appendChild(image);
                                                                form.appendChild(input);
                                                                form.appendChild(name);
                                                                form.appendChild(close);
                                                                div.appendChild(form);
                                                                output.appendChild(div);
                                                            };
                                                            reader.readAsDataURL(file);
                                                        }
                                                        var closeImage = document.getElementsByClassName('delete-image');
                                                        closeImage = [...closeImage];
                                                        closeImage.forEach((item) => {
                                                            item.addEventListener("click", function () {
                                                                output.removeChild(item.parentNode);
                                                            });
                                                        });
        </script>
    </body>
</html>

