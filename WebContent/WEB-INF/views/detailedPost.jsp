<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Dashboard</title>

<style>
.replyTable tr:nth-last-child(n+2)  {
	background-color: #C6C9C4;
}

div, td:not(#replyContents) {
	text-align: center;
}
</style>

</head>
<body>
	<%
		String loggedinID = (String) session.getAttribute("user_id");
		request.setAttribute("loggedinID", loggedinID);
	%>
	<table align="center" border="3" width="1000" height="500">
		<tr>
			<td width="100" height="45">Title</td>
			<td colspan="3">${post.title}</td>
		</tr>
		<tr>
			<td width="100" height="45">Date Posted</td>
			<td width="400">${post.post_date}</td>
			<td width="100" height="45">Created By</td>
			<td>${post.user_id}</td>
		</tr>
		<tr>
			<td rowspan="2" width="100" height="45">Contents</td>
			<td rowspan="2" colspan="3">${post.contents}</td>
		</tr>

	</table>

	<div id="replies">
		<br>
		<table class="replyTable" align="center">
			<c:forEach items="${replies}" var="reply">
				<tr>
					<td width="80">${reply.user_id}</td>
					<td width="600" id="replyContents">${reply.contents}</td>
					<td width="100">${reply.post_date}</td>
					<td>
						<a href="<c:url value='/reply-${post.id}-${reply.id}-${reply.parent_id}-${reply.depth}-reply' />">Reply</a>
								
						<c:choose>
							<c:when test="${loggedinID == reply.user_id}">
						<!--  		<a href="<c:url value='/edit-${post.id}-${reply.id}-reply' />">Edit</a> -->
								<a href="<c:url value='/delete-${post.id}-${reply.id}-reply' />">Delete</a>
							</c:when>
						</c:choose>
					</td>
				</tr>
				
				<!--  This is where people could write reply of replies -->
				<c:choose>
					<c:when test="${recursiveReplyPressed}">
						<!--  add POST form here -->
					</c:when>
				</c:choose>
			</c:forEach>
			<tr id="newReplyRow">
				<form:form method="POST" modelAttribute="reply">
					<td colspan="2" ><form:input style='width:100%' path="contents" id="contents" value="Write Your Reply Here!" /></td>
					<td><form:input path="post_date" id="post_date" value="${reply.post_date}" readOnly="true" /></td>
					<td><input type="submit" value="Reply"/></td>
					<td><form:input path="parent_id" type="hidden" id="parent_id" value="0" /></td>
					<td><form:input path="post_id" type="hidden" id="post_id" value="${post.id}" /></td>
					<td><form:input path="depth" type="hidden" id="depth" value="0" /></td>
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