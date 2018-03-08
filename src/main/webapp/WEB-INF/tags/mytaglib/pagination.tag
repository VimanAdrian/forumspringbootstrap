<%@ tag body-content="empty" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ attribute name="url" rtexprvalue="true" required="true" type="java.lang.String" description="Base url" %>
<%@ attribute name="nrPagini" rtexprvalue="true" required="true" type="java.lang.Integer" description="Nr of page" %>

<c:if test="${(param.page!=0) && (param.page!=1)}"><a href="${pageContext.request.contextPath}${url}0">First</a></c:if>
<c:if test="${param.page!=0}"><a href="${pageContext.request.contextPath}${url}${param.page-1}">Back</a></c:if>
<c:if test="${(param.page-3)>=0}">...</c:if>
<c:if test="${(param.page-2)>=0}"><a
        href="${pageContext.request.contextPath}${url}${(param.page-2)}">${(param.page-2)}</a></c:if>
<c:if test="${(param.page-1)>=0}"><a
        href="${pageContext.request.contextPath}${url}${(param.page-1)}">${(param.page-1)}</a></c:if>
<c:if test="${((param.page-1)>=0)||((param.page+1)<=nrPagini)}"><a
        href="${pageContext.request.contextPath}${url}${(param.page)}">${(param.page)}</a></c:if>
<c:if test="${(param.page+1)<=nrPagini}"><a
        href="${pageContext.request.contextPath}${url}${(param.page+1)}">${(param.page+1)}</a></c:if>
<c:if test="${(param.page+2)<=nrPagini}"><a
        href="${pageContext.request.contextPath}${url}${(param.page+2)}">${(param.page+2)}</a></c:if>
<c:if test="${(param.page+3)<=nrPagini}">...</c:if>
<c:if test="${(param.page+1)<=nrPagini}"><a
        href="${pageContext.request.contextPath}${url}${param.page+1}">Next</a></c:if>
<c:if test="${(param.page!=nrPagini) && ((param.page+1)!=nrPagini)}"><a
        href="${pageContext.request.contextPath}${url}${nrPagini}">Last</a></c:if>
