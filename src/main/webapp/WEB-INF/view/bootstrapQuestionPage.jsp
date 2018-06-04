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
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.12/css/all.css"
              integrity="sha384-G0fIWCsCzJIMAVNQPfjH08cyYaUtMwjJwqiRKxxE/rx96Uroj1BtIQ6MLJuheaO9"
              crossorigin="anonymous">
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
            display: inline-block;
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

        .delete-confirmation-modal {
            width: 320px;
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
                                    <c:forEach var="tag" items="${question.questionCategories}">
                                        <a href="${pageContext.request.contextPath}/tag?tag=${tag.url}&page=0&searchingFor=question"><span
                                                class="label label-default">${tag.title}</span></a>
                                    </c:forEach>
                                </p>
                            </div>
                            <div class="col-md-6 text-right-responsive">
                                <p class="text-right-responsive margin-bottom-0px gi-08x">
                                    asked ${question.created.toLocaleString()} by <a
                                        href="${pageContext.request.contextPath}/account?username=${question.user.username}"><img
                                        src="${question.user.profileImage}" class="img-circle" height="35" width="35"
                                        alt="Avatar"> ${question.user.username}</a>
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
                            <c:forEach var="comment" items="${question.questionComments}">
                                <hr class="hr-5px "/>
                                <p class="text-left margin-bottom-0px padding-left-15px gi-08x">
                                    <c:out value="${comment.content}"/> &nbsp&nbsp by
                                    <a href="${pageContext.request.contextPath}/account?username=${comment.user.username}">${comment.user.username}</a>
                                    at ${comment.creationDate.toLocaleString()}
                                </p>
                            </c:forEach>
                            <sec:authorize access="isAuthenticated()">
                                <hr class="hr-5px "/>
                                <input type="text" placeholder="Post a comment."
                                       class="comment-input question-comment-input">
                            </sec:authorize>
                        </div>

                    </div>
                </div>
                <div class="col-md-1">
                    <div class="question-buttons" id="${question.questionId}">
                        <sec:authorize access="isAuthenticated()">
                            <c:if test="${question.voteType==1}">
                                <p class="margin-bottom-0px buttons-p">
                                    <button id="upvoteButton" class="btn btn-info interaction-button disabled">
                                        <i class="fas fa-arrow-alt-circle-up fa-inverse"></i>
                                    </button>
                                </p>
                                <p class="margin-bottom-0px buttons-p">
                                    <button id="downvoteButton" class="btn btn-info interaction-button">
                                        <i class="fas fa-arrow-alt-circle-down fa-inverse"></i>
                                    </button>
                                </p>
                            </c:if>
                            <c:if test="${question.voteType==-1}">
                                <p class="margin-bottom-0px buttons-p">
                                    <button id="upvoteButton" class="btn btn-info interaction-button">
                                        <i class="fas fa-arrow-alt-circle-up fa-inverse"></i>
                                    </button>
                                </p>
                                <p class="margin-bottom-0px buttons-p">
                                    <button id="downvoteButton" class="btn btn-info interaction-button disabled">
                                        <i class="fas fa-arrow-alt-circle-down fa-inverse"></i>
                                    </button>
                                </p>
                            </c:if>
                            <c:if test="${question.voteType==0}">
                                <p class="margin-bottom-0px buttons-p">
                                    <button id="upvoteButton" class="btn btn-info interaction-button">
                                        <i class="fas fa-arrow-alt-circle-up fa-inverse"></i>
                                    </button>
                                </p>
                                <p class="margin-bottom-0px buttons-p">
                                    <button id="downvoteButton" class="btn btn-info interaction-button">
                                        <i class="fas fa-arrow-alt-circle-down fa-inverse"></i>
                                    </button>
                                </p>
                            </c:if>
                            <jsp:include page="shareThisMenu.jsp"/>
                            <c:if test="${question.user.username!=pageContext.request.userPrincipal.name}">
                                <p class="margin-bottom-0px buttons-p">
                                    <button id="bookmarkButton" class="btn btn-info interaction-button">
                                        <i class="fas fa-bookmark fa-inverse"></i>
                                    </button>
                                </p>
                            </c:if>
                            <c:if test="${question.user.username!=pageContext.request.userPrincipal.name}">
                                <p class="margin-bottom-0px buttons-p">
                                    <button id="reportButton" class="btn btn-info interaction-button">
                                        <i class="fas fa-exclamation-circle fa-inverse"></i>
                                    </button>
                                </p>
                            </c:if>
                            <c:if test="${question.user.username==pageContext.request.userPrincipal.name}">
                                <p class="margin-bottom-0px buttons-p">
                                    <button id="editButton" class="btn btn-info interaction-button">
                                        <i class="fas fa-edit fa-inverse"></i>
                                    </button>
                                </p>
                            </c:if>
                        </sec:authorize>
                    </div>
                </div>
            </div>

            <%--edit question--%>
            <c:if test="${question.user.username==pageContext.request.userPrincipal.name}">
                <div class="row edit-question" style="display: none">
                    <div class="col-md-11">
                        <form id="edit-post-form" action="${pageContext.request.contextPath}/editQuestion" method="POST"
                              class="form-horizontal form">
                            <div class="form-group">
                                <label class="control-label col-sm-1" for="post_title">Title:</label>
                                <div class="col-sm-11">
                                    <input id="post_title" class="form-control " type="text"
                                           name="title" value="${question.title}" required>
                                </div>
                            </div>
                            <div class="form-group">
                                    <%--TODO responsive this part--%>
                                <div class="col-md-12">
                                    <div id="wmd-button-bar"></div>
                                    <textarea id="wmd-input" class="wmd-input form-control vresize"
                                              name="content" tabindex="-1" required>${question.rawContent}</textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-1" for="tags">Tags:</label>
                                <div class="col-sm-11">
                                    <input type="text" id="tags" data-role="tagsinput"
                                           class="form-control flexdatalist"
                                           name="tags" multiple='multiple' list="taglist""/>
                                        <%--TODO change this--%>
                                    <datalist id="taglist">
                                        <jsp:include page="tagList.jsp"/>
                                    </datalist>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-12">
                                    <input type="submit" class="btn btn-primary align-left" value="Update question"/>
                                    <p class="margin-bottom-0px buttons-p align-right">
                                        <button type="button" id="deleteQuestionButton"
                                                class="btn btn-danger interaction-button">
                                            <i class="fas fa-trash-alt fa-inverse"></i>
                                        </button>
                                    </p>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-12">
                                    <p>You can see a live preview of how your question will look. </p>
                                    <hr/>
                                    <div id="wmd-preview" tabindex="-1" class="wmd-preview well"></div>
                                    <hr/>
                                </div>
                            </div>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <input type="hidden" name="questionId" value="${question.questionId}"/>
                        </form>
                    </div>
                </div>
            </c:if>

            <c:set var="replyId" value="${null}"/>
            <c:forEach var="reply" items="${question.replies}">
                <hr/>
                <div class="row">
                    <div class="col-md-11">
                        <div class="well pading-top-5px pading-bottom-5px">
                            <c:if test="${reply.enabled==true}">
                                <div class="row">
                                    <div class="text-left col-md-12">
                                        <c:if test="${reply.enabled==false}">
                                            This reply was marked as violating our community guidelines and has been disabled.
                                        </c:if>
                                        <c:if test="${reply.enabled==true}">
                                            ${reply.content}
                                        </c:if>
                                    </div>
                                </div>
                                <hr class="hr-5px"/>
                                <div class="row">
                                    <div class="col-md-6">
                                        <c:if test="${reply.bestAnswer==true}">
                                            <p class="best-answer-p text-right-responsive margin-bottom-0px gi-08x">
                                                This reply was marked as being the best answer given.
                                            </p>
                                        </c:if>
                                        <c:if test="${reply.bestAnswer==true}">
                                            <p class="best-answer-p text-right-responsive margin-bottom-0px gi-08x hidden">
                                                This reply was marked as being the best answer given.
                                            </p>
                                        </c:if>
                                    </div>
                                    <div class="col-md-6">
                                        <p class="text-right-responsive margin-bottom-0px gi-08x">
                                            answered ${reply.creationDate.toLocaleString()} by <a
                                                href="${pageContext.request.contextPath}/account?username=${reply.user.username}"><img
                                                src="${reply.user.profileImage}" class="img-circle" height="35"
                                                width="35"
                                                alt="Avatar"> ${reply.user.username}
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
                                    <p class="margin-bottom-0px buttons-p">
                                        <button id="upvoteButton" class="btn btn-info interaction-button disabled">
                                            <i class="fas fa-arrow-alt-circle-up fa-inverse"></i>
                                        </button>
                                    </p>
                                    <p class="margin-bottom-0px buttons-p">
                                        <button id="downvoteButton" class="btn btn-info interaction-button">
                                            <i class="fas fa-arrow-alt-circle-down fa-inverse"></i>
                                        </button>
                                    </p>
                                </c:if>
                                <c:if test="${reply.voteType==-1}">
                                    <p class="margin-bottom-0px buttons-p">
                                        <button id="upvoteButton" class="btn btn-info interaction-button">
                                            <i class="fas fa-arrow-alt-circle-up fa-inverse"></i>
                                        </button>
                                    </p>
                                    <p class="margin-bottom-0px buttons-p">
                                        <button id="downvoteButton" class="btn btn-info interaction-button disabled">
                                            <i class="fas fa-arrow-alt-circle-down fa-inverse"></i>
                                        </button>
                                    </p>
                                </c:if>
                                <c:if test="${reply.voteType==0}">
                                    <p class="margin-bottom-0px buttons-p">
                                        <button id="upvoteButton" class="btn btn-info interaction-button">
                                            <i class="fas fa-arrow-alt-circle-up fa-inverse"></i>
                                        </button>
                                    </p>
                                    <p class="margin-bottom-0px buttons-p">
                                        <button id="downvoteButton" class="btn btn-info interaction-button">
                                            <i class="fas fa-arrow-alt-circle-down fa-inverse"></i>
                                        </button>
                                    </p>
                                </c:if>
                                <c:if test="${question.user.username==pageContext.request.userPrincipal.name}">
                                    <c:if test="${reply.bestAnswer==true}">
                                        <p class="margin-bottom-0px buttons-p">
                                            <button id="favoriteButton"
                                                    class="btn btn-info interaction-button disabled">
                                                <i class="fas fa-star fa-inverse"></i>
                                            </button>
                                        </p>
                                    </c:if>
                                    <c:if test="${reply.bestAnswer==false}">
                                        <p class="margin-bottom-0px buttons-p">
                                            <button id="favoriteButton" class="btn btn-info interaction-button">
                                                <i class="fas fa-star fa-inverse"></i>
                                            </button>
                                        </p>
                                    </c:if>
                                </c:if>
                                <c:if test="${reply.user.username!=pageContext.request.userPrincipal.name}">
                                    <p class="margin-bottom-0px buttons-p">
                                        <button id="reportButton" class="btn btn-info interaction-button">
                                            <i class="fas fa-exclamation-circle fa-inverse"></i>
                                        </button>
                                    </p>
                                </c:if>
                                <c:if test="${reply.user.username==pageContext.request.userPrincipal.name}">
                                    <p class="margin-bottom-0px buttons-p">
                                        <button id="editButton" class="btn btn-info interaction-button">
                                            <i class="fas fa-edit fa-inverse"></i>
                                        </button>
                                    </p>
                                </c:if>
                            </sec:authorize>
                        </div>
                    </div>
                </div>

                <c:if test="${reply.user.username==pageContext.request.userPrincipal.name}">
                    <c:set var="hasAnswered" value="true"/>
                    <div class="row edit-answer" style="display: none;">
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
                                    <div class="col-md-12">
                                        <input type="submit" class="btn btn-primary align-left" value="Update answer"/>
                                        <p class="margin-bottom-0px buttons-p align-right">
                                            <button type="button" id="deleteAnswerButton"
                                                    class="btn btn-danger interaction-button">
                                                <i class="fas fa-trash-alt fa-inverse"></i>
                                            </button>
                                        </p>
                                    </div>
                                    <c:set var="replyId" value="${reply.replyId}"/>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <p>You can see a live preview of how your answer will look. </p>
                                        <hr/>
                                        <div id="wmd-preview" tabindex="-1" class="wmd-preview well"></div>
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
            <c:if test="${question.user.username!=pageContext.request.userPrincipal.name}">
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
                                <input type="submit" class="btn btn-primary" value="Create answer"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <p>You can see a live preview of how your answer will look. </p>
                            <div class="col-md-12">
                                <hr/>
                                <div id="wmd-preview" tabindex="-1" class="wmd-preview"></div>
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
<c:if test="${question.user.username==pageContext.request.userPrincipal.name}">
    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteQuestionLabel" aria-hidden="true"
         id="confirmDeleteQuestion">
        <div class="modal-dialog modal-sm">
            <div class="modal-content delete-confirmation-modal">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="confirmDeleteQuestionLabel">Are you sure you want to delete this
                        question?</h4>
                </div>
                <div class="modal-body">
                    <p>This action cannot be reversed. Once you delete a question, it's gone forever.</p>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" id="modal-btn-delete-question">Yes, delete it.
                        </button>
                        <button type="button" class=" btn btn-primary" data-dismiss="modal" aria-label="Close">No,
                            keep it.
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:if>
<c:if test="${replyId!=null}">
    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteAnswerLabel"
         aria-hidden="true"
         id="confirmDeleteAnswer">
        <div class="modal-dialog modal-sm">
            <div class="modal-content delete-confirmation-modal">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="confirmDeleteAnswerLabel">Are you sure you want to delete this
                        answer?</h4>
                </div>
                <div class="modal-body">
                    <p>This action cannot be reversed. Once you delete an answer, it's gone forever.</p>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" id="modal-btn-delete-answer">Yes, delete
                            it.
                        </button>
                        <button type="button" class=" btn btn-primary" data-dismiss="modal" aria-label="Close">No,
                            keep it.
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:if>
</body>
<sec:authorize access="isAuthenticated()">
    <script>
        $(document).ready(function () {
            var converter = Markdown.getSanitizingConverter();
            var editor = new Markdown.Editor(converter);
            editor.run();
        });
    </script>
    <script>
        $(document).ready(function () {
            $(".interaction-button").click(function () {
                var clicked = $(this);
                if (!clicked.hasClass("disabled")) {
                    var pParent = clicked.parent();
                    var dParent = pParent.parent();
                    if (dParent.hasClass("question-buttons")) {
                        if (clicked.children().hasClass("fa-arrow-alt-circle-up")) {
                            voteQuestion(dParent.attr('id'), "Upvote");
                            if ($(".question-buttons p #downvoteButton").hasClass("disabled"))
                                $(".question-score").html(parseInt($(".question-score").html()) + 2);
                            else
                                $(".question-score").html(parseInt($(".question-score").html()) + 1);
                            $(".question-buttons p #upvoteButton").addClass("disabled");
                            $(".question-buttons p #downvoteButton").removeClass("disabled");
                        }
                        if (clicked.children().hasClass("fa-arrow-alt-circle-down")) {
                            voteQuestion(dParent.attr('id'), "Downvote");
                            if ($(".question-buttons p #upvoteButton").hasClass("disabled"))
                                $(".question-score").html(parseInt($(".question-score").html()) - 2);
                            else
                                $(".question-score").html(parseInt($(".question-score").html()) - 1);
                            $(".question-buttons p #upvoteButton").removeClass("disabled");
                            $(".question-buttons p #downvoteButton").addClass("disabled");
                        }
                        if (clicked.children().hasClass("fa-bookmark")) {
                        }
                        if (clicked.children().hasClass("fa-exclamation-circle")) {
                        }
                        if (clicked.children().hasClass("fa-edit")) {
                            $(".edit-question").slideToggle("fast", function () {
                                $("#wmd-preview").focus();
                            });
                        }
                    } else if (dParent.hasClass("answer-buttons")) {
                        if (clicked.children().hasClass("fa-arrow-alt-circle-up")) {
                            voteAnswer(dParent.attr('id'), "Upvote");
                            if (dParent.find("#downvoteButton").hasClass("disabled"))
                                dParent.parent().parent().find(".answer-score").html(parseInt(dParent.parent().parent().find(".answer-score").html()) + 2);
                            else
                                dParent.parent().parent().find(".answer-score").html(parseInt(dParent.parent().parent().find(".answer-score").html()) + 1);
                            dParent.find("#downvoteButton").removeClass("disabled");
                            dParent.find("#upvoteButton").addClass("disabled");
                        }
                        if (clicked.children().hasClass("fa-arrow-alt-circle-down")) {
                            voteAnswer(dParent.attr('id'), "Downvote");
                            if (dParent.find("#upvoteButton").hasClass("disabled"))
                                dParent.parent().parent().find(".answer-score").html(parseInt(dParent.parent().parent().find(".answer-score").html()) - 2);
                            else
                                dParent.parent().parent().find(".answer-score").html(parseInt(dParent.parent().parent().find(".answer-score").html()) - 1);
                            dParent.find("#downvoteButton").addClass("disabled");
                            dParent.find("#upvoteButton").removeClass("disabled");
                        }
                        if (clicked.children().hasClass("fa-star")) {
                            bestAnswer($(".question-buttons").attr('id'), dParent.attr('id'));
                        }
                        if (clicked.children().hasClass("fa-exclamation-circle")) {
                        }
                        if (clicked.children().hasClass("fa-edit")) {
                            $(".edit-answer").slideToggle("fast", function () {
                                $("#wmd-preview").focus();
                            });
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
                        location.reload();
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

        $('.form').submit(function () {
            $theForm = $(this);
            $.ajax({
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

        $('.comment-input').on('keyup', function (e) {
            if (e.keyCode === 13) {
                $theInput = $(this);
                if ($theInput.hasClass("question-comment-input")) {
                    postComment('${pageContext.request.contextPath}/makeQuestionComment', $theInput.val(), '${question.questionId}');
                } else if ($theInput.hasClass("reply-comment-input")) {
                    postComment('${pageContext.request.contextPath}/makeReplyComment', $theInput.value);
                }
            }
        });

        function postComment(url, content, parentId) {
            $.ajax({
                type: "POST",
                url: url,
                data: {
                    parentId: parentId,
                    content: content,
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

    </script>
    <script>

        <c:if test="${replyId != null}">
        $("#deleteAnswerButton").click(function () {
            $("#confirmDeleteAnswer").modal("show");
        });

        $("#modal-btn-delete-answer").click(function () {
            $.ajax({
                type: "POST",
                url: '${pageContext.request.contextPath}/deleteReply',
                data: {
                    replyId: ${replyId},
                    "${_csrf.parameterName}": "${_csrf.token}"
                },
                dataType: "json",
                success: function (data, textStatus, jqXHR) {
                    location.reload();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(errorThrown);
                },
                beforeSend: function (jqXHR, settings) {
                },
                complete: function (jqXHR, textStatus) {
                }
            });
        });
        </c:if>

        $("#deleteQuestionButton").click(function () {
            $("#confirmDeleteQuestion").modal("show");
        });

        $("#modal-btn-delete-question").click(function () {
            $.ajax({
                type: "POST",
                url: '${pageContext.request.contextPath}/deleteQuestion',
                data: {
                    questionId: ${question.questionId},
                    "${_csrf.parameterName}": "${_csrf.token}"
                },
                dataType: "json",
                success: function (data, textStatus, jqXHR) {
                    window.location = "${pageContext.request.contextPath}/";
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(errorThrown);
                },
                beforeSend: function (jqXHR, settings) {
                },
                complete: function (jqXHR, textStatus) {
                }
            });
        });

    </script>
    <script>
        $('#tags').flexdatalist({
            // URL to remote data source.
            url: null,
            // Data source.
            // Array of objects or a URL to JSON string/file.
            data: [],
            // Additional parameters on AJAX requests.
            params: {},
            // Input relatives. Accepts field(s) selector(s) or an jQuery instance of the fields.
            // The relatives values will be sent with each remove server request.
            relatives: null,
            // If set to true the flexdatalist field will be disabled until all the relatives are filled.
            chainedRelatives: false,
            // Enable cache
            cache: true,
            // cache life time
            cacheLifetime: 60,
            // Search if there are n or greater characters.
            minLength: 2,
            // Group results by property value.
            groupBy: false,
            // Selection from search results is required.
            selectionRequired: false,
            //  Focus first result.
            focusFirstResult: false,
            // The text that will be visible to the user.
            // You can use {property_name} to be replaced with property value.
            textProperty: null,
            // The property name that when selected its value will be sent with the form.
            // If you wanna send properties from selected item, set this option to *
            valueProperty: null,
            // Name of properties values that will appear with the search result.
            visibleProperties: [],
            // Name of property (or properties) where it will search.
            searchIn: ['label'],
            // Name of property that holds path to image to be added as icon.
            iconProperty: 'thumb',
            // By default, Flexdatalist's search matches starting at the beginning of a word.
            // Setting this option to true allows matches starting from anywhere within a word.
            // This is especially useful for options that include a lot of special characters or phrases in ()s and []s.
            searchContain: false,
            searchEqual: false,
            searchDisabled: false,
            searchDelay: 200,
            // search by word
            searchByWord: false,
            // This allows you to normalize the strings being compared before comparison.
            normalizeString: function (string) {
                return string.toLowerCase();
            },
            // Accept multiple values
            multiple: $(this).attr('multiple'),
            // max results
            maxShownResults: 10,
            // Text that will show when no results are found. If empty string, it won't show message.
            noResultsText: 'No results found for "{keyword}"',
            // Toggle values on tap/click
            toggleSelected: false,
            // allows duplicate values
            allowDuplicateValues: false,
            // post or get
            requestType: 'post',
            // Flexdatalist expects the data from server to be in the main response object or responseObject.results but you can change the name of property that holds the results.
            resultsProperty: 'results',
            // By default, flexdatalist sends the keyword in request parameter with name keyword.
            keywordParamName: 'keyword',
            // Limit the number of values in a multiple input.
            limitOfValues: 0,
            //  Delimiter used in multiple values.
            valuesSeparator: ',',
            // debug mode
            debug: true
        });
        <c:set var="tags" value="["/>
        <c:forEach var="tag" items="${question.questionCategories}" varStatus="i">
        <c:set var="tags" value="${tags}'${tag.title}',"/>
        </c:forEach>
        <c:set var="tags" value="${tags.substring(0,tags.length()-1)}]"/>
        var tgs = ${tags};
        $("#tags").val(tgs);
    </script>
</sec:authorize>
</html>
