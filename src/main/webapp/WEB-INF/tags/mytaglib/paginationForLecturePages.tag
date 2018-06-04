<%@ tag body-content="empty" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ attribute name="url" rtexprvalue="true" required="true" type="java.lang.String" description="Base url" %>
<%@ attribute name="currentPage" rtexprvalue="true" required="true" type="java.lang.Integer"
              description="Current page" %>
<%@ attribute name="nbrOfPages" rtexprvalue="true" required="true" type="java.lang.Integer" description="Nr of page" %>
<%@ attribute name="howManyPagesToShow" rtexprvalue="true" required="true" type="java.lang.Integer"
              description="Nr of page" %>

<ul class="pagination">
<c:if test="${nbrOfPages == 0}">
    <li class="disabled">
        <a href="#" aria-label="Previous">
            <span aria-hidden="true">&laquo;&laquo;</span>
        </a>
    </li>
    <li class="disabled">
        <a href="#" aria-label="Previous">
            <span aria-hidden="true">&laquo;</span>
        </a>
    </li>
    <li>
        <a href="#" aria-label="(current)">
            <span aria-hidden="true">0</span>
        </a>
    </li>
    <li class="disabled">
        <a href="#" aria-label="Next">
            <span aria-hidden="true">&raquo;</span>
        </a>
    </li>
    <li class="disabled">
        <a href="#" aria-label="Next">
            <span aria-hidden="true">&raquo;&raquo;</span>
        </a>
    </li>
</c:if>
<c:if test="${nbrOfPages >0}">
    <c:if test="${currentPage==0}">
        <li class="disabled">
            <a href="#" aria-label="Previous">
                <span aria-hidden="true">&laquo;&laquo;</span>
            </a>
        </li>
    </c:if>
    <c:if test="${currentPage!=0}">
        <li>
            <a href="${pageContext.request.contextPath}${url}${0}" aria-label="Previous">
                <span aria-hidden="true">&laquo;&laquo;</span>
            </a>
        </li>
    </c:if>
    <c:if test="${currentPage==0}">
        <li class="disabled">
            <a href="#" aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
            </a>
        </li>
    </c:if>
    <c:if test="${currentPage!=0}">
        <li>
            <a href="${pageContext.request.contextPath}${url}${currentPage - 1}" aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
            </a>
        </li>
    </c:if>

    <c:if test="${currentPage - howManyPagesToShow < 0}">
        <c:set var="start" scope="page" value="0"/>
    </c:if>
    <c:if test="${currentPage - howManyPagesToShow >= 0}">
        <c:set var="start" scope="page" value="${currentPage-3}"/>
    </c:if>
    <c:if test="${currentPage + howManyPagesToShow > nbrOfPages}">
        <c:set var="stop" scope="page" value="${nbrOfPages}"/>
    </c:if>
    <c:if test="${currentPage + howManyPagesToShow <= nbrOfPages}">
        <c:set var="stop" scope="page" value="${currentPage+3}"/>
    </c:if>

    <c:forEach begin="${start}" end="${stop}" step="1" varStatus="pp">
        <c:if test="${pp.index == currentPage}">
            <li class="active"><a href="#">${pp.index}<span class="sr-only">(current)</span></a></li>
        </c:if>
        <c:if test="${pp.index != currentPage}">
            <li><a href="${pageContext.request.contextPath}${url}${pp.index}">${pp.index}</a></li>
        </c:if>
    </c:forEach>

    <c:if test="${currentPage==nbrOfPages}">
        <li class="disabled">
            <a href="#" aria-label="Next">
                <span aria-hidden="true">&raquo;</span>
            </a>
        </li>
    </c:if>
    <c:if test="${currentPage!=nbrOfPages}">
        <li>
            <a href="${pageContext.request.contextPath}${url}${currentPage+1}" aria-label="Next">
                <span aria-hidden="true">&raquo;</span>
            </a>
        </li>
    </c:if>
    <c:if test="${currentPage==nbrOfPages}">
        <li class="disabled">
            <a href="#" aria-label="Next">
                <span aria-hidden="true">&raquo;&raquo;</span>
            </a>
        </li>
    </c:if>
    <c:if test="${currentPage!=nbrOfPages}">
        <li>
            <a href="${pageContext.request.contextPath}${url}${nbrOfPages}" aria-label="Next">
                <span aria-hidden="true">&raquo;&raquo;</span>
            </a>
        </li>
    </c:if>
</c:if>