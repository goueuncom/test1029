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
<%@include file="inc/pasdf.jsp" %>
<%@include file="inc/buttoncss.jsp" %>

	<form method="post" action="sal-search.jsp">
		<table style="border: 1px solid black">			
			<tr>
				<td>사원번호 검색 : </td>
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
int pdes = 0 , pnum=0;
try{
	String url = "jdbc:mysql://192.168.10.49:3306/testboard";
	String id = "root";                                                    // 사용자 계정
	String pw = "1234";                                                // 사용자 계정의 패스워드

	Class.forName("com.mysql.jdbc.Driver");                      // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
	conn=DriverManager.getConnection(url,id,pw); 
	String a = request.getParameter("code");
	
	String sql = "select phdate,psa,pname,p.pdes,p.pnum from plist p , psal s where p.pdes = s.pdes and p.pnum = s.pnum and pcode = ?";                        // sql 쿼리
	pstmt = conn.prepareStatement(sql);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.
	pstmt.setString(1,a);
	rs = pstmt.executeQuery();                                        // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
	
	rs.next();
	String phdate = rs.getString("phdate");	
	int psa = rs.getInt("psa");
	String pname = rs.getString("pname");	
	pdes = rs.getInt("p.pdes");
	pnum = rs.getInt("pnum");
	
	String sql1 = "select posname from pposit where pnum = ?";                        // sql 쿼리
	pstmt = conn.prepareStatement(sql1);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.
	pstmt.setInt(1,pnum);
	rs = pstmt.executeQuery();
	
	rs.next();
	String posname = rs.getString("posname");
	//psa = psa - 50000;
	%>
	<tr class="lv-bg">
		<td width="50">사원코드</td>
		<td width="50">사원명</td>
		<td width="50">부서번호</td>
		<td width="50">직급</td>
		<td width="50">급여</td>
		<td width="50">입사일자</td>
	</tr>
<%	

%>		
<tr class="lv-bg">
	<td width="50"><%=a%></td>
	<td width="50"><%=pname%></td>
	<td width="50"><%=pdes%></td>
	<td width="50"><%=posname%></td>
	<td width="50"><%=psa%></td>
	<td width="50"><%=phdate%></td>

</tr>

<%

	}
	catch(Exception e){                                                    // 예외가 발생하면 예외 상황을 처리한다.
		//e.printStackTrace();
		//out.println("member 테이블 호출에 실패했습니다.");
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