<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DBPKG.DAO" %>
<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("UTF-8");

Connection conn = DAO.getConnection();
%>
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

    <div class="movie" >
    
      <div style="background-image:url('img/uncharted.jpg')"class="fakeimg">
      <!-- background-image 배경으로 사진을 첨부해서 비율을 맞추도록합니다. -->
      </div>
      
      <!-- 영화설명 -->
      <ul>
      	<li><h2>영화제목입니다.</h2></li>
      	<li>영화입니다.</li>
      	<li>설명입니다.</li>
      	<li>설명입니다.</li>
      	<li>설명입니다.</li>
      <button type="button" onclick="alert('로그인해주세요.');">예매하기</button>
      <!-- 로그인 여부 확인을 위한 자바스크립트 유효성체크 *테스트로 작성했어요 수정하셔야합니다 :)-->
      </ul>
     
    </div>
    
      <div class="videowrapper" >
      <iframe width="560" height="315" src="https://www.youtube.com/embed/rB3x60FMwm0?controls=0"
      frameborder="0" allowfullscreen></iframe>
      </div>   
 
</section>

<footer>
  <h5>삼공시네마 2022</h5>
</footer>
</body>
<script src="script/script.js"></script>
</html>