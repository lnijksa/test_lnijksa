<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String storeName = (String) request.getSession().getAttribute("storeName");
%>
<script>
	function show() {
		var valueBM = document.getElementById("bookMark").value;
		var storeArray = localStorage.getItem("storeArray"); // 로컬 스토리지의 storeArray를 가져와라 문자열 상태
		if (storeArray === null) { // 가져온 문자열이 비어있으면
			storeArray = []; // 빈 배열을 만들어줘라
			localStorage.setItem("storeArray", JSON.stringify(storeArray)); // 만든 배열을 문자열로 바꿔서 로컬스토리지에 저장해라
		}
		addBM2LS(valueBM);
	}

	function addBM2LS(value) {
		var storeArray = localStorage.getItem("storeArray");// 로컬 스토리지의 storeArray를 가져와라 문자열 상태
		var now = new Date();
		var time = now.getTime();
		var newkey = "storeName" + time ; // 새로운 키
		storeArray = JSON.parse(storeArray); // 문자열을 배열로 만들어주고
		for (var num1 = 0; num1 < storeArray.length; num1++) { // 배열로서 검사해줄거 다 검사해주고
			var valueArr = storeArray[num1];
			if (value === valueArr) {
				alert("이미 즐겨찾기한 매장입니다.");
				history.back();
				return;
			}
		}
		localStorage.setItem(newkey, value); // 로컬저장소에 새로 추가
		storeArray.push(value); // 새로운 밸류를 배열에 추가
		localStorage.setItem("storeArray", JSON.stringify(storeArray)); // 배열을 문자열로 바꿔서 로컬 스토리지에 저장해라
		alert("즐겨찾기 완료");
		history.back();
	}

	if (('localStorage' in window) && window['localStorage'] !== null) {
		window.onload = show;
	} else {
		alert("로컬 스토리지를 제공하지 않는 브라우저입니다.");
		history.back();
	}
</script>
</head>
<body>
	<input type="hidden" value="<%=storeName%>" id="bookMark">
</body>
</html>