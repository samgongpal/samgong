<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DBPKG.DAO" %>
<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("UTF-8");
Connection conn = DAO.getConnection();

String sql = " SELECT q_no,q_title,q_con,q_hit,TO_CHAR(q_date,'YYYY/MM/DD')q_date FROM qna ";
PreparedStatement pstmt = conn.prepareStatement(sql);

ResultSet rs = pstmt.executeQuery();

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA</title>
</head>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/qna.css">
<body>
<%@ include file="topmenu.jsp" %>
<section>
<div class="top"><h1>테스트 수정중</h1></div>


<div class="board">
   	
	<table >		
	<colgroup>
		<col width="8%"/>
		<col width="50%"/>
		<col width="15%"/>
		<col width="15%"/>
		<col width="*"/>
	</colgroup>	
		<tr>
			<th>순서</th>
			<th>순서</th>
			
			<th>순서</th>
			<th>순서</th>
		</tr>
		<%while(rs.next()) {%>
		<tr>
			<td><%=rs.getString("q_no")%></td>
			<td><%=rs.getString("q_title")%></td>
			
			<td><%=rs.getString("q_date")%></td>
			<td><%=rs.getString("q_hit")%></td>
		</tr>
		<%} %>
	</table>

</div>

</section>
</body>
</html>