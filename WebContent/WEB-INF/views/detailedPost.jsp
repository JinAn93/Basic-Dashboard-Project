<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Dashboard</title>

<style>
tr:first-child {
	font-weight: bold;
	background-color: #C6C9C4;
}

div {
	text-align: center;
}
</style>

</head>
<body>
	<%
		String loggedinID = (String) session.getAttribute("user_id");
		request.setAttribute("loggedinID", loggedinID);
	%>

	<div id="title">
		Title: ${post.title}
	</div>
	
	<div id="postDate">
		Date Posted: ${post.post_date}
	</div>
	
	<div id="userID">
		Created By: ${post.user_id}
	</div>
	
	<div id="contents">
		Contents: ${post.contents}
	</div>
	
	
	<div id="replies">
		<table align="center">
		<c:forEach items="${replies}" var="reply">
			<tr>
				<td>${reply.user_id}</td>
				<td>${reply.contents}</td>
				<td>${reply.post_date}</td>
				<c:choose>
					<c:when test="${loggedinID == reply.user_id}">
						<td><a href="<c:url value='/edit-${reply.id}-reply' />">Edit</a>
							<a href="<c:url value='/delete-${reply.id}-reply' />">Delete</a></td>
					</c:when>
					<c:otherwise>
						<td></td>
					</c:otherwise>
				</c:choose>
			</tr>
		</c:forEach>
			<tr>
				<form:form method="POST" modelAttribute="reply">
					<td><form:input path="user_id" id="user_id" value="${loggedinID}" readOnly="true" /></td>
					<td><form:input path="contents" id="contents" value="Write Your Reply Here!" /></td>
					<td><form:input path="parent_id" type="hidden" value="0" /></td>
					<td><a href="<c:url value='/new-${post.id}-reply' />">Reply</a></td>
					<td><form:input path="post_id" type="hidden" value="${post.id}" /></td>
					<td><form:input path="depth" type="hidden" value="0" /></td>
				</form:form>
			</tr>
			
		</table>
	</div>
	
	<div align="center" id="action">
		<a href="dashboard"> Go Back to Dashboard</a>
		
		<c:choose>
			<c:when test="${loggedinID == post.user_id}">
				<a href="<c:url value='/edit-${post.id}-post' />">Edit</a>
				<a href="<c:url value='/delete-${post.id}-post' />">Delete</a>
			</c:when>
		</c:choose>
	</div>
</body>
</html>