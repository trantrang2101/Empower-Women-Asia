<%-- 
    Document   : signup
    Created on : Jan 6, 2022, 11:09:13 AM
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
        <link rel="icon" type="image/x-icon" href="assests/img/Logo.png" />
        <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
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
                            <p class="text-center">Sign up by entering the information below</p>
                            <form action="UserController" method="POST" id="login-form" role="form" class="login-form">
                                <div class="form-group">
                                    <div class="icon d-flex align-items-center justify-content-center"><span class="fa fa-user"></span></div>
                                    <input class="form-control" type="text" name="userID" placeholder="Username" required>
                                </div>
                                <div class="form-group">
                                    <div class="icon d-flex align-items-center justify-content-center"><span class="fa fa-lock"></span></div>
                                    <input class="form-control" name="password" type="password" placeholder="Password" required>
                                </div>
                                <div class="form-group">
                                    <div class="icon d-flex align-items-center justify-content-center"><span class="fa fa-lock"></span></div>
                                    <input class="form-control" name="confirm" type="password" placeholder="Confirm Password" required>
                                </div>
                                <div class="form-group" style="margin-bottom: 30px;">
                                    <input type="checkbox" name="agree-term" id="agree-term" class="agree-term icon d-flex align-items-center justify-content-center"/>
                                    <label for="agree-term" class="label-agree-term form-control" style="border-bottom: none;"><span><span></span></span>I agree all statements in  <a href="#" class="term-service">Terms of service</a></label>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn form-control btn-primary rounded submit px-3" value="Register" name="action">Register</button>
                                </div>
                            </form>
                            <div class="w-100 text-center mt-4 text">
                                <p class="mb-0">Already have account?</p>
                                <a href="signin.jsp">Sign In</a>
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
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>

    </body>
</html>
