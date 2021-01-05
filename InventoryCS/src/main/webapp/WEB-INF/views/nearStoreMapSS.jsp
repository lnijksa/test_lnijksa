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
         <font size=4>주변 편의점</font>
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

         // 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
         var placeOverlay = new daum.maps.CustomOverlay({
            zIndex : 1
         }), markers = [], // 마커를 담을 배열입니다
         currCategory = 'CS2'; // 현재 선택된 카테고리를 가지고 있을 변수입니다

         var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
         mapOption = {
            center : new daum.maps.LatLng(lat, lng), // 지도의 중심좌표
            level : 3
         // 지도의 확대 레벨
         };
         // 지도를 생성합니다    
         var map = new daum.maps.Map(mapContainer, mapOption);

         // 주소-좌표 변환 객체를 생성합니다
         var geocoder = new daum.maps.services.Geocoder();

         // 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
         searchAddrFromCoords(map.getCenter(), displayCenterInfo);

         // 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
         daum.maps.event.addListener(map, 'click', function(mouseEvent) {

            searchAddrFromCoords(mouseEvent.latLng,
                  function(status, result) {
                     if (status === daum.maps.services.Status.OK) {
                        var content = '<div style="padding:5px;">'
                              + result[0].fullName + '</div>';

                     }
                  });
         });

         // 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
         daum.maps.event.addListener(map, 'idle', function() {
            searchAddrFromCoords(map.getCenter(), displayCenterInfo);
         });

         function searchAddrFromCoords(coords, callback) {
            // 좌표로 주소 정보를 요청합니다
            geocoder.coord2addr(coords, callback);
         }

         // 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
         function displayCenterInfo(status, result) {
            if (status === daum.maps.services.Status.OK) {
               var infoDiv = document.getElementById('centerAddr');
               infoDiv.innerHTML = result[0].fullName;
            }
         }

         // 장소 검색 객체를 생성합니다
         var ps = new daum.maps.services.Places(map);

         // 지도에 idle 이벤트를 등록합니다
         daum.maps.event.addListener(map, 'idle', searchPlaces);

         // 각 카테고리에 클릭 이벤트를 등록합니다
         searchPlaces()

         // 카테고리 검색을 요청하는 함수입니다
         function searchPlaces() {
            if (!currCategory) {
               return;
            }

            ps.categorySearch(currCategory, placesSearchCB, {
               useMapBounds : true
            });
         }
         // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
         function placesSearchCB(status, data, pagination) {
            if (status === daum.maps.services.Status.OK) {

               // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
               displayPlaces(data.places);
            }
         }

         // 지도에 마커를 표출하는 함수입니다
         function displayPlaces(places) {

            // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
            // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
            var order = document.getElementById(currCategory).getAttribute(
                  'data-order');

            // 지도에 표시되고 있는 마커를 제거합니다
            removeMarker();

            for (var i = 0; i < places.length; i++) {

               // 마커를 생성하고 지도에 표시합니다
               var marker = addMarker(new daum.maps.LatLng(
                     places[i].latitude, places[i].longitude), order);

               // 마커와 검색결과 항목을 클릭 했을 때
               // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
               (function(marker, place) {
                  daum.maps.event.addListener(marker, 'click',
                        function() {
                           displayPlaceInfo(place);

                        });
               })(marker, places[i]);
            }
         }

         // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
         function addMarker(position, order) {
            var imageSrc = 'http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
            imageSize = new daum.maps.Size(27, 28), // 마커 이미지의 크기
            imgOptions = {
               spriteSize : new daum.maps.Size(72, 208), // 스프라이트 이미지의 크기
               spriteOrigin : new daum.maps.Point(46, (order * 36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
               offset : new daum.maps.Point(11, 28)
            // 마커 좌표에 일치시킬 이미지 내에서의 좌표
            }, markerImage = new daum.maps.MarkerImage(imageSrc, imageSize,
                  imgOptions), marker = new daum.maps.Marker({
               position : position, // 마커의 위치
               image : markerImage
            });

            marker.setMap(map); // 지도 위에 마커를 표출합니다
            markers.push(marker); // 배열에 생성된 마커를 추가합니다

            return marker;
         }

         // 지도 위에 표시되고 있는 마커를 모두 제거합니다
         function removeMarker() {
            for (var i = 0; i < markers.length; i++) {
               markers[i].setMap(null);
            }
            markers = [];
         }

         // 클릭한 마커에 대한 장소 상세정보를 커스텀 오보레이로 표시하는 함수입니다
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
                     + '      <span class="jibun" title="' + place.address + '">(지번 : '
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

         // 각 카테고리에 클릭 이벤트를 등록합니다
         function addCategoryClickEvent() {
            var category = document.getElementById('category'), children = category.children;

            for (var i = 0; i < children.length; i++) {
               children[i].onclick = onClickCategory;
            }
         }

         
         // 카테고리를 클릭했을 때 호출되는 함수입니다
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

         // 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
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