<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="DBPKG.DAO"%>
<%@page import="java.sql.*"%>
<%@include file="certificated.jsp" %>
<%
String strReferer = request.getHeader("referer");
if(strReferer == null){ 
//비정상적인 URL 접근차단을 위해 request.getHeader("referer") 메소드를 사용하였습니다.
//로그인한 회원이 주소창에 URL 로 접근하는것을 차단
%>
	<script>
	location="index.jsp";
	</script>
<%
	return;
}
	request.setCharacterEncoding("UTF-8");
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	String m_no = request.getParameter("m_no");	
	
	ArrayList<String[]> movieList = new ArrayList<String[]>();
	ArrayList<String[]> theaterList = new ArrayList<String[]>();

	try{
		//1. 연결
		conn = DAO.getConnection();
		String sql = "SELECT m_no, m_name, m_grade FROM movie";
		//2. 명령문보내기
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();
		
		while(rs.next()){
			String[] movie = new String[3];
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
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/ticket.css">

</head>
<body>
<%@ include file="topmenu.jsp" %>
<section>
<div class="top"><h1>최신개봉작</h1></div>

<div class="ticket">
	<div class="ticketBox">
		<div class="ticketHead"><h3>영화</h3></div>
		<%for(int i = 0; i < movieList.size(); i++) {
		String[] movie = movieList.get(i); 
		String color=""; 

		if(m_no != null && m_no.equals(movie[0])){
			color="style=\"background-image:url('img/main.webp')\" ";
		}
		%>			
		<div class="ticketList"  <%=color%> onClick="location='ticketList.jsp?m_no=<%=movie[0]%>&u_no=<%=session_no%>' ">
		<img style="width:20px" src="img/<%=movie[2].replace(" ","")%>.png"> <!-- 영화등급 -->
		<%=movie[1]%>
		</div>
		<%}%>
	</div>

		<div class="ticketBox">
		<div class="ticketHead"><h3>극장</h3></div>
		<% if(m_no != null && !m_no.equals("")){ 		
			
			conn = DAO.getConnection();
			Statement stmt = conn.createStatement();

			String sql = " SELECT*FROM theater";
			       
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				String[] theater = new String[3];
				theater[0] = rs.getInt("t_no") + "";
				theater[1] = rs.getString("t_name");
				theater[2] = rs.getString("t_address");
				theaterList.add(theater);
			}		
			
			rs.close();
			stmt.close();
			conn.close(); 
			
			
			for(int i = 0; i < theaterList.size(); i++){
			String[] theater = theaterList.get(i); 	
		%>
			<div class="ticketList" onClick="location='ticketSeat.jsp?m_no=<%=m_no%>&u_no=<%=session_no%>&t_no=<%=theater[0]%>' ">
			<%=theater[2]%>
			</div>		
		<%}%>
		<%}%>
	</div>
</div>
</section>
<%@ include file="footer.jsp" %>
</body>
</html>