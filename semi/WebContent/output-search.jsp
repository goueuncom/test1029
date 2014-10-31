<%@page contentType="text/html;charset=euc-kr" %>
<!DOCTYPE html >
<%@ page import="java.sql.Connection,java.sql.Date,java.sql.DriverManager
,java.sql.ResultSet,java.sql.SQLException,java.sql.SQLIntegrityConstraintViolationException,
java.sql.Statement,java.util.Scanner" %>
<%@ page import = "java.sql.*" %> 
<%@ page import = "java.util.*" %> 
                <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->

<html>
<head>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script>
  $(function() {
    $( "#datepicker" ).datepicker({
    	dateFormat:"yy/mm/dd"
    });
  });
  </script>
 <link rel="stylesheet" type="text/css" href="css/table.css">
</head>


<body>
<%@include file="inc/asdf.jsp" %>
<%@include file="inc/buttoncss.jsp" %>
<br/>
	<form name="f" method="post" action="output-search.jsp">
		<div style="border: 1px" >			
			<div>
				<div>출고조회</div><br/>
				<div>상품명 : <input type="text" name="name" /></div>
				<div>상품코드 : <input type="text" name="code" /></div>
				<div>날짜 : <input type="text" name="day" id="datepicker" /></div>
           		<div>부서명 : <input type="text" name="des" /></div>
				
			</div>
	<hr/>
			
				<div>					
					<input class="b1" type="submit" value="전송" />				
				</div>
					
		</div>
	</form>


				
<br/>
<table width="550" border="1">
<br/>
<%

ResultSet rs = null;
Connection conn = null;                                        // null로 초기화 한다.
PreparedStatement pstmt = null;

try{
	String url = "jdbc:mysql://localhost:3306/testboard";        // 사용하려는 데이터베이스명을 포함한 URL 기술
	String id = "root";                                                    // 사용자 계정
	String pw = "1234";                                                // 사용자 계정의 패스워드

	Class.forName("com.mysql.jdbc.Driver");                      // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
	conn=DriverManager.getConnection(url,id,pw); 
	response.setCharacterEncoding("euc-kr");
	request.setCharacterEncoding("euc-kr");
	/* String a = ;	
	String c = request.getParameter("name"); */	

	String sql = "select * from toutput where name = ?";                        // sql 쿼리
	pstmt = conn.prepareStatement(sql);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.
	pstmt.setString(1,request.getParameter("name"));
	

	rs = pstmt.executeQuery();                                        // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
%>
	<tr class="lv-bg">
		<td width="100">상품코드</td>
		<td width="100">상품명</td>
		<td width="100">출고갯수</td>
		<td width="100">출고일</td>
		<td width="100">부서번호</td>
	</tr>
<%	
	while(rs.next()){                                                        // 결과를 한 행씩 돌아가면서 가져온다.
		int code = rs.getInt("code");
		String name = rs.getString("name");
		int count = rs.getInt("count");
		Date odate = rs.getDate("odate");
		int des = rs.getInt("des");
		
%>

	<tr class="lv-bg">
		<td width="100"><%=code%></td>
		<td width="100"><%=name%></td>
		<td width="100"><%=count%></td>
		<td width="100"><%=odate.toString()%></td>
		<td width="100"><%=des%></td>
	</tr>
<%
		}
	//String b = request.getParameter("code");
	//String sql1 = "select * from toutput where ((instr(name , ? , 1))>0)";// sql 쿼리
}
catch(SQLException e){
	String a = request.getParameter("name");
	if(a != null)
	out.println("입력된 값이 없거나 리스트에 없는 상품입니다.");
}
///코드검색
try{
	String sql1 = "select * from toutput where code = ?";
	pstmt = conn.prepareStatement(sql1);                          
	pstmt.setString(1,request.getParameter("code"));
	rs = pstmt.executeQuery();                                    
	
	while(rs.next()){                                             
		int code = rs.getInt("code");
		String name = rs.getString("name");
		int count = rs.getInt("count");
		Date odate = rs.getDate("odate");
		int des = rs.getInt("des");
	 	
%>

	<tr>
		<td width="100"><%=code%></td>
		<td width="100"><%=name%></td>
		<td width="100"><%=count%></td>
		<td width="100"><%=odate.toString()%></td>
		<td width="100"><%=des%></td>
	</tr> 
<%
		}


	}
	catch(Exception e){
		e.printStackTrace();
	}
///날짜검색
try{
	String sql1 = "select * from toutput where odate = ?";
	pstmt = conn.prepareStatement(sql1);                          
	pstmt.setString(1,request.getParameter("day"));
	rs = pstmt.executeQuery();                                    
	
	while(rs.next()){                                             
		int code = rs.getInt("code");
		String name = rs.getString("name");
		int count = rs.getInt("count");
		Date odate = rs.getDate("odate");
		int des = rs.getInt("des");
	 	
%>

	<tr>
		<td width="100"><%=code%></td>
		<td width="100"><%=name%></td>
		<td width="100"><%=count%></td>
		<td width="100"><%=odate.toString()%></td>
		<td width="100"><%=des%></td>
	</tr> 
<%
		}


	}
	catch(Exception e){
		e.printStackTrace();
	}
///날짜검색 연도제외 2번
try{
	String sql1 = "select * from toutput where odate = ?";
	pstmt = conn.prepareStatement(sql1);                          
	pstmt.setString(1,"14/"+request.getParameter("day"));
	rs = pstmt.executeQuery();                                    
	
	while(rs.next()){                                             
		int code = rs.getInt("code");
		String name = rs.getString("name");
		int count = rs.getInt("count");
		Date odate = rs.getDate("odate");
		int des = rs.getInt("des");
	 	
%>

	<tr>
		<td width="100"><%=code%></td>
		<td width="100"><%=name%></td>
		<td width="100"><%=count%></td>
		<td width="100"><%=odate.toString()%></td>
		<td width="100"><%=des%></td>
	</tr> 
<%
		}


	}
	catch(Exception e){
		e.printStackTrace();
	}
///부서명검색
try{
	String sql1 = "select * from toutput where des = ?";
	pstmt = conn.prepareStatement(sql1);                          
	pstmt.setString(1,request.getParameter("des"));
	rs = pstmt.executeQuery();                                    
	
	while(rs.next()){                                             
		int code = rs.getInt("code");
		String name = rs.getString("name");
		int count = rs.getInt("count");
		Date odate = rs.getDate("odate");
		int des = rs.getInt("des");
	 	
%>

	<tr>
		<td width="100"><%=code%></td>
		<td width="100"><%=name%></td>
		<td width="100"><%=count%></td>
		<td width="100"><%=odate.toString()%></td>
		<td width="100"><%=des%></td>
	</tr> 
<%
		}


	}
	catch(Exception e){
		e.printStackTrace();
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