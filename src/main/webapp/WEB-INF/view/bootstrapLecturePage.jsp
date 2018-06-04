<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tags-mytaglib" tagdir="/WEB-INF/tags/mytaglib" %>
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

        #wmd-preview-second {
            width: 100% !important;
            margin: 0 !important;
            padding: 0 !important;
            text-align: left;
            background-color: #ecf0f1 !important;
        }

        #wmd-preview-third {
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

        .interaction-button {
            width: 51px;
        }

        .buttons-p {
            display: inline-block;
        }

        .lecture-buttons {
            text-align: center;
        }

        .switch-div {
            text-align: right;
        }

        .switch-div a {
            vertical-align: middle;
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
                        ${lecture.title}
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-11">
                    <div class="well pading-top-5px pading-bottom-5px">
                        <div class="row">
                            <div class="text-left col-md-12">
                                <div id="lectureDescription" class="collapse">
                                    <c:if test="${lecture.description.length() == 0}">
                                        This lecture has no description.
                                    </c:if>
                                    <c:if test="${lecture.description == null}">
                                        This lecture has no description.
                                    </c:if>
                                    <c:if test="${lecture.description.length() != 0}">
                                        ${lecture.description}
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        <hr class="hr-5px"/>
                        <div class="row">
                            <div class="col-md-6">
                                <button type="button" id="expandButton" class="btn btn-info" data-toggle="collapse"
                                        data-target="#lectureDescription">
                                    <i class="fas fa-chevron-circle-down fa-inverse active-icon"></i>
                                </button>
                                <c:if test="${lecture.virtualClass.user.username!=pageContext.request.userPrincipal.name}">
                                    <a type="button" class="btn btn-info"
                                       href="${pageContext.request.contextPath}/newQuestion?lectureId=${lecture.lectureId}">Ask
                                        a question</a>
                                </c:if>
                                <a type="button" class="btn btn-info" href="#">See questions</a>
                            </div>
                            <div class="col-md-6 text-right-responsive">
                                <p class="text-right-responsive margin-bottom-0px gi-08x">
                                    created ${lecture.created.toLocaleString()} by <a
                                        href="${pageContext.request.contextPath}/account?username=${lecture.virtualClass.user.username}"><img
                                        src="${lecture.virtualClass.user.profileImage}" class="img-circle" height="35"
                                        width="35"
                                        alt="Avatar"> ${lecture.virtualClass.user.username}
                                </a>
                                </p>
                                <p class="text-right-responsive margin-bottom-0px gi-08x">
                                    views ${lecture.views}
                                </p>
                                <p class="text-right-responsive margin-bottom-0px gi-08x">
                                    votes <span class="lecture-score">${lecture.score}</span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="well pading-top-5px pading-bottom-5px">
                        <div class="row">
                            <div class="text-left col-md-12" id="myDiv">
                                <div id="pageContent">
                                    <c:if test="${lecture.pages.size() == 0}">
                                        <p>This lecture does not yet have any pages.</p>
                                        <p>You should check again soon.</p>
                                    </c:if>
                                    <c:if test="${page < lecture.pages.size() && lecture.pages.size() != 0}">
                                        ${lecture.pages.toArray()[page].content}
                                    </c:if>
                                    <c:if test="${page >= lecture.pages.size() && lecture.pages.size() != 0}">
                                        <p>You have gone to far...</p>
                                        <p>Maybe you are interested in <a
                                                href="${pageContext.request.contextPath}/lecture?lectureId=${lecture.lectureId}&page=${lecture.pages.size()-1}">this
                                            page?</a></p>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        <hr class="hr-5px"/>
                    </div>
                </div>
                <div class="col-md-1">
                    <div class="lecture-buttons" id="${lecture.lectureId}">
                        <sec:authorize access="isAuthenticated()">
                            <c:if test="${lecture.voteType==1}">
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
                            <c:if test="${lecture.voteType==-1}">
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
                            <c:if test="${lecture.voteType==0}">
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
                            <c:if test="${lecture.virtualClass.user.username!=pageContext.request.userPrincipal.name}">
                                <p class="margin-bottom-0px buttons-p">
                                    <button id="bookmarkButton" class="btn btn-info interaction-button">
                                        <i class="fas fa-bookmark fa-inverse"></i>
                                    </button>
                                </p>
                            </c:if>
                            <c:if test="${lecture.virtualClass.user.username!=pageContext.request.userPrincipal.name}">
                                <p class="margin-bottom-0px buttons-p">
                                    <button id="reportButton" class="btn btn-info interaction-button">
                                        <i class="fas fa-exclamation-circle fa-inverse"></i>
                                    </button>
                                </p>
                            </c:if>
                            <c:if test="${lecture.virtualClass.user.username==pageContext.request.userPrincipal.name}">
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

            <%--edit lecture--%>
            <c:if test="${lecture.virtualClass.user.username==pageContext.request.userPrincipal.name}">
                <div class="edit-forms" style="display: none;">
                    <div class="row">
                        <div class="col-md-11">
                            <ul class="nav nav-tabs">
                                <li class="active tab-control"><a id="createNewPage" role="button">Create a new page</a>
                                </li>
                                <c:if test="${lecture.pages.size() != 0}">
                                    <li class="tab-control"><a id="editPage" role="button">Edit current page</a></li>
                                </c:if>
                                <li class="tab-control"><a id="editLecture" role="button">Edit lecture</a></li>
                            </ul>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-md-11">
                            <form id="edit-lecture-form" action="${pageContext.request.contextPath}/editLecture"
                                  method="POST"
                                  class="form-horizontal form">
                                <div class="form-group">
                                    <label class="control-label col-sm-1" for="post_title">Title:</label>
                                    <div class="col-sm-11">
                                        <input id="post_title" class="form-control " type="text"
                                               name="title" value="${lecture.title}" required>
                                    </div>
                                </div>
                                <div class="form-group">
                                        <%--TODO responsive this part--%>
                                    <div class="col-md-12">
                                        <div id="wmd-button-bar"></div>
                                        <textarea id="wmd-input" class="wmd-input form-control vresize"
                                                  name="description" tabindex="-1"
                                                  required>${lecture.rawDescription}</textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <input type="submit" class="btn btn-primary align-left"
                                               value="Update lecture"/>
                                        <p class="margin-bottom-0px buttons-p align-right">
                                            <button type="button" id="deleteLectureButton"
                                                    class="btn btn-danger interaction-button">
                                                <i class="fas fa-trash-alt fa-inverse"></i>
                                            </button>
                                        </p>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <p>You can see a live preview of how your lecture description will look. </p>
                                        <hr/>
                                        <div id="wmd-preview" tabindex="-1" class="wmd-preview well"></div>
                                        <hr/>
                                    </div>
                                </div>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <input type="hidden" name="lectureId" value="${lecture.lectureId}"/>
                            </form>

                            <form id="edit-page-form" action="${pageContext.request.contextPath}/editPage"
                                  method="POST"
                                  class="form-horizontal form">
                                <div class="form-group">
                                        <%--TODO responsive this part--%>
                                    <div class="col-md-12">
                                        <div id="wmd-button-bar-second"></div>
                                        <textarea id="wmd-input-second" class="wmd-input form-control vresize"
                                                  name="content" tabindex="-1"
                                                  required>${lecture.pages.toArray()[page].rawContent}</textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <input type="submit" class="btn btn-primary align-left"
                                               value="Update page"/>
                                        <p class="margin-bottom-0px buttons-p align-right">
                                            <button type="button" id="deletePageButton"
                                                    class="btn btn-danger interaction-button">
                                                <i class="fas fa-trash-alt fa-inverse"></i>
                                            </button>
                                        </p>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <p id="preview-text">You can see a live preview of how your page content will
                                            look. </p>
                                        <hr/>
                                        <div id="wmd-preview-second" tabindex="-1" class="wmd-preview well"></div>
                                        <hr/>
                                    </div>
                                </div>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <input type="hidden" name="pageId" value="${lecture.pages.toArray()[page].pageId}"/>
                            </form>

                            <form id="create-page-form" action="${pageContext.request.contextPath}/newPage"
                                  method="POST"
                                  class="form-horizontal form form-active">
                                <div class="form-group">
                                        <%--TODO responsive this part--%>
                                    <div class="col-md-12">
                                        <div id="wmd-button-bar-third"></div>
                                        <textarea id="wmd-input-third" class="wmd-input form-control vresize"
                                                  name="content" tabindex="-1"
                                                  required></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-1">
                                        <input type="submit" class="btn btn-primary"
                                               value="Create page"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <p id="preview-text">You can see a live preview of how your page content will
                                            look. </p>
                                        <hr/>
                                        <div id="wmd-preview-third" tabindex="-1" class="wmd-preview well"></div>
                                        <hr/>
                                    </div>
                                </div>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <input type="hidden" name="lectureId" value="${lecture.lectureId}"/>
                            </form>
                        </div>
                    </div>
                </div>
            </c:if>

            <c:if test="${lecture.pages.size() != 0}">
                <div class="row">
                    <div class="col-md-11">
                        <nav aria-label="Page navigation">
                            <tags-mytaglib:paginationForLecturePages url="/lecture?lectureId=${lecture.lectureId}&page="
                                                                     nbrOfPages="${lecture.pages.size()-1}"
                                                                     currentPage="${page}"
                                                                     howManyPagesToShow="3"/>
                        </nav>
                    </div>
                </div>
            </c:if>

        </div>
        <jsp:include page="bootstrapNavigationBottom.jsp"/>

        <c:if test="${lecture.virtualClass.user.username==pageContext.request.userPrincipal.name}">
        <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="confirmDeletePageLabel" aria-hidden="true"
             id="confirmDeletePage">
            <div class="modal-dialog modal-sm">
                <div class="modal-content delete-confirmation-modal">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="confirmDeletePageLabel">Are you sure you want to delete this
                            page?</h4>
                    </div>
                    <div class="modal-body">
                        <p>This action cannot be reversed. Once you delete a page, it's gone forever.</p>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" id="modal-btn-delete-page">Yes, delete it.
                            </button>
                            <button type="button" class=" btn btn-primary" data-dismiss="modal" aria-label="Close">No,
                                keep
                                it.
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteLectureLabel"
             aria-hidden="true"
             id="confirmDeleteLecture">
            <div class="modal-dialog modal-sm">
                <div class="modal-content delete-confirmation-modal">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="confirmDeleteLectureLabel">Are you sure you want to delete this
                            lecture?</h4>
                    </div>
                    <div class="modal-body">
                        <p>This action cannot be reversed. Once you delete a lecture, it's gone forever.</p>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" id="modal-btn-delete-lecture">Yes, delete
                                it.
                            </button>
                            <button type="button" class=" btn btn-primary" data-dismiss="modal" aria-label="Close">No,
                                keep
                                it.
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
            var converter1 = new Markdown.Converter();
            var editor1 = new Markdown.Editor(converter1);
            editor1.run();

            var converter2 = new Markdown.Converter();
            var editor2 = new Markdown.Editor(converter2, "-second");
            editor2.run();

            var converter3 = new Markdown.Converter();
            var editor3 = new Markdown.Editor(converter3, "-third");
            editor3.run();
        });
    </script>
</sec:authorize>
<sec:authorize access="isAuthenticated()">
    <script>
        $("#editButton").click(function () {
            $("#edit-page-form").hide();
            $("#edit-lecture-form").hide();
            $("#create-page-form").show();
            $(".edit-forms").slideToggle("fast", function () {
                $("#wmd-preview-third").focus();
            });
        });
    </script>
    <script>
        $("#createNewPage").click(function () {
            $(".tab-control").removeClass('active');
            $(this).parent().addClass("active");
            $('.form-active').fadeOut('fast', function () {
                $(this).removeClass('form-active');
                $("#create-page-form").fadeIn('fast', function () {
                    $(this).addClass('form-active');
                });
            });
        });
        $("#editPage").click(function () {
            $(".tab-control").removeClass('active');
            $(this).parent().addClass("active");
            $('.form-active').fadeOut('fast', function () {
                $(this).removeClass('form-active');
                $("#edit-page-form").fadeIn('fast', function () {
                    $(this).addClass('form-active');
                });
            });
        });
        $("#editLecture").click(function () {
            $(".tab-control").removeClass('active');
            $(this).parent().addClass("active");
            $('.form-active').fadeOut('fast', function () {
                $(this).removeClass('form-active');
                $("#edit-lecture-form").fadeIn('fast', function () {
                    $(this).addClass('form-active');
                });
            });
        });
    </script>
    <script>
        $('.form').submit(function () {
            $theForm = $(this);
            $.ajax({
                type: $theForm.attr('method'),
                url: $theForm.attr('action'),
                data: $theForm.serialize(),
                success: function (data) {
                    if ($theForm.attr("id") === "create-page-form") {
                        window.location = "${pageContext.request.contextPath}/lecture?lectureId=${lecture.lectureId}&page=" + (data - 1);
                    } else {
                        location.reload(true);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(errorThrown);
                }
            });
            return false;
        });
    </script>
    <script>
        $(".interaction-button").click(function () {
            var id = this.id;
            var isDisabled = $(this).hasClass("disabled");
            if (id === "downvoteButton" && !isDisabled) {
                voteLecture("${lecture.lectureId}", "Downvote");
                if ($("#upvoteButton").hasClass("disabled"))
                    $(".lecture-score").html(parseInt($(".lecture-score").html()) - 2);
                else
                    $(".lecture-score").html(parseInt($(".lecture-score").html()) - 1);
                $("#downvoteButton").addClass("disabled");
                $("#upvoteButton").removeClass("disabled");
            } else if (id === "upvoteButton" && !isDisabled) {
                voteLecture("${lecture.lectureId}", "Upvote");
                if ($("#downvoteButton").hasClass("disabled"))
                    $(".lecture-score").html(parseInt($(".lecture-score").html()) + 2);
                else
                    $(".lecture-score").html(parseInt($(".lecture-score").html()) + 1);
                $("#upvoteButton").addClass("disabled");
                $("#downvoteButton").removeClass("disabled");
            }
        });

        function voteLecture(lectureId, voteType) {
            $.ajax({
                type: "POST",
                url: '${pageContext.request.contextPath}/voteLecture',
                data: {
                    lectureId: lectureId,
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
    </script>
    <script>

        $("#deleteLectureButton").click(function () {
            $("#confirmDeleteLecture").modal("show");
        });

        $("#deletePageButton").click(function () {
            $("#confirmDeletePage").modal("show");
        });

        $("#modal-btn-delete-page").click(function () {
            $.ajax({
                type: "POST",
                url: '${pageContext.request.contextPath}/deletePage',
                data: {
                    pageId: ${lecture.pages.toArray()[page].pageId},
                    "${_csrf.parameterName}": "${_csrf.token}"
                },
                dataType: "json",
                success: function (data, textStatus, jqXHR) {
                    window.location = "${pageContext.request.contextPath}/lecture?lectureId=${lecture.lectureId}";
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

        $("#modal-btn-delete-lecture").click(function () {
            $.ajax({
                type: "POST",
                url: '${pageContext.request.contextPath}/deleteLecture',
                data: {
                    lectureId: ${lecture.lectureId},
                    "${_csrf.parameterName}": "${_csrf.token}"
                },
                dataType: "json",
                success: function (data, textStatus, jqXHR) {
                    window.location = "${pageContext.request.contextPath}/class?classId=${lecture.virtualClass.virtualClassId}";
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
        a
    </script>
</sec:authorize>
</html>
