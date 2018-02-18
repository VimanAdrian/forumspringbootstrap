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
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css"/>
    <link rel="stylesheet" href="https://bootswatch.com/3/flatly/bootstrap.css">
    <%--<link rel="stylesheet" href="https://bootswatch.com/3/simplex/bootstrap.css">--%>
    <style>
    </style>
    <title>MemoryLeak</title>
</head>
<body>
<jsp:include page="bootstrapNavigationTop.jsp"/>
<div class="container text-center" id="mainContent">
    <div class="row">
        <jsp:include page="bootstrapNavigationLeft.jsp"/>
        <div class="col-sm-9">
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
        <%--<jsp:include page="bootstrapNavigationRight.jsp"/>--%>
    </div>
</div>
<%--<script>--%>
<%--TODO check this out--%>
<%--$(document).ready(function () {--%>
<%--var engine = new Bloodhound({--%>
<%--local: [{value: 'java'}, {value: 'c#'}, {value: 'c++'}, {value: 'python'}, {value: 'ruby'}, {value: 'html'}, {value: 'css'}, {value: 'javascript'}],--%>
<%--datumTokenizer: function (d) {--%>
<%--return Bloodhound.tokenizers.whitespace(d.value);--%>
<%--},--%>
<%--queryTokenizer: Bloodhound.tokenizers.whitespace--%>
<%--});--%>

<%--engine.initialize();--%>

<%--$('#tokenfield-typeahead').tokenfield({--%>
<%--typeahead: [null, {source: engine.ttAdapter()}],--%>
<%--createTokensOnBlur: true,--%>
<%--delimiter: [',', ' ']--%>
<%--});--%>
<%--});--%>

<%--$('#tokenfield-typeahead').on('tokenfield:createtoken', function (event) {--%>
<%--var existingTokens = $(this).tokenfield('getTokens');--%>
<%--$.each(existingTokens, function (index, token) {--%>
<%--if (token.value === event.attrs.value)--%>
<%--event.preventDefault();--%>
<%--});--%>
<%--});--%>

<%--</script>--%>
<jsp:include page="bootstrapNavigationBottom.jsp"/>
</body>
</html>
