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
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css"/>
    <link rel="stylesheet" href="https://bootswatch.com/3/flatly/bootstrap.css">
    <%--<link rel="stylesheet" href="https://bootswatch.com/3/simplex/bootstrap.css">--%>
    <%--extra--%>
    <script src="//cdnjs.cloudflare.com/ajax/libs/pagedown/1.0/Markdown.Converter.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/pagedown/1.0/Markdown.Editor.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/pagedown/1.0/Markdown.Sanitizer.js"></script>
    <link rel="stylesheet" href="https://cdn.rawgit.com/balpha/pagedown/master/demo/browser/demo.css"/>
    <script src="https://cdn.rawgit.com/google/code-prettify/master/loader/run_prettify.js"></script>
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

        #wmd-preview * {
            width: 100% !important;
            margin: 0 !important;
            padding: 0 !important;
            text-align: left;
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

    </style>
    <title>MemoryLeak</title>
</head>
<body>
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
                    <div class="">
                        <p><span class="glyphicon glyphicon-triangle-top gi-2x" aria-hidden="true"></span></p>
                        <p><span>${post.score}</span></p>
                        <p><span class="glyphicon glyphicon-triangle-bottom gi-2x" aria-hidden="true"></span></p>
                        <p><span class="glyphicon glyphicon-exclamation-sign gi-2x text-muted"
                                 aria-hidden="true"></span></p>
                    </div>
                </div>
            </div>

            <c:forEach var="reply" items="${post.replies}">
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
                        <div class="">
                            <p><span class="glyphicon glyphicon-triangle-top gi-2x" aria-hidden="true"></span></p>
                            <p><span>${post.score}</span></p>
                            <p><span class="glyphicon glyphicon-triangle-bottom gi-2x" aria-hidden="true"></span></p>
                            <p><span class="glyphicon glyphicon-exclamation-sign gi-2x text-muted"
                                     aria-hidden="true"></span></p>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <div class="row">
                <div class="col-sm-12">
                    <div class="alert alert-warning fade in">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
                        <%--TODO change this --%>
                        Please read the rules before posting. bla bla
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <form id="new-post-form" action="${pageContext.request.contextPath}/makeReply" method="POST"
                          class="form-horizontal">
                        <div class="form-group">
                            <%--TODO responsive this part--%>
                            <div class="col-sm-12">
                                <div id="wmd-button-bar"></div>
                                <textarea id="wmd-input" class="wmd-input form-control vresize"
                                          name="content" required></textarea>
                            </div>
                            <%--<div class="col-sm-offset-2 col-sm-10">--%>
                            <%--<textarea id="post_content"--%>
                            <%--class="form-control vresize"--%>
                            <%--name="content" required></textarea>--%>
                            <%--</div>--%>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-1">
                                <input type="submit" class="btn btn-primary" value="Ask"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <div id="wmd-preview" class="wmd-preview"></div>
                            </div>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </form>
                </div>
            </div>
        </div>
        <%--<jsp:include page="bootstrapNavigationRight.jsp"/>--%>
    </div>
</div>
<script>
    $(document).ready(function () {
        $(function () {
            var $formUpdate = $('#update-form');
            var $formUpload = $('#upload-form');
            var $formLink = $('#link-form');
            var $divForms = $('#div-forms-user');
            var $modalAnimateTime = 300;
            var $msgAnimateTime = 150;
            var $msgShowTime = 2000;
            if ("${modalUpdate}") {
                if ("${uploadFailure}")
                    msgChange($('#div-update-msg'), $('#icon-update-msg'), $('#text-update-msg'), "error", "glyphicon-remove", "${uploadFailure}");
                if ("${uploadSuccess}")
                    msgChange($('#div-update-msg'), $('#icon-update-msg'), $('#text-update-msg'), "success", "glyphicon-ok", "${uploadSuccess}");
                if ("${updateFailure}")
                    msgChange($('#div-update-msg'), $('#icon-update-msg'), $('#text-update-msg'), "error", "glyphicon-remove", "${updateFailure}");
                if ("${updateSuccess}")
                    msgChange($('#div-update-msg'), $('#icon-update-msg'), $('#text-update-msg'), "success", "glyphicon-ok", "${updateSuccess}");
                $("#update-modal").modal('show');
            }
            $('#update_upload_btn').click(function () {
                modalAnimate($formUpdate, $formUpload)
            });
            $('#update_link_btn').click(function () {
                modalAnimate($formUpdate, $formLink);
            });
            $('#upload_update_btn').click(function () {
                modalAnimate($formUpload, $formUpdate)
            });
            $('#upload_link_btn').click(function () {
                modalAnimate($formUpload, $formLink)
            });
            $('#link_update_btn').click(function () {
                modalAnimate($formLink, $formUpdate)
            });
            $('#link_upload_btn').click(function () {
                modalAnimate($formLink, $formUpload)
            });

            function modalAnimate($oldForm, $newForm) {
                var $oldH = $oldForm.height();
                var $newH = $newForm.height();
                $divForms.css("height", $oldH);
                $oldForm.fadeToggle($modalAnimateTime, function () {
                    $divForms.animate({height: $newH}, $modalAnimateTime, function () {
                        $newForm.fadeToggle($modalAnimateTime);
                    });
                });
            }

            function msgFade($msgId, $msgText) {
                $msgId.fadeOut($msgAnimateTime, function () {
                    $(this).text($msgText).fadeIn($msgAnimateTime);
                });
            }

            function msgChange($divTag, $iconTag, $textTag, $divClass, $iconClass, $msgText) {
                var $msgOld = $divTag.text();
                msgFade($textTag, $msgText);
                $divTag.addClass($divClass);
                $iconTag.removeClass("glyphicon-chevron-right");
                $iconTag.addClass($iconClass + " " + $divClass);
                setTimeout(function () {
                    msgFade($textTag, $msgOld);
                    $divTag.removeClass($divClass);
                    $iconTag.addClass("glyphicon-chevron-right");
                    $iconTag.removeClass($iconClass + " " + $divClass);
                }, $msgShowTime);
            }
        });
    });
</script>
<script>
    $(document).ready(function () {
        var converter = Markdown.getSanitizingConverter();
        var editor = new Markdown.Editor(converter);
        editor.run();
    })
</script>
<jsp:include page="bootstrapNavigationBottom.jsp"/>
</body>
</html>
