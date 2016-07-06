<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Success Confirmation Page</title>
</head>

<style>
body {
	text-align: center;
	font-family: Helvetica;
}
</style>
<body>
	<h4>${success}</h4>
	<br />
	<%
		String loggedinID = (String) session.getAttribute("user_id");
		request.setAttribute("loggedinID", loggedinID);
	%>
	<c:choose>
		<c:when test="${loggedinID != null}">
			Go to <a href="dashboard">Dashboard</a>
		</c:when>
		<c:otherwise>
			<a href="login">Login Here!</a>
		</c:otherwise>
	</c:choose>
</body>
</html>