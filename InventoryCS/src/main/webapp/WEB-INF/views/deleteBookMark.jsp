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
      storeArray = JSON.parse(storeArray); // ���ڿ��� �迭��
      
      //�迭���� ���� for��
      for (var num1 = 0; num1 < storeArray.length; num1++) {
         var valueArr = storeArray[num1];         
         if (valueArr === valueBM) {
            storeArray.splice(num1,1);
            localStorage.setItem("storeArray", JSON.stringify(storeArray));
         for ( var key in localStorage) {
               // key�� �κй��ڿ� ������ġ 0�������� 9�ڸ��� "storeName" �̸�
               if ((key.substring(0, 9) == "storeName")&& (localStorage[key] == document.getElementById("bookMark").value)) {
                  localStorage.removeItem(key);
                  alert("���ã�� ���� �Ϸ�");
                  history.back();
                  return;
               }
            }
            break;
         }
         
      }
      
      alert("���ã������ ���� �����Դϴ�.");
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
	<input type="hidden" value="<%=storeName%>" id="bookMark" >
</body>
</html>