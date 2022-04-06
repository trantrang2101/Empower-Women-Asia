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
        <c:set var="blog" value="${sessionScope.BLOG_CHOOSE}"></c:set>
        <c:if test="${blog == null}">
            <c:redirect url="BlogController"></c:redirect>
        </c:if>
        <jsp:include page="included/navbar.jsp"/>
        <div class="wrapper" style="margin-top: 100px;">
            <div id="content">
                <section class="py-5">
                    <div class="py-4">
                        <div class="row text-center">
                            <div class="col-lg-8 mx-auto">
                                <h1 class="text-uppercase">${blog.getTitle()}</h1>
                                <div class="row text-white">
                                    <ul class="list-inline mb-5 text-center col">
                                        <input type="text" hidden value="${blog.getAuthorName()}" class="author">
                                        <input type="text" hidden value="${blog.getPublishedAt()}" class="date">
                                        <li class="list-inline-item mx-2 text-uppercase writer-link reset-anchor"></li>
                                        <li class="list-inline-item mx-2 text-uppercase meta-link text-muted reset-anchor"></li>
                                    </ul>
                                    <a class="col p-0 list-inline-item mx-2 text-uppercase read-more-btn mr-auto reset-anchor" href="BlogController"><span>Return Blogs Page&nbsp;<i class="fas fa-long-arrow-alt-right" style="font-size: 24px;"></i></span></a>
                                </div>
                            </div>
                        </div>
                        <div class="image-cover">
                            <c:if test="${blog.getImage()!=null}">
                                <img class="w-100 mb-5" style="margin: 0!important" src="assests/img/blog/${blog.getImage()}" alt="...">
                            </c:if>
                            <div class="image-wrapper">
                                <div class="container gy-5 summary-wrapper">
                                    <p class="lead drop-caps mb-5 summary" style="margin: 0!important">${blog.getSummary()}</p>
                                </div>
                            </div>
                            <div class="blog-cover">
                                <div class="container blog-content">${blog.getContent()}</div>
                                <div class="container">
                                    <hr>
                                    <div class="row">
                                        <div class="col text-left">
                                            <c:if test="${sessionScope.BLOG_PREVIOUS!=null}">
                                                <a class="btn btn-link p-0 read-more-btn" href="BlogController?action=detail&blogID=${sessionScope.BLOG_PREVIOUS}"><span><i class="fas fa-long-arrow-alt-left"></i>Newer Blog</span></a>
                                                        </c:if>
                                        </div>
                                        <div class="text-center col p-0"><span>Recent Post</span></div>
                                        <div class="col text-right">
                                            <c:if test="${sessionScope.BLOG_NEXT!=null}">
                                                <a class="btn btn-link p-0 read-more-btn" href="BlogController?action=detail&blogID=${sessionScope.BLOG_NEXT}"><span>Older Blog<i class="fas fa-long-arrow-alt-right"></i></span></a>
                                                    </c:if>
                                        </div>
                                    </div>
                                    <hr>     
                                </div>
                                <div class="row" style="margin-top: 40px;">
                                    <c:forEach begin="0" end="3" var="x">    
                                        <c:set var="post" value="${sessionScope.BLOG_LIST.get(x)}"></c:set>
                                            <div class="col-lg-3 col-md-12 mb-5 small-blog">
                                                <a class="d-block mb-4" href="BlogController?action=detail&blogID=${post.getBlogID()}">
                                                <c:choose>
                                                    <c:when test="${post.getImage()!=null}">
                                                        <img class="img-fluid" style="width:100%;height:200px;object-fit:cover;"  src="assests/img/blog/${post.getImage()}" alt="..."/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img class="img-fluid" style="width:100%;height:200px;object-fit:cover;"  src="assests/img/Logo.png" alt="..."/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </a>
                                            <ul class="list-inline">
                                                <input type="text" hidden value="${post.getAuthorName()}" class="author">
                                                <input type="text" hidden value="${post.getPublishedAt()}" class="date">
                                                <li class="me-2 writer-link fw-normal"></li>
                                                <li class="mx-2 text-uppercase meta-link fw-normal"></li>
                                            </ul>
                                            <h2 class="h3 mb-4 blog-title">
                                                <c:choose>
                                                    <c:when test="${blog.getBlogID()==post.getBlogID()}">
                                                        <a class="d-block text-uppercase reset-anchor font-weight-bold" style="color: #ef5285;">${blog.getTitle()}</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a class="d-block text-uppercase reset-anchor font-weight-bold" href="BlogController?action=detail&blogID=${post.getBlogID()}">${blog.getTitle()}</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </h2>
                                            <p class="text-muted blog-summary">${post.getSummary()}</p><a class="btn btn-link p-0 read-more-btn" href="BlogController?action=detail&blogID=${post.getBlogID()}"><span>Read more</span><i class="fas fa-long-arrow-alt-right"></i></a>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
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
        </script>
    </body>
</html>

