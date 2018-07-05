<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags-mytaglib" tagdir="/WEB-INF/tags/mytaglib" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: viorelv
  Date: 13-Oct-17
  Time: 11:07 AM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="apple-touch-icon" sizes="57x57"
          href="${pageContext.request.contextPath}/resources/favicon/apple-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="60x60"
          href="${pageContext.request.contextPath}/resources/favicon/apple-icon-60x60.png">
    <link rel="apple-touch-icon" sizes="72x72"
          href="${pageContext.request.contextPath}/resources/favicon/apple-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="76x76"
          href="${pageContext.request.contextPath}/resources/favicon/apple-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114"
          href="${pageContext.request.contextPath}/resources/favicon/apple-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120"
          href="${pageContext.request.contextPath}/resources/favicon/apple-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144"
          href="${pageContext.request.contextPath}/resources/favicon/apple-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152"
          href="${pageContext.request.contextPath}/resources/favicon/apple-icon-152x152.png">
    <link rel="apple-touch-icon" sizes="180x180"
          href="${pageContext.request.contextPath}/resources/favicon/apple-icon-180x180.png">
    <link rel="icon" type="image/png" sizes="192x192"
          href="${pageContext.request.contextPath}/resources/favicon/android-icon-192x192.png">
    <link rel="icon" type="image/png" sizes="32x32"
          href="${pageContext.request.contextPath}/resources/favicon/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="96x96"
          href="${pageContext.request.contextPath}/resources/favicon/favicon-96x96.png">
    <link rel="icon" type="image/png" sizes="16x16"
          href="${pageContext.request.contextPath}/resources/favicon/favicon-16x16.png">
    <link rel="manifest" href="${pageContext.request.contextPath}/resources/favicon/manifest.json">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="msapplication-TileImage" content="/ms-icon-144x144.png">
    <meta name="theme-color" content="#ffffff">


    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/3.3.7/flatly/bootstrap.min.css">
    <script src="//cdnjs.cloudflare.com/ajax/libs/pagedown/1.0/Markdown.Converter.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/pagedown/1.0/Markdown.Editor.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/pagedown/1.0/Markdown.Sanitizer.js"></script>
    <link rel="stylesheet" href="https://cdn.rawgit.com/balpha/pagedown/master/demo/browser/demo.css"/>
    <script src="https://cdn.rawgit.com/google/code-prettify/master/loader/run_prettify.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/tomorrow.css"/>
    <script src="${pageContext.request.contextPath}/resources/javascript/jquery.flexdatalist.js"></script>
    <link href="${pageContext.request.contextPath}/resources/css/jquery.flexdatalist.css" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.12/css/all.css"
          integrity="sha384-G0fIWCsCzJIMAVNQPfjH08cyYaUtMwjJwqiRKxxE/rx96Uroj1BtIQ6MLJuheaO9" crossorigin="anonymous">
    <style>
        .wmd-button > span {
            background-image: url('http://cdn.rawgit.com/derobins/wmd/master/images/wmd-buttons.png');
            background-repeat: no-repeat;
            background-position: 0px 0px;
            width: 20px;
            height: 20px;
            display: inline-block;
        }

        #wmd-preview {
            width: 100% !important;
            margin: 0 !important;
            padding: 0 !important;
            text-align: left;
            background-color: #ecf0f1 !important;
        }

        .vresize {
            resize: vertical;
            min-height: 200px;
        }

        .pading-top-5px {
            padding-top: 5px;
        }

        .pading-bottom-5px {
            padding-bottom: 5px;
        }

        .text-left {
            text-align: left;
        }

        .question-title {
            text-align: left;
            font-weight: bold;
        }

        .margin-bottom-0px {
            margin-bottom: 0px;
        }

        .margin-bottom-5px {
            margin-bottom: 5px;
        }

        .gi-08x {
            font-size: 0.8em;
        }

        .gi-2x {
            font-size: 2em;
        }

        .gi-3x {
            font-size: 3em;
        }

        .gi-4x {
            font-size: 4em;
        }

        .gi-5x {
            font-size: 5em;
        }

        .clickable {
            cursor: pointer;
        }

        .hidden {
            display: none;
        }

        .hr-5px {
            margin-top: 5px;
            margin-bottom: 5px;
        }

        .padding-left-15px {
            padding-left: 15px;
        }

        .hr-comments {
            border-color: lightgray;
        }

        .comment-input {
            width: 100%;
            border: none;
            padding-left: 15px;
            background-color: inherit;
            outline: none;
        }

        @media screen and (min-width: 992px) {
            .text-left-responsive {
                text-align: left;
            }

            .text-right-responsive {
                text-align: right;
            }

        }

        .buttons-p {
        }

        @media screen and (max-width: 992px) {
            .buttons-p {
                display: inline;
                padding-left: 5px;
                padding-right: 5px;
            }

            .gi-1x {
                font-size: 2em !important;
            }
        }

        .interaction-button {
            width: 51px;
        }

        .align-right {
            float: right;
        }

        .align-left {
            float: left;
        }

        .li-padding-bottom {
            padding-bottom: 7px;
        }

        .wordBreak {
            word-wrap: break-word;
        }

        #mainContent {
            min-height: 600px;
        }
    </style>
    <title>MemoryLeak</title>
</head>
<body>
<jsp:include page="bootstrapNavigationTop.jsp"/>
<div class="container text-center" id="mainContent">
    <div class="row">
        <jsp:include page="bootstrapNavigationLeft.jsp"/>
        <div class="col-md-9">

            <c:if test="${showUser}">
                <c:if test="${searchedUser != null}">
                    <div class="row">
                        <div class="col-md-6">
                            <p>
                                <a href="${pageContext.request.contextPath}/account?username=<c:out value='${searchedUser.username}'/>"><c:out
                                        value="${searchedUser.username}"/></a></p>
                            <img src="${searchedUser.profileImage}" class="img-circle" height="100"
                                 width="100" alt="Avatar">
                        </div>
                        <div class="col-md-6">
                            <p>First name: <c:out value="${searchedUser.firstName}"/></p>
                            <p>Last name: <c:out value="${searchedUser.lastName}"/></p>
                            <p>Email: <c:out value="${searchedUser.email}"/></p>
                            <p>Member since: ${searchedUser.creationDate.toLocaleString()}</p>
                        </div>
                    </div>
                </c:if>
                <c:if test="${searchedUser == null}">
                    <div class="row">
                        <hr class="hr-5px"/>
                        <div class="col-md-12 align-left">
                            <p>There is nothing here...</p>
                        </div>
                    </div>
                </c:if>
                <br/>
                <br/>
            </c:if>

            <c:if test="${showSearchResults}">
                <div class="row">
                    <div class="col-md-12">
                        <p class="align-left">Search results for '<b>${tag}${search}${lecture}</b>':</p>
                    </div>
                </div>
            </c:if>
            <div class="row">
                <div class="col-md-12">
                    <ul class="nav nav-tabs">
                        <c:if test="${showQuestion}">
                            <li class="<c:if test="${searchingFor == 'question'}">active</c:if> tab-control"><a
                                    id="questionTab" role="button"
                                    href="${pageContext.request.contextPath}${questionUrl}0">Questions</a></li>
                        </c:if>
                        <c:if test="${showVirtualClass}">
                            <li class="<c:if test="${searchingFor == 'virtualClass'}">active</c:if> tab-control"><a
                                    id="virtualClassTab" role="button"
                                    href="${pageContext.request.contextPath}${virtualClassUrl}0">Virtual classes</a>
                            </li>
                        </c:if>
                        <c:if test="${showLecture}">
                            <li class="<c:if test="${searchingFor == 'lecture'}">active</c:if> tab-control"><a
                                    id="lectureTab" role="button"
                                    href="${pageContext.request.contextPath}${lectureUrl}0">Lectures</a></li>
                        </c:if>
                    </ul>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <c:if test="${searchingFor == 'question'}">
                        <c:if test="${questionPage.content.size() == 0}">
                            <div class="row">
                                <hr class="hr-5px"/>
                                <div class="col-md-12 align-left">
                                    <p>There is nothing here...</p>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${questionPage.content.size() > 0}">
                            <c:forEach items="${questionPage.content}" var="question">
                                <hr class="hr-5px"/>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="well pading-top-5px pading-bottom-5px">
                                            <div class="row">
                                                <div class="text-left col-md-12 question-title wordBreak">
                                                    <a href="${pageContext.request.contextPath}/question?questionId=${question.questionId}"><c:out
                                                            value="${question.title}"/></a>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="text-left col-md-12 wordBreak">
                                                    <c:if test="${question.content.length() == 0}">
                                                        This question has no content.
                                                    </c:if>
                                                    <c:if test="${question.content == null}">
                                                        This question has no content.
                                                    </c:if>
                                                    <c:if test="${question.content.length() != 0}">
                                                        <c:if test="${question.content.length() <500}">
                                                            <c:out value="${question.content}"/>
                                                        </c:if>
                                                        <c:if test="${question.content.length() >=500}">
                                                            <c:out value="${question.content.substring(0, 499)}..."/>
                                                        </c:if>
                                                    </c:if>
                                                </div>
                                            </div>
                                            <hr class="hr-5px"/>
                                            <div class="row">
                                                <div class="col-md-6 col-md-offset-6">
                                                    <p class="text-right-responsive margin-bottom-0px gi-08x">
                                                        created ${question.created.toLocaleString()} by <a
                                                            href="${pageContext.request.contextPath}/account?username=${question.user.username}"><img
                                                            src="${question.user.profileImage}" class="img-circle"
                                                            height="35" width="35"
                                                            alt="Avatar"> ${question.user.username}</a>
                                                    </p>
                                                    <p class="text-right-responsive margin-bottom-0px gi-08x">
                                                        views <span class="answer-score">${question.views}</span>
                                                    </p>
                                                    <p class="text-right-responsive margin-bottom-0px gi-08x">
                                                        score <span class="answer-score">${question.score}</span>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                    </c:if>
                    <c:if test="${searchingFor == 'virtualClass'}">
                        <c:if test="${virtualClassPage.content.size() == 0}">
                            <div class="row">
                                <hr class="hr-5px"/>
                                <div class="col-md-12 align-left">
                                    <p>There is nothing here...</p>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${virtualClassPage.content.size() > 0}">
                            <c:forEach items="${virtualClassPage.content}" var="virtualClass">
                                <hr class="hr-5px"/>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="well pading-top-5px pading-bottom-5px">
                                            <div class="row">
                                                <div class="text-left col-md-12 question-title wordBreak">
                                                    <a href="${pageContext.request.contextPath}/class?classId=${virtualClass.virtualClassId}"><c:out
                                                            value="${virtualClass.title}"/></a>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="text-left col-md-12 wordBreak">
                                                    <c:if test="${virtualClass.description.length() == 0}">
                                                        This class has no description.
                                                    </c:if>
                                                    <c:if test="${virtualClass.description == null}">
                                                        This class has no description.
                                                    </c:if>
                                                    <c:if test="${virtualClass.description.length() != 0}">
                                                        <c:if test="${virtualClass.description.length() <500}">
                                                            <c:out value="${virtualClass.description}"/>
                                                        </c:if>
                                                        <c:if test="${virtualClass.description.length() >=500}">
                                                            <c:out value="${virtualClass.description.substring(0, 499)}..."/>
                                                        </c:if>
                                                    </c:if>
                                                </div>
                                            </div>
                                            <hr class="hr-5px"/>
                                            <div class="row">
                                                <div class="col-md-6 col-md-offset-6">
                                                    <p class="text-right-responsive margin-bottom-0px gi-08x">
                                                        created ${virtualClass.created.toLocaleString()} by <a
                                                            href="${pageContext.request.contextPath}/account?username=${virtualClass.user.username}"><img
                                                            src="${virtualClass.user.profileImage}" class="img-circle"
                                                            height="35" width="35"
                                                            alt="Avatar"> ${virtualClass.user.username}</a>
                                                    </p>
                                                    <p class="text-right-responsive margin-bottom-0px gi-08x">
                                                        views <span class="answer-score">${virtualClass.views}</span>
                                                    </p>
                                                    <p class="text-right-responsive margin-bottom-0px gi-08x">
                                                        score <span class="answer-score">${virtualClass.score}</span>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                    </c:if>
                    <c:if test="${searchingFor == 'lecture'}">
                        <c:if test="${lecturePage.content.size() == 0}">
                            <div class="row">
                                <hr class="hr-5px"/>
                                <div class="col-md-12 align-left">
                                    <p>There is nothing here...</p>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${lecturePage.content.size() > 0}">
                            <c:forEach items="${lecturePage.content}" var="lecture">
                                <hr class="hr-5px"/>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="well pading-top-5px pading-bottom-5px">
                                            <div class="row">
                                                <div class="text-left col-md-12 question-title wordBreak">
                                                    <a href="${pageContext.request.contextPath}/lecture?lectureId=${lecture.lectureId}&page=0"><c:out
                                                            value="${lecture.title}"/></a>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="text-left col-md-12 wordBreak">
                                                    <c:if test="${lecture.description.length() == 0}">
                                                        This lecture has no description.
                                                    </c:if>
                                                    <c:if test="${lecture.description == null}">
                                                        This lecture has no description.
                                                    </c:if>
                                                    <c:if test="${lecture.description.length() != 0}">
                                                        <c:if test="${lecture.description.length() <500}">
                                                            <c:out value="${lecture.description}"/>
                                                        </c:if>
                                                        <c:if test="${lecture.description.length() >=500}">
                                                            <c:out value="${lecture.description.substring(0, 499)}..."/>
                                                        </c:if>
                                                    </c:if>
                                                </div>
                                            </div>
                                            <hr class="hr-5px"/>
                                            <div class="row">
                                                <div class="col-md-6 col-md-offset-6">
                                                    <p class="text-right-responsive margin-bottom-0px gi-08x">
                                                        created ${lecture.created.toLocaleString()} by <a
                                                            href="${pageContext.request.contextPath}/account?username=${lecture.virtualClass.user.username}"><img
                                                            src="${lecture.virtualClass.user.profileImage}"
                                                            class="img-circle" height="35" width="35"
                                                            alt="Avatar"> ${lecture.virtualClass.user.username}</a>
                                                    </p>
                                                    <p class="text-right-responsive margin-bottom-0px gi-08x">
                                                        views <span class="answer-score">${lecture.views}</span>
                                                    </p>
                                                    <p class="text-right-responsive margin-bottom-0px gi-08x">
                                                        score <span class="answer-score">${lecture.score}</span>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                    </c:if>
                </div>
            </div>

            <c:if test="${searchingFor == 'question'}">
                <div class="row">
                    <div class="col-md-12">
                        <nav aria-label="Page navigation">
                            <tags-mytaglib:paginationGeneral
                                    url="${questionUrl}"
                                    pageable="${questionPage}"
                                    howManyPagesToShow="3"/>
                        </nav>
                    </div>
                </div>
            </c:if>
            <c:if test="${searchingFor == 'virtualClass'}">
                <div class="row">
                    <div class="col-md-12">
                        <nav aria-label="Page navigation">
                            <tags-mytaglib:paginationGeneral
                                    url="${virtualClassUrl}"
                                    pageable="${virtualClassPage}"
                                    howManyPagesToShow="3"/>
                        </nav>
                    </div>
                </div>
            </c:if>
            <c:if test="${searchingFor == 'lecture'}">
                <div class="row">
                    <div class="col-md-12">
                        <nav aria-label="Page navigation">
                            <tags-mytaglib:paginationGeneral
                                    url="${lectureUrl}"
                                    pageable="${lecturePage}"
                                    howManyPagesToShow="3"/>
                        </nav>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>
<jsp:include page="bootstrapNavigationBottom.jsp"/>
</body>
<script>

</script>
</html>
