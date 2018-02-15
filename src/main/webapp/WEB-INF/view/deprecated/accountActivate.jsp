<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: viorelv
  Date: 09-Aug-17
  Time: 12:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Activate</title>
    <style>
        #all {
            margin: auto;
            width: 50%;
            text-align: center;
        }
    </style>
</head>
<jsp:include page="navigation.jsp"/>
<body>
<div id="all">
    <c:choose>
        <c:when test="${succes}">
            Another token was sent to the email specified.
        </c:when>
        <c:otherwise>
            Something went wrong...<br/>
            You can try again <a href="http://localhost:8080/activate?retryToken&id=${param.id}">here</a>.
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
