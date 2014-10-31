<%@page contentType="text/html;charset=euc-kr" %>
<!DOCTYPE html >
<%@ page import="java.sql.Connection,java.sql.Date,java.sql.DriverManager
,java.sql.ResultSet,java.sql.SQLException,java.sql.SQLIntegrityConstraintViolationException,
java.sql.Statement,java.util.Scanner" %>
<%@ page import = "java.sql.*" %> 
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

   <form method="post" action="output.jsp">
      <div style="border: 1px" >         
         <div>
            <div>입고입력</div>
            <div>상품코드 : <input type="text" name="code" /></div>            
            <div>입고갯수 : <input type="text" name="count" /></div>
            <div>입고날짜 : <input type="text" id="datepicker" name="date" /></div>
         </div>
   <hr/>
         
            <div>               
               <input class="b1" type="submit" value="전송" />               
            </div>
               
      </div>
   </form>


<table width="550" border="1">
<%
ResultSet rs = null;
Connection conn = null;                                        // null로 초기화 한다.
PreparedStatement pstmt = null;
Statement stmt = null;

try{
   /* String url = "jdbc:oracle:thin:@192.168.10.49:1521:orcl";        // 사용하려는 데이터베이스명을 포함한 URL 기술
   String id = "jointest";                                                    // 사용자 계정
   String pw = "1111";                                                // 사용자 계정의 패스워드
   
   Class.forName("oracle.jdbc.OracleDriver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
   conn=DriverManager.getConnection(url,id,pw);  */
   
   String url = "jdbc:mysql://localhost:3306/testboard";        // 사용하려는 데이터베이스명을 포함한 URL 기술
   String id = "root";                                                    // 사용자 계정
   String pw = "1234";                                                // 사용자 계정의 패스워드

   Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
   conn=DriverManager.getConnection(url,id,pw);              // DriverManager 객체로부터 Connection 객체를 얻어온다.
   
   
   String a = request.getParameter("code");
   String count = request.getParameter("count");
   String date = request.getParameter("date");
   out.println("여기1");	
   String sql = "select iname, cname, price, sprice , des from tlist where code = ?";                         // sql 쿼리
   pstmt = conn.prepareStatement(sql);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.
   pstmt.setString(1, a);
   rs = pstmt.executeQuery();   	
   rs.next();   
   String iname = rs.getString("iname");
   String cname = rs.getString("cname");
   int price = rs.getInt("price");
   int sprice = rs.getInt("sprice");
   int des = rs.getInt("des");
   out.println("여기");	
   String sql3 = "update tstock set count = count- ? where code=?";
   pstmt = conn.prepareStatement(sql3);
        
   pstmt.setString(1, count); //code
   pstmt.setString(2, a); // count
   int result = pstmt.executeUpdate();   
   out.println(result);
    if(result == 0){
    	out.println("업뎃");
       String sql2 = "insert into tstock values(?, ?, ?, ?, ?, ?,?)";
       System.out.println(sql2);
       pstmt = conn.prepareStatement(sql2);
       pstmt.setString(1, a); //code
       pstmt.setString(2, iname); // iname
       pstmt.setString(3, cname); // cname
       pstmt.setString(4, count); // count
       pstmt.setInt(5, price); // price
       pstmt.setInt(6, sprice); // sprice
       pstmt.setInt(7, des); // desc
       pstmt.executeUpdate();
       
       String sql4 = "insert into toutput values(? , ?, ?, ?,?)";
       
       pstmt = conn.prepareStatement(sql4);
       pstmt.setString(1, a);
       pstmt.setString(2, iname);
       pstmt.setString(3, count);
       pstmt.setString(4, date); //날짜
       pstmt.setInt(5, des); // desc
       pstmt.executeUpdate();
    }
    else{    	
       String sql4 = "insert into toutput values(?, ?, ?, ?,?)";            
       pstmt = conn.prepareStatement(sql4);
       pstmt.setString(1, a);
       pstmt.setString(2, iname);
       pstmt.setString(3, count);
       pstmt.setString(4, date); //날짜
       pstmt.setInt(5, des); // desc
       pstmt.executeUpdate();
    }
  
   }
   catch(Exception e){                                                    // 예외가 발생하면 예외 상황을 처리한다.
     //e.printStackTrace();
	    String a = request.getParameter("code");
      if(a != null)
      out.println("입력된 값이 없거나 리스트에 없는 상품입니다."); 
   }
   finally   {                                                            // 쿼리가 성공 또는 실패에 상관없이 사용한 자원을 해제 한다.  (순서중요)
      if(rs != null) try{rs.close();}catch(SQLException sqle){}            // Resultset 객체 해제
      if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}   // PreparedStatement 객체 해제
      if(conn != null) try{conn.close();}catch(SQLException sqle){}   // Connection 해제
   }
%>
</table>
</body>
</html>