<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DBPKG.DAO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	request.setCharacterEncoding("UTF-8");
	
	String m_no = request.getParameter("m_no");
		
	String [] movie = new String [11];
	
	try{
		conn = DAO.getConnection();
		String sql = "select * from movie where m_no = "+m_no;
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();
		
		if(rs.next()){
			movie[0] = rs.getInt("m_no") + "";
			movie[1] = rs.getString("m_name");
			movie[2] = rs.getString("m_dir");
			movie[3] = rs.getString("m_actor");
			movie[4] = rs.getString("m_genre");
			movie[5] = rs.getString("m_sdate");
			movie[6] = rs.getString("m_edate");
			movie[7] = rs.getString("m_grade");
			movie[8] = rs.getInt("m_rtime") + "";
			movie[9] = rs.getInt("m_view") + "";
			movie[10] = rs.getString("m_info");
		}
		
		conn.close();
		ps.close();
		rs.close();
		
	}catch(Exception e){}
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
<script type="text/javascript">
function fn_reservation(){
	if(<%= u_no %> == -1){
		alert("로그인하세요");
		location.href="#"; // 로그인페이지
	}
	else{
		alert("로그확인");
		location.href="#"; // 예약 페이지
	}
}
</script>
<section>
    <div class="movie" >
    
      <div style="background-image:url('img/<%= m_no %>.jpg')"class="fakeimg">
      <!-- background-image 배경으로 사진을 첨부해서 비율을 맞추도록합니다. -->
      
      </div>

    
      <!-- 영화설명 -->
      <ul>
      	
      	<li><h2><%= movie[1] %></h2></li>
      	<li>감독 :<%= movie[2] %></li>
      	<li>배우 :<%= movie[3] %></li>
      	<li>장르 :<%= movie[4] %> </li>
      	<li>상영시간 :<%= movie[8] %> </li>
      	<li>누적관객수 :<%= movie[9] %> </li>
      	<li>영화소개 :<%= movie[10] %> </li>
      	
     
      <button type="button" onclick="fn_reservation()">예매하기</button>
      
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