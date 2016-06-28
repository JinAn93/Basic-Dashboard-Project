<%--
	Document	: validate
	Created on	: June 20th, 2016
	Author		: Seung Jin An
--%>

<%@ page import="java.sql.*"%>
<%
	try {
		String user_id = request.getParameter("userID");
		String password = request.getParameter("password");
		Class.forName("com.mysql.jdbc.Driver"); // Connect to MySQL database
		Connection conn = DriverManager
				.getConnection("jdbc:mysql://localhost:3306/dashboard?"
						+ "user=root&password=");
		PreparedStatement pst = conn
				.prepareStatement("Select * from users  where user_id=? and password=?");
		pst.setString(1, user_id);
		pst.setString(2, password);
		ResultSet rs = pst.executeQuery();
		if (rs.next()){
			session.setAttribute("user_id", user_id);
			response.sendRedirect("http://localhost:8080/Basic-Dashboard-Project/dashboard");
		}
		else
			out.println("Invalid password <a href='http://localhost:8080/Basic-Dashboard-Project/login'> try again</a>");
	} catch (Exception e) {
		out.println("Try again!");
	}
%>
