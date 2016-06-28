<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Post Creation Form</title>

<style>
.error {
	color: #ff0000;
}
</style>

</head>

<body>
	<form:form method="POST" modelAttribute="post">
		<table>
			<tr>
				<td><label for="title">Title: </label></td>
				<td><form:input path="title" id="title" /></td>
				<td><form:errors path="title" cssClass="error" /></td>
			</tr>

			<tr>
				<td><label for="contents">Contents: </label></td>
				<td><form:input path="contents" id="contents" /></td>
				<td><form:errors path="contents" cssClass="error" /></td>
			</tr>

			<tr>
				<td><form:input path="user_id" type="hidden"
						value="<%=session.getAttribute("user_id")%>" /></td>
			</tr>
		</table>

		<c:choose>
			<c:when test="${edit}">
				<input type="submit" value="Edit" />
			</c:when>
			<c:otherwise>
				<input type="submit" value="Create Post!" />
			</c:otherwise>
		</c:choose>
	</form:form>
	<br />
	<br /> Go back to
	<a href="dashboard">Dashboard</a>
</body>
</html>