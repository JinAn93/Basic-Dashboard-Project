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

h1 {
	text-align: center;
}

p {
	text-align: center;
}

.contents {
	position: relative;
}

.action {
	position: absolute;
	bottom: 0;
}
</style>

</head>
<body>
	<%
		String loggedinID = (String) session.getAttribute("user_id");
		request.setAttribute("loggedinID", loggedinID);
	%>

	<h1>
		Welcome
		<%=loggedinID%>, you are logged in!
	</h1>
	<p>List of Posts on Dashboard</p>
	<table align="center" border="3" width="1000" height="75">
		<tr>
			<td width="700">Title</td>
			<td width="100">Post Date</td>
			<td width="100">User ID</td>
			<td width="100">Action</td>
		</tr>
		<c:forEach items="${posts}" var="post">
			<tr>
				<td><a href="<c:url value='/view-${post.id}-post' />">${post.title}</a></td>
				<td>${post.post_date}</td>
				<td>${post.user_id}</td>
				<c:choose>
					<c:when test="${loggedinID == post.user_id}">
						<td><a href="<c:url value='/edit-${post.id}-post' />">Edit</a>
							<a href="<c:url value='/delete-${post.id}-post' />">Delete</a></td>
					</c:when>
					<c:otherwise>
						<td>N/A</td>
					</c:otherwise>
				</c:choose>
			</tr>
		</c:forEach>
	</table>
	
	<div id="action" align="center">
		<a href="newPost">Create a new post</a> 
		<a href="logout">Log out</a> 
		<a 	href="<c:url value='/edit-${loggedinID}-user' />">Edit Account</a>
	</div>
</body>
</html>