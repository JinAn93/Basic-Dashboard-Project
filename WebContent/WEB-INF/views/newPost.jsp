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

body {
	margin: auto;
	text-align: center;
	padding: 70px;
	font-family: Helvetica;
}

input {
	font-family: Helvetica;
}

h1 {
	text-align: center;
}

tr {
	border: 1px solid black;
}

.postForm {
	margin-left: 300px;
	margin-right: 300px;
	width: 1000px; 
	height: 500px;
	text-align: center;
}

#title{
	height: 40px;
	width: 750px;
	padding: 30px;
}

#contents{
	height: 400px;
	width: 750px;
	padding: 30px;
}

</style>

</head>

<body>
	<form:form method="POST" modelAttribute="post" onkeypress="return entercheck(event)">
		<table class="postForm" >
			<tr>
				<td height="50" width="150"><label for="title">Title: </label></td>
				<td height="50" width="750"><form:input path="title" id="title"/></td>
				<td height="50" width="100"><form:errors path="title" cssClass="error" /></td>
			</tr>

			<tr>
				<td><label for="contents">Contents: </label></td>
				<td><form:textarea rows="60" cols="200" path="contents" id="contents"/></td>
				<td><form:errors path="contents" cssClass="error" /></td>
			</tr>

			<tr>
				<td><form:input path="user_id" type="hidden" value="<%=session.getAttribute("user_id")%>" /></td>
			</tr>
		</table>

		<script>
			function entercheck(e){
				if(e.keyCode == 13){
					document.ge.getElementById('contents').innerHTML+="<br />";
					return false;
				}
				return true;
			}
		</script>
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