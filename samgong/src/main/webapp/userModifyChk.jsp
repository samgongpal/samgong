<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DBPKG.DAO" %>
<%@ page import="java.sql.*" %>
<%@ include file="topmenu.jsp" %>
<%
if(session_no == null || session_no.equals("")){
%>
	<script>
	alert("비정상적인 접근!");
	location="index.jsp";	
	</script>
<%	return;
}
String u_pw = request.getParameter("u_pw");
Connection conn = DAO.getConnection();
Statement stmt = conn.createStatement();

String sql1 = " SELECT u_pw FROM MUSER WHERE u_no="+session_no;
ResultSet rs = stmt.executeQuery(sql1);
rs.next();
if(!u_pw.equals(rs.getString("u_pw"))){ //회원정보의 기존 비밀번호와 일치하지 않을때
%>
	<script>
	alert("비밀번호가 일치하지않습니다.");
	history.back();
	</script>  
<%
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>