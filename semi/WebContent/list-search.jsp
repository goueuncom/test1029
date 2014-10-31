<%@page contentType="text/html;charset=euc-kr" %>
<!DOCTYPE html >

<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %> 
 
                <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->

<html>
<head>
<link rel="stylesheet" type="text/css" href="css/table.css">

</head>

<body>
<%@include file="inc/asdf.jsp" %>
<%@include file="inc/buttoncss.jsp" %>

	<form method="post" action="list-search.jsp">
		<table style="border: 1px solid black">			
			<tr>
				<td>상품코드 : </td>
				<td><input type="text" name="code" /></td>
			</tr>
	
				<tr>
				<td colspan="2" align="center">
					<input class="b1"  type="submit" value="전송"  />&nbsp;&nbsp;&nbsp;					
				</td> 	
			</tr>			
		</table>
	</form>
	
<br/>
<table width="550" border="1">
<%
ResultSet rs = null;
Connection conn = null;                                        // null로 초기화 한다.
PreparedStatement pstmt = null;

try{
	String url = "jdbc:mysql://192.168.10.49:3306/testboard";
	String id = "root";                                                    // 사용자 계정
	String pw = "1234";                                                // 사용자 계정의 패스워드

	Class.forName("com.mysql.jdbc.Driver");                      // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
	conn=DriverManager.getConnection(url,id,pw); 
	String a = request.getParameter("code");
	if(a != ""){
	String sql = "select * from tlist where code = ?";                        // sql 쿼리
	pstmt = conn.prepareStatement(sql);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.
	pstmt.setString(1,a);
	}
	if(a == ""){
		String sql1 = "select * from tlist order by code";                        // sql 쿼리
		pstmt = conn.prepareStatement(sql1);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.
		
	}

	rs = pstmt.executeQuery();                                        // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
%>
	<tr class="lv-bg">
		<td width="200">상품코드</td>
		<td width="100">상품명</td>
		<td width="100">업체명</td>		
		<td width="100">입고단가</td>
		<td width="100">판매단가</td>
		<td width="100">부서번호</td>
	</tr>
<%	
	while(rs.next()){                                                        // 결과를 한 행씩 돌아가면서 가져온다.
		int code = rs.getInt("code");
		String iname = rs.getString("iname");
		String cname = rs.getString("cname");
		int price = rs.getInt("price");
		int sprice = rs.getInt("sprice");
		int des = rs.getInt("des");
		
		
%>		
	<tr class="lv-bg">
		<td width="200"><%=code%></td>
		<td width="100"><%=iname%></td>
		<td width="100"><%=cname%></td>
		<td width="100"><%=price%></td>
		<td width="100"><%=sprice%></td>
		<td width="100"><%=des%></td>
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