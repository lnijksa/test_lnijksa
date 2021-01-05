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
<link rel="stylesheet" href="./resources/geo+category.css"
   type="text/css" />
</head>
<body>
   <%@ include file="tabMenu.jsp" %>

   <div data-role="header" data-theme="b">
      <center>
         <font size=4>�ֺ� ������</font>
      </center>
   </div>

   <div class="map_wrap">
      <div id="map"
         style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
      <div id="centerAddr"></div>
      <ul id="category">
         <li id="CS2" data-order="1"></li>
      </ul>
   </div>

   <script type="text/javascript"
      src="//apis.daum.net/maps/maps3.js?apikey=9760f5284290988190f80be3413a4c2b&libraries=services"></script>

   <script>
      if (!!navigator.geolocation) {
         navigator.geolocation.getCurrentPosition(successCallback,
               errorCallback);
      }
      function successCallback(position) {
         var lat = position.coords.latitude;
         var lng = position.coords.longitude;

         // ��Ŀ�� Ŭ������ �� �ش� ����� �������� ������ Ŀ���ҿ��������Դϴ�
         var placeOverlay = new daum.maps.CustomOverlay({
            zIndex : 1
         }), markers = [], // ��Ŀ�� ���� �迭�Դϴ�
         currCategory = 'CS2'; // ���� ���õ� ī�װ��� ������ ���� �����Դϴ�

         var mapContainer = document.getElementById('map'), // ������ ǥ���� div 
         mapOption = {
            center : new daum.maps.LatLng(lat, lng), // ������ �߽���ǥ
            level : 3
         // ������ Ȯ�� ����
         };
         // ������ �����մϴ�    
         var map = new daum.maps.Map(mapContainer, mapOption);

         // �ּ�-��ǥ ��ȯ ��ü�� �����մϴ�
         var geocoder = new daum.maps.services.Geocoder();

         // ���� ���� �߽���ǥ�� �ּҸ� �˻��ؼ� ���� ���� ��ܿ� ǥ���մϴ�
         searchAddrFromCoords(map.getCenter(), displayCenterInfo);

         // ������ Ŭ������ �� Ŭ�� ��ġ ��ǥ�� ���� �ּ������� ǥ���ϵ��� �̺�Ʈ�� ����մϴ�
         daum.maps.event.addListener(map, 'click', function(mouseEvent) {

            searchAddrFromCoords(mouseEvent.latLng,
                  function(status, result) {
                     if (status === daum.maps.services.Status.OK) {
                        var content = '<div style="padding:5px;">'
                              + result[0].fullName + '</div>';

                     }
                  });
         });

         // �߽� ��ǥ�� Ȯ�� ������ ������� �� ���� �߽� ��ǥ�� ���� �ּ� ������ ǥ���ϵ��� �̺�Ʈ�� ����մϴ�
         daum.maps.event.addListener(map, 'idle', function() {
            searchAddrFromCoords(map.getCenter(), displayCenterInfo);
         });

         function searchAddrFromCoords(coords, callback) {
            // ��ǥ�� �ּ� ������ ��û�մϴ�
            geocoder.coord2addr(coords, callback);
         }

         // ���� ������ܿ� ���� �߽���ǥ�� ���� �ּ������� ǥ���ϴ� �Լ��Դϴ�
         function displayCenterInfo(status, result) {
            if (status === daum.maps.services.Status.OK) {
               var infoDiv = document.getElementById('centerAddr');
               infoDiv.innerHTML = result[0].fullName;
            }
         }

         // ��� �˻� ��ü�� �����մϴ�
         var ps = new daum.maps.services.Places(map);

         // ������ idle �̺�Ʈ�� ����մϴ�
         daum.maps.event.addListener(map, 'idle', searchPlaces);

         // �� ī�װ��� Ŭ�� �̺�Ʈ�� ����մϴ�
         searchPlaces()

         // ī�װ� �˻��� ��û�ϴ� �Լ��Դϴ�
         function searchPlaces() {
            if (!currCategory) {
               return;
            }

            ps.categorySearch(currCategory, placesSearchCB, {
               useMapBounds : true
            });
         }
         // ��Ұ˻��� �Ϸ���� �� ȣ��Ǵ� �ݹ��Լ� �Դϴ�
         function placesSearchCB(status, data, pagination) {
            if (status === daum.maps.services.Status.OK) {

               // ���������� �˻��� �Ϸ������ ������ ��Ŀ�� ǥ���մϴ�
               displayPlaces(data.places);
            }
         }

         // ������ ��Ŀ�� ǥ���ϴ� �Լ��Դϴ�
         function displayPlaces(places) {

            // ���° ī�װ��� ���õǾ� �ִ��� ���ɴϴ�
            // �� ������ ��������Ʈ �̹��������� ��ġ�� ����ϴµ� ���˴ϴ�
            var order = document.getElementById(currCategory).getAttribute(
                  'data-order');

            // ������ ǥ�õǰ� �ִ� ��Ŀ�� �����մϴ�
            removeMarker();

            for (var i = 0; i < places.length; i++) {

               // ��Ŀ�� �����ϰ� ������ ǥ���մϴ�
               var marker = addMarker(new daum.maps.LatLng(
                     places[i].latitude, places[i].longitude), order);

               // ��Ŀ�� �˻���� �׸��� Ŭ�� ���� ��
               // ��������� ǥ���ϵ��� Ŭ�� �̺�Ʈ�� ����մϴ�
               (function(marker, place) {
                  daum.maps.event.addListener(marker, 'click',
                        function() {
                           displayPlaceInfo(place);

                        });
               })(marker, places[i]);
            }
         }

         // ��Ŀ�� �����ϰ� ���� ���� ��Ŀ�� ǥ���ϴ� �Լ��Դϴ�
         function addMarker(position, order) {
            var imageSrc = 'http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // ��Ŀ �̹��� url, ��������Ʈ �̹����� ���ϴ�
            imageSize = new daum.maps.Size(27, 28), // ��Ŀ �̹����� ũ��
            imgOptions = {
               spriteSize : new daum.maps.Size(72, 208), // ��������Ʈ �̹����� ũ��
               spriteOrigin : new daum.maps.Point(46, (order * 36)), // ��������Ʈ �̹��� �� ����� ������ �»�� ��ǥ
               offset : new daum.maps.Point(11, 28)
            // ��Ŀ ��ǥ�� ��ġ��ų �̹��� �������� ��ǥ
            }, markerImage = new daum.maps.MarkerImage(imageSrc, imageSize,
                  imgOptions), marker = new daum.maps.Marker({
               position : position, // ��Ŀ�� ��ġ
               image : markerImage
            });

            marker.setMap(map); // ���� ���� ��Ŀ�� ǥ���մϴ�
            markers.push(marker); // �迭�� ������ ��Ŀ�� �߰��մϴ�

            return marker;
         }

         // ���� ���� ǥ�õǰ� �ִ� ��Ŀ�� ��� �����մϴ�
         function removeMarker() {
            for (var i = 0; i < markers.length; i++) {
               markers[i].setMap(null);
            }
            markers = [];
         }

         // Ŭ���� ��Ŀ�� ���� ��� �������� Ŀ���� �������̷� ǥ���ϴ� �Լ��Դϴ�
         function displayPlaceInfo(place) {
            var encode = encodeURI(place.title);
            var content = '<div class="placeinfo_wrap">'
                  + '   <div class="placeinfo">'
                  + '       <a class="title" href="printStoreInfoSS?title='
                  + encode + '" title="' + place.title + '">'
                  + place.title + '</a>';

            if (place.newAddress) {
               content += '        <span title="' + place.newAddress + '">'
                     + place.newAddress
                     + '</span>'
                     + '      <span class="jibun" title="' + place.address + '">(���� : '
                     + place.address + ')</span>';
            } else {
               content += '        <span title="' + place.address + '">'
                     + place.address + '</span>';
            }

            content += '        <span class="tel">' + place.phone
                  + '</span>' + '   </div>'
                  + '   <div class="after"></div>' + '</div>';

            placeOverlay.setContent(content);
            placeOverlay.setPosition(new daum.maps.LatLng(place.latitude,
                  place.longitude));
            placeOverlay.setMap(map);
         }

         // �� ī�װ��� Ŭ�� �̺�Ʈ�� ����մϴ�
         function addCategoryClickEvent() {
            var category = document.getElementById('category'), children = category.children;

            for (var i = 0; i < children.length; i++) {
               children[i].onclick = onClickCategory;
            }
         }

         
         // ī�װ��� Ŭ������ �� ȣ��Ǵ� �Լ��Դϴ�
         function onClickCategory() {
            var id = this.id, className = this.className;

            if (className === 'on') {
               currCategory = '';
               changeCategoryClass();
               removeMarker();
               placeOverlay.setMap(null);
            } else {
               currCategory = id;
               changeCategoryClass(this);
               searchPlaces();
            }
         }

         // Ŭ���� ī�װ����� Ŭ���� ��Ÿ���� �����ϴ� �Լ��Դϴ�
         function changeCategoryClass(el) {
            var category = document.getElementById('category'), children = category.children, i;

            for (i = 0; i < children.length; i++) {
               children[i].className = '';
            }

            if (el) {
               el.className = 'on';
            }
         }

      }
      function errorCallback(error) {
         alert(error.message);
      }
   </script>


</body>
</html>