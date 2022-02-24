<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="DBPKG.DAO" %>
<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("UTF-8");
String array = request.getParameter("array");

ArrayList<Integer> movienum = new ArrayList<Integer>();

if(array != null && !array.equals("")){
	
	try{
		//1. 연결
		
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
				conn = DAO.getConnection();
				String sql = "SELECT m_no FROM movie ORDER BY "+array+" DESC";
				//2. 명령문보내기
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				
				while(rs.next()){
					int num = rs.getInt("m_no");
					movienum.add(num);
				}
							
				rs.close();
				ps.close();
				conn.close(); 
		 
	}catch (Exception e) {
		  e.printStackTrace(); 
	}
}else{
	
	try{
		//1. 연결	
	
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
				conn = DAO.getConnection();
				String sql = "SELECT m_no FROM movie ";
				//2. 명령문보내기
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				
				while(rs.next()){
					int num = rs.getInt("m_no");
					movienum.add(num);
				}	
				rs.close();
				ps.close();
				conn.close(); 
				
	}catch (Exception e) {
		  e.printStackTrace(); 
	}
}

%>
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
 
 	<div class="right">
 	<form name="frm" method="post" action="movieList.jsp">
 	<select name="array" ><!--정렬하기위한 이름 -->
 		<option value=""></option>
 		<option value="m_view">관람객순</option>
 		<option value="m_sdate">최신개봉순</option>
 	</select>
 	<button type="submit">GO</button>
 	</form>
 	</div>
 	
 	<%
 	int size = movienum.size();
 
 	int scount = ((size/4)<1)?1:(size/4);
 	int count = 0;
 	%>
 	<%while(scount>0){ %>
    <div class="movie" >
      <!-- background-image 배경으로 사진을 첨부해서 비율을 맞추도록합니다. -->	
      <%
    
      for(int i=0+count; i<count+4; i++) {
      int rank = (i<8)?i+1:0;//영화순위   
      %>
      <div class="a">
      <div onclick="location='movieDetail.jsp?m_no=<%=movienum.get(i)%>'" style="background-image:url('img/<%=movienum.get(i)%>.jpg')" class="fakeimg"></div>
      <div class="c"><img src="img/rank<%=rank%>.png"></div>
      </div>
    <%} %>
    </div>
    <%
    count+=4;
    scount--;
  	}
  	%>    
</section>

<%@include file="footer.jsp" %>
</body>
</html>