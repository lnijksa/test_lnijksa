<%@page import="com.sun.corba.se.spi.orbutil.fsm.Guard.Result"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

<script type="text/javascript">
   var xmlRequest;
   function callMethod() {
      xmlRequest = xmlRequest || new XMLHttpRequest(); //1)

      xmlRequest.onreadystatechange = CallbackMethod; //2)대기
      var productName = document.getElementById("productName").value;
      var encProduct= encodeURI(productName);
      var address = document.getElementById("aaa").value;
      var encAddress=encodeURI(address);
      var url = "searchProductPS?productSerch=" + encProduct + "&address="+encAddress;
    
      //3      
      console.log("url:"+url);
      xmlRequest.open("post", url, true);
      xmlRequest.send();
   }
   //4
   function CallbackMethod() {
      if (xmlRequest.readyState === 4 && xmlRequest.status === 200) {
    	 $('#resultProductPS').html(xmlRequest.responseText).trigger("create");
     }
      $('#resultProductPS').listview("refresh");
   }
</script>

</head>
<body>
	<%@ include file="tabMenu.jsp" %>


	<script type="text/javascript"
		src="//apis.daum.net/maps/maps3.js?apikey=9760f5284290988190f80be3413a4c2b&libraries=services"></script>

	<script>
      var addrDiv;
      if (!!navigator.geolocation) {
         navigator.geolocation.getCurrentPosition(successCallback,
               errorCallback);
      }
      function successCallback(position) {
         var lat = position.coords.latitude;
         var lng = position.coords.longitude;

         var geocoder = new daum.maps.services.Geocoder();

         var coord = new daum.maps.LatLng(lat, lng);
         var callback = function(status, result) {
            if (status === daum.maps.services.Status.OK) {
               addrDiv = document.getElementById("currentAddr");
               addrDiv.innerHTML = result[0].fullName;
             document.getElementsByName("address").innerText = result[0].fullName;
               document.getElementById("aaa").value = result[0].fullName;

            }
         };

         geocoder.coord2addr(coord, callback);

      }

      function errorCallback(error) {
         alert(error.message);
      }
      function getAddress() {

      }
   </script>
	<div data-role="header" data-theme="b">
		<center>
			<font size=4>상품검색</font>
		</center>
	</div>
	<br>
	<table>
		<tr>
			<td><img src="./resources/location1.png" width="18" height="18"></td>
			<td><font size=3>현재 위치 > </font></td>
			<td>
				<div id="currentAddr" style="font-size: 3"></div>
			</td>
	</table>
	<table width="100%">
		<tr>
			<td><input type="text" name="productSerch" id="productName"
				required="required" placeholder="상품명을 입력해주세요"> <input
				type="hidden" name="address" id="aaa"></td>
			<td><button onclick="callMethod()">
					<img src="./resources/search.png" width="17" height="17">검색
				</button></td>
		</tr>
	</table>
	<ul id="resultProductPS" data-role="listview">
	</ul>

</body>
</html>