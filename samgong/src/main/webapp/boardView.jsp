<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DBPKG.DAO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="certificated.jsp" %> 
<%
String strReferer = request.getHeader("referer");
if(strReferer == null){ 
%>
	<script>
	location="index.jsp";
	</script>
<%
	return;
}
String view = request.getParameter("view");

if(view == null){
%>
	<script>
	location="index.jsp";
	</script>
<%
}

switch(view){
case("a"): view = "이용약관"; break;//이용약관
case("b"): view = "위치기반서비스"; break;//위치기반서비스
case("c"): view = "개인정보처리방침"; break;//개인정보처리방침
case("d"): view = "스크린 기준"; break;//스크린 기준
default: break;
}
Connection conn = DAO.getConnection();

String sql = " SELECT ";
sql+= " q_no, ";
sql+= " q_title, ";
sql+= " q_con, ";
sql+= " q_hit, ";
sql+= " TO_CHAR(q_date,'YYYY/MM/DD')q_date ";
sql+= " FROM qna WHERE q_title LIKE '%["+view+"]%'";
//공지 최신글 5개
PreparedStatement pstmt = conn.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>∙ 삼공시네마 고객센터 ∙</title>
</head>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/board.css">
<body>
<%@ include file="topmenu.jsp" %>
<section>
<div class="top"></div>
<!-- 사이드 메뉴입니다. -->
<%@ include file="boardSide.jsp" %>
<div class="leftcolumn">
<div class="top"><h1>∙ <%=view%> ∙</h1></div>
<div class="board">
<div class="viewBox">
		<%if(rs.next()) {
		int q_no = rs.getInt("q_no");
		String q_title = rs.getString("q_title");
		String q_date = rs.getString("q_date");
		String q_con = rs.getString("q_con");
		String q_hit = rs.getString("q_hit");
		%>
		
		<%=q_con %>
		<%}%>
</div>
</div>
</div>
</section>
<%@ include file="footer.jsp" %>
</body>
</html>