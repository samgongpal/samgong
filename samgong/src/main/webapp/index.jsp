<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삼공시네마</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<%@ include file="topmenu.jsp" %>
<section>
  <div class="leftcolumn">
	<div class="movie">
      <h1>피그</h1>
      <p>2022년 2월 10일 개봉</p>
      <div class="videowrapper">
      <iframe width="560" height="315" src="https://www.youtube.com/embed/HLmm2ZR_VOI"></iframe>
      </div>
    </div>
    <div class="movie">
      <h1>씽2게더</h1>
      <h5>2022년 1월 5일 개봉</h5>
      <div class="videowrapper">
      <iframe width="560" height="315" src="https://www.youtube.com/embed/XWjZXGRYARk"></iframe>
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
      <h3>Popular Post</h3>
     
    </div>
    <div class="movie">
      <h3>Follow Me</h3>
      <p>Some text..</p>
    </div>
</div>
</section>
<%@include file="footer.jsp" %>
</body>
</html>