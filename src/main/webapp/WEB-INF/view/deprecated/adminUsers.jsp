<%--
  Created by IntelliJ IDEA.
  User: viorelv
  Date: 7/25/2017
  Time: 11:37 AM
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="mytaglib" tagdir="/WEB-INF/tags/mytaglib" %>
<html>
<head>
    <title>Admin</title>
    <style>

        .hello {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
            color: #5c8202;
            background-color: #eaf7ca;
            border-color: #d8efa2;
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

        .msg {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
            color: #31708f;
            background-color: #d9edf7;
            border-color: #bce8f1;
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

        .black {
            width: 350px;
            padding: 20px;
            margin: 100px auto;
            background: #fff;
            -webkit-border-radius: 2px;
            -moz-border-radius: 2px;
        }

        #userTableBox {
            margin: auto;
            width: 80%;
        }

        #userTable {
            width: 100%;
        }

        #userTable, th, td {
            border: 2px solid black;
        }

        #RANDGOLFIX {
            display: none;
        }

        .page {
            margin: auto;
            width: 50%;
            text-align: center;
        }

    </style>
</head>
<jsp:include page="navigation.jsp"/>
<body>
<div>
    <sec:authorize access="isAuthenticated()">
        <div class="black">
            <div class="hello">
                Welcome: ${pageContext.request.userPrincipal.name}
            </div>
            <br/>
            <br/>

            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>
            <c:if test="${not empty adminSucces}">
                <div class="msg">${adminSucces}</div>
            </c:if>
            <c:if test="${not empty disableSucces}">
                <div class="msg">${disableSucces}</div>
            </c:if>
            <c:if test="${not empty enableSucces}">
                <div class="msg">${enableSucces}</div>
            </c:if>
        </div>
        <div class="page">
            <mytaglib:pagination url="${url}" nrPagini="${nrPagini}"/>
        </div>
        <div id="userTableBox">
            <table id="userTable">
                <thead>
                <tr>
                    <th>userID</th>
                    <th>username</th>
                    <th>firstName</th>
                    <th>lastName</th>
                    <th>email</th>
                    <th>dateOfBirth</th>
                    <th>gender</th>
                    <th>creationDate</th>
                    <th>profileImage</th>
                    <th>enabled</th>
                    <th>Make Admin</th>
                </tr>
                </thead>
                <tbody>
                <tr id="RANDGOLFIX">
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <c:forEach var="user" items="${userList}">
                    <tr>
                        <td>${user.userId}</td>
                        <td><a href="http://localhost:8080/account?username=${user.username}">${user.username}</a></td>
                        <td>${user.firstName}</td>
                        <td>${user.lastName}</td>
                        <td>${user.email}</td>
                        <td>${user.dateOfBirth}</td>
                        <td>${user.gender}</td>
                        <td>${user.creationDate}</td>
                        <td><img src="${user.profileImage}" style="width: 50px; height: 50px;"></td>
                        <td>
                            <c:if test="${user.enabled==1}">
                                <form action="/toggleEnabled" method="post">
                                    <input type="hidden" name="username" value="${user.username}">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <input type="hidden" name="page" value="${param.page}">
                                    <input name="submit" type="submit" value="Disable"/>
                                </form>
                            </c:if>
                            <c:if test="${user.enabled==0}">
                                <form action="/toggleEnabled" method="post">
                                    <input type="hidden" name="username" value="${user.username}">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                    <input type="hidden" name="page" value="${param.page}">
                                    <input name="submit" type="submit" value="Enable"/>
                                </form>
                            </c:if>
                        </td>
                        <td>
                            <form action="/makeAdmin" method="post">
                                <input type="hidden" name="username" value="${user.username}">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <input type="hidden" name="page" value="${param.page}">
                                <input name="submit" type="submit" value="Make Admin"/>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="page">
            <mytaglib:pagination url="${url}" nrPagini="${nrPagini}"/>
        </div>
    </sec:authorize>
</div>
</body>
</html>


