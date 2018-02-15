<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: viorelv
  Date: 7/31/2017
  Time: 12:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Post</title>
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

        #post-box {
            width: 800px;
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

        .text {
            width: 700px;
        }

        #content {
            width: 700px;
            max-width: 700px;
            min-height: 250px;
            max-height: 500px;
        }

    </style>
    <link rel="stylesheet" href="http://localhost:8080/resources/css/jquery.tag-editor.css">
</head>
<jsp:include page="navigation.jsp"/>
<body>
<div id="post-box">
    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>
    <form action="/makePost" method="post">
        <table id="postTable">
            <tbody>
            <tr>
                <td>Title</td>
                <td></td>
            </tr>
            <tr>
                <td><input type="text" name="title" required class="text"/>
                <td>
                <td></td>
            </tr>
            <tr>
                <td>Content</td>
                <td></td>
            </tr>
            <tr>
                <td><textarea name="content" required id="content"></textarea></td>
                <td></td>
            </tr>
            <tr>
                <td>Tags</td>
                <td></td>
            </tr>
            <tr>
                <td><textarea name="tags" class="text" id="tags"></textarea></td>
                <td></td>
            </tr>
            <tr>
                <td><input type="submit" value="ask" id="button"/></td>
                <td></td>
            </tr>
            </tbody>
        </table>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </form>
</div>
<script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.10.2/jquery-ui.min.js"></script>
<script src="http://localhost:8080/resources/javascript/jquery.caret.min.js"></script>
<script src="http://localhost:8080/resources/javascript/jquery.tag-editor.js"></script>
<script>
    $(document).ready(function () {
        $('#tags').tagEditor({
            delimiter: ', ', /* space and comma */
            placeholder: 'Enter tags ...'
        });
    });

</script>
</body>
</html>
