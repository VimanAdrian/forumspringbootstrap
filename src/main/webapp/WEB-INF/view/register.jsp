<%--
  Created by IntelliJ IDEA.
  User: viorelv
  Date: 7/25/2017
  Time: 11:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
    <style>
        .registerError {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
            color: #a94442;
            background-color: #f2dede;
            border-color: #ebccd1;
        }

        .msg {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
            color: #31708f;
            background-color: #d9edf7;
            border-color: #bce8f1;
        }

        #register-box {
            width: 350px;
            padding: 20px;
            margin: 100px auto;
            background: #fff;
            -webkit-border-radius: 2px;
            -moz-border-radius: 2px;
            border: 1px solid #000;
        }

        #button {
            background-color: black;
            border: none;
            color: white;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
        }

    </style>
</head>
<jsp:include page="navigation.jsp"/>
<body>
<div id="register-box">
    <c:if test="${not empty registerError}">
        <div class="registerError">${registerError}</div>
    </c:if>
    <c:if test="${not empty msg}">
        <div class="msg">${msg}</div>
    </c:if>
    <form action="/register" method="POST" id="registerForm">

        <p><label for="username">Username:</label>
            <input type="text" id="username" name="username" placeholder="username(required)" required
                   pattern=".{3,}"/></p><br/>
        <p><label for="password">Password:</label>
            <input type="password" id="password" name="password" placeholder="password(required)" required
                   pattern=".{5,}"/></p><br/>
        <p><label for="password2">Password again:</label>
            <input type="password" id="password2" name="password2" placeholder="password(required)" required
                   pattern=".{5,}"/></p><br/>
        <p><label for="email">Email:</label>
            <input type="email" id="email" name="email" placeholder="email(required)" required/></p><br/>
        <p><label for="firstName">First Name:</label>
            <input type="text" id="firstName" name="firstName" placeholder="firstName"/></p><br/>
        <p><label for="lastName">Last Name:</label>
            <input type="text" id="lastName" name="lastName" placeholder="lastName"/></p><br/>
        <p><label for="date">Date of birth:</label>
            <input type="date" id="date" name="dateOfBirth" value="1970-01-01"/></p><br/>
        <p><label for="gender">Gender:</label>
            <select name="gender" id="gender">
                <option value="male">Male</option>
                <option value="female">Female</option>
            </select>
        </p>
        <br/>
        <p><input type="submit" value="Register" id="button"/></p>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </form>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script src="http://localhost:8080/resources/javascript/formValidation.js"></script>
<script>
    $("#registerForm").validate();
</script>
</body>
</html>
