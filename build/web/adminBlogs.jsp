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
                        <h5 class="modal-title" id="uploadImage">Add new Post</h5>
                        <button type="button" class="btn btn-light" aria-label="Close" data-bs-dismiss="modal">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <form action="BlogController" method="POST">
                        <div class="modal-body" style="padding: 0;width: 100%;object-fit: cover;">
                            <div class="row">
                                <div class="form-group col-md-3">
                                    <label class="form-label">Post ID</label>
                                    <input type="number" class="form-control mb-1" value="${sessionScope.BLOG_NUMBER+1}" disabled>
                                </div>
                                <div class="form-group col-md-9">
                                    <div class="form-group col">
                                        <label class="form-label">Author</label>
                                        <input type="text" name="author" class="form-control mb-1" value="">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="form-label">Post Title</label>
                                <input type="text" name="title" class="form-control mb-1" value="">
                            </div>
                            <div class="form-group">
                                <label class="form-label">Post Summary</label>
                                <input type="text" class="form-control mb-1" name="summary" value="">
                            </div>
                            <div class="form-group">
                                <label class="form-label">Post Content</label>
                                <textarea id="postAdd" class="form-control mb-1" name="content"></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input name="page" type="hidden" value="${param.page}"/>
                            <input name="search" value="${param.search}" type="hidden"/>
                            <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
                            <button class="btn btn-dark" name="action" value="addBlog">Save Changes</button>
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
                            <div class="collapse" id="collapsePages" data-bs-parent="#blogController">
                                <nav class="sidenav-menu-nested nav accordion" id="blogController">
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
                                            Blogs
                                        </h1>
                                        <div class="page-header-subtitle">Blogs in Empower Women Asia is ${sessionScope.BLOG_NUMBER}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </header>
                    <div class="container-xl px-4 mt-n10">
                        <c:if test="${sessionScope.BLOG_CHOOSE!=null}">
                            <c:set var="blog" value="${sessionScope.BLOG_CHOOSE}"></c:set>
                                <div class="mb-4">
                                    <div class="card card-header-actions h-100">
                                        <div class="card-header">
                                            <div>Edit Blogs #${blog.getBlogID()}</div>
                                        <form action="BlogController" method="POST">
                                            <input type="hidden" name="previous" value="adminBlogs.jsp">
                                            <button class="btn btn-light" name="action" value="close">×</button>
                                        </form>
                                    </div>
                                    <div class="card-body row">
                                        <div class="col-md-4">
                                            <c:choose>
                                                <c:when test="${blog.getImage()!=null}">
                                                    <img src="./assests/img/blog/${blog.getImage()}" alt="" id="result" class="d-block ui-w-80" style="width: 100%;height: auto;object-fit: cover;">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="./assests/img/Logo.png" alt="" id="result" class="d-block ui-w-80" style="width: 100%;height: auto;object-fit: cover;">
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="col-md-8">
                                            <div class="row">
                                                <div class="form-group col-md-3">
                                                    <label class="form-label">Post ID</label>
                                                    <input type="number" class="form-control mb-1" value="${blog.getBlogID()}" disabled="">
                                                </div>
                                                <div class="form-group col-md-9">
                                                    <form action="FileUploadHandler" id="myForm" method="POST"  enctype="multipart/form-data">
                                                        <label class="form-label">Post Image</label>
                                                        <input type="file" class="account-settings-fileinput" id="files" onchange="readURL(this)" multiple="false" name="file" accept="image/*" hidden="">
                                                        <div class="form-control border-0" style="padding: 0;">
                                                            <label for="files" class="btn btn-outline-primary">
                                                                Upload new photo
                                                            </label><input type="submit" class="btn btn-primary" value="Upload">
                                                            <div class="text-dark small mt-1">Allowed JPG, GIF or PNG. Max size of 800K</div>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                            <form action="BlogController" method="POST">
                                                <div class="row">
                                                    <div class="form-group col-md-9">
                                                        <label class="form-label">Post Title</label>
                                                        <input type="hidden" name="blogID" class="form-control mb-1" value="${blog.getBlogID()}">
                                                        <input type="text" name="title" class="form-control mb-1" value="${blog.getTitle()}">
                                                    </div>
                                                    <div class="form-group col">
                                                        <label class="form-label">Author</label>
                                                        <input type="text" name="author" class="form-control mb-1" value="${blog.getAuthorName()}">
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="form-group col-md-4">
                                                        <label class="form-label">Published Day</label>
                                                        <input type="text" id="valueDate" value="${blog.getPublishedAt()}" hidden="">
                                                        <input type="datetime-local" id="dateInput" name="dayPublished" class="form-control mb-1">
                                                    </div>
                                                    <div class="form-group col-md-8">
                                                        <label class="form-label">Post Summary</label>
                                                        <input type="text" class="form-control mb-1" name="summary" value="${blog.getSummary()}">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="form-label">Post Content</label>
                                                    <textarea id="postEditor" class="form-control mb-1" rows="15" name="content">${blog.getContent()}</textarea>
                                                </div>
                                        </div>
                                        <div class="d-flex flex-row-reverse">
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
                                <div>Blog Table</div>
                                <button class="btn btn-light" data-bs-toggle="modal" data-bs-target="#add">+</button>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <c:if test="${sessionScope.BLOG_LIST!=null}">
                                        <div class="row">
                                            <nav class="col" aria-label="Page navigation sample">
                                                <ul class="pagination">
                                                    <c:forEach begin="1" end="${sessionScope.BLOGS_PAGES}" var="i">
                                                        <c:choose>
                                                            <c:when test="${currentPage eq i}">
                                                                <c:url var="thisPage" value="BlogController">
                                                                    <c:if test="${param.search!=null && param.search!=''}">                          
                                                                        <c:param name="search" value="${param.search}"></c:param>                                        
                                                                    </c:if>
                                                                    <c:param name="page" value="${i}"></c:param>
                                                                </c:url>
                                                                <li class="page-item active"><a class="page-link" href="${thisPage}" hidden="">${i}</a></li>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <c:url var="choosePage" value="BlogController">
                                                                        <c:if test="${param.search!=null && param.search!=''}">                                              
                                                                            <c:param name="search" value="${param.search}"></c:param>                                         
                                                                        </c:if>
                                                                        <c:param name="page" value="${i}"></c:param>
                                                                    </c:url>
                                                                <li class="page-item"><a class="page-link" href="${choosePage}">${i}</a></li>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                </ul>
                                            </nav>
                                            <header class="col ml-auto">
                                                <div class="form-inline">
                                                    <form class="mr-md-auto">
                                                        <div class="input-group">
                                                            <div class="input-group input-group-joined input-group-solid">
                                                                <form action="BlogController" method="POST">
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
                                        <hr>
                                        <table border="1" class="table table-striped col-lg-11">
                                            <thead class="thead-dark text-center">
                                                <tr>
                                                    <th>Title</th>
                                                    <th>Author</th>
                                                    <th>Summary</th>
                                                    <th>Status</th>
                                                    <th>Created</th>
                                                    <th>Published</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="blog" items="${sessionScope.BLOG_LIST}">
                                                <form action="BlogController" method="POST">
                                                    <tr>
                                                        <td>${blog.getTitle()}</td>
                                                        <td>${blog.getAuthorName()}</td>
                                                        <td>${blog.getSummary()}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${blog.isPublished()}">
                                                                    <div class="badge bg-primary text-white rounded-pill">Published</div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="badge bg-warning rounded-pill">Draft</div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>${blog.getCreatedAt()}</td>
                                                        <td>${blog.getPublishedAt()}</td>
                                                        <td>
                                                            <button name="action" value="detail" class="btn btn-datatable btn-icon btn-transparent-dark me-2">
                                                                <div class="dropdown-item-icon"><i data-feather="edit"></i></div>
                                                            </button>
                                                            <input name="page" type="hidden" value="${param.page}"/>
                                                            <input name="search" value="${param.search}" type="hidden"/>
                                                            <input hidden name="blogID" value="${blog.getBlogID()}">
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
        <script src="assests/javscript/moment.js"></script>
        <script src="./assests/ckeditor/ckeditor.js" type="text/javascript"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://unpkg.com/easymde/dist/easymde.min.js" crossorigin="anonymous"></script>
        <script src="assests/javscript/litepicker.js"></script>
        <script>
                                                            window.addEventListener('DOMContentLoaded', event => {
                                                                // Simple-DataTables
                                                                // https://github.com/fiduswriter/Simple-DataTables/wiki

                                                                const tableBlog = document.getElementById('tableBlog');
                                                                if (tableBlog) {
                                                                    new simpleDatatables.DataTable(tableBlog);
                                                                }
                                                                CKEDITOR.replace('postAdd');
                                                                CKEDITOR.replace('postEditor');
                                                            });
                                                            function handleSelect(elm)
                                                            {
                                                                window.location = elm.value;
                                                            }
                                                            function readURL(input) {
                                                                if (input.files && input.files[0]) {
                                                                    var reader = new FileReader();

                                                                    reader.onload = function (e) {
                                                                        $('#result').attr('src', e.target.result);
                                                                    };
                                                                    reader.readAsDataURL(input.files[0]);
                                                                }
                                                            }
                                                            var inputDate = document.querySelectorAll('#dateInput')[0];
                                                            var date = document.querySelectorAll('#valueDate')[0];
                                                            var day = date.value.split('T')[0].split('-');
                                                            var time = date.value.split('T')[1].split(':');
                                                            inputDate.value = moment(new Date(day[2], day[1] - 1, day[0], time[0], time[1])).format('YYYY-MM-DDTHH:mm');
                                                            if (new Date().getTime() < new Date(day[2], day[1] - 1, day[0], time[0], time[1]).getTime()) {
                                                                inputDate.min = moment(new Date()).format('YYYY-MM-DDTHH:mm');
                                                            } else {
                                                                inputDate.min = moment(new Date(day[2], day[1] - 1, day[0], time[0], time[1])).format('YYYY-MM-DDTHH:mm');
                                                            }
        </script>
    </body>
</html>

