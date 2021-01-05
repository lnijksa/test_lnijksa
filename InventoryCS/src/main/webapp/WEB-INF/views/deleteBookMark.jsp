<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
   String storeName = (String) request.getSession().getAttribute(
         "storeName");
%>
<script type="text/javascript">
   function show() {
      var storeArray = localStorage.getItem("storeArray");
      var valueBM = document.getElementById("bookMark").value;
      storeArray = JSON.parse(storeArray); // 문자열을 배열로
      
      //배열에서 삭제 for문
      for (var num1 = 0; num1 < storeArray.length; num1++) {
         var valueArr = storeArray[num1];         
         if (valueArr === valueBM) {
            storeArray.splice(num1,1);
            localStorage.setItem("storeArray", JSON.stringify(storeArray));
         for ( var key in localStorage) {
               // key의 부분문자열 시작위치 0에서부터 9자리가 "storeName" 이면
               if ((key.substring(0, 9) == "storeName")&& (localStorage[key] == document.getElementById("bookMark").value)) {
                  localStorage.removeItem(key);
                  alert("즐겨찾기 해제 완료");
                  history.back();
                  return;
               }
            }
            break;
         }
         
      }
      
      alert("즐겨찾기하지 않은 매장입니다.");
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
	<input type="hidden" value="<%=storeName%>" id="bookMark" >
</body>
</html>