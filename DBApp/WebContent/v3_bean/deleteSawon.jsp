<%@page import="mybean.DBConnectionMgr"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.sql.*" %>

<jsp:useBean id="dao" class="mybean.SawonDao"	/>

<%
	request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");
	
	int no = Integer.parseInt(request.getParameter("no"));
	
	try{
		dao.deleteSawon(no);
%>
<script>
	alert("삭제되었습니다.");
	location.href="index.jsp";
</script>
<%
	}
	catch(Exception err){
		System.out.println("deleteSawon.jsp : " + err);
	}
%>