<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
</style>
<%--TODO SANITISE ALL USER INPUT EVERYWHERE ALL OF IT--%>
<div class="col-sm-3 well">
    <sec:authorize access="isAuthenticated()">
        <div class="well well-top">
            <p><a href="${pageContext.request.contextPath}/account?username=${user.username}">${user.username}</a></p>
            <img src="${user.profileImage}" class="img-circle" height="65"
                 width="65" alt="Avatar">
        </div>
        <c:if test="${newAnswers==true}">
            <div class="alert alert-dismissible alert-info">
                <a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
                <p><strong>You have new answers!</strong></p>
                <c:forEach var="post" items="${answerList}" varStatus="loop">
                    <p><a href="/post?postID=${post.postId}&page=0" class="alert-link">${post.title}</a></p>
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
                    You can ask one <a href="${pageContext.request.contextPath}/newPost">here</a>!
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


