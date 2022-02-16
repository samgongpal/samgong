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

</head>
<body>
<%@ include file="topmenu.jsp"%>
<section>
 	<div style="text-align:center"><h2>최신개봉작</h2></div>
    <div class="movie" >
      <div onclick="location='movieDetail.jsp'" style="background-image:url('img/uncharted.jpg')" class="fakeimg">
      <!-- background-image 배경으로 사진을 첨부해서 비율을 맞추도록합니다. -->
      </div>
     
      <div style="background-image:url('img/death.jpg')" class="fakeimg"></div>
     
      <div style="background-image:url('img/uncharted.jpg')" class="fakeimg"></div>
    </div>
    
    <div class="movie" >
      <div style="background-image:url('img/uncharted.jpg')" class="fakeimg"></div>
     
      <div style="background-image:url('img/death.jpg')" class="fakeimg"></div>
 
      <div style="background-image:url('img/uncharted.jpg')" class="fakeimg"></div>
    </div>

</section>

<footer>
  <h5>삼공시네마 2022</h5>
</footer>
</body>
</html>