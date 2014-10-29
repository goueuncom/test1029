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
		String sql = "update tblsawon set id=?, name=?, pass=?, age=?, addr=?, ext=?, dept=? where no=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, name);
		pstmt.setString(3, pass);
		pstmt.setString(4, age);
		pstmt.setString(5, addr);
		pstmt.setString(6, ext);
		pstmt.setString(7, dept);
		pstmt.setString(8, no);
		pstmt.executeUpdate();
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
	finally{
		pool.freeConnection(con, pstmt);
		//response.sendRedirect("index.jsp");
	}
%>