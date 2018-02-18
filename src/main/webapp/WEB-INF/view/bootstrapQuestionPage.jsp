<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        .question-content {
            text-align: left;
        }

        .answer-content {
            text-align: left;
        }

        .question-title {
            text-align: left;
            font-weight: bold;
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

    </style>
    <title>MemoryLeak</title>
</head>
<body onload="PR.prettyPrint()">
<jsp:include page="bootstrapNavigationTop.jsp"/>
<div class="container text-center" id="mainContent">
    <div class="row">
        <jsp:include page="bootstrapNavigationLeft.jsp"/>
        <%-- NEW QUESTION FORM --%>
        <div class="col-sm-9">

            <div class="row">
                <div class="col-sm-12">
                    <div class="question-title">
                        ${post.title}
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-11">
                    <div class="well question-content">
                        ${post.content}
                    </div>
                </div>
                <div class="col-sm-1">
                    <sec:authorize access="isAuthenticated()">
                        <div class="question-buttons" id="${post.postId}">
                            <c:if test="${voteType==1}">
                                <p><span class="glyphicon glyphicon-triangle-top gi-2x glyphicon-button"
                                         aria-hidden="true"></span></p>
                                <p><span class="question-score">${post.score}</span></p>
                                <p><span
                                        class="glyphicon glyphicon-triangle-bottom gi-2x glyphicon-button text-muted clickable"
                                        aria-hidden="true"></span></p>
                            </c:if>
                            <c:if test="${voteType==-1}">
                                <p><span
                                        class="glyphicon glyphicon-triangle-top gi-2x glyphicon-button text-muted clickable"
                                        aria-hidden="true"></span></p>
                                <p><span class="question-score">${post.score}</span></p>
                                <p><span class="glyphicon glyphicon-triangle-bottom gi-2x glyphicon-button"
                                         aria-hidden="true"></span></p>
                            </c:if>
                            <c:if test="${voteType==0}">
                                <p><span
                                        class="glyphicon glyphicon-triangle-top gi-2x glyphicon-button text-muted clickable"
                                        aria-hidden="true"></span></p>
                                <p><span class="question-score">${post.score}</span></p>
                                <p><span
                                        class="glyphicon glyphicon-triangle-bottom gi-2x glyphicon-button text-muted clickable"
                                        aria-hidden="true"></span></p>
                            </c:if>
                            <p><span class="glyphicon glyphicon-star glyphicon-button text-muted clickable"
                                     aria-hidden="true"></span></p>
                            <c:if test="${post.user.username!=pageContext.request.userPrincipal.name}">
                                <p><span
                                        class="glyphicon glyphicon-exclamation-signglyphicon-button text-muted clickable"
                                        aria-hidden="true"></span></p>
                            </c:if>
                            <c:if test="${post.user.username==pageContext.request.userPrincipal.name}">
                                <p><span
                                        class="glyphicon glyphicon glyphicon-edit glyphicon-button text-muted clickable"
                                        aria-hidden="true"></span></p>
                            </c:if>
                        </div>
                    </sec:authorize>
                </div>
            </div>

            <c:if test="${post.user.username==pageContext.request.userPrincipal.name}">
                <div class="row edit-question hidden">
                    <div class="col-sm-11">
                        <form id="edit-post-form" action="${pageContext.request.contextPath}/editPost" method="POST"
                              class="form-horizontal">
                            <div class="form-group">
                                    <%--TODO responsive this part--%>
                                <div class="col-sm-12">
                                    <div id="wmd-button-bar"></div>
                                    <textarea id="wmd-input" class="wmd-input form-control vresize"
                                              name="content" tabindex="-1" required>${post.rawContent}</textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-1">
                                    <input type="submit" class="btn btn-primary" value="Update"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <p>You can see a live preview of how your question will look. </p>
                                    <hr/>
                                        <div id="wmd-preview" class="wmd-preview well"></div>
                                    <hr/>
                                </div>
                            </div>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <input type="hidden" name="title" value="${post.title}"/>
                            <input type="hidden" name="postId" value="${post.postId}"/>
                        </form>
                    </div>
                </div>
            </c:if>

            <c:forEach var="reply" items="${post.replies}">
                <hr/>
                <div class="row">
                    <div class="col-sm-2">
                        <div class="well">
                            <p>${reply.user.username}</p>
                            <img src="${reply.user.profileImage}" class="img-circle" height="55" width="55"
                                 alt="Avatar">
                        </div>
                    </div>
                    <div class="col-sm-9">
                        <div class="well answer-content">
                            <c:if test="${reply.enabled==0}">
                                <p>This reply was marked as violating our comunity guidlines and has been disabled.</p>
                            </c:if>
                            <c:if test="${reply.enabled==1}">
                                ${reply.content}
                            </c:if>
                        </div>
                    </div>
                    <div class="col-sm-1">
                        <sec:authorize access="isAuthenticated()">
                            <div class="answer-buttons" id="${reply.replyId}">
                                <c:if test="${reply.replyVoteType==1}">
                                    <p><span class="glyphicon glyphicon-triangle-top gi-2x glyphicon-button"
                                             aria-hidden="true"></span></p>
                                    <p><span class="answer-score">${reply.score}</span></p>
                                    <p><span
                                            class="glyphicon glyphicon-triangle-bottom gi-2x glyphicon-button text-muted clickable"
                                            aria-hidden="true"></span></p>
                                </c:if>
                                <c:if test="${reply.replyVoteType==-1}">
                                    <p><span
                                            class="glyphicon glyphicon-triangle-top gi-2x glyphicon-button text-muted clickable"
                                            aria-hidden="true"></span></p>
                                    <p><span class="answer-score">${reply.score}</span></p>
                                    <p><span class="glyphicon glyphicon-triangle-bottom gi-2x glyphicon-button"
                                             aria-hidden="true"></span></p>
                                </c:if>
                                <c:if test="${reply.replyVoteType==0}">
                                    <p><span
                                            class="glyphicon glyphicon-triangle-top gi-2x glyphicon-button text-muted clickable"
                                            aria-hidden="true"></span></p>
                                    <p><span class="answer-score">${reply.score}</span></p>
                                    <p><span
                                            class="glyphicon glyphicon-triangle-bottom gi-2x glyphicon-button text-muted clickable"
                                            aria-hidden="true"></span></p>
                                </c:if>
                                <c:if test="${post.user.username==pageContext.request.userPrincipal.name}">
                                    <p><span class="glyphicon glyphicon-star glyphicon-button  text-muted clickable"
                                             aria-hidden="true"></span></p>
                                </c:if>
                                <c:if test="${post.user.username!=pageContext.request.userPrincipal.name}">
                                    <p><span
                                            class="glyphicon glyphicon-exclamation-sign glyphicon-button text-muted clickable"
                                            aria-hidden="true"></span></p>
                                </c:if>
                            </div>
                        </sec:authorize>
                    </div>
                </div>
            </c:forEach>

            <sec:authorize access="isAuthenticated()">
            <c:if test="${post.user.username!=pageContext.request.userPrincipal.name}">
            <hr/>
            <div class="row">
                <div class="col-sm-offset-2 col-sm-9">
                    <div class="alert alert-warning fade in">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
                            <%--TODO change this --%>
                        Please read the rules before posting. bla bla
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-offset-2 col-sm-9">
                    <form id="new-reply-form" action="${pageContext.request.contextPath}/makeReply" method="POST"
                          class="form-horizontal">
                        <div class="form-group">
                                <%--TODO responsive this part--%>
                            <div class="col-sm-12">
                                <div id="wmd-button-bar"></div>
                                <textarea id="wmd-input" class="wmd-input form-control vresize"
                                          name="content" required></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-1">
                                <input type="submit" class="btn btn-primary" value="Answer"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <hr/>
                                <div id="wmd-preview" class="wmd-preview"></div>
                                <hr/>
                            </div>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </form>
                </div>
            </div>
        </div>
        </c:if>
        </sec:authorize>
        <%--<jsp:include page="bootstrapNavigationRight.jsp"/>--%>
    </div>
</div>
<jsp:include page="bootstrapNavigationBottom.jsp"/>
</body>
<script>
    $(document).ready(function () {
        var converter = Markdown.getSanitizingConverter();
        var editor = new Markdown.Editor(converter);
        editor.run();
    });
</script>
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
                        $(".question-buttons p .question-score").html(parseInt($(".question-buttons p .question-score").html()) + 1);
                    }
                    if (clicked.hasClass("glyphicon-triangle-bottom")) {
                        voteQuestion(dParent.attr('id'), "Downvote");
                        $(".question-buttons p .glyphicon-triangle-bottom").removeClass("text-muted clickable");
                        $(".question-buttons p .glyphicon-triangle-top").addClass("text-muted clickable");
                        $(".question-buttons p .question-score").html(parseInt($(".question-buttons p .question-score").html()) - 1);
                    }
                    if (clicked.hasClass("glyphicon-star")) {
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
                        dParent.find(".answer-score").html(parseInt(dParent.find(".answer-score").html()) + 1);
                    }
                    if (clicked.hasClass("glyphicon-triangle-bottom")) {
                        voteAnswer(dParent.attr('id'), "Downvote");
                        dParent.find(".glyphicon-triangle-bottom").removeClass("text-muted clickable");
                        dParent.find(".glyphicon-triangle-top").addClass("text-muted clickable");
                        dParent.find(".answer-score").html(parseInt(dParent.find(".answer-score").html()) - 1);
                    }
                    if (clicked.hasClass("glyphicon-star")) {
                    }
                    if (clicked.hasClass("glyphicon-exclamation-sign")) {
                    }
                }
            }
        });

        function voteQuestion(postId, voteType) {
            $.ajax({
                type: "POST",
                url: '${pageContext.request.contextPath}/votePost',
                data: {
                    postID: postId,
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
                    replyID: answerId,
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
    });
</script>
</html>
