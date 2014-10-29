<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.DataSource" %>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>
<h1>JNDI를 이용한 DB연결 테스트</h1>
<%
	try{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/DBL3");
			// 대소문자도 틀려선 X/java:comp/env : 가상 프로젝트/Object->DataSource
		Connection con = ds.getConnection();
			
		if(con != null)
			out.println("연결 성공");
	}
	catch(Exception err){
		System.out.println("연결 실패 : " + err);
	}
%>
</body>
</html>