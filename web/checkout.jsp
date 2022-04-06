<%-- 
    Document   : checkout
    Created on : Jan 23, 2022, 2:50:30 PM
    Author     : Tran Trang
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <link rel="icon" type="image/x-icon" href="assests/img/Logo.png" />
        <link rel="stylesheet" href="./included/navbar.css">
        <title>Checkout | Empower Women Asia</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="./assests/css/checkout.css">
    </head>
    <body>
        <jsp:include page="included/navbar.jsp"/>
        <c:if test="${sessionScope.CHOOSE_CART == null}">
            <c:redirect url="cart.jsp"></c:redirect>
        </c:if>
        <div class="nav-fixed content row" id="layoutSidenav_content" style="margin: 0;margin-top: 70px;">
            <main class="EqHeightDiv col-9" style="margin: 0;padding-right: 0;margin-bottom: 50px;min-height: 1260px;">
                <header class="page-header page-header-dark bg-gradient-primary-to-secondary pb-10">
                    <div class="container-xl px-4">
                        <div class="page-header-content pt-4">
                            <div class="row align-items-center justify-content-between">
                                <div class="col-auto mt-4">
                                    <h1 class="page-header-title">
                                        <div class="page-header-icon"><i data-feather="arrow-right-circle"></i></div>
                                        Wizard
                                    </h1>
                                    <div class="page-header-subtitle">Wizard examples for step-by-step form submission content to use as part of an application</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </header>
                <div class="container-xl mt-n10" style="margin-right: 0; padding:0;" id="checkout">
                    <c:set var="loginUser" value="${sessionScope.LOGIN_USER}"></c:set>
                    <c:set var="user" value="${sessionScope.CUSTOMER}"></c:set>
                        <div class="card">
                            <div class="card-header border-bottom">
                                <div class="nav nav-pills nav-justified flex-column flex-xl-row nav-wizard" id="cardTab" role="tablist">
                                    <a class="nav-item nav-link active" id="wizard1-tab" href="#wizard1" data-bs-toggle="tab" role="tab" aria-controls="wizard1" aria-selected="true">
                                        <div class="wizard-step-icon">1</div>
                                        <div class="wizard-step-text">
                                            <div class="wizard-step-text-name">Account Setup</div>
                                            <div class="wizard-step-text-details">Basic details and information</div>
                                        </div>
                                    </a>
                                    <a class="nav-item nav-link" id="wizard2-tab" href="#wizard2" data-bs-toggle="tab" role="tab" aria-controls="wizard2" aria-selected="true">
                                        <div class="wizard-step-icon">2</div>
                                        <div class="wizard-step-text">
                                            <div class="wizard-step-text-name">Billing Details</div>
                                            <div class="wizard-step-text-details">Credit card information</div>
                                        </div>
                                    </a>
                                    <a class="nav-item nav-link" id="wizard3-tab" href="#wizard3" data-bs-toggle="tab" role="tab" aria-controls="wizard3" aria-selected="true">
                                        <div class="wizard-step-icon">3</div>
                                        <div class="wizard-step-text">
                                            <div class="wizard-step-text-name">Review &amp; Submit</div>
                                            <div class="wizard-step-text-details">Review and submit changes</div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="tab-content" id="cardTabContent">
                                    <div class="tab-pane py-5 py-xl-10 fade show active" id="wizard1" role="tabpanel" aria-labelledby="wizard1-tab">
                                        <div class="row justify-content-center">
                                            <div class="col-xxl-6 col-xl-8">
                                                <h3 class="text-primary">Step 1</h3>
                                                <h5 class="card-title mb-4">Enter your account information</h5>
                                            <c:choose>
                                                <c:when test="${sessionScope.LOGIN_USER==null}">
                                                    <div class="row dialog">
                                                        <div class="col-md-12">
                                                            <div class="panel panel-login">
                                                                <div class="panel-heading">
                                                                    <div class="row">
                                                                        <div class="col-md-6 text-center">
                                                                            <a href="#" id="register-form-link">Register</a>
                                                                        </div>
                                                                        <div class="col-md-6 text-center">
                                                                            <a href="#" class="active" id="login-form-link">Login</a>
                                                                        </div>
                                                                    </div>
                                                                    <hr>
                                                                </div>
                                                                <div class="panel-body">
                                                                    <div class="row">
                                                                        <div class="col-lg-12">
                                                                            <form action="UserController" method="POST" id="register-form" role="form" style="display: block;">
                                                                                <input type="hidden" name="previous" value="checkout.jsp">
                                                                                <div class="form-group">
                                                                                    <div class="input-group margin-bottom-sm">
                                                                                        <span class="input-group-addon"><i class="fa fa-user fa-fw" aria-hidden="true"></i></span>
                                                                                        <input class="form-control" type="text" name="userID" placeholder="User ID" required>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="form-group">
                                                                                    <div class="input-group">
                                                                                        <span class="input-group-addon"><i class="fa fa-key fa-fw" aria-hidden="true"></i></span>
                                                                                        <input class="form-control" name="password" type="password" placeholder="Password" required>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="form-group">
                                                                                    <div class="input-group">
                                                                                        <span class="input-group-addon"><i class="fa fa-key fa-fw" aria-hidden="true"></i></span>
                                                                                        <input class="form-control" name="confirm" type="password" placeholder="Confirm Password" required>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="form-group">                                            
                                                                                    <input type="checkbox" name="agree-term" id="agree-term" class="agree-term"/>
                                                                                    <label for="agree-term" class="label-agree-term"><span><span></span></span>I agree all statements in  <a href="#" class="term-service">Terms of service</a></label>
                                                                                </div>
                                                                                <div class="form-group">
                                                                                    <div class="row">
                                                                                        <div class="col-sm-6 col-sm-offset-3">
                                                                                            <input tabindex="4" type="submit" class="btn btn-light btn-block btn-register" value="Register" name="action">
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </form>
                                                                            <form action="UserController" method="POST" id="login-form" role="form" style="display: none;">
                                                                                <div class="form-group">
                                                                                    <div class="input-group margin-bottom-sm">
                                                                                        <span class="input-group-addon"><i class="fa fa-user fa-fw" aria-hidden="true"></i></span>
                                                                                        <input class="form-control" type="text" name="userID" placeholder="User ID" required>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="form-group">
                                                                                    <div class="input-group">
                                                                                        <span class="input-group-addon"><i class="fa fa-key fa-fw" aria-hidden="true"></i></span>
                                                                                        <input class="form-control" name="password" type="password" placeholder="Password" required>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="form-group">
                                                                                    <div class="row">
                                                                                        <div class="col-sm-6 col-sm-offset-3">
                                                                                            <input type="hidden" name="previous" value="checkout.jsp">
                                                                                            <button type="submit" class="btn btn-light btn-block btn-login" id="login-submit" tabindex="4" value="Login" name="action">Sign in</button>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </form>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="mb-3">
                                                        <label class="small mb-1" for="inputUsername">Username (how your name will appear to other users on the site)</label>
                                                        <input class="form-control" id="inputUsername" type="text" value="${loginUser.getUserID()}" disabled=""d="" />
                                                    </div>
                                                    <div class="row gx-3">
                                                        <div class="mb-3 col-md-6" style="padding: 0; padding-right: 10px;">
                                                            <label class="small mb-1" for="inputFullName">Full name</label>
                                                            <input class="form-control" id="inputFullName" oninput="onValue(this)" type="text" placeholder="Enter your full name" value="${user.getFullName()}" />
                                                        </div>
                                                        <div class="mb-3 col-md-6" style="padding: 0;">
                                                            <label class="small mb-1" for="inputPhone">Phone number</label>
                                                            <input class="form-control" id="inputPhone" oninput="onValue(this)" type="tel" placeholder="Enter your phone number" value="${user.getPhone()}" />
                                                        </div>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="small mb-1" for="inputAddress">Your address</label>
                                                        <input class="form-control" id="inputAddress" oninput="onValue(this)" type="text" placeholder="Enter your address" value="${user.getAddress()}" />
                                                    </div>
                                                    <div class="row gx-3">
                                                        <div class="mb-3 col-md-4" style="padding: 0; padding-right: 10px;">
                                                            <label class="small mb-1" for="inputRegion">Your region</label>
                                                            <input class="form-control" id="inputRegion" oninput="onValue(this)" type="text" placeholder="Enter your region" value="${user.getRegion()}" />
                                                        </div>
                                                        <div class="mb-3 col-md-4" style="padding: 0; padding-right: 10px;">
                                                            <label class="small mb-1" for="inputCountry">Country</label>
                                                            <p id="country" style="display: none">${user.country}</p>
                                                            <select id="countries" name="countries" oninput="onValue(this)" class="form-control" required style="color: black;"></select>
                                                        </div>
                                                        <div class="mb-3 col-md-4" style="padding: 0;">
                                                            <label class="small mb-1" for="inputZip">Postal Code</label>
                                                            <input class="form-control" id="inputZip" oninput="onValue(this)" type="text" placeholder="Enter your postal code" value="${user.getPostalCode()}" />
                                                        </div>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="small mb-1" for="inputNote">Your Note</label>
                                                        <input class="form-control" id="inputNote" oninput="onValue(this)" type="text" placeholder="Enter your note"/>
                                                    </div>
                                                    <hr class="my-4" />
                                                    <div class="d-flex justify-content-between">
                                                        <button class="btn btn-light btnPrevious" disabled="" type="button">Previous</button>
                                                        <button class="btn btn-primary btnNext" type="button">Next</button>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane py-5 py-xl-10 fade" id="wizard2" role="tabpanel" aria-labelledby="wizard2-tab">
                                    <div class="row justify-content-center">
                                        <div class="col-xxl-6 col-xl-8">
                                            <h3 class="text-primary">Step 2</h3>
                                            <div class="row dialog">
                                                <div class="col-md-12">
                                                    <div class="panel panel-login">
                                                        <div class="panel-heading">
                                                            <div class="row">
                                                                <h5 class="card-title mb-4">Enter your billing details</h5>
                                                                <select name="payment" style="border: none;padding: 0 20px;" id="payment" onchange="selectPay(this)">
                                                                    <option value="prepay">Prepayment</option>
                                                                    <option value="cod" selected>Cash On Delivery</option>
                                                                </select>
                                                            </div>
                                                            <hr>
                                                        </div>
                                                        <div class="panel-body">
                                                            <div class="row">
                                                                <div class="col-lg-12">
                                                                    <div style="display: block;">
                                                                        <div class="panel-body">
                                                                            <div>
                                                                                <table class="col row">
                                                                                    <tr class="bank col">
                                                                                        <th><strong>Vietnam Bank Account:</strong></h2>
                                                                                        <th><strong>International Bank Account:</strong>
                                                                                    </tr>
                                                                                    <tr class="bank col">
                                                                                        <td><img src="./assests/img/vietnambank.gif" style="width: 80%;height: auto;object-fit: cover;"></td>
                                                                                        <td><img src="./assests/img/vietnambank.gif" style="width: 80%;height: auto;object-fit: cover;"></td>
                                                                                    </tr>
                                                                                </table>
                                                                                <hr>
                                                                                <div id="cod" class="col-md-12" style="display: none;">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <i>Note: If you prepay for the bill, please write transfer content: [Your bill ID]</i>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <hr class="my-4" />
                                            <div class="d-flex justify-content-between">
                                                <button class="btn btn-light btnPrevious" type="button">Previous</button>
                                                <button class="btn btn-primary btnNext" type="button">Next</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane py-5 py-xl-10 fade" id="wizard3" role="tabpanel" aria-labelledby="wizard3-tab">
                                    <form action="OrderController" method="POST">
                                        <div class="row justify-content-center">
                                            <div class="col-xxl-6 col-xl-8">
                                                <h3 class="text-primary">Step 3</h3>
                                                <h5 class="card-title mb-4">Review the following information and submit</h5>
                                                <div class="row small text-muted">
                                                    <div class="col-sm-3 text-truncate"><em>Username:</em></div>
                                                    <input class="col" type="text" style="border: none;" id="userID" name="userID" value="${loginUser.getUserID()}">
                                                </div>
                                                <div class="row small text-muted">
                                                    <div class="col-sm-3 text-truncate"><em>Name:</em></div>
                                                    <input class="col" type="text" style="border: none;" id="FullName" name="FullName" value="${user.getFullName()}">
                                                </div>
                                                <div class="row small text-muted">
                                                    <div class="col-sm-3 text-truncate"><em>Phone Number:</em></div>
                                                    <input class="col" type="tel" style="border: none;" id="Phone" name="Phone" value="${user.getPhone()}">
                                                </div>
                                                <div class="row small text-muted">
                                                    <div class="col-sm-3 text-truncate"><em>Address:</em></div>
                                                    <input class="col" type="text" style="border: none;" id="Address" name="Address" value="${user.getAddress()}">
                                                </div>
                                                <div class="row small text-muted">
                                                    <div class="col-sm-3 text-truncate"><em>Region:</em></div>
                                                    <input class="col" type="text" style="border: none;" id="Region" name="Region" value="${user.getRegion()}">
                                                </div>
                                                <div class="row small text-muted">
                                                    <div class="col-sm-3 text-truncate"><em>Country:</em></div>
                                                    <input class="col" type="text" style="border: none;" id="Country" name="Country" value="${user.getCountry()}">
                                                </div>
                                                <div class="row small text-muted">
                                                    <div class="col-sm-3 text-truncate"><em>Postal Code:</em></div>
                                                    <input class="col" type="text" style="border: none;" id="Zip" name="Zip" value="${user.getPostalCode()}">
                                                </div>
                                                <div class="row small text-muted">
                                                    <div class="col-sm-3 text-truncate"><em>Payment:</em></div>
                                                    <div class="col"><input class="col" type="text" style="border: none;" id="Payment" name="payment" value="cod"></div>
                                                </div>
                                                <div class="row small text-muted">
                                                    <div class="col-sm-3 text-truncate"><em>Date:</em></div>
                                                    <input class="col" type="text" style="border: none;" id="current_date" name="Date" value="">
                                                </div>
                                                <div class="form-group row small text-muted">
                                                    <div class="col-sm-3 text-truncate"><em>Note:</em></div>         
                                                    <input class="col" type="text" style="border: none;" id="Note" name="Note">
                                                </div>
                                                <hr class="my-4" />
                                                <div class="d-flex justify-content-between">
                                                    <button class="btn btn-light btnPrevious" type="button">Previous</button>
                                                    <button class="btn btn-primary" name="action" value="Checkout" type="submit">Submit</button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <div id="form-cart-menu" class="col-3 EqHeightDiv" style="margin-left: 0;padding: 0;padding-left: 20px;">
                <div class="shopping-cart-head" style="margin-top: 20px">
                    <h1>Shopping Cart</h1>
                </div>
                <table id="shopping-cart-menu">
                    <c:forEach items="${sessionScope.CHOOSE_CART}" var="product"  varStatus="counter">
                        <tr class='shopping-cart-item'>
                            <td class='cart-title'>${product.name}</td>
                            <td class='cart-price'>${product.price*product.quantity}</td>
                        </tr>
                    </c:forEach>
                    <tr class='shopping-cart-total'>
                        <td class='cart-total'>Total price</td>
                        <td class='cart-price-total'>${sessionScope.TOTAL_CART}</td>
                    </tr>
                    <!--<tr class='shopping-cart-total'>-->
                        <!--<td class='cart-total'>Discount</td>-->
                        <!--<td class='cart-price-total'>658</td>-->
                    <!--</tr>-->
                    <tr class='shopping-cart-total'>
                        <td class='cart-total'>Total</td>
                        <td class='cart-price-total'>${sessionScope.TOTAL_CART}</td>
                    </tr>
                </table>
            </div>
        </div>
        <jsp:include page="included/footer.html"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
        <script type="text/javascript">
                                                                    $(document).ready(function () {
                                                                        $('#sidebarCollapse').on('click', function () {
                                                                            $('#sidebar').toggleClass('active');
                                                                        });
                                                                    });
                                                                    $(function () {
                                                                        $('#login-form-link').click(function (e) {
                                                                            $("#login-form").delay(500).fadeIn(500);
                                                                            $("#register-form").fadeOut(500);
                                                                            $('#register-form-link').removeClass('active');
                                                                            $(this).addClass('active');
                                                                            e.preventDefault();
                                                                        });
                                                                        $('#register-form-link').click(function (e) {
                                                                            $("#register-form").delay(500).fadeIn(500);
                                                                            $("#login-form").fadeOut(500);
                                                                            $('#login-form-link').removeClass('active');
                                                                            $(this).addClass('active');
                                                                            e.preventDefault();
                                                                        });
                                                                        $('#prepay-link').click(function (e) {
                                                                            $("#prepay").delay(500).fadeIn(500);
                                                                            $("#cod").fadeOut(500);
                                                                            document.getElementById('cod-link').getElementsByTagName('input')[0].removeAttribute("checked");
                                                                            document.getElementById('prepay-link').getElementsByTagName('input')[0].setAttribute("checked", true);
                                                                            e.preventDefault();
                                                                        });
                                                                        $('#cod-link').click(function (e) {
                                                                            $("#cod").delay(500).fadeIn(500);
                                                                            $("#prepay").fadeOut(500);
                                                                            document.getElementById('prepay-link').getElementsByTagName('input')[0].removeAttribute("checked");
                                                                            document.getElementById('cod-link').getElementsByTagName('input')[0].setAttribute("checked", true);
                                                                            e.preventDefault();
                                                                        });
                                                                    });
                                                                    $(document).ready(function () {
                                                                        $('.nav-item.nav-link').on('hmm', function (e, idAdd, idRemove) {
                                                                            $('#' + idAdd).addClass('active');
                                                                            $('#' + idAdd.split("-")[0]).addClass('active');
                                                                            $('#' + idAdd.split("-")[0]).addClass('show');
                                                                            $('#' + idRemove).removeClass('active');
                                                                            $('#' + idRemove.split("-")[0]).removeClass('active');
                                                                            $('#' + idRemove.split("-")[0]).removeClass('show');
                                                                        });
                                                                    });
                                                                    $('.btnNext').click(function () {
                                                                        $('#cardTab > .active').next('a').trigger('hmm', [$('#cardTab > .active').next('a').attr('id'), $('#cardTab > .active').attr('id')]);
                                                                    });

                                                                    $('.btnPrevious').click(function () {
                                                                        $('#cardTab > .active').prev('a').trigger('hmm', [$('#cardTab > .active').prev('a').attr('id'), $('#cardTab > .active').attr('id')]);
                                                                    });
                                                                    function equalHeight(group) {
                                                                        tallest = 0;
                                                                        group.each(function () {
                                                                            thisHeight = $(this).height();
                                                                            if (thisHeight > tallest) {
                                                                                tallest = thisHeight;
                                                                            }
                                                                        });
                                                                        group.height(tallest);
                                                                    }
                                                                    $(document).ready(function () {
                                                                        equalHeight($(".EqHeightDiv"));
                                                                    });
                                                                    document.addEventListener('DOMContentLoaded', () => {
                                                                        const countriesList = document.getElementById("countries");
                                                                        let countries;
                                                                        let now = document.getElementById("country").innerHTML;
                                                                        fetch("https://restcountries.com/v2/all")
                                                                                .then(res => res.json())
                                                                                .then(data => initialize(data))
                                                                                .catch(err => console.log("Error:", err));

                                                                        function initialize(countriesData) {
                                                                            countries = countriesData;
                                                                            for (var i = 0, max = countries.length; i < max; i++) {
                                                                                let options = document.createElement('option');
                                                                                if (now === countries[i].name) {
                                                                                    options.value = countries[i].name;
                                                                                    options.innerHTML = countries[i].name;
                                                                                    options.setAttribute('selected', true);
                                                                                    countriesList.appendChild(options);
                                                                                }
                                                                            }
                                                                            for (var i = 0, max = countries.length; i < max; i++) {
                                                                                let options = document.createElement('option');
                                                                                if (now !== countries[i].name) {
                                                                                    options.value = countries[i].name;
                                                                                    options.innerHTML = countries[i].name;
                                                                                    countriesList.appendChild(options);
                                                                                }
                                                                            }
                                                                        }
                                                                    });
                                                                    var price = document.getElementsByClassName('price');
                                                                    Array.from(price).forEach(p => {
                                                                        p.innerHTML = '$' + (Math.round(p.innerHTML * 100) / 100).toFixed(2);
                                                                    });
                                                                    function selectPay(e) {
                                                                        document.getElementById("Payment").value = e.value;
                                                                    }
                                                                    function onValue(x) {
                                                                        var currentID = x.id;
                                                                        var output = document.getElementById(currentID.substring(5, currentID.length));
                                                                        output.value = x.value;
                                                                    }
                                                                    date = new Date();
                                                                    year = date.getFullYear();
                                                                    month = date.getMonth() + 1;
                                                                    day = date.getDate();
                                                                    document.getElementById("current_date").value = day + "/" + month + "/" + year;
        </script>
    </body>
</html>
