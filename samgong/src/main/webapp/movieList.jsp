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
 	<div style="text-align:center"><h1>최신개봉작</h1></div>
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
      <div class="a">
      <div onclick="location='movieDetail.jsp?m_no=1'" style="background-image:url('img/1.jpg')" class="fakeimg"></div>
      <div class="c"><img src="img/rank1.png"></div>
      </div>
      
      <div class="a">
      <div onclick="location='movieDetail.jsp?m_no=2'" style="background-image:url('img/2.jpg')" class="fakeimg"></div>
      <div class="c"><img src="img/rank2.png"></div>
      </div>
      
      <div class="a">
      <div onclick="location='movieDetail.jsp?m_no=3'" style="background-image:url('img/3.jpg')" class="fakeimg"></div>
      <div class="c"><img src="img/rank3.png"></div>
      </div>
      
      <div class="a">
      <div onclick="location='movieDetail.jsp?m_no=4'" style="background-image:url('img/4.jpg')" class="fakeimg"></div>
      <div class="c"><img src="img/rank4.png"></div>
      </div>
    </div>
    
    <div class="movie" >
      <div class="a">
      <div onclick="location='movieDetail.jsp?m_no=5'" style="background-image:url('img/5.jpg')" class="fakeimg"></div>
      <div class="c"><img src="img/rank5.png"></div>
      </div>
      
      <div class="a">
      <div onclick="location='movieDetail.jsp?m_no=6'" style="background-image:url('img/6.jpg')" class="fakeimg"></div>
      <div class="c"><img src="img/rank6.png"></div>
      </div>
      
      <div class="a">
      <div onclick="location='movieDetail.jsp?m_no=7'" style="background-image:url('img/7.jpg')" class="fakeimg"></div>
      <div class="c"><img src="img/rank7.png"></div>
      </div>
      
      <div class="a">
      <div onclick="location='movieDetail.jsp?m_no=8'" style="background-image:url('img/8.jpg')" class="fakeimg"></div>
      <div class="c"><img src="img/rank8.png"></div>
      </div>
    </div>
</section>

<footer>
  <h5>삼공시네마 2022</h5>
</footer>
</body>
</html>