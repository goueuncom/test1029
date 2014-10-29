<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<title>오라클 연결 테스트</title>
</head>
<body>
<%
	try{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		Connection con = DriverManager.getConnection(url, "scott", "1111");
		
		if(con != null)
			out.println("연결 성공");
		else
			out.println("연결 실패");
	}
	catch(Exception err){
		System.out.println("연결 실패 : " + err);
	}
	finally{
		
	}
%>
</body>
</html>