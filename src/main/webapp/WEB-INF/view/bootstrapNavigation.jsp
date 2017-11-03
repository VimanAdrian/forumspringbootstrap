<%--
  Created by IntelliJ IDEA.
  User: viorelv
  Date: 09-Oct-17
  Time: 10:25 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>

        @import url(http://fonts.googleapis.com/css?family=Roboto);

        * {
            font-family: 'Roboto', sans-serif;
        }

        #login-modal .modal-dialog {
            width: 350px;
        }

        #login-modal input[type=text], input[type=password] {
            margin-top: 10px;
        }

        #div-login-msg,
        #div-lost-msg,
        #div-register-msg {
            border: 1px solid #dadfe1;
            height: 30px;
            line-height: 28px;
            transition: all ease-in-out 500ms;
        }

        #div-login-msg.success,
        #div-lost-msg.success,
        #div-register-msg.success {
            border: 1px solid #68c3a3;
            background-color: #c8f7c5;
        }

        #div-login-msg.error,
        #div-lost-msg.error,
        #div-register-msg.error {
            border: 1px solid #eb575b;
            background-color: #ffcad1;
        }

        #icon-login-msg,
        #icon-lost-msg,
        #icon-register-msg {
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
        #icon-register-msg.success {
            background-color: #68c3a3 !important;
        }

        #icon-login-msg.error,
        #icon-lost-msg.error,
        #icon-register-msg.error {
            background-color: #eb575b !important;
        }

        #img_logo {
            max-height: 100px;
            max-width: 100px;
        }

        .modal-backdrop.in {
            filter: alpha(opacity=50);
            opacity: .8;
        }

        .modal-content {
            background-color: #ececec;
            border: 1px solid #bdc3c7;
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

        #register_gender {
            margin-top: 10px;
        }

        .register_option {
            max-width: 318px;
            overflow: hidden;
        }

        @media screen and (min-width: 1024px) {
            #register_gender {
                overflow: hidden;
            }

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

        .navbar-default {
            background-color: #607d8b;
            border-color: #78909c;
        }

        .navbar-default .navbar-brand {
            color: #eceff1;
        }

        .navbar-default .navbar-brand:hover,
        .navbar-default .navbar-brand:focus {
            color: #cfd8dc;
        }

        .navbar-default .navbar-text {
            color: #eceff1;
        }

        .navbar-default .navbar-nav > li > a {
            color: #eceff1;
        }

        .navbar-default .navbar-nav > li > a:hover,
        .navbar-default .navbar-nav > li > a:focus {
            color: #cfd8dc;
        }

        .navbar-default .navbar-nav > li > .dropdown-menu {
            background-color: #607d8b;
        }

        .navbar-default .navbar-nav > li > .dropdown-menu > li > a {
            color: #eceff1;
        }

        .navbar-default .navbar-nav > li > .dropdown-menu > li > a:hover,
        .navbar-default .navbar-nav > li > .dropdown-menu > li > a:focus {
            color: #cfd8dc;
            background-color: #78909c;
        }

        .navbar-default .navbar-nav > li > .dropdown-menu > li.divider {
            background-color: #78909c;
        }

        .navbar-default .navbar-nav .open .dropdown-menu > .active > a,
        .navbar-default .navbar-nav .open .dropdown-menu > .active > a:hover,
        .navbar-default .navbar-nav .open .dropdown-menu > .active > a:focus {
            color: #cfd8dc;
            background-color: #78909c;
        }

        .navbar-default .navbar-nav > .active > a,
        .navbar-default .navbar-nav > .active > a:hover,
        .navbar-default .navbar-nav > .active > a:focus {
            color: #cfd8dc;
            background-color: #78909c;
        }

        .navbar-default .navbar-nav > .open > a,
        .navbar-default .navbar-nav > .open > a:hover,
        .navbar-default .navbar-nav > .open > a:focus {
            color: #cfd8dc;
            background-color: #78909c;
        }

        .navbar-default .navbar-toggle {
            border-color: #78909c;
        }

        .navbar-default .navbar-toggle:hover,
        .navbar-default .navbar-toggle:focus {
            background-color: #78909c;
        }

        .navbar-default .navbar-toggle .icon-bar {
            background-color: #eceff1;
        }

        .navbar-default .navbar-collapse,
        .navbar-default .navbar-form {
            border-color: #eceff1;
        }

        .navbar-default .navbar-link {
            color: #eceff1;
        }

        .navbar-default .navbar-link:hover {
            color: #cfd8dc;
        }

        @media (max-width: 767px) {
            .navbar-default .navbar-nav .open .dropdown-menu > li > a {
                color: #eceff1;
            }

            .navbar-default .navbar-nav .open .dropdown-menu > li > a:hover,
            .navbar-default .navbar-nav .open .dropdown-menu > li > a:focus {
                color: #cfd8dc;
            }

            .navbar-default .navbar-nav .open .dropdown-menu > .active > a,
            .navbar-default .navbar-nav .open .dropdown-menu > .active > a:hover,
            .navbar-default .navbar-nav .open .dropdown-menu > .active > a:focus {
                color: #cfd8dc;
                background-color: #78909c;
            }
        }

        .modal .modal-content {
            background-color: #FFFFFF;
        }
    </style>
    <title>Navigation</title>
</head>
<body>
<!-- TopNavigation navbar navbar-inverse -->
<nav class="navbar navbar-default navbar-static-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">MemoryLeak</a>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav navbar-left">
                <li><a href="http://localhost:8080/post?search&browse&page=0">Browse</a></li>
                <sec:authorize access="isAuthenticated()">
                    <li><a href="http://localhost:8080/newPost">Ask a question</a></li>
                </sec:authorize>
                <sec:authorize access="hasRole('ROLE_ADMIN')">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">Admin<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="http://localhost:8080/post?disabled=on&search&browse&page=0">Disabled
                            questions</a>
                        </li>
                        <li><a href="http://localhost:8080/admin/users?page=0">Users</a></li>
                    </ul>
                    </sec:authorize>
            </ul>
            <form class="navbar-form navbar-right" id="searchForm" role="search" action="/post" method="GET">
                <div class="form-group input-group">
                    <input type="text" class="form-control" name="search" placeholder="Search..">
                    <span class="input-group-btn">
                    <button class="btn btn-default" id="searchButton" type="button">
                       <span class="glyphicon glyphicon-search"></span>
                    </button>
                  </span>
                </div>
                <input type="hidden" name="page" value="0">
            </form>
            <script>
                $("#searchButton").click(function () {
                    $("#searchForm").submit();
                });
            </script>
            <ul class="nav navbar-nav navbar-right">
                <sec:authorize access="isAnonymous()">
                    <li><a href="#" class="" role="button" data-toggle="modal" data-target="#login-modal"><span
                            class="glyphicon glyphicon-log-in"></span> Login</a></li>
                </sec:authorize>
                <sec:authorize access="isAuthenticated()">
                    <li><a href="javascript:formSubmit()" class="" role="button"><span
                            class="glyphicon glyphicon-log-out"></span> Logout</a></li>
                    <c:url value="/logout" var="logoutUrl"/>
                    <form action="${logoutUrl}" method="post" id="logoutForm" style="display: none;">
                        <input type="hidden" name="${_csrf.parameterName}"
                               value="${_csrf.token}"/>
                    </form>
                    <script>
                        function formSubmit() {
                            document.getElementById("logoutForm").submit();
                        }
                    </script>
                </sec:authorize>
            </ul>
        </div>
    </div>
</nav>
<!-- END TopNavigation -->

<!-- Modal -->
<div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
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
            <div id="div-forms">

                <!-- Begin # Login Form -->
                <form id="login-form" action="/login_check" method="POST">
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
                            <button id="login_lost_btn" type="button" class="btn btn-link">Lost Password?</button>
                            <button id="login_register_btn" type="button" class="btn btn-link">Register</button>
                        </div>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>
                <!-- End # Login Form -->

                <!-- Begin | Lost Password Form -->
                <form id="lost-form" style="display:none;" action="/forgotPassword" method="POST">
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

                <!-- Begin | Register Form -->
                <form id="register-form" style="display:none;" action="/register" method="POST">
                    <div class="modal-body">
                        <div id="div-register-msg">
                            <div id="icon-register-msg" class="glyphicon glyphicon-chevron-right"></div>
                            <span id="text-register-msg">Register an account.</span>
                        </div>
                        <input id="register_username" class="form-control" type="text" name="username"
                               placeholder="Username" required>
                        <input id="register_email" class="form-control" type="text" name="email"
                               placeholder="E-Mail" required>
                        <input id="register_password" class="form-control" type="password" name="password"
                               placeholder="Password" required>
                        <input id="register_password2" class="form-control" type="password" name="password2"
                               placeholder="Password" required>
                        <input id="register_firstName" class="form-control" type="text" name="firstName"
                               placeholder="First name">
                        <input id="register_lastName" class="form-control" type="text" name="lastName"
                               placeholder="Last name">
                        <select id="register_gender" class="form-control" name="gender">
                            <option value="placeholder" disabled selected hidden>Gender</option>
                            <option value="male" class="form-control register_option">Male</option>
                            <option value="female" class="form-control register_option">Female</option>
                        </select>
                    </div>
                    <div class="modal-footer">
                        <div>
                            <input type="submit" class="btn btn-primary btn-lg btn-block" value="Register">
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

            </div>
            <!-- End # DIV Form -->

        </div>
    </div>
</div>
<script>

    $(function () {
        var $formLogin = $('#login-form');
        var $formLost = $('#lost-form');
        var $formRegister = $('#register-form');
        var $divForms = $('#div-forms');
        var $modalAnimateTime = 300;
        var $msgAnimateTime = 150;
        var $msgShowTime = 2000;
        if ("${modal}") {
            if ("${loginFailure}")
                msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "error", "glyphicon-remove", "${loginFailure}");
            if ("${logoutSuccess}")
                msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "success", "glyphicon-ok", "${logoutSuccess}");
            if ("${resetSuccess}")
                msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "success", "glyphicon-ok", "${resetSuccess}");
            if ("${resetFailure}")
                msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "error", "glyphicon-remove", "${resetFailure}");
            if ("${sendSuccess}")
                msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "success", "glyphicon-ok", "${sendSuccess}");
            if ("${sendFailure}")
                msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "error", "glyphicon-remove", "${sendFailure}");
            if ("${registerSuccess}")
                msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "success", "glyphicon-ok", "${registerSuccess}");
            if ("${registerFailure}")
                msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "error", "glyphicon-remove", "${registerFailure}");
            $("#login-modal").modal('show');
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
<!-- End Modal -->
<jsp:include page="bootstrapFooter.jsp"/>
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
</body>
</html>
