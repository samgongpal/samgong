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
<link rel="stylesheet" href="style.css">
<style type="text/css">
@media screen and (min-width: 700px) {
	.movie {
		display: flex;
		justify-content: center;
		align-items: center;
	}
}
</style>
</head>
<body>
<%@ include file="topmenu.jsp"%>
<section>
 
    <div class="movie" >
      <div class="fakeimg">영화사진</div>
     
      <div class="fakeimg">영화사진</div>
 
      <div class="fakeimg">영화사진</div>
  
      <div class="fakeimg">영화사진</div>
      
    </div>

</section>

<footer>
  <h5>삼공시네마 2022</h5>
</footer>
</body>
</html>