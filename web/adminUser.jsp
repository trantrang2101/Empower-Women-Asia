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
        <title>Empower Women Asia - Admin User</title>
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
                                            Users
                                        </h1>
                                        <div class="page-header-subtitle">Users signed in Empower Women Asia</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </header>
                    <div class="container-xl px-4 mt-n10">
                        <div class="card mb-4">
                            <div class="card-header">User Table</div>
                            <div class="card-body">
                                <table id="tableUser" class="table table-striped col-lg-10">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th>Username</th>
                                            <th>Create At</th>
                                            <th>Role</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${sessionScope.LIST_USER}" var="user">
                                        <form action="UserController" method="POST">
                                            <tr>
                                                <td>${user.getUserID()}</td>
                                                <td>${user.getCreateAt()}</td>
                                                <td>
                                                    <c:set var="getRolID" value="${user.roleID}"></c:set>
                                                        <select name="roleID">
                                                        <c:choose>
                                                            <c:when test="${getRolID=='AD'}">
                                                                <option value="AD" selected="selected">Admin</option>
                                                                <option value="US">User</option>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <option value="US" selected="selected">User</option>
                                                                <option value="AD">Admin</option>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </select>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${user.isStatus()==true}">
                                                            <div class="badge bg-primary text-white rounded-pill">Enable</div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="badge bg-warning rounded-pill">Disable</div>
                                                        </c:otherwise>
                                                    </c:choose>

                                                </td>
                                                <td>
                                                    <input type="hidden" name="userID" value="${user.getUserID()}">
                                                    <button class="btn btn-datatable btn-icon btn-transparent-dark me-2" name="action" value="Update"><i data-feather="edit"></i></button>
                                                        <c:url var="deleteLink" value="UserController">
                                                            <c:param name="action" value="Delete"></c:param>
                                                            <c:param name="userID" value="${user.userID}"></c:param>
                                                        </c:url>
                                                    <a class="btn btn-datatable btn-icon btn-transparent-dark" href="${deleteLink}"><i data-feather="trash-2"></i></a>
                                                </td>
                                            </tr>
                                        </form>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="assests/javscript/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assests/javscript/chart-area-demo.js"></script>
        <script src="assests/javscript/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="assests/javscript/datatables-simple-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/litepicker/dist/bundle.js" crossorigin="anonymous"></script>
        <script src="assests/javscript/litepicker.js"></script>
    </body>
</html>

