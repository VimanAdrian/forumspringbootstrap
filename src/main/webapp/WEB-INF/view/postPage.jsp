<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="mytaglib" tagdir="/WEB-INF/tags/mytaglib" %>
<%--
  Created by IntelliJ IDEA.
  User: viorelv
  Date: 7/31/2017
  Time: 1:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>PostPage</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            $(document).on("click", "#editButton", function () {
                if ($(".postEdit").css('display') === 'none') {
                    $(".postEdit").css("display", "inherit");
                }
                else {
                    $(".postEdit").css("display", "none");
                }
            });

        });
    </script>

    <script>
        $(document).ready(function () {
            localPostId = "${post.postId}";
            $(document).on("click", ".voteButton", function () {
                localVoteType = $(this).val();
                $.ajax({
                    type: "POST",
                    url: '/votePost',
                    data: {
                        postID: localPostId,
                        type: localVoteType,
                        "${_csrf.parameterName}": "${_csrf.token}"
                    },
                    dataType: "json",
                    success: function (data, textStatus, jqXHR) {
                        if (data) {
                            //alert("Succes!");
                            if (localVoteType === 'Upvote') {
                                $("#postScore").html(parseInt($("#postScore").html()) + 1);
                            }
                            else if (localVoteType === 'Downvote') {
                                $("#postScore").html(parseInt($("#postScore").html()) - 1);
                            }
                            $('.voteButton').each(function () {
                                $(this).toggle();

                            });
                        }
                        else {
                            alert("Eroare!");
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert("Server error!")
                    },
                    beforeSend: function (jqXHR, settings) {
                    },
                    complete: function (jqXHR, textStatus) {
                    }

                });
            });
        });
    </script>

    <script>
        $(document).ready(function () {
            $(document).on("click", ".toggleButton", function () {
                toggleButton = $(this).val();
                $.ajax({
                    type: "POST",
                    url: '/togglePostStatus',
                    data: {
                        postID: localPostId,
                        "${_csrf.parameterName}": "${_csrf.token}"
                    },
                    dataType: "json",
                    success: function (data, textStatus, jqXHR) {
                        if (data) {
                            $('.toggleButton').each(function () {
                                $(this).toggle();
                            });
                        }
                        else {
                            alert("Eroare!");
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert("Server error!")
                    },
                    beforeSend: function (jqXHR, settings) {
                    },
                    complete: function (jqXHR, textStatus) {
                    }

                });
            });
        });
    </script>

    <style>

        #post {
            border: 1px solid green;
        }

        #mainPost {
            background: whitesmoke;
        }

        .reply {
            border: 1px solid darkgray;
            background: whitesmoke;
        }

        .user {
            border: 1px solid red;
        }

        .profilePicture {
            width: 75px;
            height: 75px;
        }

        #center {
            margin: auto;
            width: 50%;
            text-align: center;
            background-color: white;
        }

        #content {
            width: 399px;
            background: #fff;
            -webkit-border-radius: 2px;
            -moz-border-radius: 2px;
            border: 1px solid #000;
        }

        .postEdit {
            display: none;
        }

        .newlines {
            white-space: pre-wrap;
        }

        #titleRow {
            width: 100%;
        }

        .buttonsCol {
            width: 10%;
        }

        .contentCol {
            min-width: 90%;
            background-color: lightgray;
            word-break: keep-all;
            padding-left: 5%;
        }

        .randomInfCol {
            width: 60%;
        }

        .userCol {
            width: 40%;
        }

        #bestRandomInfoCol {
            width: 25%;
        }

        #bestContent {
            width: 75%;
        }

        .postTables {
            width: 100%;
        }

        .replyTables {
            width: 100%;
        }

        .upvoteButton {
            overflow: hidden;
            background: url("http://localhost:8080/resources/images/buttons/upvote.png");
            width: 40px;
            height: 40px;

            text-indent: 200%;
            white-space: nowrap;

            box-shadow: none;
        }

        .downvoteButton {
            overflow: hidden;
            background: url("http://localhost:8080/resources/images/buttons/downvote.png");
            width: 40px;
            height: 40px;

            text-indent: 200%;
            white-space: nowrap;

            box-shadow: none;
        }

        .enableButton {
            overflow: hidden;
            background: url("http://localhost:8080/resources/images/buttons/enable.png");
            width: 40px;
            height: 40px;

            text-indent: 200%;
            white-space: nowrap;

            box-shadow: none;
        }

        .disableButton {
            overflow: hidden;
            background: url("http://localhost:8080/resources/images/buttons/disable.png");
            width: 40px;
            height: 40px;

            text-indent: 200%;
            white-space: nowrap;

            box-shadow: none;
        }

        .bestButton {
            overflow: hidden;
            background: url("http://localhost:8080/resources/images/buttons/best.png");
            width: 40px;
            height: 40px;

            text-indent: 200%;
            white-space: nowrap;

            box-shadow: none;
        }

        .editButton {
            overflow: hidden;
            background: url("http://localhost:8080/resources/images/buttons/edit.png");
            width: 40px;
            height: 40px;

            text-indent: 200%;
            white-space: nowrap;

            box-shadow: none;
        }

        .userCol table {
            float: right;
        }

        .disabledReply {
            background: #AA98A9;
            margin: 0;
        }

        #bestReply {
            background: #5E716A;
            margin: 0;
        }
    </style>
</head>
<jsp:include page="navigation.jsp"/>
<body>
<c:if test="${not empty post}">
    <div id="center">
        <div id="mainPost">
            <p id="titleRow">${post.title}</p>
            <table class="postTables">
                <tbody>
                <tr>
                    <td colspan="1" class="buttonsCol">
                        <sec:authorize access="isAuthenticated()">
                            <table>
                                <tbody>
                                <tr>
                                    <td><input type="button" name="voteButton" class="voteButton upvoteButton"
                                               value="Upvote"
                                               <c:if test="${voteType==1}">hidden</c:if> />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="button" name="voteButton" class="voteButton downvoteButton"
                                               value="Downvote"
                                               <c:if test="${voteType==-1}">hidden</c:if> />
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </sec:authorize>
                        <sec:authorize access="hasRole('ROLE_ADMIN')">
                            <table>
                                <tbody>
                                <tr id="deleteRow">
                                    <td><input type="button" name="toggleButton" class="toggleButton disableButton"
                                               value="Disable"
                                               <c:if test="${post.active==0}">hidden</c:if> >
                                        <input type="button" name="toggleButton" class="toggleButton enableButton"
                                               value="Enable"
                                               <c:if test="${post.active==1}">hidden</c:if> >
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </sec:authorize>
                        <c:if test="${post.user.username==pageContext.request.userPrincipal.name}">
                            <table>
                                <tbody>
                                <tr>
                                    <td>
                                        <input type="button" value="Edit" id="editButton" class="editButton"/>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </c:if>
                    </td>
                    <td colspan="1" class="contentCol">${post.content}</td>
                </tr>
                </tbody>
            </table>
            <table class="postTables">
                <tbody>
                <tr>
                    <td class="randomInfCol">
                        <table>
                            <tbody>
                            <tr>
                                Views: ${post.views}<br/>
                                Score:<span id="postScore">${post.score}</span><br/>
                                Date: <span class="creationDate">${post.creationDate}</span><br/>
                                Tags:
                                <c:forEach var="category" items="${post.categories}">
                                    <a href="http://localhost:8080/post?search&tag=${category.url}&page=0">${category.title}</a> 
                                </c:forEach>
                                <br/>
                            </tr>
                            </tbody>
                        </table>
                    </td>
                    <td class="userCol">
                        <table style="background-color: darkgray;">
                            <tbody>
                            <tr>
                                <td rowspan="4">
                                    <img src="${post.user.profileImage}" class="profilePicture">
                                </td>
                                <td>
                                    Username: <a
                                        href="http://localhost:8080/account?username=${post.user.username}">${post.user.username}</a>
                                </td>
                            </tr>
                            <tr>
                                <td>Name: ${post.user.firstName} ${post.user.lastName}</td>
                            </tr>
                            <tr>
                                <td>Email: ${post.user.email}</td>
                            </tr>
                            <tr>
                                <td>Member since: ${post.user.creationDate}</td>
                            </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                </tbody>
            </table>

            <form action="/editPost" method="Post" class="postEdit">
                <table class="postEdit">
                    <tbody>
                    <tr>
                        <td>Title</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><input type="text" name="title" required class="text"
                                   value="${post.title}"/>
                        <td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>Content</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><textarea name="content" required id="contentPost" rows="20"
                                      cols="100">${post.content}</textarea></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Edit" id="buttonPost"/></td>
                        <td></td>
                    </tr>
                    </tbody>
                </table>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="postId" value="${post.postId}"/>
            </form>
        </div>
        <sec:authorize access="isAuthenticated()">
            <form action="/makeReply" method="post">
                <table style="width: 100%">
                    <tbody>
                    <tr>
                        <td><textarea name="content" required id="content"
                                      placeholder="Insert answer here" style="width: 100%"></textarea></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="answer" id="button"/></td>
                    </tr>
                    </tbody>
                </table>
                <input type="hidden" name="postId" value="${post.postId}">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="page" value="${param.page}">
            </form>
        </sec:authorize>

        <jsp:include page="postPageReplies.jsp"/>
    </div>

</c:if>
<c:if test="${empty post}">You took a wrong turn. There is nothing here. :</c:if>
</body>
</html>
