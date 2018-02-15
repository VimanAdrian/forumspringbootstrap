<%--
  Created by IntelliJ IDEA.
  User: viorelv
  Date: 7/25/2017
  Time: 11:37 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>navigation</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            currentTime();

            function currentTime() {
                var dt = new Date();
                var time = ('0' + dt.getHours()).slice(-2) + ":" + ('0' + dt.getMinutes()).slice(-2) + ":" + ('0' + dt.getSeconds()).slice(-2);
                $("#currentTime").text("The current time is " + time);
                setTimeout(currentTime, 1000);
            }
        });
    </script>
    <style>
        #topNavigation {
            background-color: black;
        }

        #topNavigationList {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
        }

        .element {
            float: left;
            width: 150px;
        }

        .element a {
            display: block;
            color: white;
            text-align: center;
            padding: 16px;
            text-decoration: none;
        }

        .element :hover {
            background-color: gray;
        }

        #search {
            float: right;
            width: 400px;
        }

        #searchBox {
            width: 350px;
            border-radius: 4px;
            padding: 8px;
            font-size: 16px;
            position: relative;
            top: 8px;
            left: 18px;
        }

        #searchDisabled {
            position: relative;
            top: 8px;
            left: 8px;
            padding: 8px;
        }

        html {
            height: 100%;
            box-sizing: border-box;
        }

        *,
        *:before,
        *:after {
            box-sizing: inherit;
        }

        body {
            position: relative;
            margin: 0;
            padding-bottom: 6rem;
            min-height: 100%;
            font-family: "Helvetica Neue", Arial, sans-serif;
        }

        #footer {
            position: absolute;
            right: 0;
            bottom: 0;
            left: 0;
            padding: 1rem;
            background-color: black;
            text-align: center;
            color: white;
        }

        #currentTime {
            color: white;
            text-align: center;
            text-decoration: none;
        }

        #logoutForm {
            display: none;
        }

        #logo {
            width: 46px;
            height: 21px;
        }

    </style>
</head>
<body>
<div id="topNavigation">
    <ul id="topNavigationList">
        <li class="element"><a href="/"><img src="http://localhost:8080/resources/images/big_logo_negative.png"
                                             alt="Home" id="logo"/></a>
        </li>
        <!-- login -->
        <sec:authorize access="isAnonymous()">
            <li class="element"><a href="http://localhost:8080/login">Login</a></li>
        </sec:authorize>
        <!-- register -->
        <sec:authorize access="isAnonymous()">
            <li class="element"><a href="http://localhost:8080/register">Register</a></li>
        </sec:authorize>
        <!-- logout -->
        <c:url value="/logout" var="logoutUrl"/>
        <form action="${logoutUrl}" method="post" id="logoutForm">
            <input type="hidden" name="${_csrf.parameterName}"
                   value="${_csrf.token}"/>
        </form>
        <script>
            function formSubmit() {
                document.getElementById("logoutForm").submit();
            }
        </script>
        <sec:authorize access="isAuthenticated()">
            <li class="element"><a href="javascript:formSubmit()">Logout</a></li>
        </sec:authorize>
        <!-- myAccount -->
        <sec:authorize access="isAuthenticated()">
            <li class="element"><a href="http://localhost:8080/account">My account</a></li>
        </sec:authorize>
        <!--make post-->
        <sec:authorize access="isAuthenticated()">
            <li class="element"><a href="http://localhost:8080/newPost">Ask a question</a></li>
        </sec:authorize>
        <li class="element"><a href="http://localhost:8080/post?search&browse&page=0">All posts</a></li>
        <!-- admin stuff -->
        <sec:authorize access="hasRole('ROLE_ADMIN')">
            <li class="element"><a href="http://localhost:8080/post?disabled=on&search&browse&page=0">Disabled Posts</a>
            </li>
            <li class="element"><a href="http://localhost:8080/admin/users?page=0">Users</a></li>
        </sec:authorize>
        <!-- search -->
        <li id="search">
            <form action="/post" method="get">
                <sec:authorize access="hasRole('ROLE_ADMIN')">
                    <input type="checkbox" name="disabled" id="searchDisabled">
                </sec:authorize>
                <input type="text" name="search" placeholder="Search.." id="searchBox">
                <input type="hidden" name="page" value="0">
            </form>
        </li>
    </ul>
</div>
<div id="footer"><p id="currentTime"></p></div>
</body>
</html>