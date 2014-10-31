<%@page contentType="text/html;charset=euc-kr" %>
<style type="text/css">
.css1{
	-moz-box-shadow:inset 0px 1px 0px 0px #ffffff;
	-webkit-box-shadow:inset 0px 1px 0px 0px #ffffff;
	box-shadow:inset 0px 1px 0px 0px #ffffff;
	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #ffffff), color-stop(1, #8de6d4) );
	background:-moz-linear-gradient( center top, #ffffff 5%, #8de6d4 100% );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#8de6d4');
	background-color:#ffffff;

	text-indent:0px;
	border:0px solid #dcdcdc;
	display:inline-block;
	color:#91a2cc;
	font-family:arial;
	font-size:12px;
	font-weight:bold;
	font-style:normal;
	height:42px;
	line-height:42px;
	width:130px;
	text-decoration:none;
	text-align:center;
	text-shadow:1px 1px 0px #ffffff;
}
.css1:hover {
	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #8de6d4), color-stop(1, #ffffff) );
	background:-moz-linear-gradient( center top, #8de6d4 5%, #ffffff 100% );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#8de6d4', endColorstr='#ffffff');
	background-color:#8de6d4;
}.css1:active {
	position:relative;
	top:1px;
}</style>

  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script>
  $(function() {
    $( "#tabs" ).tabs({
    	event: "mouseover"
    });
  });
  </script>

<div id="tabs">
  <ul>
    <li><a href="#tabs-1">상품추가</a></li>
    <li><a href="#tabs-2">조회</a></li>
    <li><a href="#tabs-3">전체조회</a></li>
   <li><a href="#tabs-4">입출고입력</a></li>
  </ul>
  
	<div id="tabs-1">
	<div>
	<form method="post" action="add-list.jsp">
	<input class="css1" type="submit" value="상품추가" />
	</form>
	</div>
	</div>
	
	<div id="tabs-2">
		<div style="float: left">	
		<form method="post" action="input-search.jsp">
		<!-- <input type="image" src="images/b.png" name="Submit" value="입고조회"> -->
		<input class="css1" type="submit" value="입고조회" />
		</form>
		</div>
	
	
		<div style="float: left">
		<form method="post" action="output-search.jsp">
		<input class="css1" type="submit" value="출고조회" />
		</form>
		</div>
	
		<div>
		<form method="post" action="stock-search.jsp">
		<input class="css1" type="submit" value="재고조회" />
		</form>
		</div>
	</div>
	
	
	<div id="tabs-3">
		<div style="float: left">
		<form method="post" action="input-all-search.jsp">
		<input class="css1" type="submit" value="입고 전체조회" />
		</form>
		</div>
	
		<div>
		<form method="post" action="output-all-search.jsp">
		<input class="css1" type="submit" value="출고 전체조회" />
		</form>
		</div>
	</div>
	
	<div id="tabs-4">
		<div style="float: left">	
		<form method="post" action="input.jsp">
		<input class="css1" type="submit" value="입고입력" />
		</form>
		</div>
		
		<div>
		<form method="post" action="output.jsp">
		<input class="css1" type="submit" value="출고입력" />
		</form>
		</div>
	</div>
	
</div>
<br/>
<hr/>