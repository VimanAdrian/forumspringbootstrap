<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: viorelv
  Date: 09-Aug-17
  Time: 2:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ForgotPassword</title>
    <style>
        #all {
            margin: auto;
            width: 50%;
            text-align: center;
        }

        #emailBox {
            width: 300px;
            padding: 20px;
            margin: 100px auto;
            background: #fff;
            -webkit-border-radius: 2px;
            -moz-border-radius: 2px;
            border: 1px solid #000;
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
<div id="all">
    <div id="emailBox">
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <form name='emailForm' action="forgotPassword" method='POST'>
            <table id="emailTable">
                <tr>
                    <td>Username:</td>
                    <td><input type='text' name='username' placeholder="username" required></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input name="submit" type="submit" value="submit" id="button"/></td>
                </tr>
            </table>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
    </div>
</div>
</body>
</html>
