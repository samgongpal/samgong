<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="DBPKG.DAO" %>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	ArrayList<Integer> movienum = new ArrayList<Integer>();
	
	try{
		
		//1. 연결
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "";
				conn = DAO.getConnection();
				sql = "select * from movie where m_sdate > sysdate";
						
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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>∙ 개봉예정작 ∙</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/movieList.css">

</head>
<body>
<%@ include file="topmenu.jsp"%>
<section>
	<div class="topList"><h1> 개봉예정작 </h1></div>
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
    %>
      <div class="a">
      <div class="fakeimg" onclick="location='movieDetail.jsp?m_no=<%=movienum.get(i)%>'" style="background-image:url('img/<%=movienum.get(i)%>.jpg')" ></div>
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