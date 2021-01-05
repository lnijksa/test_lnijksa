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
		var storeArray = localStorage.getItem("storeArray"); // ���� ���丮���� storeArray�� �����Ͷ� ���ڿ� ����
		if (storeArray === null) { // ������ ���ڿ��� ���������
			storeArray = []; // �� �迭�� ��������
			localStorage.setItem("storeArray", JSON.stringify(storeArray)); // ���� �迭�� ���ڿ��� �ٲ㼭 ���ý��丮���� �����ض�
		}
		addBM2LS(valueBM);
	}

	function addBM2LS(value) {
		var storeArray = localStorage.getItem("storeArray");// ���� ���丮���� storeArray�� �����Ͷ� ���ڿ� ����
		var now = new Date();
		var time = now.getTime();
		var newkey = "storeName" + time ; // ���ο� Ű
		storeArray = JSON.parse(storeArray); // ���ڿ��� �迭�� ������ְ�
		for (var num1 = 0; num1 < storeArray.length; num1++) { // �迭�μ� �˻����ٰ� �� �˻����ְ�
			var valueArr = storeArray[num1];
			if (value === valueArr) {
				alert("�̹� ���ã���� �����Դϴ�.");
				history.back();
				return;
			}
		}
		localStorage.setItem(newkey, value); // ��������ҿ� ���� �߰�
		storeArray.push(value); // ���ο� ����� �迭�� �߰�
		localStorage.setItem("storeArray", JSON.stringify(storeArray)); // �迭�� ���ڿ��� �ٲ㼭 ���� ���丮���� �����ض�
		alert("���ã�� �Ϸ�");
		history.back();
	}

	if (('localStorage' in window) && window['localStorage'] !== null) {
		window.onload = show;
	} else {
		alert("���� ���丮���� �������� �ʴ� �������Դϴ�.");
		history.back();
	}
</script>
</head>
<body>
	<input type="hidden" value="<%=storeName%>" id="bookMark">
</body>
</html>