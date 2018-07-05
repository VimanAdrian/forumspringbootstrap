<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>

    @import url(http://fonts.googleapis.com/css?family=Roboto);

    * {
        font-family: 'Roboto', sans-serif;
    }

    .modal-dialog {
        margin: auto;
        margin-top: 40px;
    }

    #login-modal .modal-dialog {
        width: 350px;
    }

    #login-modal input[type=text], input[type=password] {
        margin-top: 10px;
    }

    #div-login-msg,
    #div-lost-msg,
    #div-register-msg,
    #div-reset-msg,
    #div-resend-msg,
    #div-update-user-msg {
        border: 1px solid #dadfe1;
        height: 30px;
        line-height: 28px;
        transition: all ease-in-out 500ms;
    }

    #div-login-msg.success,
    #div-lost-msg.success,
    #div-register-msg.success,
    #div-reset-msg.success,
    #div-resend-msg.success,
    #div-update-user-msg.success {
        border: 1px solid #68c3a3;
        background-color: #c8f7c5;
    }

    #div-login-msg.error,
    #div-lost-msg.error,
    #div-register-msg.error,
    #div-reset-msg.error,
    #div-resend-msg.error,
    #div-update-user-msg.er

    ]
    {
        border: 1px solid #eb575b
    ;
        background-color: #ffcad1
    ;
    }

    #div-login-msg.info,
    #div-lost-msg.info,
    #div-register-msg.info,
    #div-reset-msg.info,
    #div-resend-msg.info,
    #div-update-user-msg.info {
        border: 1px solid #31708f;
        background-color: #bce8f1;
    }

    #icon-login-msg,
    #icon-lost-msg,
    #icon-register-msg,
    #icon-reset-msg,
    #icon-resend-msg,
    #icon-update-user-msg {
        width: 30px;
        float: left;
        line-height: 28px;
        text-align: center;
        background-color: #dadfe1;
        margin-right: 5px;
        transition: all ease-in-out 500ms;
    }

    #icon-login-msg.success,
    #icon-lost-msg.success,
    #icon-register-msg.success,
    #icon-reset-msg.success,
    #icon-resend-msg.success,
    #icon-update-user-msg.success {
        background-color: #68c3a3 !important;
    }

    #icon-login-msg.error,
    #icon-lost-msg.error,
    #icon-register-msg.error,
    #icon-reset-msg.error,
    #icon-resend-msg.error,
    #icon-update-user-msg.error {
        background-color: #eb575b !important;
    }

    #icon-login-msg.info,
    #icon-lost-msg.info,
    #icon-register-msg.info,
    #icon-reset-msg.info,
    #icon-resend-msg.info,
    #icon-update-user-msg.info {
        background-color: #337ab7 !important;
    }

    #img_logo {
        max-height: 100px;
        max-width: 100px;
        border-radius: 0px;
    }

    .modal-backdrop.in {
        filter: alpha(opacity=50);
        opacity: .8;
    }

    .modal-content {
        background-color: white;
        border: 1px solid white;
        border-radius: 0px;
        outline: 0;
    }

    .modal-header {
        min-height: 16.43px;
        padding: 15px 15px 15px 15px;
        border-bottom: 0px;
    }

    .modal-body {
        position: relative;
        padding: 5px 15px 5px 15px;
    }

    .modal-footer {
        padding: 15px 15px 15px 15px;
        text-align: left;
        border-top: 0px;
    }

    .checkbox {
        margin-bottom: 0px;
    }

    .btn {
        border-radius: 0px;
    }

    .btn:focus,
    .btn:active:focus,
    .btn.active:focus,
    .btn.focus,
    .btn:active.focus,
    .btn.active.focus {
        outline: none;
    }

    .btn-lg, .btn-group-lg > .btn {
        border-radius: 0px;
    }

    .btn-link {
        padding: 5px 10px 0px 0px;
        color: #95a5a6;
    }

    .btn-link:hover, .btn-link:focus {
        color: #2c3e50;
        text-decoration: none;
    }

    .glyphicon {
        top: 0px;
    }

    .form-control {
        border-radius: 0px;
    }

    .register_option {
        max-width: 318px;
        overflow: hidden;
    }

    @media screen and (min-width: 1024px) {
        .register_option {
            width: 318px !important;
            max-width: 318px;
            overflow: hidden;
        }
    }

    @media screen and (max-width: 480px) {
        #login-modal .modal-dialog {
            width: 95%;
        }
    }

    .navbar-brand {
        background-image: url("${pageContext.request.contextPath}/resources/images/logo-only.png");
        background-repeat: no-repeat;
        background-size: contain; /* Make the image cover the td */
        background-position: 50%; /* Center the image inside the td */
        height: 60px;
        width: 100px;
    }

    .well {
        border-radius: 0px;
    }

    #register_email:invalid,
    #register_firstName:invalid,
    #register_lastName:invalid,
    #register_username:invalid,
    #register_password:invalid,
    #register_password2:invalid,
    #register_profileImage:invalid,
    #update_user_firstName:invalid,
    #update_user_lastName:invalid,
    #update_user_profileImage:invalid {
        border-color: red;
    }

    #register_email:valid,
    #register_firstName:valid,
    #register_lastName:valid,
    #register_username:valid,
    #register_password:valid,
    #register_password2:valid,
    #register_profileImage:valid,
    #update_user_firstName:valid,
    #update_user_lastName:valid,
    #update_user_profileImage:valid {
        border-color: #ccc;
    }

    .navbar-offline {
        background-color: #f39c12 !important;
    }
</style>
<nav class="navbar navbar-default navbar-static-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="${pageContext.request.contextPath}/"></a>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav navbar-left">
                <li><a role="button" class="btn-warning show-offline" id="offlineHelpButton" style="display: none;">Help?</a>
                </li>
                <li><a class="hide-offline"
                       href="${pageContext.request.contextPath}/browse?page=0&size=20&searchingFor=question">Browse</a>
                </li>
                <sec:authorize access="isAuthenticated()">
                    <li><a class="hide-offline" href="${pageContext.request.contextPath}/newQuestion">Ask a question</a>
                    </li>
                </sec:authorize>
                <sec:authorize access="isAuthenticated()">
                    <li><a class="hide-offline" href="${pageContext.request.contextPath}/newClass">Start a new class</a>
                    </li>
                </sec:authorize>
            </ul>
            <form class="navbar-form navbar-right hide-offline" id="searchForm" role="search"
                  action="${pageContext.request.contextPath}/search" method="GET">
                <div class="form-group input-group">
                    <input type="text" class="form-control" name="search" placeholder="Search..">
                    <span class="input-group-btn">
                    <button class="btn btn-default" id="searchButton" type="button">
                       <span class="glyphicon glyphicon-search"></span>
                    </button>
                  </span>
                </div>
                <input type="hidden" name="page" value="0">
                <input type="hidden" name="size" value="20">
                <input type="hidden" name="searchFor" value="question" id="formSearchFor">
            </form>
            <script>
                $("#searchButton").click(function () {
                    $("#searchForm").submit();
                });
            </script>
            <ul class="nav navbar-nav navbar-right hide-offline">
                <sec:authorize access="isAnonymous()">
                    <li><a href="#${pageContext.request.contextPath}/" class="" role="button" data-toggle="modal"
                           data-target="#login-modal"><span
                            class="glyphicon glyphicon-log-in"></span> Login</a></li>
                </sec:authorize>
                <sec:authorize access="isAuthenticated()">
                    <li><a role="button" data-toggle="modal" data-target="#login-modal" id="updateButton"><span
                            class="glyphicon glyphicon-user"></span> Update account</a></li>
                    <li><a role="button" id="logoutButton"><span class="glyphicon glyphicon-log-out"></span> Logout</a>
                    </li>
                    <form action="${pageContext.request.contextPath}/logout" method="post" id="logoutForm"
                          style="display: none;">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </form>
                </sec:authorize>
            </ul>
        </div>
    </div>
</nav>
<!-- END TopNavigation -->

<!-- Modal -->
<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="offline-info-label" aria-hidden="true"
     id="offline-info">
    <div class="modal-dialog modal-sm">
        <div class="modal-content offline-info-confirmation-modal">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="offline-info-label">Your browser appears to be offline.</h4>
            </div>
            <div class="modal-body">
                While you are offline you can still visit some pages, namely question, class and lecture pages,
                and they will appear like they did the last time you were online. While you can still visit
                those pages, and read the content's, you cannot interact with the content (eg: upvote, downvote, edit).
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
     style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" align="center">
                <img class="img-circle" id="img_logo" src="/resources/images/logo-only.png">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
                </button>
            </div>

            <!-- Begin # DIV Form -->
            <div id="div-forms">
                <sec:authorize access="isAnonymous()">
                    <!-- Begin # Login Form -->
                    <form id="login-form" action="${pageContext.request.contextPath}/login_check" method="POST">
                        <div class="modal-body">
                            <div id="div-login-msg">
                                <div id="icon-login-msg" class="glyphicon glyphicon-chevron-right"></div>
                                <span id="text-login-msg">Type your username and password.</span>
                            </div>
                            <input id="login_username" class="form-control" type="text"
                                   name="username" placeholder="Username" required autofocus>
                            <input id="login_password" class="form-control" type="password" name="password"
                                   placeholder="Password" required>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="remember-me"> Remember me
                                </label>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <div>
                                <input type="submit" class="btn btn-primary btn-lg btn-block" value="Login"/>
                            </div>
                            <div>
                                <button id="login_register_btn" type="button" class="btn btn-link">Register</button>
                                <button id="login_lost_btn" type="button" class="btn btn-link">Lost Password?</button>
                            </div>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </form>
                    <!-- End # Login Form -->
                </sec:authorize>
                <sec:authorize access="isAnonymous()">
                    <!-- Begin | Lost Password Form -->
                    <form id="lost-form" style="display:none;"
                          action="${pageContext.request.contextPath}/forgotPassword"
                          method="POST">
                        <div class="modal-body">
                            <div id="div-lost-msg">
                                <div id="icon-lost-msg" class="glyphicon glyphicon-chevron-right"></div>
                                <span id="text-lost-msg">Type your username.</span>
                            </div>
                            <input id="lost_username" class="form-control" type="text" name="username"
                                   placeholder="Username" required>
                        </div>
                        <div class="modal-footer">
                            <div>
                                <input type="submit" class="btn btn-primary btn-lg btn-block" value="Send">
                            </div>
                            <div>
                                <button id="lost_login_btn" type="button" class="btn btn-link">Log In</button>
                                <button id="lost_register_btn" type="button" class="btn btn-link">Register</button>
                            </div>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </form>
                    <!-- End | Lost Password Form -->
                </sec:authorize>
                <sec:authorize access="isAnonymous()">
                    <!-- Begin | Register Form -->
                    <form id="register-form" style="display:none;" action="${pageContext.request.contextPath}/register"
                          method="POST" class="form-horizontal">
                        <div class="modal-body">
                            <div id="div-register-msg">
                                <div id="icon-register-msg" class="glyphicon glyphicon-chevron-right"></div>
                                <span id="text-register-msg">Register an account.</span>
                            </div>
                            <input id="register_username" class="form-control" type="text" name="username"
                                   placeholder="Username" required pattern="[A-Za-z0-9_]{4,32}"
                                   title="Your username must be 4-32 characters long and only contain alphanumeric characters.">
                            <input id="register_email" class="form-control" type="text" name="email"
                                   placeholder="E-Mail" required
                                   pattern='[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*'
                                   title="You should insert a valid email address.">
                            <input id="register_password" class="form-control" type="password" name="password"
                                   placeholder="Password" required pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{4,32}"
                                   title="Your password must be 4-32 characters long, and must include one upper case letter, one lower case letter, and one numeric digit.">
                            <input id="register_password2" class="form-control" type="password"
                                   name="confirmationPassword"
                                   placeholder="Password" required pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{4,32}"
                                   title="Your password must be between 4 and 32 characters long, and must include at least one upper case letter, one lower case letter, and one numeric digit.">
                            <input id="register_firstName" class="form-control" type="text" name="firstName"
                                   placeholder="First name" required pattern="[a-zA-Z ,.'-]+">
                            <input id="register_lastName" class="form-control" type="text" name="lastName"
                                   placeholder="Last name" required pattern="[a-zA-Z ,.'-]+">
                            <input id="register_profileImage" class="form-control" type="text" name="profileImage"
                                   placeholder="Profile image link" pattern="(https?:\/\/.*\.(?:png|jpg|jpeg|gif))"
                                   title="Your profile image should be a .png, .jpg, .jpeg of .gif">
                        </div>
                        <div class="modal-footer">
                            <div>
                                <input id="register-submit" type="submit" class="btn btn-primary btn-lg btn-block"
                                       value="Register">
                            </div>
                            <div>
                                <button id="register_login_btn" type="button" class="btn btn-link">Log In</button>
                                <button id="register_lost_btn" type="button" class="btn btn-link">Lost Password?
                                </button>
                            </div>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </form>
                    <!-- End | Register Form -->
                </sec:authorize>
                <!-- Begin | Reset Form -->
                <sec:authorize access="isAnonymous()">
                    <form id="reset-form" style="display:none;"
                          action="${pageContext.request.contextPath}/resetPassword"
                          method="POST">
                        <div class="modal-body">
                            <div id="div-reset-msg">
                                <div id="icon-reset-msg" class="glyphicon glyphicon-chevron-right"></div>
                                <span id="text-reset-msg">Reset your password.</span>
                            </div>
                            <input id="reset_password" class="form-control" type="password" name="password"
                                   placeholder="Password" required>
                            <input id="reset_password2" class="form-control" type="password" name="confirmationPassword"
                                   placeholder="Password" required>
                        </div>
                        <div class="modal-footer">
                            <div>
                                <input type="submit" class="btn btn-primary btn-lg btn-block" value="Reset">
                            </div>
                            <div>
                                <button id="reset_login_btn" type="button" class="btn btn-link">Log In</button>
                                <button id="reset_register_btn" type="button" class="btn btn-link">Register</button>
                                <button id="reset_lost_btn" type="button" class="btn btn-link">Lost Password?</button>
                            </div>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <input type="hidden" name="userId" value="${userID}"/>
                    </form>
                    <!-- End | Reset Form -->
                </sec:authorize>
                <sec:authorize access="isAnonymous()">
                    <!-- Begin | Resend Form -->
                    <form id="resend-form" style="display:none;" action="${pageContext.request.contextPath}/resendToken"
                          method="POST">
                        <div class="modal-body">
                            <div id="div-resend-msg">
                                <div id="icon-resend-msg" class="glyphicon glyphicon-chevron-right"></div>
                                <span id="text-resend-msg">Send a new token</span>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <div>
                                <input type="submit" class="btn btn-primary btn-lg btn-block" value="Send">
                            </div>
                            <div>
                                <button id="resend_login_btn" type="button" class="btn btn-link">Log In</button>
                                <button id="resend_register_btn" type="button" class="btn btn-link">Register</button>
                                <button id="resend_lost_btn" type="button" class="btn btn-link">Lost Password?</button>
                            </div>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <input type="hidden" name="userId" value="${userID}"/>
                    </form>
                </sec:authorize>
                <!-- End | Resend Form -->
                <!-- Begin | Update User Form -->
                <sec:authorize access="isAuthenticated()">
                    <form id="update-user-form" action="${pageContext.request.contextPath}/updateUser"
                          method="POST" class="form-horizontal">
                        <div class="modal-body">
                            <div id="div-update-user-msg">
                                <div id="icon-update-user-msg" class="glyphicon glyphicon-chevron-right"></div>
                                <span id="text-update-user-msg">Update your account.</span>
                            </div>
                            <input id="update_user_firstName" class="form-control" type="text" name="firstName"
                                   placeholder="First name" required pattern="[a-zA-Z ,.'-]+"
                                   value="<c:out value='${user.firstName}'/>">
                            <input id="update_user_lastName" class="form-control" type="text" name="lastName"
                                   placeholder="Last name" required pattern="[a-zA-Z ,.'-]+"
                                   value="<c:out value='${user.lastName}'/>">
                            <input id="update_user_profileImage" class="form-control" type="text" name="profileImage"
                                   placeholder="Profile image link" pattern="(https?:\/\/.*\.(?:png|jpg|jpeg|gif))"
                                   title="Your profile image should be a .png, .jpg, .jpeg of .gif"
                                   value="<c:out value='http://localhost:8080${user.profileImage}'/>">
                        </div>
                        <div class="modal-footer">
                            <div>
                                <input id="update-user-submit" type="submit" class="btn btn-primary btn-lg btn-block"
                                       value="Update">
                            </div>
                            <div>
                            </div>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </form>
                </sec:authorize>

            </div>

            <!-- End # DIV Form -->
        </div>
    </div>
</div>
<!-- End Modal -->
<script>

    var $formLogin = $('#login-form');
    var $formLost = $('#lost-form');
    var $formRegister = $('#register-form');
    var $formReset = $('#reset-form');
    var $formResend = $('#resend-form');
    var $formUpdate = $("#update-user-form");
    var $divForms = $('#div-forms');
    var $modalAnimateTime = 300;
    var $msgAnimateTime = 150;
    var $msgShowTime = 2000;
    <sec:authorize access="isAnonymous()">
    $('#login-form').submit(function () {
        $theForm = $(this);
        $.ajax({
            type: $theForm.attr('method'),
            url: $theForm.attr('action'),
            data: $theForm.serialize(),
            success: function (data) {
                var url = window.location.href;
                if (url.match("${pageContext.request.contextPath}/activate?"))
                    window.location.replace("${pageContext.request.contextPath}/");
                else
                    location.reload(true);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                if (jqXHR.status === 401)
                    msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "error", "glyphicon-remove", "Invalid username or password!");
                else if (jqXHR.status === 417)
                    msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "error", "glyphicon-remove", "You account is locked!");
                else
                    msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "error", "glyphicon-remove", "Something went wrong!");
            },
            beforeSend: function () {
                msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "info", "glyphicon-refresh", "Please wait!");
            }
        });
        return false;
    });

    $('#register-form').submit(function () {
        $theForm = $(this);
        $.ajax({
            type: $theForm.attr('method'),
            url: $theForm.attr('action'),
            data: $theForm.serialize(),
            success: function (data) {
                if (data == 1) {
                    modalAnimate($formRegister, $formLogin);
                    msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "success", "glyphicon-ok", "You've been registered successfully!");
                } else if (data == -1) {
                    msgChange($('#div-register-msg'), $('#icon-register-msg'), $('#text-register-msg'), "error", "glyphicon-remove", "Invalid field!");
                } else if (data == -2) {
                    msgChange($('#div-register-msg'), $('#icon-register-msg'), $('#text-register-msg'), "error", "glyphicon-remove", "Email address already registered!");
                } else if (data == -3) {
                    msgChange($('#div-register-msg'), $('#icon-register-msg'), $('#text-register-msg'), "error", "glyphicon-remove", "Username already registered!");
                } else {
                    msgChange($('#div-register-msg'), $('#icon-register-msg'), $('#text-register-msg'), "error", "glyphicon-remove", "Register failed!");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                msgChange($('#div-register-msg'), $('#icon-register-msg'), $('#text-register-msg'), "error", "glyphicon-remove", "Something went wrong!");
                console.log(errorThrown);
            },
            beforeSend: function () {
                msgChange($('#div-register-msg'), $('#icon-register-msg'), $('#text-register-msg'), "info", "glyphicon-refresh", "Please wait!");
            }
        });
        return false;
    });

    $('#lost-form').submit(function () {
        $theForm = $(this);
        $.ajax({
            type: $theForm.attr('method'),
            url: $theForm.attr('action'),
            data: $theForm.serialize(),
            success: function (data) {
                if (data) {
                    modalAnimate($formLost, $formLogin);
                    msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "success", "glyphicon-ok", "An email has been sent!");
                } else {
                    msgChange($('#div-lost-msg'), $('#icon-lost-msg'), $('#text-lost-msg'), "error", "glyphicon-remove", "An email could not be sent!");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                msgChange($('#div-lost-msg'), $('#icon-lost-msg'), $('#text-lost-msg'), "error", "glyphicon-remove", "Something went wrong!");
                console.log(errorThrown);
            },
            beforeSend: function () {
                msgChange($('#div-lost-msg'), $('#icon-lost-msg'), $('#text-lost-msg'), "info", "glyphicon-refresh", "Please wait!");
            }
        });
        return false;
    });

    $('#reset-form').submit(function () {
        $theForm = $(this);
        $.ajax({
            type: $theForm.attr('method'),
            url: $theForm.attr('action'),
            data: $theForm.serialize(),
            success: function (data) {
                if (data) {
                    modalAnimate($formReset, $formLogin);
                    msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "success", "glyphicon-ok", "Reset successfull!");
                    setTimeout(function () {
                        window.location.replace("${pageContext.request.contextPath}/login");
                    }, 1000);
                } else {
                    msgChange($('#div-reset-msg'), $('#icon-reset-msg'), $('#text-reset-msg'), "error", "glyphicon-remove", "Reset unsuccessfull!");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                msgChange($('#div-reset-msg'), $('#icon-reset-msg'), $('#text-reset-msg'), "error", "glyphicon-remove", "Something went wrong!");
                console.log(errorThrown);
            },
            beforeSend: function () {
                msgChange($('#div-reset-msg'), $('#icon-reset-msg'), $('#text-reset-msg'), "info", "glyphicon-refresh", "Please wait!");
            }
        });
        return false;
    });

    $('#resend-form').submit(function () {
        $theForm = $(this);
        $.ajax({
            type: $theForm.attr('method'),
            url: $theForm.attr('action'),
            data: $theForm.serialize(),
            success: function (data) {
                if (data) {
                    modalAnimate($formResend, $formLogin);
                    msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "success", "glyphicon-ok", "Token sent successfully!");
                    setTimeout(function () {
                        window.location.replace("${pageContext.request.contextPath}/login");
                    }, 1000);
                } else {
                    msgChange($('#div-resend-msg'), $('#icon-resend-msg'), $('#text-resend-msg'), "error", "glyphicon-remove", "Token failed to send!");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                msgChange($('#div-resend-msg'), $('#icon-resend-msg'), $('#text-resend-msg'), "error", "glyphicon-remove", "Something went wrong!");
                console.log(errorThrown);
            },
            beforeSend: function () {
                msgChange($('#div-resend-msg'), $('#icon-resend-msg'), $('#text-resend-msg'), "info", "glyphicon-refresh", "Please wait!");
            }
        });
        return false;
    });
    </sec:authorize>

    <sec:authorize access="isAuthenticated()">

    $('#update-user-form').submit(function () {
        $theForm = $(this);
        $.ajax({
            type: $theForm.attr('method'),
            url: $theForm.attr('action'),
            data: $theForm.serialize(),
            success: function (data) {
                if (data == 1) {
                    msgChange($('#div-update-user-msg'), $('#icon-update-user-msg'), $('#text-update-user-msg'), "success", "glyphicon-ok", "Account updated successfully!");
                    setTimeout(function () {
                        location.reload(true);
                    }, 1000);
                } else if (data == -1) {
                    msgChange($('#div-update-user-msg'), $('#icon-update-user-msg'), $('#text-update-user-msg'), "error", "glyphicon-remove", "Invalid field!");
                } else {
                    msgChange($('#div-update-user-msg'), $('#icon-update-user-msg'), $('#text-update-user-msg'), "error", "glyphicon-remove", "Update failed!");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                msgChange($('#div-update-user-msg'), $('#icon-update-user-msg'), $('#text-update-user-msg'), "error", "glyphicon-remove", "Something went wrong!");
                console.log(errorThrown);
            },
            beforeSend: function () {
                msgChange($('#div-update-user-msg'), $('#icon-update-user-msg'), $('#text-update-user-msg'), "info", "glyphicon-refresh", "Please wait!");
            }
        });
        return false;
    });


    $("#logoutButton").click(function () {
        $theForm = $("#logoutForm");
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
    });
    </sec:authorize>

    checkModal();

    function checkModal() {
        <c:if test="${modal==true}">
        $("#login-modal").modal('show');
        <c:if test="${validToken==1}">
        modalAnimate($formLogin, $formReset);
        msgChange($('#div-reset-msg'), $('#icon-reset-msg'), $('#text-reset-msg'), "info", "glyphicon-refresh", "Insert your new password!");
        </c:if>
        <c:if test="${validToken==0}">
        modalAnimate($formLogin, $formReset);
        msgChange($('#div-reset-msg'), $('#icon-reset-msg'), $('#text-reset-msg'), "error", "glyphicon-remove", "Invalid token!");
        </c:if>
        <c:if test="${activationSuccess!=null && activationSuccess==true}">
        msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "success", "glyphicon-ok", "Account activated successfully!");
        </c:if>
        <c:if test="${activationSuccess!=null && activationSuccess==false}">
        modalAnimate($formLogin, $formResend);
        msgChange($('#div-resend-msg'), $('#icon-resend-msg'), $('#text-resend-msg'), "error", "glyphicon-remove", "Account activation failed!");
        </c:if>
        </c:if>
    }

    $('#login_register_btn').click(function () {
        modalAnimate($formLogin, $formRegister)
    });
    $('#register_login_btn').click(function () {
        modalAnimate($formRegister, $formLogin);
    });
    $('#login_lost_btn').click(function () {
        modalAnimate($formLogin, $formLost);
    });
    $('#lost_login_btn').click(function () {
        modalAnimate($formLost, $formLogin);
    });
    $('#lost_register_btn').click(function () {
        modalAnimate($formLost, $formRegister);
    });
    $('#register_lost_btn').click(function () {
        modalAnimate($formRegister, $formLost);
    });
    $('#reset_login_btn').click(function () {
        modalAnimate($formReset, $formLogin);
    });
    $('#reset_lost_btn').click(function () {
        modalAnimate($formReset, $formLost);
    });
    $('#reset_register_btn').click(function () {
        modalAnimate($formReset, $formRegister);
    });
    $('#resend_login_btn').click(function () {
        modalAnimate($formResend, $formLogin);
    });
    $('#resend_lost_btn').click(function () {
        modalAnimate($formResend, $formLost);
    });
    $('#resend_register_btn').click(function () {
        modalAnimate($formResend, $formRegister);
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

    $("#offlineHelpButton").click(function () {
        $("#offline-info").modal("show");
    })
</script>
<script>
    $(document).ready(function () {
        var $window = $(window);
        var $container = $('#mainContent');
        var $brand = $('.navbar-brand');
        var $search = $("#searchForm");

        function checkWidth() {
            var windowsize = $window.width();
            if (windowsize > 1025) {
                var margr = parseInt($container.css("marginLeft"));
                var margl = margr - 30;
                $brand.css("marginLeft", margl);
                $search.css("marginRight", margl);
            }
            if (windowsize < 1025) {
                $brand.css("marginLeft", -15);
                $search.css("marginRight", -15);
            }
            if (windowsize < 768) {
                $brand.css("marginLeft", 0);
            }
        }

        checkWidth();
        $(window).resize(checkWidth);

    });
</script>

