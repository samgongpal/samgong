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
      <h2>영화제목</h2>
      <h5>날짜, 2022</h5>
      <div class="videowrapper">
      <iframe width="560" height="315" src="https://www.youtube.com/embed/XWjZXGRYARk" frameborder="0" ></iframe>
      </div>
      <p>출연진</p>
      <p>영화소개
      </p>
    </div>
	<div class="movie">
      <h2>영화제목</h2>
      <h5>날짜, 2022</h5>
      <div class="videowrapper">
      <iframe width="560" height="315" src="https://www.youtube.com/embed/ebO37MbksIY"
      frameborder="0"></iframe>
      </div>
      <p>출연진</p>
      <p>영화소개
      </p>
    </div>
    <div class="movie">
      <h2>영화제목</h2>
      <h5>날짜, 2022</h5>
      <div class="videowrapper">
      <iframe width="560" height="315" src="https://www.youtube.com/embed/ebO37MbksIY"
      frameborder="0"></iframe>
      </div>
      <p>출연진</p>
      <p>영화소개
      </p>
    </div>
  </div>
<!-- 사이드 메뉴입니다. -->
<div class="rightcolumn">
    <div class="movie">
    <form name="frm" method="post" action="indexSearch.jsp">
      <input type="text" name="m_name">
      <button type="submit">search</button>
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