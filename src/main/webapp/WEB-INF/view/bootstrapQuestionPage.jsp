<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="hasAnswered" value="false"/>
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
    <%--default--%>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <%--<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>--%>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <%--<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css"/>--%>
    <link rel="stylesheet" href="https://bootswatch.com/3/flatly/bootstrap.css">
    <%--<link rel="stylesheet" href="https://bootswatch.com/3/simplex/bootstrap.css">--%>
    <%--extra--%>
    <script src="//cdnjs.cloudflare.com/ajax/libs/pagedown/1.0/Markdown.Converter.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/pagedown/1.0/Markdown.Editor.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/pagedown/1.0/Markdown.Sanitizer.js"></script>
    <link rel="stylesheet" href="https://cdn.rawgit.com/balpha/pagedown/master/demo/browser/demo.css"/>
    <script src="https://cdn.rawgit.com/google/code-prettify/master/loader/run_prettify.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/tomorrow.css"/>
    <script src="${pageContext.request.contextPath}/resources/javascript/jquery.flexdatalist.js"></script>
    <link href="${pageContext.request.contextPath}/resources/css/jquery.flexdatalist.css" rel="stylesheet">
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

    </style>
    <title>MemoryLeak</title>
</head>
<body onload="PR.prettyPrint()">
<jsp:include page="bootstrapNavigationTop.jsp"/>
<div class="container text-center" id="mainContent">
    <div class="row">
        <jsp:include page="bootstrapNavigationLeft.jsp"/>
        <%-- NEW QUESTION FORM --%>
        <div class="col-md-9">

            <div class="row">
                <div class="col-md-11">
                    <div class="question-title">
                        ${question.title}
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-11">
                    <div class="well pading-top-5px pading-bottom-5px">
                        <div class="row">
                            <div class="text-left col-md-12">
                                ${question.content}
                            </div>
                        </div>
                        <hr class="hr-5px"/>
                        <div class="row">
                            <div class="col-md-6">
                                <p class="text-left-responsive">
                                    <c:forEach var="tag" items="${question.questionCategoriesByQuestionId}">
                                        <a href="${pageContext.request.contextPath}/post?search&tag=${tag.url}&page=0"><span
                                                class="label label-default">${tag.title}</span></a>
                                    </c:forEach>
                                </p>
                            </div>
                            <div class="col-md-6 text-right-responsive">
                                <p class="text-right-responsive margin-bottom-0px gi-08x">
                                    asked ${question.created.toLocaleString()} by <a
                                        href="${pageContext.request.contextPath}/account?username=${question.userByUserId.username}"><img
                                        src="${question.userByUserId.profileImage}" class="img-circle" height="35" width="35"
                                        alt="Avatar"> ${question.userByUserId.username}
                                </a>
                                </p>
                                <p class="text-right-responsive margin-bottom-0px gi-08x">
                                    views ${question.views}
                                </p>
                                <p class="text-right-responsive margin-bottom-0px gi-08x">
                                    votes <span class="question-score">${question.score}</span>
                                </p>
                            </div>
                        </div>

                        <div class="row comment-row">
                            <c:forEach var="comment" items="${question.questionCommentsByQuestionId}">
                                <hr class="hr-5px "/>
                                <p class="text-left margin-bottom-0px padding-left-15px gi-08x">
                                    <c:out value="${comment.content}"/> - <a
                                        href="${pageContext.request.contextPath}/account?username=${comment.userByUserId.username}">${comment.userByUserId.username}</a>
                                    at ${comment.creationDate.toLocaleString()}
                                </p>
                            </c:forEach>
                            <sec:authorize access="isAuthenticated()">
                                <hr class="hr-5px "/>
                                <input type="text" placeholder="Post a comment." class="comment-input">
                            </sec:authorize>
                        </div>

                    </div>
                </div>
                <div class="col-md-1">
                    <div class="question-buttons" id="${question.questionId}">
                        <sec:authorize access="isAuthenticated()">
                            <c:if test="${question.voteType==1}">
                                <p class="margin-bottom-0px buttons-p"><span
                                        class="gi-1x glyphicon glyphicon-triangle-top gi-2x glyphicon-button"
                                        aria-hidden="true"></span></p>
                                <p class="margin-bottom-0px buttons-p"><span
                                        class="gi-1x glyphicon glyphicon-triangle-bottom gi-2x glyphicon-button text-muted clickable"
                                        aria-hidden="true"></span></p>
                            </c:if>
                            <c:if test="${question.voteType==-1}">
                                <p class="margin-bottom-0px buttons-p"><span
                                        class="gi-1x glyphicon glyphicon-triangle-top gi-2x glyphicon-button text-muted clickable"
                                        aria-hidden="true"></span></p>
                                <p class="margin-bottom-0px buttons-p"><span
                                        class="gi-1x glyphicon glyphicon-triangle-bottom gi-2x glyphicon-button"
                                        aria-hidden="true"></span></p>
                            </c:if>
                            <c:if test="${question.voteType==0}">
                                <p class="margin-bottom-0px buttons-p"><span
                                        class="gi-1x glyphicon glyphicon-triangle-top gi-2x glyphicon-button text-muted clickable"
                                        aria-hidden="true"></span></p>
                                <p class="margin-bottom-0px buttons-p"><span
                                        class="gi-1x glyphicon glyphicon-triangle-bottom gi-2x glyphicon-button text-muted clickable"
                                        aria-hidden="true"></span></p>
                            </c:if>
                            <p class="margin-bottom-0px buttons-p"><span
                                    class="gi-1x glyphicon glyphicon-bookmark glyphicon-button text-muted clickable"
                                    aria-hidden="true"></span></p>
                            <c:if test="${question.userByUserId.username!=pageContext.request.userPrincipal.name}">
                                <p class="margin-bottom-0px buttons-p"><span
                                        class="gi-1x glyphicon glyphicon-exclamation-signglyphicon-button text-muted clickable"
                                        aria-hidden="true"></span></p>
                            </c:if>
                            <c:if test="${question.userByUserId.username==pageContext.request.userPrincipal.name}">
                                <p class="margin-bottom-0px buttons-p"><span
                                        class="gi-1x glyphicon glyphicon-edit glyphicon-button text-muted clickable"
                                        aria-hidden="true"></span></p>
                            </c:if>
                        </sec:authorize>
                    </div>
                </div>
            </div>

            <%--edit question--%>
            <c:if test="${question.userByUserId.username==pageContext.request.userPrincipal.name}">
                <div class="row edit-question hidden">
                    <div class="col-md-11">
                        <form id="edit-post-form" action="${pageContext.request.contextPath}/editQuestion" method="POST"
                              class="form-horizontal form">
                            <div class="form-group">
                                    <%--TODO responsive this part--%>
                                <div class="col-md-12">
                                    <div id="wmd-button-bar"></div>
                                    <textarea id="wmd-input" class="wmd-input form-control vresize"
                                              name="content" tabindex="-1" required>${question.rawContent}</textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-1">
                                    <input type="submit" class="btn btn-primary" value="Update"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-12">
                                    <p>You can see a live preview of how your question will look. </p>
                                    <hr/>
                                    <div id="wmd-preview" class="wmd-preview well"></div>
                                    <hr/>
                                </div>
                            </div>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <input type="hidden" name="title" value="${question.title}"/>
                            <input type="hidden" name="questionId" value="${question.questionId}"/>
                        </form>
                    </div>
                </div>
            </c:if>

            <c:forEach var="reply" items="${question.repliesByQuestionId}">
                <hr/>
                <div class="row">
                    <div class="col-md-11">
                        <div class="well pading-top-5px pading-bottom-5px">
                            <c:if test="${reply.enabled==0}">
                                <p>This reply was marked as violating our community guidelines and has been disabled.</p>
                            </c:if>
                            <c:if test="${reply.enabled==1}">
                                <div class="row">
                                    <div class="text-left col-md-12">
                                            ${reply.content}
                                    </div>
                                </div>
                                <hr class="hr-5px"/>
                                <div class="row">
                                    <div class="col-md-6 col-md-offset-6">
                                        <p class="text-right-responsive margin-bottom-0px gi-08x">
                                            answered ${reply.creationDate.toLocaleString()} by <a
                                                href="${pageContext.request.contextPath}/account?username=${reply.userByUserId.username}"><img
                                                src="${reply.userByUserId.profileImage}" class="img-circle" height="35"
                                                width="35"
                                                alt="Avatar"> ${reply.userByUserId.username}
                                        </a>
                                        </p>
                                        <p class="text-right-responsive margin-bottom-0px gi-08x">
                                            score <span class="answer-score">${reply.score}</span>
                                        </p>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    <div class="col-md-1">
                        <div class="answer-buttons" id="${reply.replyId}">
                            <sec:authorize access="isAuthenticated()">
                                <c:if test="${reply.voteType==1}">
                                    <p class="margin-bottom-0px buttons-p"><span
                                            class="gi-1x glyphicon glyphicon-triangle-top gi-2x glyphicon-button"
                                            aria-hidden="true"></span></p>
                                    <p class="margin-bottom-0px buttons-p"><span
                                            class="gi-1x glyphicon glyphicon-triangle-bottom gi-2x glyphicon-button text-muted clickable"
                                            aria-hidden="true"></span></p>
                                </c:if>
                                <c:if test="${reply.voteType==-1}">
                                    <p class="margin-bottom-0px buttons-p"><span
                                            class="gi-1x glyphicon glyphicon-triangle-top gi-2x glyphicon-button text-muted clickable"
                                            aria-hidden="true"></span></p>
                                    <p class="margin-bottom-0px buttons-p"><span
                                            class="gi-1x glyphicon glyphicon-triangle-bottom gi-2x glyphicon-button"
                                            aria-hidden="true"></span></p>
                                </c:if>
                                <c:if test="${reply.voteType==0}">
                                    <p class="margin-bottom-0px buttons-p"><span
                                            class="gi-1x glyphicon glyphicon-triangle-top gi-2x glyphicon-button text-muted clickable"
                                            aria-hidden="true"></span></p>
                                    <p class="margin-bottom-0px buttons-p"><span
                                            class="gi-1x glyphicon glyphicon-triangle-bottom gi-2x glyphicon-button text-muted clickable"
                                            aria-hidden="true"></span></p>
                                </c:if>
                                <c:if test="${question.userByUserId.username==pageContext.request.userPrincipal.name}">
                                    <c:if test="${reply.bestAnswer==1}">
                                        <p class="margin-bottom-0px buttons-p"><span
                                                class="gi-1x glyphicon glyphicon-star glyphicon-button"
                                                aria-hidden="true"></span></p>
                                    </c:if>
                                    <c:if test="${reply.bestAnswer==0}">
                                        <p class="margin-bottom-0px buttons-p"><span
                                                class="gi-1x glyphicon glyphicon-star glyphicon-button  text-muted clickable"
                                                aria-hidden="true"></span></p>
                                    </c:if>
                                </c:if>
                                <c:if test="${question.userByUserId.username!=pageContext.request.userPrincipal.name}">
                                    <c:if test="${reply.bestAnswer==1}">
                                        <p class="margin-bottom-0px buttons-p"><span
                                                class="gi-1x glyphicon glyphicon-star"
                                                aria-hidden="true"></span></p>
                                    </c:if>
                                </c:if>
                                <c:if test="${reply.userByUserId.username!=pageContext.request.userPrincipal.name}">
                                    <p class="margin-bottom-0px buttons-p"><span
                                            class="gi-1x glyphicon glyphicon-exclamation-sign glyphicon-button text-muted clickable"
                                            aria-hidden="true"></span></p>
                                </c:if>
                                <c:if test="${reply.userByUserId.username==pageContext.request.userPrincipal.name}">
                                    <p class="margin-bottom-0px buttons-p"><span
                                            class="gi-1x glyphicon glyphicon-edit glyphicon-button text-muted clickable"
                                            aria-hidden="true"></span></p>
                                </c:if>
                            </sec:authorize>
                            <sec:authorize access="isAnonymous()">
                                <c:if test="${reply.bestAnswer==1}">
                                    <p class="margin-bottom-0px buttons-p"><span class="gi-1x glyphicon glyphicon-star"
                                                                                 aria-hidden="true"></span></p>
                                </c:if>
                            </sec:authorize>
                        </div>
                    </div>
                </div>

                <c:if test="${reply.userByUserId.username==pageContext.request.userPrincipal.name}">
                    <c:set var="hasAnswered" value="true"/>
                    <div class="row edit-answer hidden">
                        <div class="col-md-11">
                            <form id="edit-answer-form" action="${pageContext.request.contextPath}/editReply"
                                  method="POST" class="form-horizontal form">
                                <div class="form-group">
                                        <%--TODO responsive this part--%>
                                    <div class="col-md-12">
                                        <div id="wmd-button-bar"></div>
                                        <textarea id="wmd-input" class="wmd-input form-control vresize"
                                                  name="content" tabindex="-1" required>${reply.rawContent}</textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-1">
                                        <input type="submit" class="btn btn-primary" value="Update"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <p>You can see a live preview of how your answer will look. </p>
                                        <hr/>
                                        <div id="wmd-preview" class="wmd-preview well"></div>
                                        <hr/>
                                    </div>
                                </div>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <input type="hidden" name="replyId" value="${reply.replyId}"/>
                            </form>
                        </div>
                    </div>
                </c:if>
            </c:forEach>

            <sec:authorize access="isAuthenticated()">
            <c:if test="${question.userByUserId.username!=pageContext.request.userPrincipal.name}">
            <c:if test="${hasAnswered=='false'}">
            <hr/>
            <div class="row">
                <div class="col-md-11">
                    <div class="alert alert-warning fade in">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
                            <%--TODO change this --%>
                        Please read the rules before posting. bla bla
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-11">
                    <form id="new-reply-form" action="${pageContext.request.contextPath}/makeReply" method="POST"
                          class="form-horizontal form">
                        <div class="form-group">
                                <%--TODO responsive this part--%>
                            <div class="col-md-12">
                                <div id="wmd-button-bar"></div>
                                <textarea id="wmd-input" class="wmd-input form-control vresize"
                                          name="content" required></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-1">
                                <input type="submit" class="btn btn-primary" value="Answer"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-md-12">
                                <hr/>
                                <div id="wmd-preview" class="wmd-preview"></div>
                                <hr/>
                            </div>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <input type="hidden" name="questionId" value="${question.questionId}"/>
                    </form>
                </div>
            </div>
        </div>
        </c:if>
        </c:if>
        </sec:authorize>
        <%--<jsp:include page="bootstrapNavigationRight.jsp"/>--%>
    </div>
</div>
<jsp:include page="bootstrapNavigationBottom.jsp"/>
</body>
<sec:authorize access="isAuthenticated()">
    <script>
        $(document).ready(function () {
            var converter = Markdown.getSanitizingConverter();
            var editor = new Markdown.Editor(converter);
            editor.run();
        });
    </script>
</sec:authorize>
<sec:authorize access="isAuthenticated()">
    <script>
        $(document).ready(function () {
            $(".glyphicon-button").click(function () {
                var clicked = $(this);
                if (clicked.hasClass("clickable")) {
                    var pParent = clicked.parent();
                    var dParent = pParent.parent();
                    if (dParent.hasClass("question-buttons")) {
                        if (clicked.hasClass("glyphicon-triangle-top")) {
                            voteQuestion(dParent.attr('id'), "Upvote");
                            $(".question-buttons p .glyphicon-triangle-top").removeClass("text-muted clickable");
                            $(".question-buttons p .glyphicon-triangle-bottom").addClass("text-muted clickable");
                            $(".question-score").html(parseInt($(".question-score").html()) + 1);
                        }
                        if (clicked.hasClass("glyphicon-triangle-bottom")) {
                            voteQuestion(dParent.attr('id'), "Downvote");
                            $(".question-buttons p .glyphicon-triangle-bottom").removeClass("text-muted clickable");
                            $(".question-buttons p .glyphicon-triangle-top").addClass("text-muted clickable");
                            $(".question-score").html(parseInt($(".question-score").html()) - 1);
                        }
                        if (clicked.hasClass("glyphicon-bookmark")) {
                        }
                        if (clicked.hasClass("glyphicon-exclamation-sign")) {
                        }
                        if (clicked.hasClass("glyphicon-edit")) {
                            clicked.toggleClass("text-muted");
                            $(".edit-question").toggleClass("hidden");
                            $("#wmd-input").focus();
                        }
                    } else if (dParent.hasClass("answer-buttons")) {
                        if (clicked.hasClass("glyphicon-triangle-top")) {
                            voteAnswer(dParent.attr('id'), "Upvote");
                            dParent.find(".glyphicon-triangle-top").removeClass("text-muted clickable");
                            dParent.find(".glyphicon-triangle-bottom").addClass("text-muted clickable");
                            dParent.parent().parent().find(".answer-score").html(parseInt(dParent.parent().parent().find(".answer-score").html()) + 1);
                        }
                        if (clicked.hasClass("glyphicon-triangle-bottom")) {
                            voteAnswer(dParent.attr('id'), "Downvote");
                            dParent.find(".glyphicon-triangle-bottom").removeClass("text-muted clickable");
                            dParent.find(".glyphicon-triangle-top").addClass("text-muted clickable");
                            dParent.parent().parent().find(".answer-score").html(parseInt(dParent.parent().parent().find(".answer-score").html()) - 1);
                        }
                        if (clicked.hasClass("glyphicon-star")) {
                            bestAnswer($(".question-buttons").attr('id'), dParent.attr('id'));
                            $(".glyphicon-star").addClass("text-muted clickable");
                            dParent.find(".glyphicon-star").removeClass("text-muted clickable");
                        }
                        if (clicked.hasClass("glyphicon-exclamation-sign")) {
                        }
                        if (clicked.hasClass("glyphicon-edit")) {
                            clicked.toggleClass("text-muted");
                            $(".edit-answer").toggleClass("hidden");
                            $("#wmd-input").focus();
                        }
                    }
                }
            });

            function voteQuestion(questionId, voteType) {
                $.ajax({
                    type: "POST",
                    url: '${pageContext.request.contextPath}/voteQuestion',
                    data: {
                        questionId: questionId,
                        type: voteType,
                        "${_csrf.parameterName}": "${_csrf.token}"
                    },
                    dataType: "json",
                    success: function (data, textStatus, jqXHR) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(errorThrown);
                    },
                    beforeSend: function (jqXHR, settings) {
                    },
                    complete: function (jqXHR, textStatus) {
                    }
                });
            }

            function voteAnswer(answerId, voteType) {
                $.ajax({
                    type: "POST",
                    url: '${pageContext.request.contextPath}/voteReply',
                    data: {
                        replyId: answerId,
                        type: voteType,
                        "${_csrf.parameterName}": "${_csrf.token}"
                    },
                    dataType: "json",
                    success: function (data, textStatus, jqXHR) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(errorThrown);
                    },
                    beforeSend: function (jqXHR, settings) {
                    },
                    complete: function (jqXHR, textStatus) {
                    }
                });
            }

            function bestAnswer(postID, replyID) {
                $.ajax({
                    type: "POST",
                    url: '${pageContext.request.contextPath}/favoriteReply',
                    data: {
                        questionId: postID,
                        replyId: replyID,
                        "${_csrf.parameterName}": "${_csrf.token}"
                    },
                    dataType: "json",
                    success: function (data, textStatus, jqXHR) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        console.log(errorThrown);
                    },
                    beforeSend: function (jqXHR, settings) {
                    },
                    complete: function (jqXHR, textStatus) {
                    }
                })
            }
        });

        $('form').submit(function () {
            $theForm = $(this);
            $.c({
                type: $theForm.attr('method'),
                url: $theForm.attr('action'),
                data: $theForm.serialize(),
                success: function (data) {
                    location.reload(true);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(errorThrown);
                }
            });
            return false;
        });

    </script>
</sec:authorize>
</html>
