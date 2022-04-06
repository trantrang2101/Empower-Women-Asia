<%-- 
    Document   : invalid
    Created on : Dec 26, 2021, 2:13:38 AM
    Author     : Tran Trang
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Invalid Page</title>
        <link href="https://fonts.googleapis.com/css?family=Kanit:200" rel="stylesheet">
        <link rel="icon" type="image/x-icon" href="assests/img/Logo.png" />
        <link type="text/css" rel="stylesheet" href="./assests/css/invalid.css" />
    </head>

    <body>
        <div id="notfound">
            <div class="notfound">
                <div class="notfound-404">
                    <h1>404</h1>
                </div>
                <h2>Oops! Nothing was found</h2>
                <p>The page you are looking for might have been removed had its name changed or is temporarily unavailable. 
                    <c:choose>
                        <c:when test="${sessionScope.LOGIN_USER!=null && sessionScope.LOGIN_USER.getRoleID()=='AD'}">
                            <a href="admin.jsp">Return to setting</a>
                        </c:when>
                        <c:otherwise><a href="CategoryController">Return to homepage</a></c:otherwise>
                    </c:choose>
                </p>
            </div>
        </div>
        <script>
            let msg = '${requestScope.ERROR}';
            if (msg !== '') {
                alert(msg);
            }
        </script>
    </body>
</html>

