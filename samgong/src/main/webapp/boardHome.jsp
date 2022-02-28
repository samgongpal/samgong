<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	java.util.Date date = new java.util.Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
	String strdate = simpleDate.format(date);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>∙ 삼공시네마 고객센터 ∙</title>
</head>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/board.css">
<body>
<%@ include file="topmenu.jsp" %>
<section>
<div class="top" style="text-align:left"><h1>Customer Center</h1></div>
<!-- 사이드 메뉴입니다. -->
<%@ include file="boardSide.jsp" %>
<div class="leftcolumn">

<div class="board">

<div class="boardWrap">
	<div class="home">
    <form name="frm" method="post" action="indexSearch.jsp"> 
    <div class="searchBox">
      	<input type="text" name="m_name" placeholder="검색어를 입력해 주세요.">
 		<button type="submit">검색</button>
 	</div>
    </form>    
    </div>
</div>
</div>

<div class="board">
    
    
    <table style="margin:50px;">
    <caption><h2>∙ 공지/뉴스 ∙</h2></caption>
    	
    	<tr>
    		<td>[공지] 영화 관람료 변경 안내 </td>
    		<td style="cursor:default"><%=strdate %></td>
    	
    	</tr>
    	<tr>
    		<td>[공지] 네이버페이 시스템 점검 안내 (2/12)</td>
    		<td style="cursor:default"><%=strdate %></td>
    		
    	</tr>
    	<tr>
    		<td>[공지] 개인정보 처리 방침 변경 안내</td>
    		<td style="cursor:default"><%=strdate %></td>
    		
    	</tr>
    	<tr>
    		<td>[공지] 운영시간 변경 안내</td>
    		<td style="cursor:default"><%=strdate %></td>
    		
    	</tr>
    
    </table>
</div>

</div>
</section>
<%@ include file="footer.jsp" %>
</body>
</html>