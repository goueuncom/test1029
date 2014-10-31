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

	<form method="post" action="des-sal-search.jsp">
			
			<div>
				<div></div><br/>
				<div>부서번호 검색 : <input type="text" name="des" /></div>				
				<div>직급 검색 : <input type="text" name="posname" /></div>				
			</div>
			<hr/>
			<div>
				<div>
					<input class="b1"  type="submit" value="전송"  />&nbsp;&nbsp;&nbsp;					
				</div> 	
			</div>			
		
	</form>
	
<br/>
<table width="550" border="1">
<%
ResultSet rs = null;
Connection conn = null;                                        // null로 초기화 한다.
PreparedStatement pstmt = null;
 

///직급검색
try{
	String url = "jdbc:mysql://localhost:3306/testboard";
	String id = "root";                                                    // 사용자 계정
	String pw = "1234";                                                // 사용자 계정의 패스워드

	Class.forName("com.mysql.jdbc.Driver");                      // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
	conn=DriverManager.getConnection(url,id,pw); 
	response.setCharacterEncoding("euc-kr");
	request.setCharacterEncoding("euc-kr");
	
	String posname1 = request.getParameter("posname");
	
		String sql1 = "select pdes , posname , psa from pposit p , psal s where p.pnum = s.pnum and posname=?"; 
		pstmt = conn.prepareStatement(sql1);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.
		pstmt.setString(1,posname1);
		rs = pstmt.executeQuery();// sql 쿼리
	
	%>
		<tr class="lv-bg">		
			<td width="50">부서번호</td>
			<td width="50">직급</td>
			<td width="50">급여</td>
		</tr>
	<%	

		while(rs.next()){	
			int pdes = rs.getInt("pdes");
		String posname = rs.getString("posname");	
		int psa = rs.getInt("psa");
	%>		
	<tr class="lv-bg">
		<td width="50"><%=pdes%></td>
		<td width="50"><%=posname%></td>
		<td width="50"><%=psa%></td>
	</tr>

	<%
	}
	}
	catch(Exception e){                                                    // 예외가 발생하면 예외 상황을 처리한다.
		//e.printStackTrace();
		//out.println("member 테이블 호출에 실패했습니다.");
	}
///전체검색 , 부서번호검색
try{
	String url = "jdbc:mysql://localhost:3306/testboard";
	String id = "root";                                                    // 사용자 계정
	String pw = "1234";                                                // 사용자 계정의 패스워드

	Class.forName("com.mysql.jdbc.Driver");                      // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
	conn=DriverManager.getConnection(url,id,pw); 
	String des = request.getParameter("des");
	String posname1 = request.getParameter("posname");
	 
	if(des == "" && posname1 == ""){
		String sql = "select pdes , posname , psa from pposit p , psal s where p.pnum = s.pnum";
		pstmt = conn.prepareStatement(sql);                        // prepareStatement에서 해당 sql을 미리 컴파일한다.
	}
	
	if(des != ""){
		String sql1 = "select pdes , posname , psa from pposit p , psal s where p.pnum = s.pnum and pdes=?"; 
		pstmt = conn.prepareStatement(sql1);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.
		pstmt.setString(1,des);
	}	
	
		rs = pstmt.executeQuery();// sql 쿼리
	

	while(rs.next()){	
	int pdes = rs.getInt("pdes");
	String posname = rs.getString("posname");	
	int psa = rs.getInt("psa");
%>		
<tr class="lv-bg">
	<td width="50"><%=pdes%></td>
	<td width="50"><%=posname%></td>
	<td width="50"><%=psa%></td>
</tr>

<%
}
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