<%-- 
    Document   : product
    Created on : Jan 5, 2022, 10:46:19 AM
    Author     : Tran Trang
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link rel="icon" type="image/x-icon" href="assests/img/Logo.png" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <link rel="stylesheet" href="./included/navbar.css">
        <link rel="stylesheet" href="./assests/css/product.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500&display=swap" rel="stylesheet">
        <title>Empower Women Asia</title>
    </head>
    <body>
        <jsp:include page="included/navbar.jsp"/>
        <div class="wrapper">
            <div id="content">
                <section class="section-content padding-y">
                    <div class="container bootdey">
                        <div class="row">
                            <aside class="col-lg-3">
                                <div class="card">
                                    <article class="filter-group">
                                        <header class="card-header">
                                            <a href="#category" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Category</a>
                                        </header>
                                        <div class="filter-content collapse show" id="category">
                                            <div class="card-body">
                                                <ul class="list-menu">
                                                    <c:url var="category" value="ProductController">
                                                        <c:param name="category" value="0"></c:param>
                                                    </c:url>
                                                    <li><a href="${category}">All</a></li>
                                                        <c:forEach items="${sessionScope.CATEGORY_LIST}" var="cate">
                                                            <c:url var="category" value="ProductController">
                                                                <c:if test="${param.search!=null && param.search!=''}">
                                                                    <c:if test="${param.search!=null && param.search!=''}">           
                                                                        <c:param name="search" value="${param.search}"></c:param>      
                                                                    </c:if>
                                                                </c:if>
                                                                <c:if test="${param.sort!=null && param.sort!=0}">
                                                                    <c:param name="sort" value="${param.sort}"></c:param>
                                                                </c:if>
                                                                <c:param name="category" value="${cate.ID}"></c:param>
                                                            </c:url>
                                                        <li><a href="${category}">${cate.name}</a></li>
                                                        </c:forEach>
                                                </ul>

                                            </div>
                                        </div>
                                    </article>
                                    <article class="filter-group">
                                        <header class="card-header">
                                            <a href="#price" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Price range</a>
                                        </header>
                                        <div class="filter-content collapse show" id="price" style="">
                                            <div class="card-body">
                                                <div class="middle" style="width: 100%; margin-bottom: 10px;">
                                                    <div class="multi-range-slider">
                                                        <input type="range" id="input-left" min="${sessionScope.MIN_PRICE}" max="${sessionScope.MAX_PRICE}" value="${sessionScope.MIN_PRICE+50}" onchange="document.getElementById('min').value = this.value">
                                                        <input type="range" id="input-right" min="${sessionScope.MIN_PRICE}" max="${sessionScope.MAX_PRICE}" value="${sessionScope.MAX_PRICE-50}" onchange="document.getElementById('max').value = this.value">
                                                        <div class="slider">
                                                            <div class="track"></div>
                                                            <div class="range"></div>
                                                            <div class="thumb left"></div>
                                                            <div class="thumb right"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <form action="ProductController" method="POST">
                                                    <div class="form-row">
                                                        <div class="form-group col-md-6">
                                                            <label>Min</label>
                                                            <input id="min" name="min" type="number" step="0.1" class="form-control" value="${sessionScope.MIN_PRICE+50}">
                                                        </div>
                                                        <div class="form-group text-right col-md-6">
                                                            <label>Max</label>
                                                            <input id="max" name="max" type="number" step="0.1" class="form-control" value="${sessionScope.MAX_PRICE-50}">
                                                        </div>
                                                    </div>
                                                    <button class="btn btn-block btn-light" name="action" value="priceRange">Apply</button>
                                                </form>
                                            </div>
                                        </div>
                                    </article>
                                    <article class="filter-group">
                                        <header class="card-header">
                                            <a href="#size" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Sizes</a>
                                        </header>
                                        <div class="filter-content collapse show" id="size" style="">
                                            <div class="card-body">
                                                <label class="checkbox-btn">
                                                    <input type="checkbox">
                                                    <span class="btn btn-light"> XS </span>
                                                </label>

                                                <label class="checkbox-btn">
                                                    <input type="checkbox">
                                                    <span class="btn btn-light"> SM </span>
                                                </label>

                                                <label class="checkbox-btn">
                                                    <input type="checkbox">
                                                    <span class="btn btn-light"> LG </span>
                                                </label>

                                                <label class="checkbox-btn">
                                                    <input type="checkbox">
                                                    <span class="btn btn-light"> XXL </span>
                                                </label>
                                            </div>
                                        </div>
                                    </article> 
                                    <article class="filter-group">
                                        <header class="card-header">
                                            <a href="#more" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">More filter</a>
                                        </header>
                                        <div class="filter-content collapse in" id="more" style="">
                                            <div class="card-body">
                                                <label class="custom-control custom-radio">
                                                    <input type="radio" name="myfilter_radio" checked="" class="custom-control-input">
                                                    <div class="custom-control-label">Any condition</div>
                                                </label>

                                                <label class="custom-control custom-radio">
                                                    <input type="radio" name="myfilter_radio" class="custom-control-input">
                                                    <div class="custom-control-label">Brand new </div>
                                                </label>

                                                <label class="custom-control custom-radio">
                                                    <input type="radio" name="myfilter_radio" class="custom-control-input">
                                                    <div class="custom-control-label">Used items</div>
                                                </label>

                                                <label class="custom-control custom-radio">
                                                    <input type="radio" name="myfilter_radio" class="custom-control-input">
                                                    <div class="custom-control-label">Very old</div>
                                                </label>
                                            </div>
                                        </div>
                                    </article>
                                </div>

                            </aside>
                            <div class="col-lg-9">
                                <header class="border-bottom mb-4 pb-3">
                                    <div class="form-inline">
                                        <form class="mr-md-auto">
                                            <div class="input-group">
                                                <form action="ProductController" method="POST">
                                                    <input type="text" class="form-control border-right-0" name="search" value="${param.search}"/>
                                                    <span class="input-group-append">
                                                        <div class="input-group-text bg-white border-left-0"><i class="fa fa-search"></i></div>
                                                    </span>
                                                </form>
                                            </div>
                                        </form>
                                        <select class="mr-2 form-control" onchange="handleSelect(this)">
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
                                </header>

                                <div class="row">
                                    <c:forEach items="${sessionScope.PRODUCT_LIST}" var="product">
                                        <div class="col-md-4">
                                            <figure class="card card-product-grid">
                                                <div class="pro-img-box">
                                                    <a href="ProductController?action=detail&productID=${product.ID}">
                                                        <c:choose>
                                                            <c:when test="${product.getImage()!=null&&product.getImage().size()>0}">
                                                                <img src="./assests/img/product/${product.ID}/${product.getImage().get(0).getImage()}" alt="" style="height: 400px;width: 100%;object-fit: cover"/>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="./assests/img/Logo.png" alt="" style="height: 400px;width: 100%;object-fit: cover"/>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </a>
                                                    <form action="CartController" method="POST">
                                                        <input name="sort" type="hidden" value="${param.sort}"/>
                                                        <input name="page" type="hidden" value="${param.page}"/>
                                                        <input name="category" value="${param.category}" type="hidden"/>
                                                        <input name="search" value="${param.search}" type="hidden"/>
                                                        <input hidden name="productID" value="${product.ID}">
                                                        <button class="adtocart" name="action" value="add">
                                                            <i class="fa fa-shopping-cart"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                                <figcaption class="info-wrap">
                                                    <div class="panel-body text-center" style="height: 150px;">
                                                        <h4>
                                                            <form action="ProductController" method="POST">
                                                                <input hidden name="productID" value="${product.ID}">
                                                                <button class="pro-title" name="action" value="detail">${product.name}</button>
                                                            </form>
                                                        </h4>
                                                        <p class="price">$${product.price}</p>
                                                    </div>
                                                </figcaption>
                                            </figure>
                                        </div>
                                    </c:forEach>
                                    <c:if test="${sessionScope.PRODUCT_LIST == null}">
                                        <div class="card-body cart">
                                            <div class="col-sm-12 empty-cart-cls text-center" style="background-color: white; padding: 75px 0;"> <img src="https://i.imgur.com/dCdflKN.png" width="130" height="130" class="img-fluid mb-4 mr-3">
                                                <h2>Our Shop Is Empty</h2>
                                                <p>You can go some where to play</p>
                                                <form action="ProductController" method="POST">
                                                    <input class="productMenu btn btn-light" type="submit" name="action" value="Product"/>
                                                </form>
                                            </div>
                                        </div>
                                    </c:if>
                                </div> 
                                <nav class="mt-4" aria-label="Page navigation sample">
                                    <ul class="pagination">
                                        <c:if test="${sessionScope.CURRENT_PAGE > 1}">
                                            <c:url var="previousPage" value="ProductController">
                                                <c:if test="${param.search!=null && param.search!=''}">                          
                                                    <c:param name="search" value="${param.search}"></c:param>                    
                                                </c:if>
                                                <c:if test="${param.sort!=null && param.sort!=0}">
                                                    <c:param name="sort" value="${param.sort}"></c:param>
                                                </c:if>
                                                <c:if test="${param.category!=null && param.category!=0}">
                                                    <c:param name="category" value="${param.category}"></c:param>
                                                </c:if>
                                                <c:param name="page" value="${sessionScope.CURRENT_PAGE-1}"></c:param>
                                            </c:url>
                                            <li class="page-item"><a class="page-link" href="${previousPage}">«</a></li>
                                            </c:if>
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
                                                            <c:if test="${param.category!=null && param.category!=0}">
                                                                <c:param name="category" value="${param.category}"></c:param>
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
                                            <c:if test="${sessionScope.CURRENT_PAGE lt sessionScope.NUMBER_PAGES}">
                                                <c:url var="nextPage" value="ProductController">
                                                    <c:if test="${param.search!=null && param.search!=''}">                                            
                                                        <c:param name="search" value="${param.search}"></c:param>                                      
                                                    </c:if>
                                                    <c:if test="${param.sort!=null && param.sort!=0}">
                                                        <c:param name="sort" value="${param.sort}"></c:param>
                                                    </c:if>
                                                    <c:if test="${param.category!=null && param.category!=0}">
                                                        <c:param name="category" value="${param.category}"></c:param>
                                                    </c:if>
                                                    <c:param name="page" value="${sessionScope.CURRENT_PAGE+1}"></c:param>
                                                </c:url>
                                            <li class="page-item"><a class="page-link" href="${nextPage}">»</a></li>
                                            </c:if>
                                    </ul>
                                </nav>
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
                                            function handleSelect(elm)
                                            {
                                                window.location = elm.value;
                                            }
                                            $(document).ready(function () {
                                                $('#sidebarCollapse').on('click', function () {
                                                    $('#sidebar').toggleClass('active');
                                                });
                                            });
                                            var inputLeft = document.getElementById("input-left");
                                            var inputRight = document.getElementById("input-right");

                                            var thumbLeft = document.querySelector(".slider > .thumb.left");
                                            var thumbRight = document.querySelector(".slider > .thumb.right");
                                            var range = document.querySelector(".slider > .range");

                                            function setLeftValue() {
                                                var _this = inputLeft,
                                                        min = parseInt(_this.min),
                                                        max = parseInt(_this.max);

                                                _this.value = Math.min(parseInt(_this.value), parseInt(inputRight.value) - 1);

                                                var percent = ((_this.value - min) / (max - min)) * 100;

                                                thumbLeft.style.left = percent + "%";
                                                range.style.left = percent + "%";
                                            }
                                            setLeftValue();

                                            function setRightValue() {
                                                var _this = inputRight,
                                                        min = parseInt(_this.min),
                                                        max = parseInt(_this.max);

                                                _this.value = Math.max(parseInt(_this.value), parseInt(inputLeft.value) + 0.1);

                                                var percent = ((_this.value - min) / (max - min)) * 100;

                                                thumbRight.style.right = (100 - percent) + "%";
                                                range.style.right = (100 - percent) + "%";
                                            }
                                            setRightValue();

                                            inputLeft.addEventListener("input", setLeftValue);
                                            inputRight.addEventListener("input", setRightValue);

                                            inputLeft.addEventListener("mouseover", function () {
                                                thumbLeft.classList.add("hover");
                                            });
                                            inputLeft.addEventListener("mouseout", function () {
                                                thumbLeft.classList.remove("hover");
                                            });
                                            inputLeft.addEventListener("mousedown", function () {
                                                thumbLeft.classList.add("active");
                                            });
                                            inputLeft.addEventListener("mouseup", function () {
                                                thumbLeft.classList.remove("active");
                                            });

                                            inputRight.addEventListener("mouseover", function () {
                                                thumbRight.classList.add("hover");
                                            });
                                            inputRight.addEventListener("mouseout", function () {
                                                thumbRight.classList.remove("hover");
                                            });
                                            inputRight.addEventListener("mousedown", function () {
                                                thumbRight.classList.add("active");
                                            });
                                            inputRight.addEventListener("mouseup", function () {
                                                thumbRight.classList.remove("active");
                                            });
        </script>
    </body>
</html>
