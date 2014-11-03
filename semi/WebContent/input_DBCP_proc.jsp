<%@ page contentType="text/html; charset=EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
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
  <link rel="stylesheet" type="text/css" href="css/table.css">
  </script>
</head>
<body>
<jsp:useBean id="dao" class="mybean.semiDao"	/>
<table width="550" border="1">
<%
	request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");
  	int code = Integer.parseInt(request.getParameter("code"));
   int count = Integer.parseInt(request.getParameter("count"));
   String date = request.getParameter("date");
   /* 
   out.println(code);
   out.println(count);
   out.println(date);
    */
   //if(request.getParameter("code") != null && request.getParameter("count") != null && date != null)
	 dao.insertInput(code, count, date);
    response.sendRedirect("input_DBCP.jsp");
   
%>
</table>
</body>
</html>