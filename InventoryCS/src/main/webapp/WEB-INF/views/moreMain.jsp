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
<script
   src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
</head>
<body>
   <%@ include file="tabMenu.jsp" %>
	<div data-role="header" data-theme="b">
		<center>
			<font size=4>더 보기</font>
		</center>
	</div>
   <div data-role="controlgroup" data-type="vertical">
      <a href="moreNotice" data-ajax="false" class="ui-btn" size="50">공지사항</a>
      <a href="moreVersion" data-ajax="false" class="ui-btn">버전정보</a>
      <a href="moreMadeBy" data-ajax="false" class="ui-btn">만든이들</a>
   </div>

   <div data-role="footer" data-position="fixed">
      <h6>
         made by 헛걸음 방지 프로젝트<br> young + won + ho + su
      </h6>
   </div>
</body>
</html>