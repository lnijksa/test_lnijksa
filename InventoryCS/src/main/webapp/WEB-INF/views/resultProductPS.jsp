<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="EUC-KR"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="kr.ywhs.dao.InventoryVO"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>

   <%
      ArrayList<InventoryVO> list = (ArrayList) request.getSession()
            .getAttribute("result");
      String[] array = new String[list.size()];
      String[] farray = new String[list.size()];

      for (int i = 0; i < list.size(); i++) {
         array[i] = list.get(i).getStore_name().trim();
         int num = array[i].indexOf(" ");
         array[i] = array[i].substring(0, num)
               + array[i].substring(num + 1);
         array[i] = URLEncoder.encode(array[i], "UTF-8");

      }

      for (int i = 0; i < list.size(); i++) {
   %>
      <li><a href="printStoreInfoPS?title=<%=array[i]%>" style="text-decoration:none;" >매장명 : <%=list.get(i).getStore_name().trim()%><br>
            상품명 : <%=list.get(i).getProduct_name().trim()%><br> 재고수량 : <%=list.get(i).getAmount()%></a></li>
      
   <%
      }
   %>

</body>
</html>