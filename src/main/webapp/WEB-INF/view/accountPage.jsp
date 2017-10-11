<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: viorelv
  Date: 03-Aug-17
  Time: 8:58 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Account</title>
    <style>
        #userTable {
            width: 70%;
            margin: auto;
        }

        #userTable {
            border: 2px solid black;
        }

        #profilePicture {
            width: 100px;
            height: 100px;
        }
    </style>
</head>
<jsp:include page="navigation.jsp"/>
<body>
<div id="account-box">
    <table id="userTable">
        <tbody>
        <tr>
            <td><img src="${user.profileImage}" id="profilePicture"></td>
        </tr>
        <tr>
            <td>Username: ${user.username}</td>
        </tr>
        <tr>
            <td>First name: ${user.firstName}</td>
        </tr>
        <tr>
            <td>Last name: ${user.lastName}</td>
        </tr>
        <tr>
            <td>Email: ${user.email}</td>
        </tr>
        <tr>
            <td>Member since: ${user.creationDate}</td>
        </tr>
        <tr>
            <td>Date of birth: ${user.dateOfBirth}</td>
        </tr>
        <tr>
            <td>Gender: ${user.gender}</td>
        </tr>
        <tr>
            <td>Role: ${user.role}</td>
        </tr>
        <tr>
            <td>
                <c:if test="${myAccount}">
                    <a href="update">Update</a>
                </c:if>
            </td>
        </tr>
        <tr>
            <td><a href="http://localhost:8080/post?search&user=${user.userId}&page=0">See my posts</a></td>
        </tr>
        <tr>
            <c:if test="${!myAccount && user.role=='ROLE_USER'}">
                <td>
                    <c:if test="${user.enabled == 1}">
                        <form action="/toggleEnabled" method="post">
                            <input type="hidden" name="username" value="${user.username}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <input type="hidden" name="user" value="${param.username}">
                            <input name="submit" type="submit" value="Disable"/>
                        </form>
                    </c:if>
                    <c:if test="${user.enabled == 0}">
                        <form action="/toggleEnabled" method="post">
                            <input type="hidden" name="username" value="${user.username}">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <input type="hidden" name="user" value="${param.username}">
                            <input name="submit" type="submit" value="Enable"/>
                        </form>
                    </c:if>
                </td>
                <td>
                    <form action="/makeAdmin" method="post">
                        <input type="hidden" name="username" value="${user.username}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <input type="hidden" name="user" value="${param.username}">
                        <input name="submit" type="submit" value="Make Admin"/>
                    </form>
                </td>
            </c:if>
        </tr>
        </tbody>
    </table>
</div>
</body>
</html>
