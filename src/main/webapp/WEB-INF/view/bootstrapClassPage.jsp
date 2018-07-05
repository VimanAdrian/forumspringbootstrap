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
<body onload="PR.prettyPrint()">
<jsp:include page="bootstrapNavigationTop.jsp"/>
<div class="container text-center" id="mainContent">
    <div class="row">
        <jsp:include page="bootstrapNavigationLeft.jsp"/>
        <%-- NEW QUESTION FORM --%>
        <div class="col-md-9">

            <div class="row">
                <div class="col-md-11">
                    <div class="question-title wordBreak">
                        <c:out value="${virtualClass.title}"/>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-11">
                    <div class="well pading-top-5px pading-bottom-5px">
                        <div class="row">
                            <div class="text-left col-md-12 wordBreak">
                                ${virtualClass.description}
                            </div>
                        </div>
                        <hr class="hr-5px"/>
                        <div class="row">
                            <div class="col-md-6">
                                <p class="text-left-responsive">
                                    <c:forEach var="tag" items="${virtualClass.virtualClassCategories}">
                                        <a href="${pageContext.request.contextPath}/tag?tag=<c:out value='${tag.url}'/>&page=0&searchingFor=virtualClass"><span
                                                class="label label-default"><c:out value="${tag.title}"/></span></a>
                                    </c:forEach>
                                </p>
                            </div>
                            <div class="col-md-6 text-right-responsive">
                                <p class="text-right-responsive margin-bottom-0px gi-08x">
                                    created ${virtualClass.created.toLocaleString()} by <a
                                        href="${pageContext.request.contextPath}/account?username=<c:out value='${virtualClass.user.username}'/>"><img
                                        src="${virtualClass.user.profileImage}" class="img-circle" height="35"
                                        width="35"
                                        alt="Avatar"> <c:out value="${virtualClass.user.username}"/>
                                </a>
                                </p>
                                <p class="text-right-responsive margin-bottom-0px gi-08x">
                                    views ${virtualClass.views}
                                </p>
                                <p class="text-right-responsive margin-bottom-0px gi-08x">
                                    votes <span class="question-score">${virtualClass.score}</span>
                                </p>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="col-md-1">
                    <div class="question-buttons" id="${virtualClass.virtualClassId}">
                        <sec:authorize access="isAuthenticated()">
                            <c:if test="${virtualClass.voteType==1}">
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
                            <c:if test="${virtualClass.voteType==-1}">
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
                            <c:if test="${virtualClass.voteType==0}">
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
                            <jsp:include page="bootstrapShareThisMenu.jsp"/>
                            <sec:authorize access="isAuthenticated()">
                                <c:if test="${virtualClass.user.username!=pageContext.request.userPrincipal.name}">
                                    <c:if test="${followsClass == false}">
                                        <p class="margin-bottom-0px buttons-p">
                                            <button id="notificationButton" class="btn btn-info interaction-button">
                                                <i class="fas fa-bell"></i>
                                            </button>
                                        </p>
                                    </c:if>
                                    <c:if test="${followsClass}">
                                        <p class="margin-bottom-0px buttons-p">
                                            <button id="notificationButton" class="btn btn-warning interaction-button">
                                                <i class="fas fa-bell"></i>
                                            </button>
                                        </p>
                                    </c:if>
                                </c:if>
                            </sec:authorize>
                            <c:if test="${virtualClass.user.username==pageContext.request.userPrincipal.name}">
                                <p class="margin-bottom-0px buttons-p">
                                    <button id="editButton" class="btn btn-info interaction-button">
                                        <i class="fas fa-edit fa-inverse"></i>
                                    </button>
                                </p>
                            </c:if>
                            <sec:authorize access="hasRole('ROLE_ADMIN')">
                                <p class="margin-bottom-0px buttons-p">
                                    <button type="button" id="adminDeleteButton-class-${virtualClass.virtualClassId}"
                                            class="btn btn-danger admin-button interaction-button">
                                        <i class="fas fa-trash-alt fa-inverse"></i>
                                    </button>
                                </p>
                            </sec:authorize>
                        </sec:authorize>
                    </div>
                </div>
            </div>

            <%--edit question--%>
            <c:if test="${virtualClass.user.username==pageContext.request.userPrincipal.name}">
                <div class="edit-forms" style="display: none;">
                    <div class="row">
                        <div class="col-md-11">
                            <ul class="nav nav-tabs">
                                <li class="tab-control active"><a id="editClass" role="button">Edit current virtual
                                    class</a></li>
                                <li class="tab-control"><a id="editLecture" role="button">Edit lectures</a></li>
                            </ul>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-md-11">
                            <form id="edit-class-form" action="${pageContext.request.contextPath}/editClass"
                                  method="POST"
                                  class="form-horizontal form form-active">
                                <div class="form-group">
                                    <label class="control-label col-sm-1" for="post_title">Title:</label>
                                    <div class="col-sm-11">
                                        <input id="post_title" class="form-control " type="text"
                                               name="title" required value="${virtualClass.title}">
                                    </div>
                                </div>
                                <div class="form-group">
                                        <%--TODO responsive this part--%>
                                    <div class="col-md-12">
                                        <div id="wmd-button-bar"></div>
                                        <textarea id="wmd-input" class="wmd-input form-control vresize"
                                                  name="description" tabindex="-1"
                                                  required>${virtualClass.rawDescription}</textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-1" for="tags">Tags:</label>
                                    <div class="col-sm-11">
                                        <input type="text" id="tags" data-role="tagsinput"
                                               class="form-control flexdatalist"
                                               name="tags" multiple='multiple' list="taglist"/>
                                            <%--TODO change this--%>
                                        <datalist id="taglist">
                                            <jsp:include page="bootstrapTagList.jsp"/>
                                        </datalist>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <input type="submit" class="btn btn-primary align-left"
                                               value="Update your class"/>
                                        <p class="margin-bottom-0px buttons-p align-right">
                                            <button type="button" id="deleteClassButton"
                                                    class="btn btn-danger interaction-button">
                                                <i class="fas fa-trash-alt fa-inverse"></i>
                                            </button>
                                        </p>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <p>You can see a live preview of how your class description will look. </p>
                                        <hr/>
                                        <div id="wmd-preview" tabindex="-1" class="wmd-preview well"></div>
                                        <hr/>
                                    </div>
                                </div>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <input type="hidden" name="virtualClassId" value="${virtualClass.virtualClassId}"/>
                            </form>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-11">
                            <form id="edit-lectures-form"
                                  action="${pageContext.request.contextPath}/editClassAddLectures"
                                  method="POST"
                                  class="form-horizontal form">
                                <div class="form-group">
                                    <div class=" col-sm-offset-1 col-sm-11">
                                        You can add more lectures to your virtual class. If you want to delete a
                                        lecture, you should go to that lecture's page.
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-1" for="lectures">Lectures:</label>
                                    <div class="col-sm-11">
                                        <ul id="lectures" style=" list-style-type: none;">
                                            <li class="li-padding-bottom"><input class="form-control" type="text"
                                                                                 name="title"
                                                                                 placeholder="Lecture title"/></li>
                                        </ul>
                                        <div class="btn-toolbar align-right">
                                            <button type="button" id="removeLecture" class="btn btn-danger btn-sm"><span
                                                    class="glyphicon glyphicon-minus"></span></button>
                                            <button type="button" id="addLecture" class="btn btn-success btn-sm"><span
                                                    class="glyphicon glyphicon-plus"></span></button>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <input type="submit" class="btn btn-primary align-left"
                                               value="Create lectures"/>
                                    </div>
                                </div>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <input type="hidden" name="virtualClassId" value="${virtualClass.virtualClassId}"/>
                            </form>
                        </div>
                    </div>
                </div>

            </c:if>

            <c:forEach var="lecture" items="${virtualClass.lectures}">
                <hr class="hr-5px"/>
                <div class="row">
                    <div class="col-md-11">
                        <div class="well pading-top-5px pading-bottom-5px">
                            <c:if test="${lecture.active==true}">
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
                                                ${lecture.description}
                                            </c:if>
                                            <c:if test="${lecture.description.length() >=500}">
                                                ${lecture.description.substring(0, 499)}...
                                            </c:if>
                                        </c:if>
                                    </div>
                                </div>
                                <hr class="hr-5px"/>
                                <div class="row">
                                    <div class="col-md-6 col-md-offset-6">
                                        <p class="text-right-responsive margin-bottom-0px gi-08x">
                                            created ${lecture.created.toLocaleString()}
                                        </p>
                                        <p class="text-right-responsive margin-bottom-0px gi-08x">
                                            views <span class="answer-score">${lecture.views}</span>
                                        </p>
                                        <p class="text-right-responsive margin-bottom-0px gi-08x">
                                            score <span class="answer-score">${lecture.score}</span>
                                        </p>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <jsp:include page="bootstrapNavigationBottom.jsp"/>
    <c:if test="${virtualClass.user.username==pageContext.request.userPrincipal.name}">
    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="confirmDeleteClassLabel" aria-hidden="true"
         id="confirmDeleteClass">
        <div class="modal-dialog modal-sm">
            <div class="modal-content delete-confirmation-modal">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="confirmDeleteClassLabel">Are you sure you want to delete this
                        class?</h4>
                </div>
                <div class="modal-body">
                    <p>This action cannot be reversed. Once you delete a class, it's gone forever.</p>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" id="modal-btn-delete-class">Yes, delete it.
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
        $("#editButton").click(function () {
            $("#edit-class-form").show();
            $("#edit-lectures-form").hide();
            $(".edit-forms").slideToggle("fast", function () {
                $("#wmd-preview").focus();
            });
        });

        $("#editClass").click(function () {
            $(".tab-control").removeClass('active');
            $(this).parent().addClass("active");
            $('.form-active').fadeOut('fast', function () {
                $(this).removeClass('form-active');
                $("#edit-class-form").fadeIn('fast', function () {
                    $(this).addClass('form-active');
                });
            });
        });
        $("#editLecture").click(function () {
            $(".tab-control").removeClass('active');
            $(this).parent().addClass("active");
            $('.form-active').fadeOut('fast', function () {
                $(this).removeClass('form-active');
                $("#edit-lectures-form").fadeIn('fast', function () {
                    $(this).addClass('form-active');
                });
            });
        });
    </script>
    <script>
        $("#addLecture").click(function () {
            $("#lectures li:last").after('<li class=" li-padding-bottom"><input class="form-control" type="text" name="title" placeholder="Lecture title"/></li>');
        });
        $("#removeLecture").click(function () {
            if ($('ul#lectures li').length > 1)
                $("#lectures li:last-child").remove()
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
                    location.reload(true);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(errorThrown);
                }
            });
            return false;
        });
    </script>
    <c:if test="${virtualClass.user.username==pageContext.request.userPrincipal.name}">
        <script>
            $("#deleteClassButton").click(function () {
                $("#confirmDeleteClass").modal("show");
            });

            $("#modal-btn-delete-class").click(function () {
                $.ajax({
                    type: "POST",
                    url: '${pageContext.request.contextPath}/deleteClass',
                    data: {
                        classId: ${virtualClass.virtualClassId},
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
    </c:if>
    <c:if test="${virtualClass.user.username!=pageContext.request.userPrincipal.name}">
        <script>
            $("#notificationButton").click(function () {
                if ($(this).hasClass("btn-info")) {
                    $.ajax({
                        type: "POST",
                        url: '${pageContext.request.contextPath}/followClass',
                        data: {
                            classId:  ${virtualClass.virtualClassId},
                            "${_csrf.parameterName}": "${_csrf.token}"
                        },
                        dataType: "json",
                        success: function (data, textStatus, jqXHR) {
                            $("#notificationButton").removeClass("btn-info");
                            $("#notificationButton").addClass("btn-warning");
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            console.log(errorThrown);
                        },
                        beforeSend: function (jqXHR, settings) {
                        },
                        complete: function (jqXHR, textStatus) {
                        }
                    });
                } else {
                    $.ajax({
                        type: "POST",
                        url: '${pageContext.request.contextPath}/unfollowClass',
                        data: {
                            classId:  ${virtualClass.virtualClassId},
                            "${_csrf.parameterName}": "${_csrf.token}"
                        },
                        dataType: "json",
                        success: function (data, textStatus, jqXHR) {
                            $("#notificationButton").removeClass("btn-warning");
                            $("#notificationButton").addClass("btn-info");
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
    </c:if>
    <c:if test="${virtualClass.user.username==pageContext.request.userPrincipal.name}">
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
            <c:set var="tags" value=""/>
            <c:forEach var="tag" items="${virtualClass.virtualClassCategories}" varStatus="i">
            <c:set var="tags" value="${tags}'"/>
            <c:set var="tags">
            ${tags}<c:out value='${tag.title}'/>
            </c:set>
            <c:if test="${i.last == false}">
            <c:set var="tags" value="${tags}',"/>
            </c:if>
            <c:if test="${i.last == true}">
            <c:set var="tags" value="${tags}'"/>
            </c:if>
            </c:forEach>
            var tgs = [${tags}];
            $("#tags").val(tgs);
        </script>
    </c:if>
    <sec:authorize access="hasRole('ROLE_ADMIN')">
        <script>
            $(".admin-button").click(function () {

                var id = this.id;
                var res = id.split("-");
                if (res[1] === "class") {
                    adminDelete("${pageContext.request.contextPath}/adminDeleteClass", res[2], "${pageContext.request.contextPath}/");
                }

                function adminDelete(url, id, location) {
                    $.ajax({
                        type: "POST",
                        url: url,
                        data: {
                            id: id,
                            "${_csrf.parameterName}": "${_csrf.token}"
                        },
                        dataType: "json",
                        success: function (data, textStatus, jqXHR) {
                            if (location === true) {
                                window.location = window.location;
                            } else {
                                window.location = location;
                            }
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
    </sec:authorize>
</sec:authorize>
<script>
    if ('serviceWorker' in navigator) {
        navigator.serviceWorker
            .register('${pageContext.request.contextPath}/service-worker.js', {scope: '/class'})
            .then(function (registration) {
                console.log("Service Worker Registered");
            })
            .catch(function (err) {
                console.log("Service Worker Failed to Register", err);
            });
    }
    if ('serviceWorker' in navigator) {
        var lastStatus = true;
        onlineCheck();

        function onlineCheck() {
            if ((navigator.onLine === true) && (lastStatus === false)) {
                $(".navbar-default").removeClass("navbar-offline");
                $(".hide-offline").show();
                $(".show-offline").hide();
                $(".interaction-button").prop("disabled", false);
            } else if ((navigator.onLine === false) && (lastStatus === true)) {
                $(".navbar-default").addClass("navbar-offline");
                $(".hide-offline").hide();
                $(".show-offline").show();
                $(".interaction-button").prop("disabled", true);
                lastStatus = false;
            }
            setTimeout(function () {
                onlineCheck()
            }, 5000);
        }
    }
</script>
</html>
