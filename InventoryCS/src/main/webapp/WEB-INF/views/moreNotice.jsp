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
			<font size=4>공지사항</font>
		</center>
	</div>
	<div data-role="collapsible-set">
		<div data-role="collapsible">
			<h1>서버폭주 - 시스템 안정화 작업 중</h1>
			2015-02-05
			<p>죄송합니다. 제가 죽을죄를 지었네요.. 앞으로 이런 일 없도록 하겠씁니다. 식사 맛있게하세용~♥</p>

		</div>

		<div data-role="collapsible">
			<h1>[공지] 업데이트 안내</h1>
			2015-02-01
			<p>
				V 1.0.1 업데이트 사항<br> 화면이 넘어갈때 생기는 오류를 수정하였습니다.
			</p>

		</div>


	</div>
	<div data-role="footer" data-position="fixed">
		<h6>
			made by 헛걸음 방지 프로젝트<br> young + won + ho + su
		</h6>
	</div>
</body>
</html>