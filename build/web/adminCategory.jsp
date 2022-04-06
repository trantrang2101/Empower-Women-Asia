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
        <div class="modal fade" id="add" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="uploadImage">Add new Category</h5>
                        <button type="button" class="btn btn-light" aria-label="Close" data-bs-dismiss="modal">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <form action="CategoryController" method="POST">
                        <div class="modal-body row" style="padding: 0;width: 100%;object-fit: cover;">
                            <div class="row">
                                <div class="form-group col-md-3">
                                    <label class="form-label">Category ID</label>
                                    <input type="number" class="form-control mb-1" value="${sessionScope.CATEGORY_LIST.size()+1}" disabled>
                                </div>
                                <div class="form-group col-md-9">
                                    <label class="form-label">Category Name</label>
                                    <input type="text" name="name" class="form-control mb-1" value="">
                                </div>
                            </div>
                            <div class="form-group col">
                                <label class="form-label">Describe</label>
                                <textarea class="form-control mb-1" rows="20" name="describe"></textarea>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                            <button class="btn btn-dark" name="action" value="addCategory">Save Changes</button>
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
                            <a class="nav-link" href="admin.jsp">
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
                                            Categories
                                        </h1>
                                        <div class="page-header-subtitle">A type, or a group of products having some features that are the same</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </header>
                    <div class="container-xl px-4 mt-n10">
                        <c:if test="${sessionScope.CATEGORY_CHOOSE!=null}">
                            <c:set var="cate" value="${sessionScope.CATEGORY_CHOOSE}"></c:set>
                                <div class="mb-4">
                                    <div class="card card-header-actions h-100">
                                        <div class="card-header">
                                            <div>Edit Category #${cate.getID()}</div>
                                        <form action="CategoryController" method="POST">
                                            <input type="hidden" name="previous" value="adminCategory.jsp">
                                            <button class="btn btn-light" name="action" value="close">×</button>
                                        </form>
                                    </div>
                                    <div class="card-body">
                                        <div class="media">
                                            <form action="CategoryController" method="POST">
                                                <div class="row">
                                                    <div class="form-group col-md-3">
                                                        <label class="form-label">Category ID</label>
                                                        <input hidden name="productID" value="${cate.ID}">
                                                        <input type="number" class="form-control mb-1" value="${cate.getID()}" disabled>
                                                    </div>
                                                    <div class="form-group col-md-9">
                                                        <label class="form-label">Category Name</label>
                                                        <input type="text" name="name" class="form-control mb-1" value="${cate.getName()}">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="form-label">Describe</label>
                                                    <textarea class="form-control mb-1" rows="8" name="describe">${cate.getDescribe()}</textarea>
                                                </div>
                                                <div class="d-flex flex-row-reverse">
                                                    <button class="btn btn-primary" name="action" value="Update">Save Change</button>
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
                                    <c:if test="${sessionScope.CATEGORY_LIST!=null}">
                                        <table id="tableCategory" class="table table-striped col-lg-10">
                                            <thead class="thead-dark">
                                                <tr>
                                                    <th>Name</th>
                                                    <th>Describe</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${sessionScope.CATEGORY_LIST}" var="cate">
                                                    <tr>
                                                        <td>${cate.getName()}</td>
                                                        <td>${cate.getDescribe()}</td>
                                                        <td>
                                                            <form action="CategoryController" method="POST">
                                                                <input type="text" hidden="" name="categoryID" value="${cate.getID()}">
                                                                <input type="text" hidden="" name="previous" value="adminCategory.jsp">
                                                                <button type="submit" class="btn btn-datatable btn-icon btn-transparent-dark me-2" name="action" value="GetCategory"><i data-feather="edit"></i></button>
                                                                <button type="submit" class="btn btn-datatable btn-icon btn-transparent-dark" name="action" value="DeleteCategory"><i data-feather="trash-2"></i></button>
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                </main>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="assests/javscript/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/litepicker/dist/bundle.js" crossorigin="anonymous"></script>
        <script src="assests/javscript/litepicker.js"></script>
    </body>
</html>

