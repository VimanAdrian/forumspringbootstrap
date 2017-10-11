<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="mytaglib" tagdir="/WEB-INF/tags/mytaglib" %>

<%--
  Created by IntelliJ IDEA.
  User: viorelv
  Date: 8/1/2017
  Time: 10:48 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
    <title>Search</title>
    <style>
        #questionList {
        }

        #questionBody {
            width: 70%;
            border: 1px solid #a94442;
            padding-left: 3%;
        }

        #questionTitle {
            color: black;
            text-decoration-style: solid;
            text-transform: uppercase;
        }

        .pages {
            margin: auto;
            width: 50%;
            text-align: center;
        }

        #categories {
            position: absolute;
            top: 70px;
            right: 20px;
        }

        .profilePicture {
            width: 35px;
            height: 35px;
        }

        #titleRow {
            width: 100%;
            text-align: left;
            margin-bottom: 0;
        }

        .randomInfCol {
            width: 60%;
            font-size: 0.8em;

        }

        .userCol {
            width: 40%;
            padding-top: 3%;
        }

        .userCol table {
            float: right;
            font-size: 0.8em;

        }

        .post {
            background: whitesmoke;
            width: 100%;
        }

        .userTable {
            background-color: darkgray;
            margin: 0;
            bottom: 0;
        }

        .postTables {
            width: 100%;
        }

        #center {
            margin-left: 5%;
            width: 50%;
            text-align: center;
            background-color: white;
        }

    </style>

    <script>
        $(document).ready(function () {
            var ajaxDataStack = {};
            var tagged = '';
            var title = "${searchParam}";
            ajaxDataStack['order'] = 'desc';
            ajaxDataStack['sort'] = 'votes';
            ajaxDataStack['min'] = 0;
            ajaxDataStack['page'] = 1;
            ajaxDataStack['pagesize'] = 50;
            ajaxDataStack['accepted'] = "True";
            ajaxDataStack['site'] = 'stackoverflow';
            if (tagged !== '')
                ajaxDataStack['tagged'] = tagged;
            if (title !== '')
                ajaxDataStack['title'] = title;
            $.ajax({
                type: "GET",
                url: 'https://api.stackexchange.com/2.2/search/advanced',
                data: ajaxDataStack,
                dataType: "json",
                success: function (data, textStatus, jqXHR) {
                    if (data) {
                        console.log("stackoverflow");
                        console.log(data);
                        $("#stackLink").attr("href", data.items[0].link);
                        $("#stackLink").text(data.items[0].title);
                        //alert($(data.items).each(function (index, object) {
                        //    alert(index);
                        //    alert(object.title);
                        //    alert(object.link);
                        //}));
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
    </script>

    <script>
        $(document).ready(function () {
            var ajaxDataReddit = {};
            var q = "${searchParam}";
            ajaxDataReddit['sort'] = 'top';
            ajaxDataReddit['t'] = 'all';
            ajaxDataReddit['restrict_sr'] = 'True';
            ajaxDataReddit['limit'] = 50;
            if (q !== '')
                ajaxDataReddit['q'] = q;
            $.ajax({
                type: "GET",
                url: 'https://www.reddit.com/r/learnprogramming/search.json?',
                data: ajaxDataReddit,
                dataType: "json",
                success: function (data, textStatus, jqXHR) {
                    if (data) {
                        console.log("reddit");
                        console.log(data);
                        $("#redditLink").attr("href", data.data.children[0].data.url);
                        $("#redditLink").text(data.data.children[0].data.title);
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
    </script>


</head>
<jsp:include page="navigation.jsp"/>
<body>
<br/>
<div class="pages">
    <mytaglib:pagination url="${url}" nrPagini="${nrPagini}"/>
</div>
<div id="stack">
    <p>stackoverflow result: <a href="" id="stackLink"></a></p>
</div>
<div id="reddit">
    <p>reddit result: <a href="" id="redditLink"></a></p>
</div>
<div id="questionList">
    <div id="center">
        <c:forEach var="post" items="${searchResults}">
            <div class="post">
                <p id="titleRow"><a href="http://localhost:8080/post?postID=${post.postId}&page=0"
                                    id="questionTitle">${post.title}</a></p>
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
                            <table class="userTable">
                                <tbody>
                                <tr>
                                    <td rowspan="3">
                                        <img src="${post.user.profileImage}" class="profilePicture">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Username: <a
                                            href="http://localhost:8080/account?username=${post.user.username}">${post.user.username}</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Email: ${post.user.email}
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>

        </c:forEach>
    </div>
</div>
<div class="pages">
    <mytaglib:pagination url="${url}" nrPagini="${nrPagini}"/>
</div>
<div id="categories">
    <table>
        <tbody>
        <c:forEach var="category" items="${categoryList}">
            <tr>
                <td><a href="http://localhost:8080/post?search&tag=${category.url}&page=0">${category.title}</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
