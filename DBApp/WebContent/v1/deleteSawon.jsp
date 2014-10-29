<%@page import="mybean.DBConnectionMgr"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");
	
	String no = request.getParameter("no");
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String pass = request.getParameter("pass");
	String age = request.getParameter("age");
	String addr = request.getParameter("addr");
	String ext = request.getParameter("ext");
	String dept = request.getParameter("dept");
	//out.println(id + ", " + name + ", " + pass + ", " + age + ", " + addr + ", " + ext + ", " + dept);
	
	DBConnectionMgr pool = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	
	try{
		pool = DBConnectionMgr.getInstance();
		con = pool.getConnection();
		/* 
		Class.forName("org.gjt.mm.mysql.Driver");
		String url = "jdbc:mysql://localhost:3306/dbl3";
		con = DriverManager.getConnection(url, "root", "1111");
		 */
		String sql = "delete from tblsawon where no=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, no);
		pstmt.executeUpdate();
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
	finally{
		pool.freeConnection(con, pstmt);
	}
%>