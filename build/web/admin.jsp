<%-- 
    Document   : admin
    Created on : Jan 26, 2022, 5:18:24 PM
    Author     : Tran Trang
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <title>Admin EWA</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link rel="icon" type="image/x-icon" href="assests/img/Logo.png" />
        <script data-search-pseudo-elements defer src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500&display=swap" rel="stylesheet">
        <link href="./assests/css/style.css" rel="stylesheet" />
    </head>
    <body class="nav-fixed" style="font-family: 'Poppins', sans-serif;">
        <c:set var="loginUser" value="${sessionScope.LOGIN_USER}"></c:set>
        <c:if test="${loginUser == null ||  loginUser.roleID ne 'AD'}">
            <c:redirect url="home.jsp"></c:redirect>
        </c:if>
        <jsp:include page="./included/adminNavbar.jsp"/>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sidenav shadow-right sidenav-light">
                    <div class="sidenav-menu">
                        <div class="nav accordion" id="accordionSidenav">
                            <div class="sidenav-menu-heading d-sm-none">Account</div>
                            <a class="nav-link d-sm-none" href="#!">
                                <div class="nav-link-icon"><i data-feather="mail"></i></div>
                                Messages
                                <span class="badge bg-success-soft text-success ms-auto">2 New!</span>
                            </a>
                            <div class="sidenav-menu-heading">Overall</div>
                            <a class="nav-link" href="admin.jsp">
                                <div class="nav-link-icon"><i data-feather="activity"></i></div>
                                Overall
                            </a>
                            <div class="sidenav-menu-heading">Admin Controller</div>
                            <a class="nav-link" href="adminUser.jsp">
                                <div class="nav-link-icon"><i data-feather="globe"></i></div>
                                User
                            </a>
                            <a class="nav-link collapsed" href="javascript:void(0);" data-bs-toggle="collapse" data-bs-target="#collapsePages" aria-expanded="false" aria-controls="collapsePages">
                                <div class="nav-link-icon"><i data-feather="grid"></i></div>
                                Product
                                <div class="sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapsePages" data-bs-parent="#productController">
                                <nav class="sidenav-menu-nested nav accordion" id="productController">
                                    <a class="nav-link" href="adminCategory.jsp">Category</a>
                                    <a class="nav-link" href="adminProduct.jsp">Product</a>
                                </nav>
                            </div>
                            <a class="nav-link" href="adminBlogs.jsp">
                                <div class="nav-link-icon"><i data-feather="file-text"></i></div>
                                Blogs
                            </a>
                            <a class="nav-link" href="adminBill.jsp">
                                <div class="nav-link-icon"><i data-feather="globe"></i></div>
                                Bill
                            </a>
                            <div class="sidenav-menu-heading">Admin Controller</div>
                            <a class="nav-link collapsed" href="javascript:void(0);" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                <div class="nav-link-icon"><i data-feather="layout"></i></div>
                                Layout
                                <div class="sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseLayouts" data-bs-parent="#accordionSidenav">
                                <nav class="sidenav-menu-nested nav accordion" id="accordionSidenavLayout">
                                    <a class="nav-link collapsed" href="javascript:void(0);" data-bs-toggle="collapse" data-bs-target="#collapseLayoutSidenavVariations" aria-expanded="false" aria-controls="collapseLayoutSidenavVariations">
                                        Navigation
                                        <div class="sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="collapseLayoutSidenavVariations" data-bs-parent="#accordionSidenavLayout">
                                        <nav class="sidenav-menu-nested nav">
                                            <a class="nav-link" href="layout-static.html">Static Sidenav</a>
                                            <a class="nav-link" href="layout-dark.html">Dark Sidenav</a>
                                            <a class="nav-link" href="layout-rtl.html">RTL Layout</a>
                                        </nav>
                                    </div>
                                    <a class="nav-link collapsed" href="javascript:void(0);" data-bs-toggle="collapse" data-bs-target="#collapseLayoutContainers" aria-expanded="false" aria-controls="collapseLayoutContainers">
                                        Container Options
                                        <div class="sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="collapseLayoutContainers" data-bs-parent="#accordionSidenavLayout">
                                        <nav class="sidenav-menu-nested nav">
                                            <a class="nav-link" href="layout-boxed.html">Boxed Layout</a>
                                            <a class="nav-link" href="layout-fluid.html">Fluid Layout</a>
                                        </nav>
                                    </div>
                                    <a class="nav-link collapsed" href="javascript:void(0);" data-bs-toggle="collapse" data-bs-target="#collapseLayoutsPageHeaders" aria-expanded="false" aria-controls="collapseLayoutsPageHeaders">
                                        Page Headers
                                        <div class="sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="collapseLayoutsPageHeaders" data-bs-parent="#accordionSidenavLayout">
                                        <nav class="sidenav-menu-nested nav">
                                            <a class="nav-link" href="header-simplified.html">Simplified</a>
                                            <a class="nav-link" href="header-compact.html">Compact</a>
                                            <a class="nav-link" href="header-overlap.html">Content Overlap</a>
                                            <a class="nav-link" href="header-breadcrumbs.html">Breadcrumbs</a>
                                            <a class="nav-link" href="header-light.html">Light</a>
                                        </nav>
                                    </div>
                                    <a class="nav-link collapsed" href="javascript:void(0);" data-bs-toggle="collapse" data-bs-target="#collapseLayoutsStarterTemplates" aria-expanded="false" aria-controls="collapseLayoutsStarterTemplates">
                                        Starter Layouts
                                        <div class="sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="collapseLayoutsStarterTemplates" data-bs-parent="#accordionSidenavLayout">
                                        <nav class="sidenav-menu-nested nav">
                                            <a class="nav-link" href="starter-default.html">Default</a>
                                            <a class="nav-link" href="starter-minimal.html">Minimal</a>
                                        </nav>
                                    </div>
                                </nav>
                            </div>
                        </div>
                    </div>
                    <!-- Sidenav Footer-->
                    <div class="sidenav-footer">
                        <div class="sidenav-footer-content">
                            <div class="sidenav-footer-subtitle">Logged in as:</div>
                            <div class="sidenav-footer-title">${sessionScope.LOGIN_USER.getUserID()}</div>
                        </div>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <header class="page-header page-header-dark bg-gradient-primary-to-secondary pb-10">
                        <div class="container-xl px-4">
                            <div class="page-header-content pt-4">
                                <div class="row align-items-center justify-content-between">
                                    <div class="col-auto mt-4">
                                        <h1 class="page-header-title">
                                            <div class="page-header-icon"><i data-feather="activity"></i></div>
                                            Tables
                                        </h1>
                                        <div class="page-header-subtitle">An extension of the Simple DataTables library, customized for SB Admin Pro</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </header>
                    <div class="container-xl px-4 mt-n10">
                        <div class="row">
                            <div class="col-lg-6 col-xl-6 mb-4">
                                <div class="card h-100">
                                    <div class="card-body h-100 p-5">
                                        <div class="row align-items-center">
                                            <div class="col-xl-8 col-xxl-12">
                                                <div class="text-center text-xl-start text-xxl-center mb-4 mb-xl-0 mb-xxl-4">
                                                    <h1 class="text-primary">Welcome to SB Admin Pro!</h1>
                                                    <p class="text-gray-700 mb-0">Browse our fully designed UI toolkit! Browse our prebuilt app pages, components, and utilites, and be sure to look at our full documentation!</p>
                                                </div>
                                            </div>
                                            <div class="col-xl-4 col-xxl-12 text-center"><img class="img-fluid" src="./assests/img/Logo.png" style="max-width: 12rem" /></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 col-xl-6 mb-4">
                                <div class="card card-header-actions h-100">
                                    <div class="card-header">
                                        Recent Activity
                                        <div class="dropdown no-caret">
                                            <button class="btn btn-transparent-dark btn-icon dropdown-toggle" id="dropdownMenuButton" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="text-gray-500" data-feather="more-vertical"></i></button>
                                            <div class="dropdown-menu dropdown-menu-end animated--fade-in-up" aria-labelledby="dropdownMenuButton">
                                                <h6 class="dropdown-header">Filter Activity:</h6>
                                                <a class="dropdown-item" href="#!"><span class="badge bg-green-soft text-green my-1">Category</span></a>
                                                <a class="dropdown-item" href="#!"><span class="badge bg-blue-soft text-blue my-1">Order</span></a>
                                                <a class="dropdown-item" href="#!"><span class="badge bg-yellow-soft text-yellow my-1">Product</span></a>
                                                <a class="dropdown-item" href="#!"><span class="badge bg-purple-soft text-purple my-1">Users</span></a>
                                                <a class="dropdown-item" href="#!"><span class="badge bg-pink-soft text-pink my-1">Blogs</span></a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="timeline timeline-xs">
                                            <c:set var="timeline" value="${sessionScope.TIMELINE}"></c:set>
                                            <c:forEach begin="0" end="8" var="i">      
                                                <!-- Timeline Item 1-->
                                                <div class="timeline-item">
                                                    <div class="timeline-item-marker">
                                                        <div class="timeline-item-marker-text">${timeline.get(i).getTime()}</div>
                                                        <c:if test="${timeline.get(i).getAction().contains('Category')}">
                                                            <div class="timeline-item-marker-indicator bg-green"></div>
                                                        </c:if>
                                                        <c:if test="${timeline.get(i).getAction().contains('Order')}">
                                                            <div class="timeline-item-marker-indicator bg-blue"></div>
                                                        </c:if>
                                                        <c:if test="${timeline.get(i).getAction().contains('Product')}">
                                                            <div class="timeline-item-marker-indicator bg-yellow"></div>
                                                        </c:if>
                                                        <c:if test="${timeline.get(i).getAction().contains('User')}">
                                                            <div class="timeline-item-marker-indicator bg-purple"></div>
                                                        </c:if>
                                                        <c:if test="${timeline.get(i).getAction().contains('Blog')}">
                                                            <div class="timeline-item-marker-indicator bg-pink"></div>
                                                        </c:if>
                                                    </div>
                                                    <div class="timeline-item-content">${timeline.get(i).getAction()}</div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-6 col-xl-3 mb-4">
                                    <div class="card bg-primary text-white h-100">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div class="me-3">
                                                    <div class="text-white-75 small">Products (All)</div>
                                                    <div class="text-lg fw-bold">${sessionScope.PRODUCT_NUMBER}</div>
                                                </div>
                                                <i class="feather-xl text-white-50" data-feather="archive"></i>
                                            </div>
                                        </div>
                                        <div class="card-footer d-flex align-items-center justify-content-between small">
                                            <a class="text-white stretched-link" href="adminProduct.jsp">View Report</a>
                                            <div class="text-white"><i class="fas fa-angle-right"></i></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-xl-3 mb-4">
                                    <div class="card bg-warning text-white h-100">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div class="me-3">
                                                    <div class="text-white-75 small">Earnings</div>
                                                    <div class="text-lg fw-bold">$${sessionScope.ORDER_TOTAL}</div>
                                                </div>
                                                <i class="feather-xl text-white-50" data-feather="dollar-sign"></i>
                                            </div>
                                        </div>
                                        <div class="card-footer d-flex align-items-center justify-content-between small">
                                            <a class="text-white stretched-link" href="adminBill.jsp">View Report</a>
                                            <div class="text-white"><i class="fas fa-angle-right"></i></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-xl-3 mb-4">
                                    <div class="card bg-success text-white h-100">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div class="me-3">
                                                    <div class="text-white-75 small">Users (Admin and user)</div>
                                                    <div class="text-lg fw-bold">${sessionScope.LIST_USER.size()}</div>
                                                </div>
                                                <i class="feather-xl text-white-50" data-feather="users"></i>
                                            </div>
                                        </div>
                                        <div class="card-footer d-flex align-items-center justify-content-between small">
                                            <a class="text-white stretched-link" href="adminUser.jsp">View Report</a>
                                            <div class="text-white"><i class="fas fa-angle-right"></i></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-xl-3 mb-4">
                                    <div class="card bg-danger text-white h-100">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div class="me-3">
                                                    <div class="text-white-75 small">Blogs</div>
                                                    <div class="text-lg fw-bold">${sessionScope.BLOG_LIST.size()}</div>
                                                </div>
                                                <i class="feather-xl text-white-50" data-feather="file-text"></i>
                                            </div>
                                        </div>
                                        <div class="card-footer d-flex align-items-center justify-content-between small">
                                            <a class="text-white stretched-link" href="adminBlogs.jsp">View Report</a>
                                            <div class="text-white"><i class="fas fa-angle-right"></i></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xl-6 mb-4">
                                    <div class="card card-header-actions h-100">
                                        <div class="card-header">Earnings Breakdown</div>
                                        <div class="card-body">
                                            <div class="chart-area"><canvas id="myAreaChart" width="100%" height="30"></canvas></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-6 mb-4">
                                    <div class="card card-header-actions h-100">
                                        <div class="card-header">
                                            Monthly Revenue
                                        </div>
                                        <div class="card-body">
                                            <div class="chart-bar"><canvas id="myBarChart" width="100%" height="30"></canvas></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/litepicker/dist/bundle.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.28.0/feather.min.js" crossorigin="anonymous"></script>
        <script src="assests/javscript/litepicker.js"></script>
        <script>
            // Set new default font family and font color to mimic Bootstrap's default styling
            (Chart.defaults.global.defaultFontFamily = "Metropolis"),
                    '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
            Chart.defaults.global.defaultFontColor = "#858796";

            function number_format(number, decimals, dec_point, thousands_sep) {
                // *     example: number_format(1234.56, 2, ',', ' ');
                // *     return: '1 234,56'
                number = (number + "").replace(",", "").replace(" ", "");
                var n = !isFinite(+number) ? 0 : +number,
                        prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
                        sep = typeof thousands_sep === "undefined" ? "," : thousands_sep,
                        dec = typeof dec_point === "undefined" ? "." : dec_point,
                        s = "",
                        toFixedFix = function (n, prec) {
                            var k = Math.pow(10, prec);
                            return "" + Math.round(n * k) / k;
                        };
                // Fix for IE parseFloat(0.55).toFixed(0) = 0;
                s = (prec ? toFixedFix(n, prec) : "" + Math.round(n)).split(".");
                if (s[0].length > 3) {
                    s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
                }
                if ((s[1] || "").length < prec) {
                    s[1] = s[1] || "";
                    s[1] += new Array(prec - s[1].length + 1).join("0");
                }
                return s.join(dec);
            }

// Area Chart Example
            var ctx = document.getElementById("myAreaChart");
            var myLineChart = new Chart(ctx, {
                type: "line",
                data: {
                    labels: [
                        "Jan",
                        "Feb",
                        "Mar",
                        "Apr",
                        "May",
                        "Jun",
                        "Jul",
                        "Aug",
                        "Sep",
                        "Oct",
                        "Nov",
                        "Dec"
                    ],
                    datasets: [{
                            label: "Earnings",
                            lineTension: 0.3,
                            backgroundColor: "rgba(0, 97, 242, 0.05)",
                            borderColor: "rgba(0, 97, 242, 1)",
                            pointRadius: 3,
                            pointBackgroundColor: "rgba(0, 97, 242, 1)",
                            pointBorderColor: "rgba(0, 97, 242, 1)",
                            pointHoverRadius: 3,
                            pointHoverBackgroundColor: "rgba(0, 97, 242, 1)",
                            pointHoverBorderColor: "rgba(0, 97, 242, 1)",
                            pointHitRadius: 10,
                            pointBorderWidth: 2,
                            data: [${sessionScope.LINE_CHART[0]},
            ${sessionScope.LINE_CHART[1]},
            ${sessionScope.LINE_CHART[2]},
            ${sessionScope.LINE_CHART[3]},
            ${sessionScope.LINE_CHART[4]},
            ${sessionScope.LINE_CHART[5]},
            ${sessionScope.LINE_CHART[6]},
            ${sessionScope.LINE_CHART[7]},
            ${sessionScope.LINE_CHART[8]},
            ${sessionScope.LINE_CHART[9]},
            ${sessionScope.LINE_CHART[10]},
            ${sessionScope.LINE_CHART[11]}
                            ]
                        }]
                },
                options: {
                    maintainAspectRatio: false,
                    layout: {
                        padding: {
                            left: 10,
                            right: 25,
                            top: 25,
                            bottom: 0
                        }
                    },
                    scales: {
                        xAxes: [{
                                time: {
                                    unit: "date"
                                },
                                gridLines: {
                                    display: false,
                                    drawBorder: false
                                },
                                ticks: {
                                    maxTicksLimit: 7
                                }
                            }],
                        yAxes: [{
                                ticks: {
                                    maxTicksLimit: 5,
                                    padding: 10,
                                    // Include a dollar sign in the ticks
                                    callback: function (value, index, values) {
                                        return "$" + number_format(value);
                                    }
                                },
                                gridLines: {
                                    color: "rgb(234, 236, 244)",
                                    zeroLineColor: "rgb(234, 236, 244)",
                                    drawBorder: false,
                                    borderDash: [2],
                                    zeroLineBorderDash: [2]
                                }
                            }]
                    },
                    legend: {
                        display: false
                    },
                    tooltips: {
                        backgroundColor: "rgb(255,255,255)",
                        bodyFontColor: "#858796",
                        titleMarginBottom: 10,
                        titleFontColor: "#6e707e",
                        titleFontSize: 14,
                        borderColor: "#dddfeb",
                        borderWidth: 1,
                        xPadding: 15,
                        yPadding: 15,
                        displayColors: false,
                        intersect: false,
                        mode: "index",
                        caretPadding: 10,
                        callbacks: {
                            label: function (tooltipItem, chart) {
                                var datasetLabel =
                                        chart.datasets[tooltipItem.datasetIndex].label || "";
                                return datasetLabel + ": $" + number_format(tooltipItem.yLabel);
                            }
                        }
                    }
                }
            });

            window.addEventListener('DOMContentLoaded', event => {
                // Simple-DataTables
                // https://github.com/fiduswriter/Simple-DataTables/wiki

                const tableProduct = document.getElementById('tableProduct');
                if (tableProduct) {
                    new simpleDatatables.DataTable(tableProduct);
                }
                const tableUser = document.getElementById('tableUser');
                if (tableUser) {
                    new simpleDatatables.DataTable(tableUser);
                }
            });
// Set new default font family and font color to mimic Bootstrap's default styling
            (Chart.defaults.global.defaultFontFamily = "Metropolis"),
                    '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
            Chart.defaults.global.defaultFontColor = "#858796";

            function number_format(number, decimals, dec_point, thousands_sep) {
                number = (number + "").replace(",", "").replace(" ", "");
                var n = !isFinite(+number) ? 0 : +number,
                        prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
                        sep = typeof thousands_sep === "undefined" ? "," : thousands_sep,
                        dec = typeof dec_point === "undefined" ? "." : dec_point,
                        s = "",
                        toFixedFix = function (n, prec) {
                            var k = Math.pow(10, prec);
                            return "" + Math.round(n * k) / k;
                        };
                s = (prec ? toFixedFix(n, prec) : "" + Math.round(n)).split(".");
                if (s[0].length > 3) {
                    s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
                }
                if ((s[1] || "").length < prec) {
                    s[1] = s[1] || "";
                    s[1] += new Array(prec - s[1].length + 1).join("0");
                }
                return s.join(dec);
            }

// Bar Chart Example
            var ctx = document.getElementById("myBarChart");
            var myBarChart = new Chart(ctx, {
                type: "bar",
                data: {
                    labels: [
                        "Jan",
                        "Feb",
                        "Mar",
                        "Apr",
                        "May",
                        "Jun",
                        "Jul",
                        "Aug",
                        "Sep",
                        "Oct",
                        "Nov",
                        "Dec"
                    ],
                    datasets: [{
                            label: "Revenue",
                            backgroundColor: "rgba(0, 97, 242, 1)",
                            hoverBackgroundColor: "rgba(0, 97, 242, 0.9)",
                            borderColor: "#4e73df",
                            data: [${sessionScope.LINE_CHART[0]},
            ${sessionScope.LINE_CHART[1]},
            ${sessionScope.LINE_CHART[2]},
            ${sessionScope.LINE_CHART[3]},
            ${sessionScope.LINE_CHART[4]},
            ${sessionScope.LINE_CHART[5]},
            ${sessionScope.LINE_CHART[6]},
            ${sessionScope.LINE_CHART[7]},
            ${sessionScope.LINE_CHART[8]},
            ${sessionScope.LINE_CHART[9]},
            ${sessionScope.LINE_CHART[10]},
            ${sessionScope.LINE_CHART[11]}
                            ],
                            maxBarThickness: 25
                        }]
                },
                options: {
                    maintainAspectRatio: false,
                    layout: {
                        padding: {
                            left: 10,
                            right: 25,
                            top: 25,
                            bottom: 0
                        }
                    },
                    scales: {
                        xAxes: [{
                                time: {
                                    unit: "month"
                                },
                                gridLines: {
                                    display: false,
                                    drawBorder: false
                                },
                                ticks: {
                                    maxTicksLimit: 6
                                }
                            }],
                        yAxes: [{
                                ticks: {
                                    min: 0,
                                    max: 1500,
                                    maxTicksLimit: 5,
                                    padding: 10,
                                    // Include a dollar sign in the ticks
                                    callback: function (value, index, values) {
                                        return "$" + number_format(value);
                                    }
                                },
                                gridLines: {
                                    color: "rgb(234, 236, 244)",
                                    zeroLineColor: "rgb(234, 236, 244)",
                                    drawBorder: false,
                                    borderDash: [2],
                                    zeroLineBorderDash: [2]
                                }
                            }]
                    },
                    legend: {
                        display: false
                    },
                    tooltips: {
                        titleMarginBottom: 10,
                        titleFontColor: "#6e707e",
                        titleFontSize: 14,
                        backgroundColor: "rgb(255,255,255)",
                        bodyFontColor: "#858796",
                        borderColor: "#dddfeb",
                        borderWidth: 1,
                        xPadding: 15,
                        yPadding: 15,
                        displayColors: false,
                        caretPadding: 10,
                        callbacks: {
                            label: function (tooltipItem, chart) {
                                var datasetLabel =
                                        chart.datasets[tooltipItem.datasetIndex].label || "";
                                return datasetLabel + ": $" + number_format(tooltipItem.yLabel);
                            }
                        }
                    }
                }
            });
            window.addEventListener('DOMContentLoaded', event => {
                // Activate feather
                feather.replace();

                // Enable tooltips globally
                var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
                var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                    return new bootstrap.Tooltip(tooltipTriggerEl);
                });

                // Enable popovers globally
                var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
                var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
                    return new bootstrap.Popover(popoverTriggerEl);
                });

                // Activate Bootstrap scrollspy for the sticky nav component
                const stickyNav = document.body.querySelector('#stickyNav');
                if (stickyNav) {
                    new bootstrap.ScrollSpy(document.body, {
                        target: '#stickyNav',
                        offset: 82,
                    });
                }

                // Toggle the side navigation
                const sidebarToggle = document.body.querySelector('#sidebarToggle');
                if (sidebarToggle) {
                    // Uncomment Below to persist sidebar toggle between refreshes
                    // if (localStorage.getItem('sb|sidebar-toggle') === 'true') {
                    //     document.body.classList.toggle('sidenav-toggled');
                    // }
                    sidebarToggle.addEventListener('click', event => {
                        event.preventDefault();
                        document.body.classList.toggle('sidenav-toggled');
                        localStorage.setItem('sb|sidebar-toggle', document.body.classList.contains('sidenav-toggled'));
                    });
                }

                // Close side navigation when width < LG
                const sidenavContent = document.body.querySelector('#layoutSidenav_content');
                if (sidenavContent) {
                    sidenavContent.addEventListener('click', event => {
                        const BOOTSTRAP_LG_WIDTH = 992;
                        if (window.innerWidth >= 992) {
                            return;
                        }
                        if (document.body.classList.contains("sidenav-toggled")) {
                            document.body.classList.toggle("sidenav-toggled");
                        }
                    });
                }

                let activatedPath = window.location.pathname.match(/([\w-]+\.html)/, '$1');

                if (activatedPath) {
                    activatedPath = activatedPath[0];
                } else {
                    activatedPath = 'index.html';
                }

                const targetAnchors = document.body.querySelectorAll('[href="' + activatedPath + '"].nav-link');

                targetAnchors.forEach(targetAnchor => {
                    let parentNode = targetAnchor.parentNode;
                    while (parentNode !== null && parentNode !== document.documentElement) {
                        if (parentNode.classList.contains('collapse')) {
                            parentNode.classList.add('show');
                            const parentNavLink = document.body.querySelector(
                                    '[data-bs-target="#' + parentNode.id + '"]'
                                    );
                            parentNavLink.classList.remove('collapsed');
                            parentNavLink.classList.add('active');
                        }
                        parentNode = parentNode.parentNode;
                    }
                    targetAnchor.classList.add('active');
                });
            });

        </script>
    </body>
</html>

