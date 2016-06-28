<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
	</div>
	
	<a href="dashboard"> Go Back to Dashboard</a>
	<c:choose>
		<c:when test="${loggedinID == post.user_id}">
			<a href="<c:url value='/edit-${post.id}-post' />">Edit</a>
			<a href="<c:url value='/delete-${post.id}-post' />">Delete</a>
		</c:when>
	</c:choose>

</body>
</html>