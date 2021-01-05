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
	<div data-role="page">
	<div data-role="header" data-theme="b">
			<center>
				<font size=4>logo화면</font>
			</center>
		</div>
		<%@ include file="tabMenu.jsp"%>
		<script type="text/javascript">
			function show() {
				var storeArray = localStorage.getItem("storeArray");
				storeArray = JSON.parse(storeArray);
				if (storeArray === null || storeArray.length === 0) {
					/* var li = document.createElement("li");
					li.innerHTML = '<center>' + "등록된 즐겨찾기가 없습니다." + '</center>';
					$('#list').append(li);
					$("#list").listview("refresh"); */
					location.href = "nearStoreMapSS";
					
				} else {
					for (var num1 = 0; num1 < storeArray.length; num1++) {
						var li = document.createElement("li");
						var value = storeArray[num1];
						var encode = encodeURI(value);
						li.innerHTML = '<a name="' + value
								+ '" href="printStoreInfoSS?title=' + encode
								+ ' "title="' + value
								+ '" style="text-decoration:none;">' + value
								+ '</a>';
						$('#list').append(li);
					}
					$("#list").listview("refresh");
				}
				
			}
			window.onload = show;
		</script>
		<div data-role="header" data-theme="b">
			<center>
				<font size=4>즐겨찾기</font>
			</center>
		</div>
		<div data-role="main">
			<ul id="list" data-role="listview">

			</ul>
		</div>
	</div>
	<input type="text" id="vlist">
</body>
</html>