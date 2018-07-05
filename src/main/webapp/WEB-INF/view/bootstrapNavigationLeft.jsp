<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .wordBreak {
        word-wrap: break-word;
    }
</style>
<div class="col-md-3 well">
    <sec:authorize access="isAuthenticated()">
        <div class="well well-top wordBreak">
            <p><a href="${pageContext.request.contextPath}/account?username=<c:out value='${user.username}'/>"><c:out
                    value="${user.username}"/></a></p>
            <img src="${user.profileImage}" class="img-circle" height="65"
                 width="65" alt="Avatar">
        </div>
        <c:if test="${newAnswers==true}">
            <div class="alert alert-dismissible alert-info wordBreak">
                <a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
                <p><strong>You have new answers!</strong></p>
                <c:forEach var="post" items="${answerList}" varStatus="loop">
                    <p><a href="/question?questionId=${post.questionId}" class="alert-link"><c:out
                            value="${post.title}"/></a></p>
                </c:forEach>
            </div>
        </c:if>
        <c:if test="${newClassActivity==true}">
            <div class="alert alert-dismissible alert-info wordBreak">
                <a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
                <p><strong>There is new activity in some of the classes you subscribed to!</strong></p>
                <c:forEach var="newActivityClass" items="${classList}" varStatus="loop">
                    <p><a href="/class?classId=${newActivityClass.virtualClassId}" class="alert-link">
                        <c:out value="${newActivityClass.title}"/>
                    </a></p>
                </c:forEach>
            </div>
        </c:if>
        <div class="well well-top wordBreak">
            <c:if test="${topQuestions==true}">
                <p>Your top question.</p>
                <c:forEach var="post" items="${questionList}" varStatus="loop">
                    <p><a href="/question?questionId=${post.questionId}"><c:out value="${post.title}"/>
                        <span class="badge">${post.score}</span></a></p>
                </c:forEach>
            </c:if>
            <c:if test="${topQuestions==false}">
                <p>
                    It seems you don't have any question.
                    <br>
                    You can ask one <a href="${pageContext.request.contextPath}/newQuestion">here</a>!
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


