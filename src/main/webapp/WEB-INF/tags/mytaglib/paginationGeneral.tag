<%@ tag body-content="empty" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tags-mytaglib" tagdir="/WEB-INF/tags/mytaglib" %>


<%@ attribute name="url" rtexprvalue="true" required="true" type="java.lang.String" description="Page 0 url" %>
<%@ attribute name="pageable" rtexprvalue="true" required="true" type="org.springframework.data.domain.Page"
              description="Page" %>
<%@ attribute name="howManyPagesToShow" rtexprvalue="true" required="true" type="java.lang.Integer"
              description="Nr of page" %>

<c:set var="currentPage" value="${pageable.number}"/>
<c:set var="nbrOfPages" value="${pageable.totalPages - 1}"/>

<tags-mytaglib:paginationForLecturePages url="${url}" currentPage="${currentPage}" nbrOfPages="${nbrOfPages}"
                                         howManyPagesToShow="3"/>