<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="mytaglib" tagdir="/WEB-INF/tags/mytaglib" %>

<%--
  Created by IntelliJ IDEA.
  User: viorelv
  Date: 08-Aug-17
  Time: 1:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<c:if test="${bestReply.replyId!=-1}">
    <c:set var="bestReplyVisible" value="false"/>
    <sec:authorize access="hasRole('ROLE_ADMIN')"><c:set var="bestReplyVisible" value="true"/></sec:authorize>
    <c:if test="${bestReply.enabled==1}"><c:set var="bestReplyVisible" value="true"/></c:if>
    <c:if test="${bestReplyVisible}">
        <div class="reply">
            <c:if test="${bestReply.enabled==0}">
                <p id="disabledReply">This reply is disabled!</p>
            </c:if>
            <p id="bestReply">This reply was marked as the best answer!</p>
            <table class="replyTables">
                <tbody>
                <tr>
                    <td colspan="1" class="buttonsCol">
                        <sec:authorize access="isAuthenticated()">
                            <table>
                                <tbody>
                                <tr>
                                    <td>
                                        <input type="button" name="voteButtonReply${bestReply.replyId}"
                                               class="voteButtonReply upvoteButton"
                                               id="${bestReply.replyId}"
                                               value="upvote" <c:if test="${bestReply.replyVoteType==1}">hidden</c:if>>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="button" name="voteButtonReply${bestReply.replyId}"
                                               class="voteButtonReply downvoteButton"
                                               id="${bestReply.replyId}"
                                               value="downvote"
                                               <c:if test="${bestReply.replyVoteType==-1}">hidden</c:if> />
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </sec:authorize>
                        <sec:authorize access="hasRole('ROLE_ADMIN')">
                            <table>
                                <tbody>
                                <tr>
                                    <td>
                                        <form action="/toggleReplyStatus" method="post">
                                            <input type="hidden" name="${_csrf.parameterName}"
                                                   value="${_csrf.token}"
                                                   style="display: none"/>
                                            <input type="hidden" name="replyID" value="${bestReply.replyId}"
                                                   style="display: none"/>
                                            <input type="hidden" name="postID" value="${post.questionId}"
                                                   style="display: none"/>
                                            <input type="hidden" name="page" value="${param.page}"
                                                   style="display: none"/>
                                            <input type="submit" name="submit"
                                                    <c:choose>
                                                        <c:when test="${bestReply.enabled==1}">
                                                            value="Delete"
                                                            class="disableButton"
                                                        </c:when>
                                                        <c:otherwise>
                                                            value="Restore"
                                                            class="enableButton"
                                                        </c:otherwise>
                                                    </c:choose>
                                            />
                                        </form>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </sec:authorize>
                    </td>
                    <td colspan="1" class="contentCol">${bestReply.content}</td>
                </tr>
                </tbody>
            </table>
            <table class="replyTables">
                <tbody>
                <tr>
                    <td class="randomInfCol">
                        <table>
                            <tbody>
                            <tr>
                                Score:<span id="r${bestReply.replyId}">${bestReply.score}</span>
                                <br/>
                                Date: <span class="creationDate">${bestReply.creationDate}</span>
                            </tr>
                            </tbody>
                        </table>
                    </td>
                    <td class="userCol">
                        <table style="background-color: darkgray;">
                            <tbody>
                            <tr>
                                <td rowspan="4">
                                    <img src="${bestReply.user.profileImage}" class="profilePicture">
                                </td>
                                <td>
                                    Username: <a
                                        href="http://localhost:8080/account?username=${post.user.username}">${bestReply.user.username}</a>
                                </td>
                            </tr>
                            <tr>
                                <td>Name: ${bestReply.user.firstName} ${post.user.lastName}</td>
                            </tr>
                            <tr>
                                <td>Email: ${bestReply.user.email}</td>
                            </tr>
                            <tr>
                                <td>Member since: ${bestReply.user.creationDate}</td>
                            </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <br/>
    </c:if>
</c:if>
<c:forEach var="reply" items="${post.reply}">
    <div class="reply">
        <c:if test="${reply.enabled==0}">
            <p class="disabledReply">This reply is disabled!</p>
        </c:if>
        <table class="replyTables">
            <tbody>
            <tr>
                <td colspan="1" class="buttonsCol">
                    <sec:authorize access="isAuthenticated()">
                        <table>
                            <tbody>
                            <tr>
                                <td>
                                    <input type="button" name="voteButtonReply${reply.replyId}"
                                           class="voteButtonReply upvoteButton"
                                           id="${reply.replyId}"
                                           value="upvote" <c:if test="${reply.replyVoteType==1}">hidden</c:if>>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="button" name="voteButtonReply${reply.replyId}"
                                           class="voteButtonReply downvoteButton"
                                           id="${reply.replyId}"
                                           value="downvote"
                                           <c:if test="${reply.replyVoteType==-1}">hidden</c:if> />
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </sec:authorize>
                    <sec:authorize access="hasRole('ROLE_ADMIN')">
                        <table>
                            <tbody>
                            <tr>
                                <td>
                                    <form action="/toggleReplyStatus" method="post" style="margin-bottom: 0;">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"
                                               style="display: none"/>
                                        <input type="hidden" name="replyID" value="${reply.replyId}"
                                               style="display: none"/>
                                        <input type="hidden" name="postID" value="${post.questionId}"
                                               style="display: none"/>
                                        <input type="hidden" name="page" value="${param.page}"
                                               style="display: none"/>
                                        <input type="submit" name="submit"
                                                <c:choose>
                                                    <c:when test="${reply.enabled==1}">
                                                        value="Delete"
                                                        class="disableButton"
                                                    </c:when>
                                                    <c:otherwise>
                                                        value="Restore"
                                                        class="enableButton"
                                                    </c:otherwise>
                                                </c:choose>
                                        />
                                    </form>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </sec:authorize>
                    <c:if test="${post.user.username == pageContext.request.userPrincipal.name}">
                        <table>
                            <tbody>
                            <tr>
                                <td>
                                    <form action="/favoriteReply" method="post">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"
                                               style="display: none"/>
                                        <input type="hidden" name="postID" value="${post.questionId}"
                                               style="display: none"/>
                                        <input type="hidden" name="page" value="${param.page}" style="display: none"/>
                                        <input type="hidden" name="replyID" value="${reply.replyId}"
                                               style="display: none"/>
                                        <input type="submit" name="submit" value="Best" class="bestButton"/>
                                    </form>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </c:if>
                </td>
                <td colspan="1" class="contentCol">${reply.content}</td>
            </tr>
            </tbody>
        </table>
        <table class="replyTables">
            <tbody>
            <tr>
                <td class="randomInfCol">
                    <table>
                        <tbody>
                        <tr>
                            Score:<span id="r${reply.replyId}">${reply.score}</span>
                            <br/>
                            Date: <span class="creationDate">${reply.creationDate}</span>
                        </tr>
                        </tbody>
                    </table>
                </td>
                <td class="userCol">
                    <table style="background-color: darkgray;">
                        <tbody>
                        <tr>
                            <td rowspan="4">
                                <img src="${reply.user.profileImage}" class="profilePicture">
                            </td>
                            <td>
                                Username: <a
                                    href="http://localhost:8080/account?username=${post.user.username}">${reply.user.username}</a>
                            </td>
                        </tr>
                        <tr>
                            <td>Name: ${reply.user.firstName} ${post.user.lastName}</td>
                        </tr>
                        <tr>
                            <td>Email: ${reply.user.email}</td>
                        </tr>
                        <tr>
                            <td>Member since: ${reply.user.creationDate}</td>
                        </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <br/>
</c:forEach>
<script>
    $(document).ready(function () {
        $(document).on("click", ".voteButtonReply", function () {
            //alert("click");
            localVoteType = $(this).val();
            localReplyId = $(this).attr('id');
            $.ajax({
                type: "POST",
                url: '/voteReply',
                data: {
                    replyID: localReplyId,
                    type: localVoteType,
                    "${_csrf.parameterName}": "${_csrf.token}"
                },
                dataType: "json",
                success: function (data, textStatus, jqXHR) {
                    if (data) {
                        //alert("Succes!");
                        if (localVoteType === 'upvote') {
                            $("#r" + localReplyId).html(parseInt($("#r" + localReplyId).html()) + 1);
                        }
                        else if (localVoteType === 'downvote') {
                            $("#r" + localReplyId).html(parseInt($("#r" + localReplyId).html()) - 1);
                        }
                        $('.voteButtonReply').each(function () {
                            if ($(this).attr('id') === localReplyId) {
                                //alert($(this).attr('id'));
                                if ($(this).val() !== localVoteType) {
                                    //alert("show");
                                    $(this).show();
                                }
                                if ($(this).val() === localVoteType) {
                                    //alert("hide");
                                    $(this).hide();
                                }
                            }
                        });
                    }
                    else {
                        alert("Eroare!");
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Server error!")
                },
                beforeSend: function (jqXHR, settings) {
                },
                complete: function (jqXHR, textStatus) {
                }

            });
        });
    });
</script>
<mytaglib:pagination url="${url}" nbrOfPages="${nrPagini}"/>
</body>
</html>
