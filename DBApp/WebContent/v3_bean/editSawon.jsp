<%@page import="mybean.SawonDto"%>
<%@page import="mybean.DBConnectionMgr"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>사원 수정</title>
</head>
<body>
<jsp:useBean id="dao" class="mybean.SawonDao"	/>
<jsp:useBean id="dto" class="mybean.SawonDto"	/>
<%
	request.setCharacterEncoding("euc-kr");
	int no = Integer.parseInt(request.getParameter("no"));
	out.println(no);
	
	try{
		dto = (SawonDto)dao.getSawon(no);
	}
	catch(Exception err){
		System.out.println("editSawon.jsp : " + err);
	}
%>
<h1>사원 수정</h1>
<form method="post" action="editSawon_proc.jsp">
<!-- hidden의 적절한 용도 -->
<input type="hidden" name="no" value=<%=no%>	/>
<table border="1">
	<tr>
		<td>ID : </td>
		<td><input type="text" name="id" value="<%=dto.getId() %>"	/></td>
	</tr>
	<tr>
		<td>이름 : </td>
		<td><input type="text" name="name" value="<%=dto.getName() %>"	/></td>
	</tr>
	<tr>
		<td>패스워드 : </td>
		<td><input type="text" name="pass" value="<%=dto.getPass() %>"	/></td>
	</tr>
	<tr>
		<td>나이 : </td>
		<td><input type="text" name="age"	 value="<%=dto.getAge()%>"/></td>
	</tr>
	<tr>
		<td>근무지 : </td>
		<td>
			<select name="addr">
				<option value="서울" <%if(dto.getAddr().equals("서울")){ %>
						 selected="true"	<%}%>>서울</option>
				<option value="경기" <%if(dto.getAddr().equals("경기")){ %>
						 selected="true"	<%}%>>경기</option>
				<option value="광주" <%if(dto.getAddr().equals("광주")){ %>
						 selected="true"	<%}%>>광주</option>
				<option value="부산" <%if(dto.getAddr().equals("부산")){ %>
						 selected="true"	<%}%>>부산</option>
			</select>
		</td>
	</tr>
	<tr>
		<td>내선 번호 : </td>
		<td><input type="text" name="ext" value="<%=dto.getExt() %>"	/></td>
	</tr>
	<tr>
		<td>부서명 : </td>
		<td>
			<select name="dept">
				<option value="영업" <%if(dto.getDept().equals("영업")){ %>
						selected="true"<%}%>>영업</option>
				<option value="기술" <%if(dto.getDept().equals("기술")){ %>
						selected="true"<%}%>>기술</option>
				<option value="기획" <%if(dto.getDept().equals("기획")){ %>
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