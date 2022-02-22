<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DBPKG.DAO" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>현재상영작</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/movie.css">
<link rel="stylesheet" href="css/movieList.css">

</head>
<body>
<%@ include file="topmenu.jsp"%>
<section>
 	<div class="top"><h1>최신개봉작</h1></div>
 	<div class="left">
 	<select name="">
 		<option>장르별</option>
 		<option>액션</option>
 		<option>액션</option>
 		<option>액션</option>
 		<option>액션</option>
 	</select>
 	
 	</div>
 	<div class="right">
 	<select name=""><!--정렬하기위한 이름 -->
 		<option value=""></option>
 		<option value="">최신순위</option>
 		<option value="">테스트</option>
 	</select>
 	</div>
 	
 	
 	
    <div class="movie" >
      <!-- background-image 배경으로 사진을 첨부해서 비율을 맞추도록합니다. -->	
      <%for(int i=1; i<5; i++) {%>
      <div class="a">
      <div onclick="location='movieDetail.jsp?m_no=<%=i %>'" style="background-image:url('img/<%=i %>.jpg')" class="fakeimg"></div>
      <div class="c"><img src="img/rank<%=i %>.png"></div>
      </div>
      <%} %>
    </div>
    
    <div class="movie" >
       <%for(int i=5; i<9; i++) {%>
      <div class="a">
      <div onclick="location='movieDetail.jsp?m_no=<%=i %>'" style="background-image:url('img/<%=i %>.jpg')" class="fakeimg"></div>
      <div class="c"><img src="img/rank<%=i %>.png"></div>
      </div>
      <%} %>
    </div>
    
    <div class="movie" >
       <%for(int i=9; i<11; i++) {%>
      <div class="a">
      <div onclick="location='movieDetail.jsp?m_no=<%=i %>'" style="background-image:url('img/<%=i %>.jpg')" class="fakeimg"></div>
      </div>
      <%} %>
    </div>
</section>

<%@include file="footer.jsp" %>
</body>
</html>