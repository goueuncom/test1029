<%@page contentType="text/html;charset=euc-kr" %>
<!DOCTYPE html >
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %> 
                <!-- JSP에서 JDBC의 객체를 사용하기 위해 java.sql 패키지를 import 한다 -->

<html>
<head>
<link rel="stylesheet" type="text/css" href="css/table.css">
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
</head>

<body>
<%@include file="inc/pasdf.jsp" %>
<%@include file="inc/buttoncss.jsp" %>

	<form method="post" action="plist-search.jsp">
		<div style="border: 1px" >			
			<div>
				<div>사원조회</div><br/>
				<div>사원명 : <input type="text" name="name" /></div>
				<div>사원코드 : <input type="text" name="code" /></div>
				<div>입사날짜 : <input type="text" id="datepicker" name="day" /></div>
           		<div>부서코드 : <input type="text" name="des" /></div>
				
			</div>
	<hr/>
			
				<div>					
					<input class="b1" type="submit" value="전송" /> 					
					 					
				</div>
					
		</div>
	</form>
	
<br/>
<table width="550" border="1">
	<tr class="lv-bg">
		<td width="50">사원코드</td>
		<td width="50">사원명</td>
		<td width="50">부서번호</td>
		<td width="50">직급</td>
		<td width="50">입사일자</td>
	</tr>
<%
ResultSet rs = null;
Connection conn = null;                                        // null로 초기화 한다.
PreparedStatement pstmt = null;
///사원번호 + 전체검색
try{
	String url = "jdbc:mysql://localhost:3306/testboard";
	String id = "root";                                                    // 사용자 계정
	String pw = "1234";                                                // 사용자 계정의 패스워드
	String sql=null;
	Class.forName("com.mysql.jdbc.Driver");                      // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
	conn=DriverManager.getConnection(url,id,pw); 
	String c = request.getParameter("code");	
	String day = request.getParameter("day");	
	String des = request.getParameter("des");	
	String name = request.getParameter("name");
	
	if(c == "" && day ==""  && des=="" && name == ""){
		sql = "select pcode,pname,pdes,phdate,posname from plist p , pposit s "+
		"where p.pnum = s.pnum order by pcode";                        // sql 쿼리
		pstmt = conn.prepareStatement(sql);                         // prepareStatement에서 해당 sql을 미리 컴파일한다.
		}
	if(c != "" ){
	sql = "select pcode,pname,pdes,phdate,posname from plist p , pposit s "+
	"where p.pnum = s.pnum and pcode = ?"; 
	pstmt = conn.prepareStatement(sql);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.
	pstmt.setString(1,c);// sql 쿼리
	}

	
	rs = pstmt.executeQuery(); 


	                                        // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
%>

<%	
	while(rs.next()){                                                        // 결과를 한 행씩 돌아가면서 가져온다.
		int pcode = rs.getInt("pcode");
		String pname = rs.getString("pname");
		int pdes = rs.getInt("pdes");
		String posname = rs.getString("posname");
		String phdate = rs.getString("phdate");
		
		
%>		
	<tr class="lv-bg">
		<td width="50"><%=pcode%></td>
		<td width="50"><%=pname%></td>
		<td width="50"><%=pdes%></td>
		<td width="50"><%=posname%></td>
		<td width="50"><%=phdate%></td>
 
	</tr>

<%
		}

	}
	catch(Exception e){                                                    // 예외가 발생하면 예외 상황을 처리한다.
		/* e.printStackTrace();
		out.println("member 테이블 호출에 실패했습니다."); */
	}
///이름검색
try{
	String url = "jdbc:mysql://localhost:3306/testboard";
	String id = "root";                                                    // 사용자 계정
	String pw = "1234";                                                // 사용자 계정의 패스워드

	Class.forName("com.mysql.jdbc.Driver");                      // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
	conn=DriverManager.getConnection(url,id,pw); 
	String a = request.getParameter("name");	
	
	String sql1 = "select pcode,pname,pdes,phdate,posname from plist p , pposit s "+
	"where p.pnum = s.pnum and pname = ?";                        // sql 쿼리
	
	pstmt = conn.prepareStatement(sql1);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.
	pstmt.setString(1,a);
	


	rs = pstmt.executeQuery();                                        // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
%>

<%	
	while(rs.next()){                                                        // 결과를 한 행씩 돌아가면서 가져온다.
		int pcode = rs.getInt("pcode");
		String pname = rs.getString("pname");
		int pdes = rs.getInt("pdes");
		String posname = rs.getString("posname");
		String phdate = rs.getString("phdate");
		
	
%>		
	<tr class="lv-bg">
		<td width="50"><%=pcode%></td>
		<td width="50"><%=pname%></td>
		<td width="50"><%=pdes%></td>
		<td width="50"><%=posname%></td>
		<td width="50"><%=phdate%></td>
 
	</tr>

<%
		}

	}
	catch(Exception e){                                                    // 예외가 발생하면 예외 상황을 처리한다.
		/* e.printStackTrace();
		out.println("member 테이블 호출에 실패했습니다."); */
	}
////부서번호
try{
	String url = "jdbc:mysql://localhost:3306/testboard";
	String id = "root";                                                    // 사용자 계정
	String pw = "1234";                                                // 사용자 계정의 패스워드

	Class.forName("com.mysql.jdbc.Driver");                      // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
	conn=DriverManager.getConnection(url,id,pw); 
	String des = request.getParameter("des");	
	
	String sql1 = "select pcode,pname,pdes,phdate,posname from plist p , pposit s "+
	"where p.pnum = s.pnum and pdes = ?";                        // sql 쿼리
	
	pstmt = conn.prepareStatement(sql1);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.
	pstmt.setString(1,des);
	


	rs = pstmt.executeQuery();                                        // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
%>

<%	
	while(rs.next()){                                                        // 결과를 한 행씩 돌아가면서 가져온다.
		int pcode = rs.getInt("pcode");
		String pname = rs.getString("pname");
		int pdes = rs.getInt("pdes");
		String posname = rs.getString("posname");
		String phdate = rs.getString("phdate");
		

%>		
	<tr class="lv-bg">
		<td width="50"><%=pcode%></td>
		<td width="50"><%=pname%></td>
		<td width="50"><%=pdes%></td>
		<td width="50"><%=posname%></td>
		<td width="50"><%=phdate%></td>
	
	</tr>

<%
		}

	}
	catch(Exception e){                                                    // 예외가 발생하면 예외 상황을 처리한다.
		/* e.printStackTrace();
		out.println("member 테이블 호출에 실패했습니다."); */
	}
////입사일
try{
String url = "jdbc:mysql://localhost:3306/testboard";
String id = "root";                                                    // 사용자 계정
String pw = "1234";                                                // 사용자 계정의 패스워드

Class.forName("com.mysql.jdbc.Driver");                      // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
conn=DriverManager.getConnection(url,id,pw); 
String day = request.getParameter("day");	

String sql1 = "select pcode,pname,pdes,phdate,posname from plist p , pposit s "+
"where p.pnum = s.pnum and phdate = ?";                        // sql 쿼리

pstmt = conn.prepareStatement(sql1);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.
pstmt.setString(1,day);



rs = pstmt.executeQuery();                                        // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.
%>

<%	
while(rs.next()){                                                        // 결과를 한 행씩 돌아가면서 가져온다.
	int pcode = rs.getInt("pcode");
	String pname = rs.getString("pname");
	int pdes = rs.getInt("pdes");
	String posname = rs.getString("posname");
	String phdate = rs.getString("phdate");
	

%>		
<tr class="lv-bg">
	<td width="50"><%=pcode%></td>
	<td width="50"><%=pname%></td>
	<td width="50"><%=pdes%></td>
	<td width="50"><%=posname%></td>
	<td width="50"><%=phdate%></td>

</tr>

<%
	}

}
catch(Exception e){                                                    // 예외가 발생하면 예외 상황을 처리한다.
	/* e.printStackTrace();
	out.println("member 테이블 호출에 실패했습니다."); */
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