<%@ page contentType="text/html;charset=euc-kr"%>
<%@ page import="java.sql.*" %>
<%@ page import="mybean.DBConnectionMgr" %>

<!DOCTYPE html>
<html>
<head>
<title>급여 조회</title>

<link rel="stylesheet" type="text/css" href="css/table.css">

</head>
<body>
<%@include file="inc/pasdf.jsp" %>
<%@include file="inc/buttoncss.jsp" %>

<%
	request.setCharacterEncoding("euc-kr");
	DBConnectionMgr pool = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	String search = request.getParameter("search");
	String searchText = request.getParameter("searchText");
%>
<form method="post" action="kge-sal-search.jsp">
	<select name="search">
		<option value="deptno" 
			<%if(search.equals("deptno")){%> selected="true"	<%}%>>부서코드</option>
		<option value="posname"
			<%if(search.equals("posname")){%> selected="true"	<%}%>>직급</option>
	</select>
	<input type="text" name="searchText"	/>
	<input type="submit" value="검색"	/>
</form>
<table style="border: 1px solid black" width="550" border="1">
	<tr class="lv-bg">
		<th>부서코드</th><th>직급</th><th>기본급여</th>
	</tr>
<%
	if(search==null){
		search = "deptno";
	}
	
	try{
		pool = DBConnectionMgr.getInstance();
		con = pool.getConnection();
		
		if(searchText.isEmpty()){
			sql = "select * from salary inner join positions on salary.posno=positions.posno";
		}
		else{
			// deptno, posno-posname, salary
			sql = "select * from salary inner join positions "
							+ "on " + search + " like '%" + searchText + "%' and salary.posno=positions.posno";
			//out.println(sql);
		}
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		while(rs.next()){
%>
	<tr class="lv-bg">
		<td><%=rs.getInt("deptno") %></td>
		<td><%=rs.getString("posname") %></td>
		<td><%=rs.getInt("salary") %></td>
	</tr>
<%
		}
	}
	catch(Exception err){
		System.out.println("kge-sal-search.jsp : " + err);
	}
	finally{
		pool.freeConnection(con, pstmt, rs);
	}
%>
</table>
</body>
</html>