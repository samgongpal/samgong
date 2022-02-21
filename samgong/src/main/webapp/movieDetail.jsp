<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DBPKG.DAO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
String strReferer = request.getHeader("referer");
if(strReferer == null){ 
//비정상적인 URL 접근차단을 위해 request.getHeader("referer") 메소드를 사용하였습니다.
%>
	<script>
	location="index.jsp";
	</script>
<%
	return;
}
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	request.setCharacterEncoding("UTF-8");
	
	String m_no = request.getParameter("m_no");
	String rank = (Integer.parseInt(m_no)<9)?m_no:"0";//영화순위 
	String URL = ""; //유튜브 예고편 링크
	switch(m_no){
	case "1":	URL = "rB3x60FMwm0"; break;
	case "2":	URL = "F8uPLJzR57w"; break;
	case "3":	URL = "-5Dc8EMVYBo"; break;
	case "4":	URL = "qhKCYXSHpWY"; break;
	case "5":	URL = "eFgBt6sRS_8"; break;
	case "6":	URL = "ujiLqutnym8"; break;
	case "7":	URL = "Y3pfj3yXY5M"; break;
	case "8":	URL = "WNahsXZgKaw"; break;
	case "9":	URL = "OAxu7YTMWNc"; break;
	case "10":	URL = "ywmOxCwBA4k"; break;	
	}
	
	
	String [] movie = new String [11];
	
	try{
		conn = DAO.getConnection();
		String sql = "SELECT * FROM movie WHERE m_no = "+m_no;
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();
		
		if(rs.next()){
			movie[0] = rs.getString("m_no");
			movie[1] = rs.getString("m_name");
			movie[2] = rs.getString("m_dir");
			movie[3] = rs.getString("m_actor");
			movie[4] = rs.getString("m_genre");
			movie[5] = rs.getString("m_sdate");
			movie[6] = rs.getString("m_edate");
			movie[7] = rs.getString("m_grade");
			movie[8] = rs.getString("m_rtime");
			movie[9] = rs.getString("m_view");
			movie[10] = rs.getString("m_info");
		}	
		conn.close();
		ps.close();
		rs.close();
		
	}catch(Exception e){
		e.printStackTrace(); 
	}
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
	if(<%= session_no %> == null || <%= session_no %>.equals("")){
		alert("로그인하세요");
		location.href="userLogin.jsp"; // 로그인페이지
	}
	else{
		alert("로그확인");
		location.href="#"; // 예약 페이지
	}
}
const drawStar = (target) => {
    document.querySelector('.star span').style.width = '${target.value * 10}%';
  }
</script>
<section> 
    <div class="movie">  
      <div class="a">
      <div style="background-image:url('img/<%= m_no %>.jpg');"class="fakeimg"></div>
      <div class="c"><img src="img/rank<%= rank%>.png"></div>
      </div>
  
      <!-- 영화설명 -->
      <ul>
      	
      	<li><h1><%= movie[1]%></h1></li>
      	<li >감독 : <%= movie[2] %></li>
      	<li style="margin-top:1rem;">배우 : <%= movie[3] %></li>
      	<li style="margin-top:1rem;">장르 : <%= movie[4] %> </li>
      	<li style="margin-top:1rem;">상영시간 : <%= movie[8] %> </li>
      	<li style="margin-top:1rem;">누적관객수 : <%= movie[9] %>명 </li>
      	<li style="margin-top:1rem;">영화소개 :<%= movie[10] %> </li>
      	<li style="margin-top:1rem;">평점 : <span>★★★★★</span></li>
      	<li><button class="button"type="button" onclick="fn_reservation()">예매하기</button></li>
      <!-- 로그인 여부 확인을 위한 자바스크립트 유효성체크 *테스트로 작성했어요 수정하셔야합니다 :)-->
      </ul>     
    </div>
    <div class="review">
    <div class="L">
    <div class="video">
	    <div class="videowrapper" >
	    <iframe width="560" height="315" src="https://www.youtube.com/embed/<%=URL %>?controls=0"
	    frameborder="0" allowfullscreen></iframe>     
	    </div>
 	</div>
 	</div>
 	<div class="R">
 	<div class="comment">
 		<span class="star">
  		★★★★★
	  	<span>★★★★★</span>
	  	<input type="range" oninput="drawStar(this)" value="1" step="1" min="0" max="10">
	  	</span>
 		<div style="display:flex; justify-content:center;">
 		<input type="text" name="comment" placeholder="감상평을 등록해주세요.">
 		<button style="padding:1rem;"type="button">저장</button>
 		</div>
 		<div class="text"><%= movie[1]%> 너무재미있어요!</div>
 		<div class="text">강추! ★★★★★</div>
 		<div class="text">배우들의 연기력이 뛰어났기 때문에 재미있게 볼 수 있었다.</div>
 		<div class="text">너무재미있어요!</div>
 		<div class="text"><%= movie[1]%> 영상미 아주 훌륭합니다.강추!</div>
 		<div class="text">너무재미있어요! ★★★★★</div>
 	</div>
 	</div>
 	</div>
</section>
<%@include file="footer.jsp" %>
</body>
<script src="script/script.js"></script>
</html>