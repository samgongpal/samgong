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
%>
	<script>
	alert("정상적인 경로를 통해 다시 접근해 주십시오.");
	location="index.jsp";
	</script>
<%
	return;
}
%>

<%
	request.setCharacterEncoding("UTF-8");
	
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	
	if(check_no == null || check_no.equals("")){
		%>
		<script>
		alert("로그인후 이용해주세요.");
		location='userLogin.jsp';
		</script>
		<% return;
	}	
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
<link rel="stylesheet" href="css/tiket.css">

<body>
<%@ include file="topmenu.jsp" %>
<section>
<div align="center">
	<h2>빠른예매_영화선택</h2>
	
</div>
</section>
<%@ include file="footer.jsp" %>
</body>
</html>