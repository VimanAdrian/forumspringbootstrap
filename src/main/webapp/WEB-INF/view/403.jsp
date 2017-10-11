<%--
  Created by IntelliJ IDEA.
  User: viorelv
  Date: 7/25/2017
  Time: 11:37 AM
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>403</title>
    <style>
        #error-box {
            width: 300px;
            padding: 20px;
            margin: 100px auto;
            background: #fff;
            -webkit-border-radius: 2px;
            -moz-border-radius: 2px;
        }

        .error {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
            color: #a94442;
            background-color: #f2dede;
            border-color: #ebccd1;
        }
    </style>
</head>
<jsp:include page="navigation.jsp"/>
<body>
<div id="error-box">
    <div class="error">
        <c:choose>
            <c:when test="${empty username}">
                You must be loged in as an administrator to view this page!
            </c:when>
            <c:otherwise>
                Username: ${username} <br/> You are not an administrator!
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>