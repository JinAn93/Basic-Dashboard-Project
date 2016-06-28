<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Page</title>
</head>

<body>
	<c:choose>
		<c:when test="${loggedinID == null}">
			<form action="validate" method="get">
				User ID: <input type="text" name="userID"><br>
				Password: <input type="password" name="password"><br> <input
					type="submit" value="Login">
			</form>
			<a href="new">Create New Account</a>

		</c:when>
		<c:otherwise>
			<%
				response.sendRedirect("http://localhost:8080/Basic-Dashboard-Project/dashboard");
			%>
		</c:otherwise>
	</c:choose>

</body>
</html>