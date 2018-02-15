<%--
  Created by IntelliJ IDEA.
  User: viorelv
  Date: 09-Aug-17
  Time: 3:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ResetPassword</title>
    <style>
        #all {
            margin: auto;
            width: 50%;
            text-align: center;
        }

        #passwordBox {
            width: 300px;
            padding: 20px;
            margin: 100px auto;
            background: #fff;
            -webkit-border-radius: 2px;
            -moz-border-radius: 2px;
            border: 1px solid #000;
        }
    </style>

</head>
<body>
<jsp:include page="navigation.jsp"/>
<div id="all">
    <div id="emailBox">
        <form name='password' action="resetPassword" method='POST'>
            <table id="emailTable">
                <tr>
                    <td>Password:</td>
                    <td><input type="password" name="password" placeholder="password(required)" required
                               pattern=".{5,}"/>
                    </td>
                </tr>
                <tr>
                    <td>Password again:</td>
                    <td><input type="password" name="password2" placeholder="password(required)" required
                               pattern=".{5,}"/>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td><input name="submit" type="submit" value="submit" id="button"/></td>
                </tr>
            </table>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="userId" value="${userID}"/>
        </form>
    </div>
</div>
</body>
</html>
