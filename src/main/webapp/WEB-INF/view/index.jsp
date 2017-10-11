<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: viorelv
  Date: 7/25/2017
  Time: 11:43 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Index</title>
    <style>
        #center {
            width: 70%;
            margin: auto;
        }

        #bigLogo {
            display: block;
            margin-left: auto;
            margin-right: auto;
        }
    </style>
</head>
<jsp:include page="navigation.jsp"/>
<body>
<div id="center">
    <img src="http://localhost:8080/resources/images/big_logo.png" id="bigLogo"/>
</div>
</body>
</html>
