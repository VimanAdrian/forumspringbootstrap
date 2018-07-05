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

        .align-right {
            float: right;
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
                <div class="col-sm-1"></div>
                <div class="col-sm-10">
                    <div class="alert alert-warning fade in">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
                        <%--TODO change this --%>
                        Please read <a href="${pageContext.request.contextPath}/class?classId=0">the rules</a> before
                        posting.
                    </div>
                </div>
                <div class="col-sm-1"></div>
            </div>
            <div class="row">
                <div class="col-sm-10 col-sm-offset-1">
                    <form id="new-post-form" action="${pageContext.request.contextPath}/askQuestion" method="POST"
                          class="form-horizontal">
                        <div class="form-group">
                            <label class="control-label col-sm-1" for="post_title">Title:</label>
                            <div class="col-sm-11">
                                <input id="post_title" class="form-control " type="text"
                                       name="title" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <%--TODO responsive this part--%>
                            <div class="col-sm-offset-1 col-sm-11">
                                <div id="wmd-button-bar"></div>
                                <textarea id="wmd-input" class="wmd-input form-control vresize"
                                          name="content" required></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-1"
                                   for="tags">Tags:</label>
                            <div class="col-sm-11">
                                <input type="text" id="tags" data-role="tagsinput" class="form-control flexdatalist"
                                       name="tags" multiple='multiple' list="taglist"/>
                                <%--TODO change this--%>
                                <datalist id="taglist">
                                    <jsp:include page="bootstrapTagList.jsp"/>
                                </datalist>
                            </div>
                        </div>
                        <div class="form-group align-right">
                            <div class="col-sm-offset-1 col-sm-1">
                                <input type="submit" class="btn btn-primary" value="Ask your question"/>
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
                        <input type="hidden" id="lectureId" name="lectureId" value=""/>
                    </form>
                </div>
            </div>
            <div class="col-sm-1"></div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        var converter = Markdown.getSanitizingConverter();
        var editor = new Markdown.Editor(converter);
        editor.run();
    })
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
        normalizeString: null,
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

    var getUrlParameter = function getUrlParameter(sParam) {
        var sPageURL = decodeURIComponent(window.location.search.substring(1)),
            sURLVariables = sPageURL.split('&'),
            sParameterName,
            i;

        for (i = 0; i < sURLVariables.length; i++) {
            sParameterName = sURLVariables[i].split('=');

            if (sParameterName[0] === sParam) {
                return sParameterName[1] === undefined ? true : sParameterName[1];
            }
        }
    };

    var lectureId = getUrlParameter('lectureId');
    if (lectureId !== undefined) {
        $("#lectureId").val(lectureId);
    }

</script>
<jsp:include page="bootstrapNavigationBottom.jsp"/>
</body>
</html>
