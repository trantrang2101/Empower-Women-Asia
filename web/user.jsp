<%-- 
    Document   : invalid
    Created on : Jan 4, 2022, 8:28:07 AM
    Author     : Tran Trang
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        <link rel="icon" type="image/x-icon" href="assests/img/Logo.png" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
        <link rel="stylesheet" href="./included/navbar.css">
        <link rel="stylesheet" href="./assests/css/user.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500&display=swap" rel="stylesheet">
        <title>Empower Women Asia</title>
    </head>
    <body>
        <c:set var="loginUser" value="${sessionScope.LOGIN_USER}"></c:set>
        <c:set var="customer" value="${sessionScope.CUSTOMER}"></c:set>
        <c:if test="${loginUser == null ||  loginUser.roleID ne 'US'}">
            <c:redirect url="home.jsp"></c:redirect>
        </c:if>
        <div class="wrapper">
            <jsp:include page="included/navbar.jsp"/>
            <div class="mb-4 light-style" style="margin: 100px 50px;">

                <h4 class="font-weight-bold py-3 mb-4">
                    Account settings
                </h4>
                <div class="card">
                    <div class="row no-gutters row-bordered row-border-light">
                        <div class="col-md-2 pt-0">
                            <div class="list-group list-group-flush account-settings-links">
                                <a class="list-group-item list-group-item-action active" data-toggle="list" href="#account-general">General</a>
                                <a class="list-group-item list-group-item-action" data-toggle="list" href="#account-change-password">Change password</a>
                                <a class="list-group-item list-group-item-action" data-toggle="list" href="#account-info">Info</a>
                                <a class="list-group-item list-group-item-action" data-toggle="list" href="#account-bill">Invoice</a>
                                <a class="list-group-item list-group-item-action" data-toggle="list" href="#account-notifications">Notifications</a>
                                <a class="list-group-item list-group-item-action" href="#" data-toggle="modal" data-target="#logoutModal">Logout</a>
                            </div>
                        </div>
                        <div class="col-md-10" style="padding: 20px 30px;">
                            <div class="tab-content">
                                <div class="tab-pane fade active show" id="account-general">
                                    <div class="row">
                                        <div class="form-group col-md-4">
                                            <label class="form-label">Username</label>
                                            <input type="text" class="form-control mb-1" name="userID" value="${loginUser.userID}" disabled>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label class="form-label">Name</label>
                                            <input type="text" class="form-control" value="${customer.fullName}"disabled>
                                        </div>
                                        <div class="form-group col-md-2">
                                            <label for="inputGender">Gender</label>
                                            <c:if test="${customer.gender!=''}">
                                                <input type="text" class="form-control mb-1" value="Male" disabled>
                                            </c:if>
                                            <c:if test="${customer.gender==''}">
                                                <input type="text" class="form-control mb-1" value="Female" disabled>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group col-md-3">
                                            <label for="inputState5">Country</label>
                                            <input type="text" class="form-control mb-1" value="${customer.country}" disabled>
                                        </div>
                                        <div class="form-group col-md-9">
                                            <label for="">Phone</label>
                                            <br>
                                            <input type="tel" class="form-control mb-1" value="${customer.phone}" disabled>
                                        </div>
                                    </div>

                                    <div class="form-group col-md-12" style="padding: 0;">
                                        <label for="">Address</label>
                                        <input type="text" class="form-control" id="" value="${customer.address}" disabled />
                                    </div>
                                    <div class="row">
                                        <div class="form-group col-md-8">
                                            <label for="inputState5">Region</label>
                                            <input type="text" class="form-control" id="" value="${customer.region}" disabled />
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label for="">Zip</label>
                                            <input type="text" class="form-control" id="" value="${customer.postalCode}" disabled/>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="account-change-password">
                                    <div class="card-body pb-2">

                                        <form action="UserController" method="POST">
                                            <div class="form-group">
                                                <label class="form-label">Current password</label>
                                                <input type="password" class="form-control" name="currentPassword" placeholder="Password">
                                            </div>

                                            <div class="form-group">
                                                <label class="form-label">New password</label>
                                                <input type="password" class="form-control" name="password" placeholder="Password">
                                            </div>

                                            <div class="form-group">
                                                <label class="form-label">Repeat new password</label>
                                                <input type="password" class="form-control" name="confirm" placeholder="Confirm Password">
                                            </div>
                                            <button class="btn btn-primary" name="action" value="changePW">Change</button>
                                            <input type="reset" class="btn btn-default" value="Cancel">
                                            <input type="hidden" value="${loginUser.userID}" name="userID">
                                        </form>

                                    </div>
                                </div>
                                <div class="tab-pane fade" id="account-info">
                                    <div class="card-body media align-items-center">
                                        <c:choose>
                                            <c:when test="${customer.getImg()==null}">
                                                <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="" id="user-avata" class="d-block ui-w-80" style="width: 100px;height: 100px;object-fit: cover;">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="./assests/img/user/${customer.getImg()}" alt="" id="user-avata" class="d-block ui-w-80" style="width: 100px;height: 100px;object-fit: cover;">
                                            </c:otherwise>
                                        </c:choose>
                                        <br>
                                        <input type="hidden" class="form-control mb-1" name="userID" value="${loginUser.userID}">
                                        <br>
                                        <div class="media-body ml-4">
                                            <form action="FileUploadHandler" enctype="multipart/form-data" method="POST">
                                                <label class="btn btn-outline-primary">
                                                    Upload new photo
                                                    <input type="file" class="account-settings-fileinput" id="inputImage" multiple="false" name="userImage" accept="image/*">
                                                </label> &nbsp;
                                                <button type="submit" class="btn btn-default md-btn-flat">Upload</button>&nbsp;
                                                <button type="reset" class="btn btn-default md-btn-flat">Reset</button>
                                                <div class="text-light small mt-1">Allowed JPG, GIF or PNG. Max size of 800K</div>
                                            </form>
                                        </div>
                                    </div>
                                    <hr>
                                    <form action="UserController" method="POST">
                                        <div class="row">
                                            <div class="form-group col-md-4">
                                                <label class="form-label">Username</label>
                                                <input type="text" class="form-control mb-1" name="userID" value="${loginUser.userID}" disabled>
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label class="form-label">Name</label>
                                                <input type="text" class="form-control" name="fullName" value="${customer.fullName}">
                                            </div>
                                            <div class="form-group col-md-2">
                                                <label for="inputState5">Gender</label>
                                                <select id="inputState5" name="gender" class="form-control">
                                                    <c:choose>
                                                        <c:when test="${customer.gender!=''}">
                                                            <option value="1" selected="selected">Male</option>
                                                            <option value="0">Female</option>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <option value="0" selected="selected">Female</option>
                                                            <option value="1">Male</option>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group col-md-9">
                                                <label for="">Address</label>
                                                <input type="text" class="form-control" name="address" id="" value="${customer.address}" />
                                            </div>

                                            <div class="form-group col-md-3">
                                                <label for="">Phone</label>
                                                <br>
                                                <input type="tel" class="form-control" id="phone" name="phone" value="${customer.phone}"/>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group col-md-4">
                                                <label for="inputState5">Country</label>
                                                <p id="country" style="display: none">${customer.country}</p>
                                                <select id="countries" name="countries" class="form-control countries">
                                                </select>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label for="inputState5">Region</label>
                                                <input type="tel" class="form-control" id="phone" name="region" value="${customer.region}"/>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <label for="">Zip</label>
                                                <input type="text" class="form-control" name="zip" id="" value="${customer.postalCode}" />
                                            </div>
                                        </div>
                                        <button class="btn btn-primary" name="action" value="changeInf">Change</button>
                                        <input type="reset" class="btn btn-default" value="Cancel">
                                        <input type="hidden" value="${loginUser.userID}" name="userID">
                                    </form>
                                </div>
                                <div class="tab-pane fade" id="account-bill" style="overflow: scroll;">
                                    <div class="container-xl px-4 mt-n10">
                                        <div class="card mb-4">
                                            <div class="card-body">
                                                <table id="tableBills" class="table table-striped col-lg-12">
                                                    <thead class="thead-dark text-center">
                                                        <tr>
                                                            <th>Full Name</th>
                                                            <th>Address</th>
                                                            <th>Phone</th>
                                                            <th>Note</th>
                                                            <th>Date</th>
                                                            <th>Payment</th>
                                                            <th>Check</th>
                                                            <th>Done</th>
                                                            <th>Detail</th>
                                                            <th>Delete</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach items="${sessionScope.ORDER_LIST}" var="order">
                                                            <c:set var="list" value="${order.getList()}"></c:set>
                                                                <tr>
                                                                    <td>${order.getFullName()}</td>
                                                                <td>${order.getAddress()}, ${order.getRegion()}, ${order.getCountry()} ${order.getPostalCode()}</td>
                                                                <td>${order.getPhone()}</td>
                                                                <td>${order.getNote()}</td>
                                                                <td>${order.getOrderDate()}</td>
                                                                <c:choose>
                                                                    <c:when test="${list==null||list.size()==0}">
                                                                        <td colspan="4">Cancel</td>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <td>
                                                                            <c:set var="pay" value="${order.prepay==true}"></c:set>
                                                                            <c:choose>
                                                                                <c:when test="${pay}">
                                                                                    Prepayment
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    COD
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                            </select>
                                                                        </td>
                                                                        <td>
                                                                            <c:choose>
                                                                                <c:when test="${order.isCheckpay()==true || order.prepay==false}">
                                                                                    Done
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    Not yet
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </td>
                                                                        <td>
                                                                            <c:choose>
                                                                                <c:when test="${order.getDone()==1}">
                                                                                    Done
                                                                                </c:when>
                                                                                <c:when test="${order.getDone()==0}">
                                                                                    Cancel
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    Process
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </td>
                                                                        <td>
                                                                            <c:url var="detail" value="OrderController">
                                                                                <c:param name="orderID" value="${order.getID()}"></c:param>
                                                                                <c:param name="action" value="Detail"></c:param>
                                                                            </c:url>
                                                                            <a class="btn btn-outline-dark" href="${detail}"><i class="fas fa-list"></i></a>
                                                                        </td>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <td>
                                                                    <c:if test="${order.prepay==false&&order.getDone()==1}">
                                                                        <form action="OrderController" method="POST">
                                                                            <input type="hidden" name="orderID" value="${order.getID()}">
                                                                            <button type="submit" name="action" value="cancelBill">Cancel</button>
                                                                        </form>
                                                                    </c:if>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="account-notifications">
                                    <div class="card-body pb-2">

                                        <h6 class="mb-4">Activity</h6>

                                        <div class="form-group">
                                            <label class="switcher">
                                                <input type="checkbox" class="switcher-input" checked="">
                                                <span class="switcher-indicator">
                                                    <span class="switcher-yes"></span>
                                                    <span class="switcher-no"></span>
                                                </span>
                                                <span class="switcher-label">Email me when someone comments on my article</span>
                                            </label>
                                        </div>
                                        <div class="form-group">
                                            <label class="switcher">
                                                <input type="checkbox" class="switcher-input" checked="">
                                                <span class="switcher-indicator">
                                                    <span class="switcher-yes"></span>
                                                    <span class="switcher-no"></span>
                                                </span>
                                                <span class="switcher-label">Email me when someone answers on my forum thread</span>
                                            </label>
                                        </div>
                                        <div class="form-group">
                                            <label class="switcher">
                                                <input type="checkbox" class="switcher-input">
                                                <span class="switcher-indicator">
                                                    <span class="switcher-yes"></span>
                                                    <span class="switcher-no"></span>
                                                </span>
                                                <span class="switcher-label">Email me when someone follows me</span>
                                            </label>
                                        </div>
                                    </div>
                                    <hr class="border-light m-0">
                                    <div class="card-body pb-2">

                                        <h6 class="mb-4">Application</h6>

                                        <div class="form-group">
                                            <label class="switcher">
                                                <input type="checkbox" class="switcher-input" checked="">
                                                <span class="switcher-indicator">
                                                    <span class="switcher-yes"></span>
                                                    <span class="switcher-no"></span>
                                                </span>
                                                <span class="switcher-label">News and announcements</span>
                                            </label>
                                        </div>
                                        <div class="form-group">
                                            <label class="switcher">
                                                <input type="checkbox" class="switcher-input">
                                                <span class="switcher-indicator">
                                                    <span class="switcher-yes"></span>
                                                    <span class="switcher-no"></span>
                                                </span>
                                                <span class="switcher-label">Weekly product updates</span>
                                            </label>
                                        </div>
                                        <div class="form-group">
                                            <label class="switcher">
                                                <input type="checkbox" class="switcher-input" checked="">
                                                <span class="switcher-indicator">
                                                    <span class="switcher-yes"></span>
                                                    <span class="switcher-no"></span>
                                                </span>
                                                <span class="switcher-label">Weekly blog digest</span>
                                            </label>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="included/footer.html"/>

        </div>
        <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="z-index: 100000000;">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                        <form action="UserController" method="POST">
                            <button class="btn btn-dark" name="action" value="Logout">Logout</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#sidebarCollapse').on('click', function () {
                    $('#sidebar').toggleClass('active');
                });
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
            let msg = '${requestScope.ERROR}';
            if (msg !== '') {
                alert(msg);
            }
            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        $('#user-avata').attr('src', e.target.result);
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            }

            $("#inputImage").change(function () {
                readURL(this);
            });
            window.addEventListener('DOMContentLoaded', event => {
                // Simple-DataTables
                // https://github.com/fiduswriter/Simple-DataTables/wiki

                const datatablesSimple = document.getElementById('tableBills');
                if (datatablesSimple) {
                    new simpleDatatables.DataTable(datatablesSimple);
                }
            });

        </script>
    </body>
</html>
