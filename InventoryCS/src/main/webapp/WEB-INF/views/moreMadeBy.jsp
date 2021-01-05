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
<script type="text/javascript" src="./jQuery/jquery-2.0.0.js"></script>

</head>
<body>
	<%@ include file="tabMenu.jsp"%>
	<div data-role="header" data-theme="b">
		<center>
			<font size=4>만든이들</font>
		</center>
	</div>
	<div data-role="content">
		<h3>made by</h3>
		<p>
			홍석영(동국대, 92)<br> 곽대원(대진대, 90)<br> 이호용(동국대, 90)<br>
			안광수(세종대, 90)
		</p>

		<h3>based Architecture</h3>
		<p>
			<a href="http://www.egovframe.go.kr/" target="_blank" style="color: black; text-decoration: none;"><b>전자정부
					프레임워크 </b></a> 기반 <br> 
			Based : Java, Eclipse, JDK 1.8.0_25 <br> 
			User Interface : HTML5,	Javascript, JSP, Ajax, JQuery, JQueryMobile <br> 
			Server : Spring	MVC, Apache Tomcat v8.0 <br> 
			Data Access : JDBC, MyBatis<br>
			RDBMS : OracleDB<br> 
			Reference : <a href="http://apis.map.daum.net/" target="_blank" style="color: black; text-decoration: none;"> Daum Map API </a>
		</p>
	</div>
	<div data-role="footer" data-position="fixed">
		<h6>
			made by 헛걸음 방지 프로젝트<br> young + won + ho + su
		</h6>
	</div>
</body>
</html>