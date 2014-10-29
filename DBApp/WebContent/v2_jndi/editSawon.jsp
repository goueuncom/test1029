<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.DataSource" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>사원 수정</title>
</head>
<body>
<%
	String no = request.getParameter("no");
	out.println(no);
	String id = null;
	String name = null;
	String pass = null;
	String age = null;
	String addr = null;
	String ext = null;
	String dept = null;
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/DBL3");
		con = ds.getConnection();
		/* 
		Class.forName("org.gjt.mm.mysql.Driver");
		String url = "jdbc:mysql://localhost:3306/dbl3";
		con = DriverManager.getConnection(url, "root", "1111");
		 */
		String sql = "select * from tblsawon where no=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, no);
		rs = pstmt.executeQuery();

		if(rs.next()){
			id = rs.getString("id");
			name = rs.getString("name");
			pass = rs.getString("pass");
			age = new String().valueOf(rs.getInt("age"));
			addr = rs.getString("addr");
			ext = rs.getString("ext");
			dept = rs.getString("dept");
		}
	}
	catch(Exception err){
		System.out.println("editSawon.jsp : " + err);
	}
	finally{
		if(rs != null) try{rs.close();}catch(SQLException sqle){}
		if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}
		if(con != null) try{con.close();}catch(SQLException sqle){}
	}
%>
<h1>사원 수정</h1>
<form method="post" action="editSawon_proc.jsp">
<!-- hidden의 적절한 용도 -->
<input type="hidden" name="no" value="<%=no %>"	/>
<table border="1">
	<tr>
		<td>ID : </td>
		<td><input type="text" name="id" value="<%=id %>"	/></td>
	</tr>
	<tr>
		<td>이름 : </td>
		<td><input type="text" name="name" value="<%=name %>"	/></td>
	</tr>
	<tr>
		<td>패스워드 : </td>
		<td><input type="text" name="pass" value="<%=pass %>"	/></td>
	</tr>
	<tr>
		<td>나이 : </td>
		<td><input type="text" name="age"	 value="<%=age%>"/></td>
	</tr>
	<tr>
		<td>근무지 : </td>
		<td>
			<select name="addr">
				<option value="서울" <%if(addr.equals("서울")){ %>
						 selected="true"	<%}%>>서울</option>
				<option value="경기" <%if(addr.equals("경기")){ %>
						 selected="true"	<%}%>>경기</option>
				<option value="광주" <%if(addr.equals("광주")){ %>
						 selected="true"	<%}%>>광주</option>
				<option value="부산" <%if(addr.equals("부산")){ %>
						 selected="true"	<%}%>>부산</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>내선 번호 : </td>
		<td><input type="text" name="ext" value="<%=ext %>"	/></td>
	</tr>
	<tr>
		<td>부서명 : </td>
		<td>
			<select name="dept">
				<option value="영업" <%if(dept.equals("영업")){ %>
						selected="true"<%}%>>영업</option>
				<option value="기술" <%if(dept.equals("기술")){ %>
						selected="true"<%}%>>기술</option>
				<option value="기획" <%if(dept.equals("기획")){ %>
						selected="true"<%}%>>기획</option>
			</select>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="수정"	/>&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="reset" value="다시 작성"	/>
		</td>
	</tr>
</table>
</form>
</body>
</html>