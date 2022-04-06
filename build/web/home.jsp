<%-- 
    Document   : home
    Created on : Jan 15, 2022, 10:25:17 PM
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
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <link rel="icon" type="image/x-icon" href="assests/img/Logo.png" />
        <link rel="stylesheet" href="./included/navbar.css">
        <link rel="stylesheet" href="./assests/css/home.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500&display=swap" rel="stylesheet">
        <title>Empower Women Asia</title>
    </head>
    <body>
        <jsp:include page="included/navbar.jsp"/>
        <div class="wrapper">
            <div id="content">
                <input name="previous" value="home.jsp" type="hidden">
                <div class="intro">
                    <div id="intro">
                        <video autoplay loop muted min-width="100%" height="500px">
                            <source src="./assests/img/intro.mp4" type="video/mp4">
                            Your browser does not support HTML video.
                        </video>
                    </div>
                </div>
                <div class="ewa-info row" style="height: auto;margin-bottom: 50px;">
                    <div class="col-md-12 col-lg-4 mission text-center" style="padding: 30px;">
                        <a href="#">
                            <h1>Our Mission</h1>
                            <span>Our Goal, Vision & Commitment</span>
                        </a>
                    </div>
                    <div class="col-md-12 col-lg-4 event text-center" style="padding: 30px;">
                        <a href="#">
                            <h1>
                                Our Events
                            </h1>
                            <span>Register & Help Make Change</span>
                        </a>
                    </div>
                    <div class="col-md-12 col-lg-4 involved text-center" style="padding: 30px;">
                        <a href="#">
                            <h1>
                                Get Involved
                            </h1>
                            <span>Volunteer, Participate, or Donate</span>
                        </a>
                    </div>
                </div>
                <div id="blogs">
                    <div class="site-heading text-center">
                        <a href="BlogController"><h3 class="text-uppercase text-center">Blogs</h3></a>
                        <div class="border"></div>
                    </div>
                    <section class="blog-listing">
                        <div class="container">
                            <div class="row align-items-start">
                                <div class="col-lg-12 m-15px-tb">
                                    <div class="row">
                                        <c:if test="${sessionScope.BLOG_LIST!=null}">
                                            <c:forEach begin="0" end="2" var="x">    
                                                <c:set var="blog" value="${sessionScope.BLOG_LIST.get(x)}"></c:set>
                                                    <div class="col-lg-4 col-md-12">
                                                        <div class="blog-grid" style="height: 550px;">
                                                            <div class="blog-img">
                                                                <a href="BlogController?action=detail&blogID=${blog.getBlogID()}">
                                                                <img src="./assests/img/blog/${blog.getImage()}" title="" alt="">
                                                            </a>
                                                        </div>
                                                        <div class="blog-info" style="margin-bottom: 20px;">
                                                            <h3 style="height: 55px;"><a class="text-uppercase font-weight-bold" href="BlogController?action=detail&blogID=${blog.getBlogID()}">${blog.getTitle()}</a></h3>
                                                            <p>${blog.getSummary()}</p>
                                                        </div>
                                                        <div class="blog-footer"><a href="BlogController?action=detail&blogID=${blog.getBlogID()}" class="btn btn-info btn-rounded btn-md" style="background-color: #ec5e87;color: white;position: absolute;bottom: 30px;left: 30px;">Read more</a></div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
                <div class="quote">
                    <h4 class="text-center italic">“Positive actions create a chain reaction reaching far across the Universe. One Life touches another Life, who touches another Life. Be the Good, leave a Legacy.” </h4>
                    <p class="text-center">Karyn Mann Young</p>
                </div>
                <section class="home-blog">
                    <div class="container">
                        <!-- section title -->
                        <div class="site-heading text-center">
                            <h3 class="text-uppercase">Our Events</h3>
                            <div class="border"></div>
                        </div>
                        <div class="row ">
                            <div class="col-md-12 blog-info">
                                <div class="media blog-media">
                                    <a href="#"><img class="d-flex" src="./assests/img/weaving.png" alt="WEAVING THE SEASON OF HOPE"></a>
                                    <div class="media-body">
                                        <a href=""><h3 class="mt-0 font-weight-bold">WEAVING THE SEASON OF HOPE</h3></a>
                                        <p>Christmas time is also time to show love and share joys.</p>
                                        <a href="#" class="post-link">Read More</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 blog-info">
                                <div class="media blog-media">
                                    <a href="#"><img class="d-flex" src="./assests/img/craftEvent.png" alt="Generic placeholder image"></a>
                                    <div class="media-body">
                                        <a href=""><h3 class="mt-0 font-weight-bold">VIETNAMESE WOMEN AND CRAFT VILLAGES</h3></a>
                                        <p>An effort to disseminate the traditional beauties and cultural values that are imprinted with national identity and bring the image of Vietnamese women in traditional craft villages, especially those of minorities, to both fellow Vietnamese people and international friends.                                </p>
                                        <a href="#" class="post-link">Read More</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 blog-info">
                                <div class="media blog-media">
                                    <a href="#"><img class="d-flex" src="./assests/img/productEvent.png" alt="Generic placeholder image"></a>
                                    <div class="media-body">
                                        <a href=""><h3 class="mt-0 font-weight-bold">IDEAS FOR SUSTAINABLE PRODUCTS OF TRADITIONAL VILLAGES VIETNAM 2020</h3></a>
                                        <p> A competition to find more innovative and applicable ideas using traditional materials from traditional craft villages of Vietnam.</p>
                                        <a href="#" class="post-link">Read More</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 blog-info">
                                <div class="media blog-media">
                                    <a href="#"><img class="d-flex" src="./assests/img/workshop.png" alt="Generic placeholder image"></a>
                                    <div class="media-body">
                                        <a href=""><h3 class="mt-0 font-weight-bold">WORKSHOP | Empower Women Asia</h3></a>
                                        <p>Have you ever wondered how the products you use are made? 🤔 Now you have the opportunity to learn how everything is created, starting with: 1. dyeing with natural ingredients, 2. embroidery, 3. weaving on the loom.                                </p>
                                        <a href="#" class="post-link">Read More</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <div class="join-us row" style="margin: 0;height: auto">
                    <div class="col-lg-5 col-sm-12 join-us-detail" style="padding: 0;">
                        <h1>Join Us</h1>
                        <h3>Empower Minority Women And Girls Vietnam</h3></br></br>
                        <button type="button" class="btn btn-lg btn-primary">Donate Now</button>
                    </div>
                    <div class="col-lg-7 col-sm-12" style="padding: 0;">
                        <img src="./assests/img/joinUs.png">
                    </div>
                </div>
                <jsp:include page="included/footer.html"/>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
        <script type="text/javascript" src="assests/javscript/moment.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#sidebarCollapse').on('click', function () {
                    $('#sidebar').toggleClass('active');
                });
            });
        </script>
    </body>
</html>
