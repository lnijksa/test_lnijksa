<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
	$(document).bind("mobileinit", function() {
		$.mobile.ajaxLinksEnabled = false;
		$.mobile.ajaxFormsEnabled = false;
		$.mobile.ajaxEnabled = false;
	});
</script>
<script
	src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>



</head>
<body>
	<%@ include file="tabMenu.jsp" %>

	<div data-role="header" data-theme="b">
		<center>
			<font size=4>��ǰ �˻�</font>
		</center>
	</div>
	<br>
	<%
		session = request.getSession(true);
		String title = request.getParameter("title");
		title = URLDecoder.decode(title, "UTF-8");
		session.setAttribute("storeName", title);
		String encStoreName = URLEncoder.encode(title, "UTF-8");
		String deStoreName=URLDecoder.decode(title, "UTF-8");
	%>
<script type="text/javascript">
	function chgAction() {
		
		$(document).ready(function() {
		var tag=document.getElementById("store");
		var storeName="<%=title%>"; 
		tag.value=storeName;
		
	    var storeArray = localStorage.getItem("storeArray");
	    storeArray = JSON.parse(storeArray);
	       var bm=document.getElementById("bm");
	       if (storeArray === null) { // ������ ���ڿ��� ���������
				storeArray = []; // �� �迭�� ��������
				localStorage.setItem("storeArray", JSON.stringify(storeArray)); // ���� �迭�� ���ڿ��� �ٲ㼭 ���ý��丮���� �����ض�
			}
	       console.log("for����");
	    for (var num= 0; num < storeArray.length; num++) {
	    	console.log("for����");
	         var valueArr = storeArray[num];  
	         bm.innerHTML = '<img src="./resources/bm+.png" width="30px" height="30px">';
	         if (valueArr === storeName) {
	        	document.getElementById("bma").setAttribute("href","deleteBookMark?storeName=<%=encStoreName%>");
	        	bm.innerHTML=bm.innerHTML = bm.innerHTML = '<img src="./resources/bm-.png" width="30px" height="30px">';
	        	return;
	         }
	         
	      }
	    bm.innerHTML=bm.innerHTML = bm.innerHTML = '<img src="./resources/bm+.png" width="30px" height="30px">';
    	
	 	 
		
		});

	
	}
	window.onload=chgAction();
</script>
	<div>
		<table width=100%>
			<tr>
				<td><b>����� : <%=title%></b></td>
				<td><a id="bma" href="addBookMark?storeName=<%=encStoreName%>"><div id="bm"></div></a></td>
			<%-- 	<td><a href="deleteBookMark?storeName=<%=encStoreName%>">���ã�� ����</a></td> --%>
			</tr>
		</table>
	</div>
	<form action="printStoreInfoSS" method="post">
		<table width=100%>
			<tr>
				<td><input type="text" id="productName" name="productName"
					required="required" placeholder="��ǰ���� �Է����ּ���"></td>
				<td width="20%">
					<button type="submit">
						<img src="./resources/search.png" width="17" height="17"> �˻�
					</button>
				</td>
			</tr>
		</table>
	</form>
	<input type="hidden" id="store" name="store" >

</body>
</html>
