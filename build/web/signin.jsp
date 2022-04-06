<%-- 
    Document   : sign
    Created on : Dec 27, 2021, 8:52:06 PM
    Author     : Tran Trang
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login | Empower Women Asia</title>
        <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
        <link rel="icon" type="image/x-icon" href="assests/img/Logo.png" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="./assests/css/sign.css"/>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500&display=swap" rel="stylesheet">
    </head>
    <body>
        <section class="ftco-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-3 col-lg-4"></div>
                    <div class="col-md-6 col-lg-4">
                        <div class="login-wrap py-5" style="padding: 50px 30px;">
                            <a href="home.jsp"><div class="img d-flex align-items-center justify-content-center" style="background-image: url(./assests/img/Logo.png);"></div></a>
                            <h3 class="text-center mb-0">Welcome</h3>
                            <c:if test="${requestScope.ERROR!=null}">
                                <div class="alert alert-danger alert-dismissible" role="alert">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                    <strong>Warring!</strong> ${requestScope.ERROR}!</a>
                                </div>
                            </c:if>
                            <p class="text-center">Sign in by entering the information below</p>
                            <form action="UserController" method="POST" id="login-form" role="form" class="login-form">
                                <div class="form-group">
                                    <div class="icon d-flex align-items-center justify-content-center"><span class="fa fa-user"></span></div>
                                    <input class="form-control" type="text" name="userID" placeholder="Username" required>
                                </div>
                                <div class="form-group">
                                    <div class="icon d-flex align-items-center justify-content-center"><span class="fa fa-lock"></span></div>
                                    <input class="form-control" name="password" type="password" placeholder="Password" required>
                                </div>
                                <div class="form-group d-md-flex">
                                    <div class="w-100 text-md-right">
                                        <a href="#">Forgot Password</a>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn form-control btn-primary rounded submit px-3" value="Login" name="action">Sign in</button>
                                </div>
                            </form>
                            <div class="w-100 text-center mt-4 text">
                                <p class="mb-0">Don't have an account?</p>
                                <a href="signup.jsp">Sign Up</a>
                            </div>
                            <div class="form-group d-md-flex">
                                    <div class="w-100 text-md-right">
                                        <a href="home.jsp">Return Home</a>
                                    </div>
                                </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-lg-4"></div>
                </div>
            </div>
        </section>
    </body>
</html>
