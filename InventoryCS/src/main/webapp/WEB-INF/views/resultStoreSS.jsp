<%@page import="kr.ywhs.dao.InventoryVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
$(document).bind("mobileinit", function(){
   $.mobile.ajaxLinksEnabled=false;
   $.mobile.ajaxFormsEnabled=false;
   $.mobile.ajaxEnabled=false;
});
</script>
<script
	src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<link rel="stylesheet" href="./resources/daumKeyword.css"
	type="text/css" />
</head>
<body>

	<%
   response.setCharacterEncoding("euc-kr");
%>
	<%@ include file="tabMenu.jsp" %>
	<div data-role="header" data-theme="b">
		<center>
			<font size=4>매장 내 상품 검색 결과</font>
		</center>
	</div>

	<%
      List<InventoryVO> resultList = (List<InventoryVO>) request
            .getSession().getAttribute("result");
      for (int i = 0; i < resultList.size(); i++) {
         InventoryVO inVO = resultList.get(i);
   %>
	<ul data-role="listview" data-theme="a">
		<li><a>상품명 : <%=inVO.getProduct_name()%><br> 재고수량 : <%=inVO.getAmount()%></a></li>
	</ul>

	<%
      }
   %>
	<br>

</body>
</html>