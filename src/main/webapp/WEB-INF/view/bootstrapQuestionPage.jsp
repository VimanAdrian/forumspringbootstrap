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
    <script src="http://sliptree.github.io/bootstrap-tokenfield/docs-assets/js/typeahead.bundle.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/pagedown/1.0/Markdown.Converter.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/pagedown/1.0/Markdown.Editor.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/pagedown/1.0/Markdown.Sanitizer.js"></script>
    <link rel="stylesheet" href="https://cdn.rawgit.com/balpha/pagedown/master/demo/browser/demo.css"/>
    <script src="https://cdn.rawgit.com/google/code-prettify/master/loader/run_prettify.js"></script>
    <script src="resources/javascript/jquery.flexdatalist.js"></script>
    <link href="resources/css/jquery.flexdatalist.css" rel="stylesheet">
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
        }

        .vresize {
            resize: vertical;
            min-height: 200px;
        }

        .question-content {
            text-align: left;
        }

    </style>
    <title>MemoryLeak</title>
</head>
<body>
<jsp:include page="bootstrapNavigationTopBottom.jsp"/>
<div class="container text-center" id="mainContent">
    <div class="row">
        <jsp:include page="bootstrapNavigationLeft.jsp"/>
        <%-- NEW QUESTION FORM --%>
        <div class="col-sm-9">

            <div class="row">
                <div class="col-sm-12">
                    <div class="well question-content">
                        ${post.content}
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
                        <p>This is an answer.</p>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-sm-1"></div>
                <div class="col-sm-10">
                    <div class="alert alert-warning fade in">
                        <a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
                        <%--TODO change this --%>
                        Please read the rules before posting. bla bla
                    </div>
                </div>
                <div class="col-sm-1"></div>
            </div>
            <div class="row">
                <div class="col-sm-1"></div>
                <div class="col-sm-10">
                    <form id="new-post-form" action="/makeReply" method="POST" class="form-horizontal">
                        <div class="form-group">
                            <%--TODO responsive this part--%>
                            <div class="col-sm-offset-1 col-sm-11">
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
                            <div class="col-sm-offset-1 col-sm-1">
                                <input type="submit" class="btn btn-primary" value="Ask"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-1 col-sm-11">
                                <div id="wmd-preview" class="wmd-preview"></div>
                            </div>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    </form>
                </div>
            </div>
            <div class="col-sm-1"></div>
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
        var engine = new Bloodhound({
            local: [{value: 'java'}, {value: 'c#'}, {value: 'c++'}, {value: 'python'}, {value: 'ruby'}, {value: 'html'}, {value: 'css'}, {value: 'javascript'}],
            datumTokenizer: function (d) {
                return Bloodhound.tokenizers.whitespace(d.value);
            },
            queryTokenizer: Bloodhound.tokenizers.whitespace
        });

        engine.initialize();

        $('#tokenfield-typeahead').tokenfield({
            typeahead: [null, {source: engine.ttAdapter()}],
            createTokensOnBlur: true,
            delimiter: [',', ' ']
        });
    });

    $('#tokenfield-typeahead').on('tokenfield:createtoken', function (event) {
        var existingTokens = $(this).tokenfield('getTokens');
        $.each(existingTokens, function (index, token) {
            if (token.value === event.attrs.value)
                event.preventDefault();
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
        multiple: $this.attr('multiple'),
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
</script>
</body>
</html>
