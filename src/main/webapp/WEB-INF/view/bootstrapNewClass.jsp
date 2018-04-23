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
                        Please read the rules before posting. bla bla
                    </div>
                </div>
                <div class="col-sm-1"></div>
            </div>
            <div class="row">
                <div class="col-sm-10 col-sm-offset-1">
                    <form id="new-post-form" action="${pageContext.request.contextPath}/makeClass" method="POST"
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
                            <%--<div class="col-sm-offset-2 col-sm-10">--%>
                            <%--<textarea id="post_content"--%>
                            <%--class="form-control vresize"--%>
                            <%--name="content" required></textarea>--%>
                            <%--</div>--%>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-1" for="tags">Tags:</label>
                            <div class="col-sm-11">
                                <input type="text" id="tags" data-role="tagsinput" class="form-control flexdatalist"
                                       name="tags" multiple='multiple' list="taglist"/>
                                <%--TODO change this--%>
                                <datalist id="taglist">
                                    <option value="4th Dimension/4D">4th Dimension/4D</option>
                                    <option value="ABAP">ABAP</option>
                                    <option value="ABC">ABC</option>
                                    <option value="ActionScript">ActionScript</option>
                                    <option value="Ada">Ada</option>
                                    <option value="Agilent VEE">Agilent VEE</option>
                                    <option value="Algol">Algol</option>
                                    <option value="Alice">Alice</option>
                                    <option value="Angelscript">Angelscript</option>
                                    <option value="Apex">Apex</option>
                                    <option value="APL">APL</option>
                                    <option value="AppleScript">AppleScript</option>
                                    <option value="Arc">Arc</option>
                                    <option value="Arduino">Arduino</option>
                                    <option value="ASP">ASP</option>
                                    <option value="AspectJ">AspectJ</option>
                                    <option value="Assembly">Assembly</option>
                                    <option value="ATLAS">ATLAS</option>
                                    <option value="Augeas">Augeas</option>
                                    <option value="AutoHotkey">AutoHotkey</option>
                                    <option value="AutoIt">AutoIt</option>
                                    <option value="AutoLISP">AutoLISP</option>
                                    <option value="Automator">Automator</option>
                                    <option value="Avenue">Avenue</option>
                                    <option value="Awk">Awk</option>
                                    <option value="Bash">Bash</option>
                                    <option value="(Visual) Basic">(Visual) Basic</option>
                                    <option value="bc">bc</option>
                                    <option value="BCPL">BCPL</option>
                                    <option value="BETA">BETA</option>
                                    <option value="BlitzMax">BlitzMax</option>
                                    <option value="Boo">Boo</option>
                                    <option value="Bourne Shell">Bourne Shell</option>
                                    <option value="Bro">Bro</option>
                                    <option value="C">C</option>
                                    <option value="C Shell">C Shell</option>
                                    <option value="C#">C#</option>
                                    <option value="C++">C++</option>
                                    <option value="C++/CLI">C++/CLI</option>
                                    <option value="C-Omega">C-Omega</option>
                                    <option value="Caml">Caml</option>
                                    <option value="Ceylon">Ceylon</option>
                                    <option value="CFML">CFML</option>
                                    <option value="cg">cg</option>
                                    <option value="Ch">Ch</option>
                                    <option value="CHILL">CHILL</option>
                                    <option value="CIL">CIL</option>
                                    <option value="CL (OS/400)">CL (OS/400)</option>
                                    <option value="Clarion">Clarion</option>
                                    <option value="Clean">Clean</option>
                                    <option value="Clipper">Clipper</option>
                                    <option value="Clojure">Clojure</option>
                                    <option value="CLU">CLU</option>
                                    <option value="COBOL">COBOL</option>
                                    <option value="Cobra">Cobra</option>
                                    <option value="CoffeeScript">CoffeeScript</option>
                                    <option value="ColdFusion">ColdFusion</option>
                                    <option value="COMAL">COMAL</option>
                                    <option value="Common Lisp">Common Lisp</option>
                                    <option value="Coq">Coq</option>
                                    <option value="cT">cT</option>
                                    <option value="Curl">Curl</option>
                                    <option value="D">D</option>
                                    <option value="Dart">Dart</option>
                                    <option value="DCL">DCL</option>
                                    <option value="DCPU-16 ASM">DCPU-16 ASM</option>
                                    <option value="Delphi/Object Pascal">Delphi/Object Pascal</option>
                                    <option value="DiBOL">DiBOL</option>
                                    <option value="Dylan">Dylan</option>
                                    <option value="E">E</option>
                                    <option value="eC">eC</option>
                                    <option value="Ecl">Ecl</option>
                                    <option value="ECMAScript">ECMAScript</option>
                                    <option value="EGL">EGL</option>
                                    <option value="Eiffel">Eiffel</option>
                                    <option value="Elixir">Elixir</option>
                                    <option value="Emacs Lisp">Emacs Lisp</option>
                                    <option value="Erlang">Erlang</option>
                                    <option value="Etoys">Etoys</option>
                                    <option value="Euphoria">Euphoria</option>
                                    <option value="EXEC">EXEC</option>
                                    <option value="F#">F#</option>
                                    <option value="Factor">Factor</option>
                                    <option value="Falcon">Falcon</option>
                                    <option value="Fancy">Fancy</option>
                                    <option value="Fantom">Fantom</option>
                                    <option value="Felix">Felix</option>
                                    <option value="Forth">Forth</option>
                                    <option value="Fortran">Fortran</option>
                                    <option value="Fortress">Fortress</option>
                                    <option value="(Visual) FoxPro">(Visual) FoxPro</option>
                                    <option value="Gambas">Gambas</option>
                                    <option value="GNU Octave">GNU Octave</option>
                                    <option value="Go">Go</option>
                                    <option value="Google AppsScript">Google AppsScript</option>
                                    <option value="Gosu">Gosu</option>
                                    <option value="Groovy">Groovy</option>
                                    <option value="Haskell">Haskell</option>
                                    <option value="haXe">haXe</option>
                                    <option value="Heron">Heron</option>
                                    <option value="HPL">HPL</option>
                                    <option value="HyperTalk">HyperTalk</option>
                                    <option value="Icon">Icon</option>
                                    <option value="IDL">IDL</option>
                                    <option value="Inform">Inform</option>
                                    <option value="Informix-4GL">Informix-4GL</option>
                                    <option value="INTERCAL">INTERCAL</option>
                                    <option value="Io">Io</option>
                                    <option value="Ioke">Ioke</option>
                                    <option value="J">J</option>
                                    <option value="J#">J#</option>
                                    <option value="JADE">JADE</option>
                                    <option value="Java">Java</option>
                                    <option value="Java FX Script">Java FX Script</option>
                                    <option value="JavaScript">JavaScript</option>
                                    <option value="JScript">JScript</option>
                                    <option value="JScript.NET">JScript.NET</option>
                                    <option value="Julia">Julia</option>
                                    <option value="Korn Shell">Korn Shell</option>
                                    <option value="Kotlin">Kotlin</option>
                                    <option value="LabVIEW">LabVIEW</option>
                                    <option value="Ladder Logic">Ladder Logic</option>
                                    <option value="Lasso">Lasso</option>
                                    <option value="Limbo">Limbo</option>
                                    <option value="Lingo">Lingo</option>
                                    <option value="Lisp">Lisp</option>
                                    <option value="Logo">Logo</option>
                                    <option value="Logtalk">Logtalk</option>
                                    <option value="LotusScript">LotusScript</option>
                                    <option value="LPC">LPC</option>
                                    <option value="Lua">Lua</option>
                                    <option value="Lustre">Lustre</option>
                                    <option value="M4">M4</option>
                                    <option value="MAD">MAD</option>
                                    <option value="Magic">Magic</option>
                                    <option value="Magik">Magik</option>
                                    <option value="Malbolge">Malbolge</option>
                                    <option value="MANTIS">MANTIS</option>
                                    <option value="Maple">Maple</option>
                                    <option value="Mathematica">Mathematica</option>
                                    <option value="MATLAB">MATLAB</option>
                                    <option value="Max/MSP">Max/MSP</option>
                                    <option value="MAXScript">MAXScript</option>
                                    <option value="MEL">MEL</option>
                                    <option value="Mercury">Mercury</option>
                                    <option value="Mirah">Mirah</option>
                                    <option value="Miva">Miva</option>
                                    <option value="ML">ML</option>
                                    <option value="Monkey">Monkey</option>
                                    <option value="Modula-2">Modula-2</option>
                                    <option value="Modula-3">Modula-3</option>
                                    <option value="MOO">MOO</option>
                                    <option value="Moto">Moto</option>
                                    <option value="MS-DOS Batch">MS-DOS Batch</option>
                                    <option value="MUMPS">MUMPS</option>
                                    <option value="NATURAL">NATURAL</option>
                                    <option value="Nemerle">Nemerle</option>
                                    <option value="Nimrod">Nimrod</option>
                                    <option value="NQC">NQC</option>
                                    <option value="NSIS">NSIS</option>
                                    <option value="Nu">Nu</option>
                                    <option value="NXT-G">NXT-G</option>
                                    <option value="Oberon">Oberon</option>
                                    <option value="Object Rexx">Object Rexx</option>
                                    <option value="Objective-C">Objective-C</option>
                                    <option value="Objective-J">Objective-J</option>
                                    <option value="OCaml">OCaml</option>
                                    <option value="Occam">Occam</option>
                                    <option value="ooc">ooc</option>
                                    <option value="Opa">Opa</option>
                                    <option value="OpenCL">OpenCL</option>
                                    <option value="OpenEdge ABL">OpenEdge ABL</option>
                                    <option value="OPL">OPL</option>
                                    <option value="Oz">Oz</option>
                                    <option value="Paradox">Paradox</option>
                                    <option value="Parrot">Parrot</option>
                                    <option value="Pascal">Pascal</option>
                                    <option value="Perl">Perl</option>
                                    <option value="PHP">PHP</option>
                                    <option value="Pike">Pike</option>
                                    <option value="PILOT">PILOT</option>
                                    <option value="PL/I">PL/I</option>
                                    <option value="PL/SQL">PL/SQL</option>
                                    <option value="Pliant">Pliant</option>
                                    <option value="PostScript">PostScript</option>
                                    <option value="POV-Ray">POV-Ray</option>
                                    <option value="PowerBasic">PowerBasic</option>
                                    <option value="PowerScript">PowerScript</option>
                                    <option value="PowerShell">PowerShell</option>
                                    <option value="Processing">Processing</option>
                                    <option value="Prolog">Prolog</option>
                                    <option value="Puppet">Puppet</option>
                                    <option value="Pure Data">Pure Data</option>
                                    <option value="Python">Python</option>
                                    <option value="Q">Q</option>
                                    <option value="R">R</option>
                                    <option value="Racket">Racket</option>
                                    <option value="REALBasic">REALBasic</option>
                                    <option value="REBOL">REBOL</option>
                                    <option value="Revolution">Revolution</option>
                                    <option value="REXX">REXX</option>
                                    <option value="RPG (OS/400)">RPG (OS/400)</option>
                                    <option value="Ruby">Ruby</option>
                                    <option value="Rust">Rust</option>
                                    <option value="S">S</option>
                                    <option value="S-PLUS">S-PLUS</option>
                                    <option value="SAS">SAS</option>
                                    <option value="Sather">Sather</option>
                                    <option value="Scala">Scala</option>
                                    <option value="Scheme">Scheme</option>
                                    <option value="Scilab">Scilab</option>
                                    <option value="Scratch">Scratch</option>
                                    <option value="sed">sed</option>
                                    <option value="Seed7">Seed7</option>
                                    <option value="Self">Self</option>
                                    <option value="Shell">Shell</option>
                                    <option value="SIGNAL">SIGNAL</option>
                                    <option value="Simula">Simula</option>
                                    <option value="Simulink">Simulink</option>
                                    <option value="Slate">Slate</option>
                                    <option value="Smalltalk">Smalltalk</option>
                                    <option value="Smarty">Smarty</option>
                                    <option value="SPARK">SPARK</option>
                                    <option value="SPSS">SPSS</option>
                                    <option value="SQR">SQR</option>
                                    <option value="Squeak">Squeak</option>
                                    <option value="Squirrel">Squirrel</option>
                                    <option value="Standard ML">Standard ML</option>
                                    <option value="Suneido">Suneido</option>
                                    <option value="SuperCollider">SuperCollider</option>
                                    <option value="TACL">TACL</option>
                                    <option value="Tcl">Tcl</option>
                                    <option value="Tex">Tex</option>
                                    <option value="thinBasic">thinBasic</option>
                                    <option value="TOM">TOM</option>
                                    <option value="Transact-SQL">Transact-SQL</option>
                                    <option value="Turing">Turing</option>
                                    <option value="TypeScript">TypeScript</option>
                                    <option value="Vala/Genie">Vala/Genie</option>
                                    <option value="VBScript">VBScript</option>
                                    <option value="Verilog">Verilog</option>
                                    <option value="VHDL">VHDL</option>
                                    <option value="VimL">VimL</option>
                                    <option value="Visual Basic .NET">Visual Basic .NET</option>
                                    <option value="WebDNA">WebDNA</option>
                                    <option value="Whitespace">Whitespace</option>
                                    <option value="X10">X10</option>
                                    <option value="xBase">xBase</option>
                                    <option value="XBase++">XBase++</option>
                                    <option value="Xen">Xen</option>
                                    <option value="XPL">XPL</option>
                                    <option value="XSLT">XSLT</option>
                                    <option value="XQuery">XQuery</option>
                                    <option value="yacc">yacc</option>
                                    <option value="Yorick">Yorick</option>
                                </datalist>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class=" col-sm-offset-1 col-sm-11">
                                You can add some lectures right now. Don't worry if you don't want to do it now, you can
                                always add them later.
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-sm-1" for="lectures">Lectures:</label>
                            <div class="col-sm-11">
                                <ul id="lectures" style="list-style-type: none;">
                                    <li><input class="form-control" type="text" name="title"
                                               placeholder="Lecture title"/></li>
                                </ul>
                                <input type="button" class="btn btn-info align-right" value="Add lecture"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-1 col-sm-1">
                                <input type="submit" class="btn btn-primary" value="Save class"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <p>You can see a live preview of how your description will look. </p>
                                <hr/>
                                <div id="wmd-preview" class="wmd-preview well"></div>
                                <hr/>
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
<jsp:include page="bootstrapNavigationBottom.jsp"/>
</body>
</html>
