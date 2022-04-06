<%-- 
    Document   : blogs
    Created on : Feb 14, 2022, 3:17:24 PM
    Author     : Tran Trang
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPX$('#qty_input').val()jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <link rel="icon" type="image/x-icon" href="assests/img/Logo.png" />
        <link rel="stylesheet" href="./assests/css/blogs.css">
        <link rel="stylesheet" href="./included/navbar.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500&display=swap" rel="stylesheet">
        <title>Empower Women Asia</title>
    </head>
    <body>
        <jsp:include page="included/navbar.jsp"/>
        <div class="wrapper" style="margin-top: 100px;">
            <div id="content">
                <section class="py-5">
                    <div class="container py-4" style="">
                        <div class="row gy-5">
                            <div class="col-lg-3 ml-auto">
                                <div class="mb-4">
                                    <div class="card-body p-0">
                                        <form action="BlogController" method="POST">
                                            <div class="input-group">
                                                <input type="text" class="form-control border-right-0" name="search" value="${param.search}"/>
                                                <span class="input-group-append">
                                                    <div class="input-group-text bg-white border-left-0"><i class="fa fa-search"></i></div>
                                                </span>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="row">
                                    <c:forEach var="blog" items="${sessionScope.BLOG_LIST}">
                                        <div class="col-lg-6 col-md-12 mb-5 blog-wrapper">
                                            <div class="blog-media">
                                                <img class="blog-image" src="./assests/img/blog/${blog.getImage()}">
                                            </div>
                                            <div class="blog-container text-white" style="position: relative;">
                                                <div class="blog-header">
                                                    <ul class="list-inline">
                                                        <input type="text" hidden="" value="${blog.getAuthorName()}" class="author">
                                                        <input type="text" hidden="" value="${blog.getPublishedAt()}" class="date">
                                                        <li class="me-2 writer-link fw-normal"></li>
                                                        <li class="mx-2 text-uppercase meta-link fw-normal"></li>
                                                    </ul>
                                                </div>
                                                <div></div>
                                                <div class="blog-body">
                                                    <h2 class="h3 mb-4">
                                                        <a class="d-block font-weight-bold text-uppercase reset-anchor" href="BlogController?action=detail&blogID=${blog.getBlogID()}">${blog.getTitle()}</a>
                                                    </h2>
                                                </div>
                                                <div class="row blog-footer" style="margin: 0 20px; padding-top: 20px; border-top: 2px solid white;">
                                                    <div class=" col text-left">
                                                        <c:choose>
                                                            <c:when test="${blog.isReact()}">
                                                                <i class="fas fa-heart heart" style="color: red;"></i>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="far fa-heart heart text-white" style="color: #676669;"></i>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <form class="reactPost" action="BlogController" method="POST">
                                                            <input type="hidden" name="blogID" value="${blog.getBlogID()}">
                                                            <button type="submit" name="action" value="react" hidden></button>
                                                        </form>
                                                    </div>
                                                    <a class=" btn btn-link p-0 read-more-btn col text-right"
                                                       href="BlogController?action=detail&blogID=${blog.getBlogID()}"><span>Read more</span><i class="fas fa-long-arrow-alt-right"></i>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <nav class="mt-4" aria-label="Page navigation sample">
                                <ul class="pagination">
                                    <c:if test="${sessionScope.THIS_PAGE > 1}">
                                        <c:url var="previousPage" value="BlogController">
                                            <c:if test="${param.search!=null && param.search!=''}">                          
                                                <c:param name="search" value="${param.search}"></c:param>                    
                                            </c:if>
                                            <c:if test="${param.sort!=null && param.sort!=0}">
                                                <c:param name="sort" value="${param.sort}"></c:param>
                                            </c:if>
                                            <c:if test="${param.category!=null && param.category!=0}">
                                                <c:param name="category" value="${param.category}"></c:param>
                                            </c:if>
                                            <c:param name="page" value="${sessionScope.THIS_PAGE-1}"></c:param>
                                        </c:url>
                                        <li class="page-item"><a class="page-link" href="${previousPage}">«</a></li>
                                        </c:if>
                                        <c:forEach begin="1" end="${sessionScope.BLOGS_PAGES}" var="i">
                                            <c:choose>
                                                <c:when test="${currentPage eq i}">
                                                    <c:url var="thisPage" value="BlogController">
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
                                                <li class="page-item active"><a class="page-link" href="${thisPage}" hidden="">${i}</a></li>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:url var="choosePage" value="BlogController">
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
                                        <c:if test="${sessionScope.THIS_PAGE lt sessionScope.BLOGS_PAGES}">
                                            <c:url var="nextPage" value="BlogController">
                                                <c:if test="${param.search!=null && param.search!=''}">                                            
                                                    <c:param name="search" value="${param.search}"></c:param>                                      
                                                </c:if>
                                                <c:if test="${param.sort!=null && param.sort!=0}">
                                                    <c:param name="sort" value="${param.sort}"></c:param>
                                                </c:if>
                                                <c:if test="${param.category!=null && param.category!=0}">
                                                    <c:param name="category" value="${param.category}"></c:param>
                                                </c:if>
                                                <c:param name="page" value="${sessionScope.THIS_PAGE+1}"></c:param>
                                            </c:url>
                                        <li class="page-item"><a class="page-link" href="${nextPage}">»</a></li>
                                        </c:if>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </section>
                <jsp:include page="included/footer.html"/>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#sidebarCollapse').on('click', function () {
                    $('#sidebar').toggleClass('active');
                });
            });
            var author = document.querySelectorAll('.author');
            var writer = document.querySelectorAll('.writer-link');
            for (var i = 0; i < author.length; i++) {
                var temp = author[i].value.split(' ')[author[i].value.split(' ').length - 2] + ' ' + author[i].value.split(' ')[author[i].value.split(' ').length - 1];
                writer[i].innerHTML = temp;
            }
            var date = document.querySelectorAll('.date');
            var meta = document.querySelectorAll('.meta-link');
            for (var i = 0; i < author.length; i++) {
                meta[i].innerHTML = date[i].value;
            }
            const heart = document.querySelectorAll('.heart');
            heart.forEach((item)=>{
                item.addEventListener('click', function () {
                    if (item.className === 'far fa-heart heart text-white') {
                        item.className = 'fas fa-heart heart';
                        item.style.color = 'red';
                    } else {
                        item.className = 'far fa-heart heart text-white';
                        item.style.color = '#676669';
                    }
                });
            });
        </script>
    </body>
</html>

