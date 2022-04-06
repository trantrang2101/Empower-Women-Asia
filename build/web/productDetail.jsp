<%-- 
    Document   : productDetail
    Created on : Jan 9, 2022, 8:42:48 PM
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <link rel='stylesheet' href='https://sachinchoolur.github.io/lightslider/dist/css/lightslider.css'>
        <link rel="icon" type="image/x-icon" href="assests/img/Logo.png" />
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        <link rel="stylesheet" href="./assests/css/productDetail.css"/>
        <link rel="stylesheet" href="./included/navbar.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500&display=swap" rel="stylesheet">
        <title>${sessionScope.PRODUCT_CHOOSE.name}</title>
    </head>
    <body>
        <jsp:include page="included/navbar.jsp"/>
        <div class="wrapper" style="margin-top: 100px;">
            <c:set var="product" value="${sessionScope.PRODUCT_CHOOSE}"></c:set>
            <c:if test="${product == null}">
                <c:redirect url="product.jsp"></c:redirect>
            </c:if>
            <nav aria-label="breadcrumb" style="margin-top: 50px;">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="home.jsp">Home</a></li>
                    <li class="breadcrumb-item"><a href="product.jsp">Product</a></li>
                        <c:forEach items="${sessionScope.CATEGORY_LIST}" var="cate">
                            <c:url var="category" value="ProductController">
                                <c:param name="category" value="${cate.ID}"></c:param>
                            </c:url>
                            <c:if test="${cate.ID==product.categoryID}">
                            <li class="breadcrumb-item"><a href="${category}">${cate.name}</a></li>
                            </c:if>
                        </c:forEach>
                    <li class="breadcrumb-item active" aria-current="page">${product.name}</li>
                </ol>
            </nav>
            <div class="container-fluid mt-2 mb-3">
                <div class="row no-gutters">
                    <div class="col-md-5 pr-2">
                        <div class="card">
                            <div class="demo">
                                <ul id="lightSlider">
                                    <c:forEach items="${product.getImage()}" var="productImg">
                                        <li data-thumb="./assests/img/product/${productImg.getProductID()}/${productImg.getImage()}">
                                            <img src="./assests/img/product/${productImg.getProductID()}/${productImg.getImage()}"/>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-7">
                        <div class="card">
                            <!--                        <div class="d-flex flex-row align-items-center">
                                                        <div class="p-ratings"> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> <i class="fa fa-star"></i> </div> <span class="ml-1">5.0</span>
                                                    </div>-->
                            <div class="about"> <span class="font-weight-bold">${product.name}</span>
                                <h4 class="font-weight-bold">$${product.price}</h4>
                            </div>
                            <div class="buttons"> 
                                <form action="CartController" method="POST">
                                    <input hidden name="productID" value="${product.ID}">
                                    <input hidden name="previous" value="productDetail.jsp">
                                    <button class="btn btn-outline-warning btn-long cart adtocart" name="action" value="add">Add to Cart</button> 
                                </form>
                                <!--<button class="btn btn-warning btn-long buy">Buy it Now</button>-->
                            </div>
                            <hr>
                            <div class="product-description">
                                <div class="d-flex flex-row align-items-center"> <i class="fa fa-calendar-check-o"></i> <span class="ml-1">Delivery from Switzerland, 15-45 days</span> </div>
                                <div class="mt-2"> 
                                    <span class="font-weight-bold">Description</span>
                                    <p>${product.describe}</p>
                                </div>
                                <div class="mt-2"> 
                                    <span class="font-weight-bold">Product Info</span>
                                    <p>${product.productInfo}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="included/footer.html"/>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2" crossorigin="anonymous"></script>
    <script src='https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js'></script>
    <script src='https://sachinchoolur.github.io/lightslider/dist/js/lightslider.js'></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#sidebarCollapse').on('click', function () {
                $('#sidebar').toggleClass('active');
            });
        });
        $('#lightSlider').lightSlider({
            gallery: true,
            item: 1,
            loop: true,
            slideMargin: 0,
            thumbItem: 9
        });
    </script>
</body>
</html>
