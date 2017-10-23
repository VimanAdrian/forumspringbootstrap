<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: viorelv
  Date: 13-Oct-17
  Time: 11:07 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <style>

        #update-modal .modal-dialog {
            width: 350px;
        }

        #update-modal input[type=text], input[type=password] {
            margin-top: 10px;
        }

        #div-update-msg {
            border: 1px solid #dadfe1;
            height: 30px;
            line-height: 28px;
            transition: all ease-in-out 500ms;
        }

        #div-update-msg.success {
            border: 1px solid #68c3a3;
            background-color: #c8f7c5;
        }

        #div-update-msg.error {
            border: 1px solid #eb575b;
            background-color: #ffcad1;
        }

        #update_gender {
            margin-top: 10px;
        }

        .update_option {
            max-width: 318px;
            overflow: hidden;
        }

        @media screen and (min-width: 1024px) {
            #update_gender {
                overflow: hidden;
            }

            .update_option {
                width: 318px !important;
                max-width: 318px;
                overflow: hidden;
            }
        }

        @media screen and (max-width: 480px) {
            #update-modal .modal-dialog {
                width: 95%;
            }
        }

        .well {
            background-color: #B0BEC5 !important;
        }

        .well-top {
            background-color: #CFD8DC !important;
        }

        .panel-title-ask {
            margin-bottom: 0 !important;
        }

        .panel-heading-ask {
            padding-top: 0 !important;
            padding-bottom: 0 !important;
            padding-left: 0 !important;
            padding-right: 0 !important;
        }

        .vresize {
            resize: vertical;
        }

        .form-element {
            margin-top: 10px;
        }
    </style>
    <title>MemoryLeak</title>
</head>
<body>

<jsp:include page="bootstrapNavigation.jsp"/>

<div class="container text-center">
    <div class="row">
        <div class="col-sm-3 well">
            <sec:authorize access="isAuthenticated()">
                <div class="well well-top">
                    <p><a href="http://localhost:8080/account?username=${user.username}">${user.username}</a></p>
                    <img src="${user.profileImage}" class="img-circle" height="65"
                         width="65" alt="Avatar">
                </div>
                <div class="well well-top">
                    <c:if test="${user.username == pageContext.request.userPrincipal.name}">
                        <p>
                            <a href="#" class="" role="button" data-toggle="modal" data-target="#update-modal">
                                <span class="glyphicons glyphicons-edit"></span> Update</a>
                        </p>
                    </c:if>
                    <c:if test="${user.admin==true}">ADMIN</c:if>
                    <c:if test="${user.firstNameForUpdate!=null}">
                        <p>First name: ${user.firstName}</p>
                    </c:if>
                    <c:if test="${user.lastNameForUpdate!=null}">
                        <p>Last name: ${user.lastName}</p>
                    </c:if>
                    <p>Email: ${user.email}</p>
                    <p>Member since: ${user.memberSince}</p>
                </div>
                <c:if test="${newAnswers==true}">
                    <div class="alert alert-success fade in">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
                        <p><strong>You have new answers!</strong></p>
                        <c:forEach var="post" items="${answerList}" varStatus="loop">
                            <p><a href="/post?postID=${post.postId}&page=0">${post.title}</a></p>
                        </c:forEach>
                    </div>
                </c:if>
                <div class="well well-top">
                    <c:if test="${topQuestions==true}">
                        <p>Your top questions.</p>
                        <c:forEach var="post" items="${questionList}" varStatus="loop">
                            <p><a href="/post?postID=${post.postId}&page=0">${post.title}
                                <span class="badge">${post.score}</span></a></p>
                        </c:forEach>
                    </c:if>
                    <c:if test="${topQuestions==false}">
                        <p>
                            It seems you don't have any questions.
                            <br>
                            You can ask one <a href="#">here</a>!
                        </p>
                    </c:if>
                </div>
            </sec:authorize>
            <sec:authorize access="isAnonymous()">
                <div class="well">
                    <p>ADS</p>
                </div>
                <div class="well">
                    <p>ADS</p>
                </div>
                <div class="well">
                    <p>ADS</p>
                </div>
            </sec:authorize>
        </div>
        <div class="col-sm-7">
            <div class="row">
                <div class="col-sm-12">
                    <div class="panel-group">
                        <div class="panel panel-default">
                            <div class="panel-heading panel-heading-ask">
                                <h4 class="panel-title well panel-title-ask">
                                    <a data-toggle="collapse" href="#collapse1">
                                        <div id="icon-post-msg" class="glyphicon glyphicon-chevron-down"></div>
                                        <span id="text-post-msg">Ask a question.</span></a>
                                </h4>
                            </div>
                            <div id="collapse1" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <form id="new-post-form" action="/makePost" method="POST">
                                        <div class="form-body">
                                            <input id="post_title" class="form-control form-element" type="text"
                                                   name="title"
                                                   placeholder="Title">
                                            <textarea id="post_content" class="form-control form-element vresize"
                                                      name="content"
                                                      placeholder="Content"></textarea>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-3">
                    <div class="well">
                        <p>John</p>
                        <img src="bird.jpg" class="img-circle" height="55" width="55" alt="Avatar">
                    </div>
                </div>
                <div class="col-sm-9">
                    <div class="well">
                        <p>Just Forgot that I had to mention something about someone to someone about how I forgot
                            something, but now I forgot it. Ahh, forget it! Or wait. I remember.... no I don't.</p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-3">
                    <div class="well">
                        <p>Bo</p>
                        <img src="bandmember.jpg" class="img-circle" height="55" width="55" alt="Avatar">
                    </div>
                </div>
                <div class="col-sm-9">
                    <div class="well">
                        <p>Just Forgot that I had to mention something about someone to someone about how I forgot
                            something, but now I forgot it. Ahh, forget it! Or wait. I remember.... no I don't.</p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-3">
                    <div class="well">
                        <p>Jane</p>
                        <img src="bandmember.jpg" class="img-circle" height="55" width="55" alt="Avatar">
                    </div>
                </div>
                <div class="col-sm-9">
                    <div class="well">
                        <p>Just Forgot that I had to mention something about someone to someone about how I forgot
                            something, but now I forgot it. Ahh, forget it! Or wait. I remember.... no I don't.</p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-3">
                    <div class="well">
                        <p>Anja</p>
                        <img src="bird.jpg" class="img-circle" height="55" width="55" alt="Avatar">
                    </div>
                </div>
                <div class="col-sm-9">
                    <div class="well">
                        <p>Just Forgot that I had to mention something about someone to someone about how I forgot
                            something, but now I forgot it. Ahh, forget it! Or wait. I remember.... no I don't.</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-2 well">
            <div class="well">
                <p>ADS</p>
            </div>
            <div class="well">
                <p>ADS</p>
            </div>
            <div class="well">
                <p>ADS</p>
            </div>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="update-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
     style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" align="center">
                <img class="img-circle" id="img_logo" src="/resources/images/logo4-alt.png">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                </button>
            </div>

            <!-- Begin # DIV Form -->
            <div id="div-forms-user">

                <!-- Begin | Update Form -->
                <form id="update-form" action="/update" method="POST">
                    <div class="modal-body">
                        <div id="div-update-msg">
                            <div id="icon-update-msg" class="glyphicon glyphicon-chevron-right"></div>
                            <span id="text-update-msg">Update your account.</span>
                        </div>
                        <input id="update_firstName" class="form-control" type="text" name="firstName"
                               placeholder="${user.firstName}">
                        <input id="update_lastName" class="form-control" type="text" name="lastName"
                               placeholder="${user.lastName}">
                        <select id="update_gender" class="form-control" name="gender">
                            <option value="male" class="form-control update_option"
                                    <c:if test="${user.gender=='male'}">selected</c:if>>Male
                            </option>
                            <option value="female" class="form-control update_option"
                                    <c:if test="${user.gender=='female'}">selected</c:if>>Female
                            </option>
                        </select>
                    </div>
                    <div class="modal-footer">
                        <div>
                            <input type="submit" class="btn btn-primary btn-lg btn-block" value="Update">
                        </div>
                        <div>
                            <button id="update_reset_btn" type="button" class="btn btn-link">Reset password</button>
                            <button id="update_upload_btn" type="button" class="btn btn-link">Upload</button>
                            <button id="update_link_btn" type="button" class="btn btn-link">Link a picture</button>
                        </div>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>
                <!-- End | Update Form -->

                <!-- Begin | Upload Form -->
                <form id="upload-form" action="/uploadOneFile" style="display:none;" method="POST"
                      enctype="multipart/form-data">
                    <div class="modal-body">
                        <div id="div-upload-msg">
                            <div id="icon-upload-msg" class="glyphicon glyphicon-chevron-right"></div>
                            <span id="text-upload-msg">Upload new profile picture.</span>
                        </div>
                        <input id="upload_file" class="form-control" type="file" name="file" required>
                    </div>
                    <div class="modal-footer">
                        <div>
                            <input type="submit" class="btn btn-primary btn-lg btn-block" value="Upload">
                        </div>
                        <div>
                            <button id="upload_reset_btn" type="button" class="btn btn-link">Reset password</button>
                            <button id="upload_update_btn" type="button" class="btn btn-link">Update</button>
                            <button id="upload_link_btn" type="button" class="btn btn-link">Link a picture</button>
                        </div>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>
                <!--End | Upload Form -->

                <!-- Begin | Link Form -->
                <form id="link-form" action="/update" style="display:none;" method="POST" enctype="multipart/form-data">
                    <div class="modal-body">
                        <div id="div-link-msg">
                            <div id="icon-link-msg" class="glyphicon glyphicon-chevron-right"></div>
                            <span id="text-link-msg">Link a new profile picture.</span>
                        </div>
                        <input id="link_file" class="form-control" type="text" name="profileImage"
                               placeholder="${user.profileImage}">
                    </div>
                    <div class="modal-footer">
                        <div>
                            <input type="submit" class="btn btn-primary btn-lg btn-block" value="Update">
                        </div>
                        <div>
                            <button id="link_reset_btn" type="button" class="btn btn-link">Reset password</button>
                            <button id="link_update_btn" type="button" class="btn btn-link">Update</button>
                            <button id="link_upload_btn" type="button" class="btn btn-link">Upload</button>
                        </div>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>
                <!--End | Link Form -->

            </div>
            <!-- End # DIV Form -->

        </div>
    </div>
</div>
<script>

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
</script>

</body>
</html>
