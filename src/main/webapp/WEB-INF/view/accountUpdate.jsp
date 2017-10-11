<%--
  Created by IntelliJ IDEA.
  User: viorelv
  Date: 7/25/2017
  Time: 11:30 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update</title>
    <style>
        .error {
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

        #update-box {
            width: 350px;
            padding: 20px;
            margin: 100px auto;
            background: #fff;
            -webkit-border-radius: 2px;
            -moz-border-radius: 2px;
            border: 1px solid #000;
        }

        .button {
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

        .inputfile {
            width: 0.1px;
            height: 0.1px;
            opacity: 0;
            overflow: hidden;
            position: absolute;
            z-index: -1;
        }

        .inputfile + label {
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
<div id="update-box">
    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>
    <c:if test="${not empty msg}">
        <div class="msg">${msg}</div>
    </c:if>
    <form action="/update" method="POST">
        <table id="updateTable">
            <tbody>
            <tr>
                <td>First Name:</td>
                <td><input type="text" name="firstName" placeholder="${user.firstName}"/></td>
            </tr>
            <tr>
                <td>Last Name:</td>
                <td><input type="text" name="lastName" placeholder="${user.lastName}"/></td>
            </tr>
            <tr>
                <td>Email:</td>
                <td><input type="email" name="email" placeholder="${user.email}"/></td>
            </tr>
            <tr>
                <td>Date of birth:</td>
                <td><input type="date" name="dateOfBirth" value="${user.dateOfBirth}"/></td>
            </tr>
            <tr>
                <td>Gender:</td>
                <td>
                    <select name="gender">
                        <option value="male">Male</option>
                        <option value="female">Female</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Profile image link:</td>
                <td><input type="text" name="profileImage" placeholder="http://www.imgur.com"></td>
            </tr>
            <tr>
                <td></td>
                <td><input type="submit" value="Update" class="button" name="update"/></td>
            </tr>
            </tbody>
        </table>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </form>
    <form name='emailForm' action="forgotPassword" method='POST'>
        <table id="emailTable">
            <tr>
                <td></td>
                <td><input name="submit" type="submit" value="Password reset" class="button"/></td>
            </tr>
        </table>
        <input type='hidden' name='username' value="${user.username}">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </form>
    <form method="POST" action="uploadOneFile" enctype="multipart/form-data">
        <table>
            <tbody>
            <tr>
                <td>
                    <input type="file" name="file"><br/>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="submit" value="Upload" class="button">
                </td>
            </tr>
            </tbody>
        </table>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input type="hidden" name="username" value="${pageContext.request.userPrincipal.name}"/>
    </form>
</div>
</body>
</html>
