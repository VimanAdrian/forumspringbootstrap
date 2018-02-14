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

    <jsp:include page="bootstrapNavigation.jsp"/>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script src="http://sliptree.github.io/bootstrap-tokenfield/docs-assets/js/typeahead.bundle.min.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css"/>
    <script src="//cdnjs.cloudflare.com/ajax/libs/pagedown/1.0/Markdown.Converter.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/pagedown/1.0/Markdown.Editor.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/pagedown/1.0/Markdown.Sanitizer.js"></script>
    <link rel="stylesheet" href="https://cdn.rawgit.com/balpha/pagedown/master/demo/browser/demo.css"/>
    <script src="https://cdn.rawgit.com/google/code-prettify/master/loader/run_prettify.js"></script>
    <link href="resources/css/jquery.flexdatalist.css" rel="stylesheet">
    <script src="resources/javascript/jquery.flexdatalist.js"></script>
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
            min-height: 200px;
        }

        .form-element {
            margin-top: 10px !important;
        }

        .form-element {
            margin-bottom: 10px !important;
        }

        #wmd-preview * {
            width: 100% !important;
            margin: 0 !important;
            padding: 0 !important;
        }

    </style>
    <style>
        .wmd-button > span {
            background-image: url('http://cdn.rawgit.com/derobins/wmd/master/images/wmd-buttons.png');
            background-repeat: no-repeat;
            background-position: 0px 0px;
            width: 20px;
            height: 20px;
            display: inline-block;
        }
    </style>
    <title>MemoryLeak</title>
</head>
<body>

<div class="container text-center" id="mainContent">
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

        <%-- NEW QUESTION FORM --%>
        <div class="col-sm-7">
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
                    <form id="new-post-form" action="/makePost" method="POST" class="form-horizontal">
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
                            <label class="control-label col-sm-1"
                                   for="tags">Tags:</label>
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
                                    Z shell
                                </datalist>
                            </div>
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
<div class="modal fade" id="update-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true"
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
                <form id="link-form" action="/update" style="display:none;" method="POST"
                      enctype="multipart/form-data">
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
