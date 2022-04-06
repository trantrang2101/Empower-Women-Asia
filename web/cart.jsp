<%-- 
    Document   : cart
    Created on : Jan 6, 2022, 1:21:45 AM
    Author     : Tran Trang
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
        <link rel="stylesheet" href="./included/navbar.css">
        <link rel="stylesheet" href="./assests/css/cart.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500&display=swap" rel="stylesheet">
        <title>Empower Women Asia</title>
    </head>
    <body>

        <div class="wrapper">
            <jsp:include page="included/navbar.jsp"/>
            <div id="content">
                <c:choose>
                    <c:when test="${sessionScope.CART_PRODUCTS == null||sessionScope.CART_PRODUCTS.size()==0}">
                        <div class="card-body cart">
                            <div class="row">
                                <div class="col-sm-2"></div>
                                <div class="col-sm-8 empty-cart-cls text-center" style="background-color: white; padding: 75px 0;border-radius: 10px;"> <img src="https://i.imgur.com/dCdflKN.png" width="130" height="130" class="img-fluid mb-4 mr-3">
                                    <h2>Your Cart is Empty</h2>
                                    <p>Your cart have nothing in here</p>
                                    <form action="ProductController" method="POST">
                                        <input class="productMenu btn btn-dark" type="submit" name="action" value="Product"/>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <section class="section-content padding-y">
                            <c:if test="${requestScope.ERROR!=null}">
                                <div class="alert alert-danger alert-dismissible" role="alert">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <strong>Warring!</strong> ${requestScope.ERROR}!</a>
                                </div>
                            </c:if>
                            <div class="container">
                                <div class="row">
                                    <main class="col-md-9">
                                        <div class="card">
                                            <table class="table table-borderless table-shopping-cart">
                                                <thead class="text-muted">
                                                    <tr class="small text-uppercase">
                                                        <th scope="col">#</th>
                                                        <th scope="col">Product</th>
                                                        <th scope="col">Quantity</th>
                                                        <th scope="col" width="120">Price</th>
                                                        <th scope="col" class="text-right" width="200"></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:set var="size" value="${sessionScope.CART_PRODUCTS.size()-1}"></c:set>
                                                    <c:forEach begin="0" end="${size}" var="x">      
                                                        <c:set var="i" value="${size-x}"></c:set>
                                                        <c:set var="product" value="${sessionScope.CART_PRODUCTS.get(i)}"></c:set>
                                                        <form action="CartController" method="POST">
                                                            <tr>
                                                                <td>
                                                                    <input name="productID" type="hidden" value="${product.ID}"/>
                                                                <c:choose>
                                                                    <c:when test="${sessionScope.CART_CHECK.get(i)}">
                                                                        <input class="getCheckBox" name="get" type="checkbox" checked="">
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <input class="getCheckBox" name="get" type="checkbox">
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <input class="actionCheck" type="submit" name="action" value="check" hidden="">
                                                            </td>
                                                    </form>
                                                    <td>
                                                        <figure class="itemside">
                                                            <div class="aside">
                                                                <a href="ProductController?action=detail&productID=${product.ID}"><img src="./assests/img/product/${product.ID}/${product.getImage().get(0).getImage()}" class="img-sm" style="height: 80px; width: 80px;object-fit: cover;"></a>
                                                            </div>
                                                            <figcaption class="info">
                                                                <a href="ProductController?action=detail&productID=${product.ID}" class="title text-dark">${product.name}</a>
                                                            </figcaption>
                                                        </figure>
                                                    </td>
                                                    <form action="CartController" method="POST">
                                                        <td> 
                                                            <input name="productID" type="hidden" value="${product.ID}"/>
                                                            <div class="input-group">
                                                                <div class="input-group-prepend">
                                                                    <button class="btn btn-default btn-sm minus-btn" name="action" value="Update"><i class="fa fa-minus"></i></button>
                                                                </div>
                                                                <input type="text" onkeypress='return isNumberKey(event)' onchange="updateQuantity(this)" class="form-control qty_input text-center form-control-sm" name="quantity" value="${product.quantity}" required="" style="width: 50px;"/>
                                                                <div class="input-group-prepend">
                                                                    <button class="btn btn-default btn-sm plus-btn" name="action" value="Update"><i class="fa fa-plus"></i></button>
                                                                </div>                                                           
                                                            </div>
                                                        </td>
                                                        <td> 
                                                            <div class="price-wrap"> 
                                                                <var class="price">$${product.price*product.quantity}</var> <br>
                                                                <small class="text-muted"> $${product.price} each </small> 
                                                            </div>
                                                        </td>
                                                        <td class="text-right"> 
                                                            <button name="action" class="btn btn-light" value="Remove">Remove</button>
                                                        </td>
                                                    </form>
                                                    <td class="text-right">
                                                        <form action="CartController" method="POST">
                                                            <input name="productID" type="hidden" value="${product.ID}"/>
                                                            <button hidden class="btn btn-light" id="updateQuantity">Update</button>
                                                        </form>
                                                    </td>
                                                    </tr>
                                                </c:forEach>
                                                </tbody>
                                            </table>

                                            <div class="card-body border-top">
                                                <a href="ProductController" class="btn btn-light"> <i class="fa fa-chevron-left"></i> Continue shopping </a>
                                            </div>	
                                        </div>

                                        <div class="alert alert-success mt-3">
                                            <p class="icontext"><i class="icon text-success fa fa-truck"></i> Free Delivery within 1-2 weeks</p>
                                        </div>

                                    </main> <!-- col.// -->
                                    <aside class="col-md-3">
                                        <!--                                    <div class="card mb-3">
                                                                                <div class="card-body">
                                                                                    <form>
                                                                                        <div class="form-group">
                                                                                            <label>Have coupon?</label>
                                                                                            <div class="input-group">
                                                                                                <input type="text" class="form-control" name="" placeholder="Coupon code">
                                                                                                <span class="input-group-append"> 
                                                                                                    <button class="btn btn-primary">Apply</button>
                                                                                                </span>
                                                                                            </div>
                                                                                        </div>
                                                                                    </form>
                                                                                </div>  card-body.// 
                                                                            </div>   card .// -->
                                        <div class="card">
                                            <div class="card-body">
                                                <dl class="dlist-align">
                                                    <dt>Total price:</dt>
                                                    <dd class="text-right">$${sessionScope.TOTAL_CART}</dd>
                                                </dl>
                                                <dl class="dlist-align">
                                                    <dt>Total:</dt>
                                                    <dd class="text-right  h5"><strong>$${sessionScope.TOTAL_CART}</strong></dd>
                                                </dl>
                                                <hr>
                                                <p class="text-center mb-3">
                                                    <a href="checkout.jsp" type="submit" class="btn form-control btn-light rounded submit px-3" value="Checkout" name="action">Check out</a>
                                                </p>
                                            </div>
                                        </div>
                                    </aside>
                                </div>
                            </div> 
                        </section>
                    </c:otherwise>
                </c:choose>
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
                                                                    function isNumberKey(evt) {
                                                                        var charCode = (evt.which) ? evt.which : evt.keyCode;
                                                                        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                                                                            return false;
                                                                        }
                                                                        return true;
                                                                    }
                                                                    var quantity = document.querySelectorAll(".qty_input");
                                                                    var plus = document.querySelectorAll(".plus-btn");
                                                                    var minus = document.querySelectorAll(".minus-btn");
                                                                    for (let i = 0; i < plus.length; i++) {
                                                                        plus[i].addEventListener("click", () => {
                                                                            console.log(i);
                                                                            console.log(quantity[i]);
                                                                            quantity[i].value = parseInt(quantity[i].value) + 1;
                                                                        });
                                                                    }
                                                                    for (let i = 0; i < minus.length; i++) {
                                                                        minus[i].addEventListener("click", function () {
                                                                            quantity[i].value = parseInt(quantity[i].value) - 1;
                                                                            if (quantity[i].value <= 0) {
                                                                                quantity[i].value = 1;
                                                                            }
                                                                        });
                                                                    }
                                                                    function updateQuantity(a) {
                                                                        if (a.value === "" || a.value === null) {
                                                                            alert('Quantity cannot be empty');
                                                                            a.value = 1;
                                                                        } else {
                                                                            a.value = parseInt(a.value) + 1;
                                                                            $('#updateQuantity').submit();
                                                                        }
                                                                    }
                                                                    var getCheckBox = document.querySelectorAll(".getCheckBox");
                                                                    var actionCheck = document.querySelectorAll(".actionCheck");
                                                                    for (let i = 0; i < getCheckBox.length; i++) {
                                                                        getCheckBox[i].addEventListener("change", function () {
                                                                            actionCheck[i].click();
                                                                        });
                                                                    }
        </script>
    </body>
</html>
