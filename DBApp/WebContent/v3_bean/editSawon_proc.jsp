<%@page import="mybean.DBConnectionMgr"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="dao" class="mybean.SawonDao"	/>
<jsp:useBean id="dto" class="mybean.SawonDto"	/>
<jsp:setProperty property="*" name="dto"		/>
<%
	try{
		dao.editSawon(dto);
%>
<script>
	alert("잘 수정되었습니다.");
	location.href="index.jsp";
</script>
<%
	}
	catch(Exception err){
		System.out.println("editSawon_proc.jsp : " + err);
	}
%>