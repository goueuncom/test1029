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

<title>Lily Pads by Free Css Templates</title>

<link href="default.css" rel="stylesheet" type="text/css" />
</head>
<body>

  <div id="header">
	<h1>4조 재고관리</h1>
  </div>
 
  <div id="menu">
    <ul>
      <li><a href="#">Home</a></li>
      <li><a href="add-list.jsp">재고관리</a></li>
      <li><a href="plist-search.jsp">인사관리</a></li>
      <li><a href="#">Contact</a></li>
    </ul>
  </div>

</body>
</html>
