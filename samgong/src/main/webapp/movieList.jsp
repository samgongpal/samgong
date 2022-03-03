<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="DBPKG.DAO" %>
<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("UTF-8");
String array = request.getParameter("array");
String m_grade = request.getParameter("m_grade");
String search = request.getParameter("search"); //메인 영화검색에서 넘어오는 변수
String movie = "";
ArrayList<Integer> movienum = new ArrayList<Integer>();

if(search != null){
ArrayList<String> list = (ArrayList)session.getAttribute("session_movie_no");
	
	for(int i=0; i<list.size()-1; i++){
		int num = Integer.parseInt(list.get(i));
		movienum.add(num);
	}
	list = new ArrayList<String>();
	session.removeAttribute("session_movie_no"); //세션값을 삭제합니다.

}else{
	
	try{
		
		//1. 연결
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "";
		
		conn = DAO.getConnection();
		if(array != null && !array.equals("")){
						
		sql = " SELECT m_no FROM movie ORDER BY "+array+" DESC";
					movie = array;
						
				}else if(m_grade != null && !m_grade.equals("")){
						
					sql = " SELECT m_no FROM movie WHERE m_grade = '"+m_grade+"' ";
					movie = m_grade;
					
				}else{
						
					sql = " SELECT m_no FROM movie ";
						
				}		
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
String title = "List of Movies";

String grade = (movie.length() == 1)?"<img src='img/"+movie+".png'>":"";
//영화 등급 사진 적용
switch(movie){
case("A"): title = "전체 관람가"; break;
case("B"): title = "15세 관람가"; break;
case("C"): title = "19세 관람가"; break;
case("m_view"): title = "List of Top Movies"; break;
case("m_sdate"): title = "List of New Movies"; break;
default: break;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>∙ 현재상영작 ∙</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/movieList.css">

</head>
<body>
<%@ include file="topmenu.jsp"%>
<section>
 	<div class="topList"><%=grade%><h1><%=title%></h1></div>
 	<div class="movieSelect">
	 	<div class="left">
	 	<select name="grade" onchange="if(this.value) location.href=(this.value)">
	 		<option value="">연령별</option>
	 		<option value="movieList.jsp?m_grade=A">전체 관람가</option>
	 		<option value="movieList.jsp?m_grade=B">15세 관람가</option>
	 		<option value="movieList.jsp?m_grade=C">19세 관람가</option>
	 	</select>
	 	</div>
	 	
	 
	 	<div class="right">
	 	<form name="frm" method="post" action="movieList.jsp">
	 	<select name="array" ><!--정렬하기위한 이름 -->
	 		<option value=""></option>
	 		<option value="">현재상영작</option>
	 		<option value="m_view">관람객순</option>
	 		<option value="m_sdate">최신개봉순</option>
	 	</select>
	 	<button class="button" type="submit">GO</button>
	 	</form>
	 	</div>
 	</div>
 	<%
 	int size = movienum.size();
 	int index = 0;
 	int num = 4;
 	%>
 	<%while(size>0){ %>
    <div class="movie" >
      <!-- background-image 배경으로 사진을 첨부해서 비율을 맞추도록합니다. -->	
    <%
      num = (size<num && size%num != 0)?size:4;
      /* 영화 등급별로 선택했을때 인덱스 초과로 오류나는것을 방지하기위해 변수를 추가하였습니다. 
      size 가 4이하인경우에는 size를 num 변수에 넣어줍니다.*/
           
      for(int i=index; i<index+num; i++) {
      int rank = (i < 8)?i+1:0;//영화순위  
      String rankBox = (rank > 0)?"<img src='img/rank"+rank+".png'>":"";
    %>
      <div class="a">
      <div class="fakeimg" onclick="location='movieDetail.jsp?m_no=<%=movienum.get(i)%>'" style="background-image:url('img/<%=movienum.get(i)%>.jpg')" ></div>
      <div class="c"><%=rankBox%></div>
      </div>
    <%
    	size--;
    }
    index+=4;
    %>
    </div>
    <%}%>    
</section>
<%@include file="footer.jsp" %>
</body>
</html>