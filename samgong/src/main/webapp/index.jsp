<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>∙ 삼공시네마 ∙</title>
<link rel="stylesheet" href="css/style.css">
<style>
@media screen and (max-width: 700px) {
    .rightcolumn {   
        display: none;
        padding: 0;
    }
}
</style>
</head>
<body>
<%@ include file="topmenu.jsp" %>
<section>
	<div class="movie">
	<div class="movieBox" >
    <img style="cursor:pointer" onclick="location='movieDetail.jsp?m_no=21'" src="img/Black.jpg">
    </div>
    </div>
  	<div class="leftcolumn">
	<div class="movie">
      <h1>블랙라이트 Blacklight, 2020</h1>
      <p>2022년 3월 9일 대개봉</p>
      <div class="videowrapper">
      <iframe width="560" height="315" src="https://www.youtube.com/embed/Rdq1Uao67aQ"></iframe>
      </div>
    </div>
    <div class="movie">
      <h1>미니언즈2 Minions: The Rise of Gru, 2022</h1>
      <p>2022년 7월 대개봉</p>
      <div class="videowrapper">
      <iframe width="560" height="315" src="https://www.youtube.com/embed/99DlyQZgfs8"></iframe>
      </div>
    </div>
  </div>
<!-- 사이드 메뉴입니다. -->
<div class="rightcolumn">
    <div class="movie">
    <form name="frm" method="post" action="indexSearch.jsp">
     
    <div class="searchBox">
      	<input type="text" name="m_name" >
 		<button type="submit">검색</button>
 	</div>
    </form>
    </div>  
    <div class="movie">
    <div class="movieBox">
    	<img src="img/side.jpg">
    </div>
    </div>
    <div class="movie">
    <div class="movieBox">
    	<img src="img/side2.jpg">
    </div>
    </div>
</div>
</section>
<div class="movie">
	<div class="movieBox">
    <img style="cursor:pointer" onclick="location='movieDetail.jsp?m_no=14'" src="img/Nite.jpg">
    </div>
    </div>
<%@include file="footer.jsp" %>
</body>
</html>