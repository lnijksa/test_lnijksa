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
<link rel="stylesheet" href="./resources/daumKeyword.css"
   type="text/css" />
</head>
<body>
	<%@ include file="tabMenu.jsp" %>
   <div data-role="header" data-theme="b">
      <center>
         <font size=4>매장 검색</font>
      </center>
   </div>
    <div id="menu_wrap" class="bg_white">
      <div class="option">
         <p>
         <form onsubmit="searchPlaces(); return false;">
               <table width="100%">
               <tr>
               <td>
                  <input type="text" placeholder="ex) 한남동" id="keyword">
               </td>   
               <td width="32%">
                     <button type="submit">
                        <img src="./resources/search.png" width="17" height="17">검색 </button>
               </td>
               </tr>      
               </table>   
            </form>
            </p>
      </div> 

   <div class="map_wrap">
      <div id="map"
         style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
      <div id="centerAddr"></div>
   </div>

      <hr>
      </div>
      <ul id="placesList"></ul>
      <div id="pagination"></div>
   <script type="text/javascript"
      src="//apis.daum.net/maps/maps3.js?apikey=9760f5284290988190f80be3413a4c2b&libraries=services"></script>
   <script>
      // 마커를 담을 배열입니다
      var markers = [];
      var keyword = "";
      var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
      mapOption = {
         center : new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
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

         searchAddrFromCoords(mouseEvent.latLng, function(status, result) {
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
      var ps = new daum.maps.services.Places();

      // 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
      var infowindow = new daum.maps.InfoWindow({
         zIndex : 1,
         removable : true
      });

      // 키워드로 장소를 검색합니다
      searchPlaces();

      // 키워드 검색을 요청하는 함수입니다
      function searchPlaces() {

         keywordSetting();
      }

      // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
      function placesSearchCB(status, data, pagination) {
         if (status === daum.maps.services.Status.OK) {

            // 정상적으로 검색이 완료됐으면
            // 검색 목록과 마커를 표출합니다
            displayPlaces(data.places);

            // 페이지 번호를 표출합니다
            displayPagination(pagination);

         } else if (status === daum.maps.services.Status.ZERO_RESULT) {

            alert('검색 결과가 존재하지 않습니다.');
            return;

         } else if (status === daum.maps.services.Status.ERROR) {

            alert('검색 결과 중 오류가 발생했습니다.');
            return;

         }
      }

      // 검색 결과 목록과 마커를 표출하는 함수입니다
      function displayPlaces(places) {

         var listEl = document.getElementById('placesList'), menuEl = document
               .getElementById('menu_wrap'), fragment = document
               .createDocumentFragment(), bounds = new daum.maps.LatLngBounds(), listStr = '';

         // 검색 결과 목록에 추가된 항목들을 제거합니다
         removeAllChildNods(listEl);

         // 지도에 표시되고 있는 마커를 제거합니다
         removeMarker();

         for (var i = 0; i < places.length; i++) {

            // 마커를 생성하고 지도에 표시합니다
            var placePosition = new daum.maps.LatLng(places[i].latitude,
                  places[i].longitude), marker = addMarker(placePosition,
                  i), itemEl = getListItem(i, places[i], marker); // 검색 결과 항목 Element를 생성합니다

            // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
            // LatLngBounds 객체에 좌표를 추가합니다
            bounds.extend(placePosition);

            // 마커와 검색결과 항목에 mouseover 했을때
            // 해당 장소에 인포윈도우에 장소명을 표시합니다
            // mouseout 했을 때는 인포윈도우를 닫습니다
            (function(marker, title) {
               daum.maps.event.addListener(marker, 'click', function() {
                  displayInfowindow(marker, title);
               });

               /*  daum.maps.event.addListener(marker, 'mouseout', function() {
                    infowindow.close();
                }); */

               itemEl.onclick = function() {
                  displayInfowindow(marker, title);
                  map.setBounds(bounds);
               };

               /*itemEl.onmouseout = function() {
                  infowindow.close();
               };*/
            })(marker, places[i].title);

            fragment.appendChild(itemEl);

         }

         // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
         listEl.appendChild(fragment);
         menuEl.scrollTop = 0;

         // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
         map.setBounds(bounds);
      }

      // 검색결과 항목을 Element로 반환하는 함수입니다
      function getListItem(index, places) {

         var el = document.createElement('li'), itemStr = '<span class="markerbg marker_'
               + (index + 1)
               + '"></span>'
               + '<div class="info">'
               + '   <h5>' + places.title + '</h5>';

         if (places.newAddress) {
            itemStr += '    <span>' + places.newAddress + '</span>'
                  + '   <span class="jibun gray">' + places.address
                  + '</span>';
         } else {
            itemStr += '    <span>' + places.address + '</span>';
         }

         itemStr += '  <span class="tel">' + places.phone + '</span>'
               + '</div>';

         el.innerHTML = itemStr;
         el.className = 'item';

         return el;
      }

      // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
      function addMarker(position, idx, title) {
         var imageSrc = 'http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
         imageSize = new daum.maps.Size(36, 37), // 마커 이미지의 크기
         imgOptions = {
            spriteSize : new daum.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new daum.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset : new daum.maps.Point(13, 37)
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

      // 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
      function displayPagination(pagination) {
         var paginationEl = document.getElementById('pagination'), fragment = document
               .createDocumentFragment(), i;

         // 기존에 추가된 페이지번호를 삭제합니다
         while (paginationEl.hasChildNodes()) {
            paginationEl.removeChild(paginationEl.lastChild);
         }

         for (i = 1; i <= pagination.last; i++) {
            var el = document.createElement('a');
            el.href = "#";
            el.innerHTML = i;

            if (i === pagination.current) {
               el.className = 'on';
            } else {
               el.onclick = (function(i) {
                  return function() {
                     pagination.gotoPage(i);
                  }
               })(i);
            }

            fragment.appendChild(el);
         }
         paginationEl.appendChild(fragment);
      }

      // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
      // 인포윈도우에 장소명을 표시합니다
      function displayInfowindow(marker, title) {
         var encode = encodeURI(title);
         var content = '<div style="padding:5px;z-index:1;">' + '<a name="'
               + title + '" href="printStoreInfoSS?title=' + encode
               + ' "title="' + title + '">' + title + '</a></div>';
         infowindow.setContent(content);
         infowindow.open(map, marker);
      }

      // 검색결과 목록의 자식 Element를 제거하는 함수입니다
      function removeAllChildNods(el) {
         while (el.hasChildNodes()) {
            el.removeChild(el.lastChild);
         }
      }

      function keywordSetting() {
         keyword = document.getElementById('keyword').value;
         if (!keyword.replace(/^\s+|\s+$/g, '')) {
            return false;
         }

         // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
         ps.keywordSearch(keyword + '편의점', placesSearchCB);
      }
   </script>
   <br>


</body>
</html>