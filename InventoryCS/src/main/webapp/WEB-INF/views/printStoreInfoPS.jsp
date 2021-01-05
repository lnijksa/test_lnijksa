<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
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
	<%
		String title = request.getParameter("title");
		title = URLDecoder.decode(title, "UTF-8").trim();
		//String encStoreName = URLEncoder.encode(title, "UTF-8");
	%>
	<%@ include file="tabMenu.jsp" %>
	<div data-role="header" data-theme="b">
		<center>
			<font size=4><%=title%></font>
		</center>
	</div>
	<div class="map_wrap">
		<div id="map"
			style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
		<div id="centerAddr"></div>
	</div>

	<div id="menu_wrap" class="bg_white">
		<div class="option">
			<p>
			<form onsubmit="searchPlaces(); return false;">
				<input type="hidden" value=<%=title%> id="keyword" size="20">
				</p>
		</div>
		<hr>
		<ul id="placesList"></ul>
		<div id="pagination"></div>
	</div>
	<script type="text/javascript"
		src="//apis.daum.net/maps/maps3.js?apikey=9760f5284290988190f80be3413a4c2b&libraries=services"></script>
	<script>
		var markers = [];
		var keyword = "";
		var mapContainer = document.getElementById('map'), // ������ ǥ���� div 
		mapOption = {
			center : new daum.maps.LatLng(37.537187, 127.005476), // ������ �߽���ǥ
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

			searchAddrFromCoords(mouseEvent.latLng, function(status, result) {
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
		var ps = new daum.maps.services.Places();

		// �˻� ��� ����̳� ��Ŀ�� Ŭ������ �� ��Ҹ��� ǥ���� ���������츦 �����մϴ�
		var infowindow = new daum.maps.InfoWindow({
			zIndex : 1,
			removable : true
		});

		// Ű����� ��Ҹ� �˻��մϴ�
		searchPlaces();

		// Ű���� �˻��� ��û�ϴ� �Լ��Դϴ�
		function searchPlaces() {

			keywordSetting();
		}

		// ��Ұ˻��� �Ϸ���� �� ȣ��Ǵ� �ݹ��Լ� �Դϴ�
		function placesSearchCB(status, data, pagination) {
			if (status === daum.maps.services.Status.OK) {

				// ���������� �˻��� �Ϸ������
				// �˻� ��ϰ� ��Ŀ�� ǥ���մϴ�
				displayPlaces(data.places);

				// ������ ��ȣ�� ǥ���մϴ�
				displayPagination(pagination);

			} else if (status === daum.maps.services.Status.ZERO_RESULT) {

				alert('�˻� ����� �������� �ʽ��ϴ�.');
				return;

			} else if (status === daum.maps.services.Status.ERROR) {

				alert('�˻� ��� �� ������ �߻��߽��ϴ�.');
				return;

			}
		}

		// �˻� ��� ��ϰ� ��Ŀ�� ǥ���ϴ� �Լ��Դϴ�
		function displayPlaces(places) {

			var listEl = document.getElementById('placesList'), menuEl = document
					.getElementById('menu_wrap'), fragment = document
					.createDocumentFragment(), bounds = new daum.maps.LatLngBounds(), listStr = '';

			// �˻� ��� ��Ͽ� �߰��� �׸���� �����մϴ�
			removeAllChildNods(listEl);

			// ������ ǥ�õǰ� �ִ� ��Ŀ�� �����մϴ�
			removeMarker();

			for (var i = 0; i < places.length; i++) {

				// ��Ŀ�� �����ϰ� ������ ǥ���մϴ�
				var placePosition = new daum.maps.LatLng(places[i].latitude,
						places[i].longitude), marker = addMarker(placePosition,
						i), itemEl = getListItem(i, places[i], marker); // �˻� ��� �׸� Element�� �����մϴ�

				// �˻��� ��� ��ġ�� �������� ���� ������ �缳���ϱ�����
				// LatLngBounds ��ü�� ��ǥ�� �߰��մϴ�
				bounds.extend(placePosition);

				// ��Ŀ�� �˻���� �׸� mouseover ������
				// �ش� ��ҿ� ���������쿡 ��Ҹ��� ǥ���մϴ�
				// mouseout ���� ���� ���������츦 �ݽ��ϴ�
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

			// �˻���� �׸���� �˻���� ��� Elemnet�� �߰��մϴ�
			listEl.appendChild(fragment);
			menuEl.scrollTop = 0;

			// �˻��� ��� ��ġ�� �������� ���� ������ �缳���մϴ�
			map.setBounds(bounds);
		}

		// �˻���� �׸��� Element�� ��ȯ�ϴ� �Լ��Դϴ�
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

		// ��Ŀ�� �����ϰ� ���� ���� ��Ŀ�� ǥ���ϴ� �Լ��Դϴ�
		function addMarker(position, idx, title) {
			var imageSrc = 'http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // ��Ŀ �̹��� url, ��������Ʈ �̹����� ���ϴ�
			imageSize = new daum.maps.Size(36, 37), // ��Ŀ �̹����� ũ��
			imgOptions = {
				spriteSize : new daum.maps.Size(36, 691), // ��������Ʈ �̹����� ũ��
				spriteOrigin : new daum.maps.Point(0, (idx * 46) + 10), // ��������Ʈ �̹��� �� ����� ������ �»�� ��ǥ
				offset : new daum.maps.Point(13, 37)
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

		// �˻���� ��� �ϴܿ� ��������ȣ�� ǥ�ô� �Լ��Դϴ�
		function displayPagination(pagination) {
			var paginationEl = document.getElementById('pagination'), fragment = document
					.createDocumentFragment(), i;

			// ������ �߰��� ��������ȣ�� �����մϴ�
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

		// �˻���� ��� �Ǵ� ��Ŀ�� Ŭ������ �� ȣ��Ǵ� �Լ��Դϴ�
		// ���������쿡 ��Ҹ��� ǥ���մϴ�
		function displayInfowindow(marker, title) {
			var encode = encodeURI(title);
			var content = '<div style="padding:5px;z-index:1;">' + '<a name="'
					+ title + '" href="printStoreInfoSS?title=' + encode
					+ ' "title="' + title + '">' + title + '</a></div>';
			infowindow.setContent(content);
			infowindow.open(map, marker);
		}

		// �˻���� ����� �ڽ� Element�� �����ϴ� �Լ��Դϴ�
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

			// ��Ұ˻� ��ü�� ���� Ű����� ��Ұ˻��� ��û�մϴ�
			ps.keywordSearch(keyword, placesSearchCB);
		}
	</script>

</body>
</html>