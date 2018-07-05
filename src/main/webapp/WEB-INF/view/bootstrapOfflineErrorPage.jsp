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
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css"/>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/3.3.7/flatly/bootstrap.min.css">
    <link href='https://fonts.googleapis.com/css?family=Anton|Passion+One|PT+Sans+Caption' rel='stylesheet'
          type='text/css'>
    <%--<link rel="stylesheet" href="https://bootswatch.com/3/simplex/bootstrap.css">--%>
    <style>
        * {
            font-family: 'PT Sans Caption', sans-serif, 'arial', 'Times New Roman';
        }

        /* Error Page */
        .error .clip .shadow {
            height: 180px; /*Contrall*/
        }

        .error .clip:nth-of-type(2) .shadow {
            width: 130px; /*Contrall play with javascript*/
        }

        .error .clip:nth-of-type(1) .shadow, .error .clip:nth-of-type(3) .shadow {
            width: 250px; /*Contrall*/
        }

        .error .digit {
            width: 150px; /*Contrall*/
            height: 150px; /*Contrall*/
            line-height: 150px; /*Contrall*/
            font-size: 120px;
            font-weight: bold;
        }

        .error h2 /*Contrall*/
        {
            font-size: 32px;
        }

        .error .msg /*Contrall*/
        {
            top: -190px;
            left: 30%;
            width: 80px;
            height: 80px;
            line-height: 80px;
            font-size: 32px;
        }

        .error span.triangle /*Contrall*/
        {
            top: 70%;
            right: 0%;
            border-left: 20px solid #535353;
            border-top: 15px solid transparent;
            border-bottom: 15px solid transparent;
        }

        .error .container-error-404 {
            margin-top: 10%;
            position: relative;
            height: 250px;
            padding-top: 40px;
        }

        .error .container-error-404 .clip {
            display: inline-block;
            transform: skew(-45deg);
        }

        .error .clip .shadow {

            overflow: hidden;
        }

        .error .clip:nth-of-type(2) .shadow {
            overflow: hidden;
            position: relative;
            box-shadow: inset 20px 0px 20px -15px rgba(150, 150, 150, 0.8), 20px 0px 20px -15px rgba(150, 150, 150, 0.8);
        }

        .error .clip:nth-of-type(3) .shadow:after, .error .clip:nth-of-type(1) .shadow:after {
            content: "";
            position: absolute;
            right: -8px;
            bottom: 0px;
            z-index: 9999;
            height: 100%;
            width: 10px;
            background: linear-gradient(90deg, transparent, rgba(173, 173, 173, 0.8), transparent);
            border-radius: 50%;
        }

        .error .clip:nth-of-type(3) .shadow:after {
            left: -8px;
        }

        .error .digit {
            position: relative;
            top: 8%;
            color: white;
            background: #07B3F9;
            border-radius: 50%;
            display: inline-block;
            transform: skew(45deg);
        }

        .error .clip:nth-of-type(2) .digit {
            left: -10%;
        }

        .error .clip:nth-of-type(1) .digit {
            right: -20%;
        }

        .error .clip:nth-of-type(3) .digit {
            left: -20%;
        }

        .error h2 {
            color: #A2A2A2;
            font-weight: bold;
            padding-bottom: 20px;
        }

        .error .msg {
            position: relative;
            z-index: 9999;
            display: block;
            background: #535353;
            color: #A2A2A2;
            border-radius: 50%;
            font-style: italic;
        }

        .error .triangle {
            position: absolute;
            z-index: 999;
            transform: rotate(45deg);
            content: "";
            width: 0;
            height: 0;
        }

        /* Error Page */
        @media (max-width: 767px) {
            /* Error Page */
            .error .clip .shadow {
                height: 100px; /*Contrall*/
            }

            .error .clip:nth-of-type(2) .shadow {
                width: 80px; /*Contrall play with javascript*/
            }

            .error .clip:nth-of-type(1) .shadow, .error .clip:nth-of-type(3) .shadow {
                width: 100px; /*Contrall*/
            }

            .error .digit {
                width: 80px; /*Contrall*/
                height: 80px; /*Contrall*/
                line-height: 80px; /*Contrall*/
                font-size: 52px;
            }

            .error h2 /*Contrall*/
            {
                font-size: 24px;
            }

            .error .msg /*Contrall*/
            {
                top: -110px;
                left: 15%;
                width: 40px;
                height: 40px;
                line-height: 40px;
                font-size: 18px;
            }

            .error span.triangle /*Contrall*/
            {
                top: 70%;
                right: -3%;
                border-left: 10px solid #535353;
                border-top: 8px solid transparent;
                border-bottom: 8px solid transparent;
            }

            .error .container-error-404 {
                height: 150px;
            }

            /* Error Page */
        }

        /*--------------------------------------------Framework --------------------------------*/

        .overlay {
            position: relative;
            z-index: 20;
        }

        /*done*/
        .ground-color {
            background: white;
        }

        /*done*/
        .item-bg-color {
            background: #EAEAEA
        }

        /*done*/

        /* Padding Section*/
        .padding-top {
            padding-top: 10px;
        }

        /*done*/
        .padding-bottom {
            padding-bottom: 10px;
        }

        /*done*/
        .padding-vertical {
            padding-top: 10px;
            padding-bottom: 10px;
        }

        .padding-horizontal {
            padding-left: 10px;
            padding-right: 10px;
        }

        .padding-all {
            padding: 10px;
        }

        /*done*/

        .no-padding-left {
            padding-left: 0px;
        }

        /*done*/
        .no-padding-right {
            padding-right: 0px;
        }

        /*done*/
        .no-vertical-padding {
            padding-top: 0px;
            padding-bottom: 0px;
        }

        .no-horizontal-padding {
            padding-left: 0px;
            padding-right: 0px;
        }

        .no-padding {
            padding: 0px;
        }

        /*done*/
        /* Padding Section*/

        /* Margin section */
        .margin-top {
            margin-top: 10px;
        }

        /*done*/
        .margin-bottom {
            margin-bottom: 10px;
        }

        /*done*/
        .margin-right {
            margin-right: 10px;
        }

        /*done*/
        .margin-left {
            margin-left: 10px;
        }

        /*done*/
        .margin-horizontal {
            margin-left: 10px;
            margin-right: 10px;
        }

        /*done*/
        .margin-vertical {
            margin-top: 10px;
            margin-bottom: 10px;
        }

        /*done*/
        .margin-all {
            margin: 10px;
        }

        /*done*/
        .no-margin {
            margin: 0px;
        }

        /*done*/

        .no-vertical-margin {
            margin-top: 0px;
            margin-bottom: 0px;
        }

        .no-horizontal-margin {
            margin-left: 0px;
            margin-right: 0px;
        }

        .inside-col-shrink {
            margin: 0px 20px;
        }

        /*done - For the inside sections that has also Title section*/
        /* Margin section */

        hr {
            margin: 0px;
            padding: 0px;
            border-top: 1px dashed #999;
        }

        /*--------------------------------------------FrameWork------------------------*/
    </style>
    <title>MemoryLeak</title>
</head>
<body>
<jsp:include page="bootstrapNavigationTop.jsp"/>
<div class="container text-center" id="mainContent">
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="error">
                    <div class="container-floud">
                        <div class="col-xs-12 ground-color text-center">
                            <div class="container-error-404">
                                <div class="clip">
                                    <div class="shadow"><span class="digit thirdDigit"></span></div>
                                </div>
                                <div class="clip">
                                    <div class="shadow"><span class="digit secondDigit"></span></div>
                                </div>
                                <div class="clip">
                                    <div class="shadow"><span class="digit firstDigit"></span></div>
                                </div>
                                <div class="msg">OH!<span class="triangle"></span></div>
                            </div>
                            <h2 class="h1">Sorry! It appears your browser is offline and that page was not cached.</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="bootstrapNavigationBottom.jsp"/>
</body>
<script>
    function randomNum() {
        "use strict";
        return Math.floor(Math.random() * 9) + 1;
    }

    var loop1, loop2, loop3, time = 30, i = 0, number, selector3 = document.querySelector('.thirdDigit'),
        selector2 = document.querySelector('.secondDigit'),
        selector1 = document.querySelector('.firstDigit');
    loop3 = setInterval(function () {
        "use strict";
        if (i > 40) {
            clearInterval(loop3);
            selector3.textContent = 5;
        } else {
            selector3.textContent = randomNum();
            i++;
        }
    }, time);
    loop2 = setInterval(function () {
        "use strict";
        if (i > 80) {
            clearInterval(loop2);
            selector2.textContent = 0;
        } else {
            selector2.textContent = randomNum();
            i++;
        }
    }, time);
    loop1 = setInterval(function () {
        "use strict";
        if (i > 100) {
            clearInterval(loop1);
            selector1.textContent = 3;
        } else {
            selector1.textContent = randomNum();
            i++;
        }
    }, time);
</script>
</html>
