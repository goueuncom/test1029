<%@page contentType="text/html;charset=euc-kr" %>
<!DOCTYPE html >
<%@ page import="java.sql.Connection,java.sql.Date,java.sql.DriverManager
,java.sql.ResultSet,java.sql.SQLException,java.sql.SQLIntegrityConstraintViolationException,
java.sql.Statement,java.util.Scanner" %>
<%@ page import = "java.sql.*" %> 
                <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->

<html>
<head>
<link rel="stylesheet" type="text/css" href="css/table.css">
</head>
<body>
<%@include file="inc/asdf.jsp" %>
<%@include file="inc/buttoncss.jsp" %>
<form method="post" action="input-all-search.jsp">
정렬 : 
<input type="radio" name="code" value="code" />상품코드&nbsp;
<input type="radio" name="code" value="count" />갯수&nbsp;
<input type="radio" name="code" value="idate" />입고일&nbsp;
<input class="b1" type="submit" value="정렬" />&nbsp;
</form>


<table width="550" border="1">
<%
ResultSet rs = null;
Connection conn = null;                                        // null로 초기화 한다.
Statement pstmt = null;

try{
	String url = "jdbc:mysql://localhost:3306/testboard";        // 사용하려는 데이터베이스명을 포함한 URL 기술
	String id = "root";                                                    // 사용자 계정
	String pw = "1234";                                                // 사용자 계정의 패스워드

	Class.forName("com.mysql.jdbc.Driver");                           // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
	conn=DriverManager.getConnection(url,id,pw);
	
	request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");
	String sort = request.getParameter("code");
	
	out.println(sort);
	String sql = "select * from tinput order by "+sort;                        // sql 쿼리
	out.println(sql);
	pstmt = conn.createStatement();                       // prepareStatement에서 해당 sql을 미리 컴파일한다.
	rs = pstmt.executeQuery(sql);                                        // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
%>
	<tr class="lv-bg">
		<td width="100">상품코드</td>
		<td width="100">상품명</td>
		<td width="100">입고갯수</td>
		<td width="100">입고일</td>
	</tr>
<%	
	while(rs.next()){                                                        // 결과를 한 행씩 돌아가면서 가져온다.
		int code = rs.getInt("code");
		String name = rs.getString("name");
		int count = rs.getInt("count");
		Date date = rs.getDate("idate");	
		
%>		
	<tr>
		<td width="100"><%=code%></td>
		<td width="100"><%=name%></td>
		<td width="100"><%=count%></td>
		<td width="100"><%=date%></td>
	</tr>

<%
		}

	}
	catch(Exception e){                                                    // 예외가 발생하면 예외 상황을 처리한다.
		e.printStackTrace();
		out.println("member 테이블 호출에 실패했습니다.");
	}
	finally	{                                                            // 쿼리가 성공 또는 실패에 상관없이 사용한 자원을 해제 한다.  (순서중요)
		if(rs != null) try{rs.close();}catch(SQLException sqle){}            // Resultset 객체 해제
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}   // PreparedStatement 객체 해제
		if(conn != null) try{conn.close();}catch(SQLException sqle){}   // Connection 해제
	}
%>
</table>
</body>
</html>