<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="DBPKG.DAO"%>
<%@page import="java.sql.*"%>
<%@include file="certificated.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	

	ArrayList<String[]> movieList = new ArrayList<String[]>();
	
	try{
		//1. 연결
		conn = DAO.getConnection();
		String sql = "SELECT m_no, m_name, m_grade FROM movie";
		//2. 명령문보내기
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();
		
		while(rs.next()){
			String[] movie = new String[11];
			movie[0] = rs.getInt("m_no") + "";
			movie[1] = rs.getString("m_name");
			movie[2] = rs.getString("m_grade");
			movieList.add(movie);
		}
		rs.close();
		ps.close();
		conn.close(); 
		
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화예매</title>
</head>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/ticket.css">

<body>
<%@ include file="topmenu.jsp" %>
<section>
<div class="top"><h1>빠른예매</h1></div>

<div class="ticket">
	<table>
		<tr>
		<th><h3>영화</h3></th>
		</tr>

		<%for(int i = 0; i < movieList.size(); i++) {%>
		<%String[] movie = movieList.get(i); %>	
		<tr>
			<td onClick="location='ticket_theater.jsp?m_no=<%=movie[0]%>&u_no=<%=session_no%>' ">
			<%=movie[2]%><!-- 영화등급 -->
			<%=movie[1]%>
			</td>
			
		</tr>
		<%} %>
	</table>
	
	<table>
		<tr>
		<th><h3>극장</h3></th>
		</tr>
	
		<%for(int i = 0; i < movieList.size(); i++) {%>
		<%String[] movie = movieList.get(i); %>	
		<tr>
			<td onClick="location='ticket_theater.jsp?m_no=<%=movie[0]%>&u_no=<%=session_no%>' ">
			<%=movie[2]%><!-- 영화등급 -->
			<%=movie[1]%>
			</td>
			
		</tr>
		<%} %>
	</table>
	
	<table>
		<tr>
		<th><h3>시간</h3></th>
		</tr>
	
		<%for(int i = 0; i < movieList.size(); i++) {%>
		<%String[] movie = movieList.get(i); %>	
		<tr>
			<td onClick="location='ticket_theater.jsp?m_no=<%=movie[0]%>&u_no=<%=session_no%>' ">
			<%=movie[2]%><!-- 영화등급 -->
			<%=movie[1]%>
			</td>
			
		</tr>
		<%} %>
	</table>
	
</div>

</section>
<%@ include file="footer.jsp" %>
</body>
</html>