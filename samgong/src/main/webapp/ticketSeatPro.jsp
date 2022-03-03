<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="DBPKG.DAO"%>
<%@page import="java.sql.*"%>
<%@include file="certificated.jsp" %>

<%
	request.setCharacterEncoding("UTF-8");

	int r_count2 = 0;
	int r_no2 = 2;
	//String r_no = request.getParameter("r_no");
	//String r_count = request.getParameter("r_count");
	String u_no = request.getParameter("u_no");
	String m_no = request.getParameter("m_no");
	String t_no = request.getParameter("t_no");
	String[] seat = request.getParameterValues("seat");
	
	
 	for(int i = 0; i < seat.length; i++){
		System.out.println(seat[i]);
		r_count2++;
	}
 	String r_count = r_count2 + "";
 	//System.out.println(r_count);
 	
 	//String r_no = r_no2 + "";
	
	Connection conn = null;
	PreparedStatement ps = null;
	
	try{
		conn = DAO.getConnection();
		String sql = " INSERT INTO RESERVATION ";
		       sql+= " (r_no, r_count, m_no, u_no, t_no) ";
		       sql+= " VALUES(RES_DEPT.NEXTVAL, ?, ?, ?, ?) ";
		ps = conn.prepareStatement(sql);
		ps.setString(1, r_count);
		ps.setString(2, m_no);
		ps.setString(3, u_no);
		ps.setString(4, t_no);
		ps.executeUpdate();
		
		conn.close();
		ps.close();
		
	}catch(Exception e){
		  e.printStackTrace();
	}
	
response.sendRedirect("userTicketing.jsp");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좌석선택</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/ticket.css">

<style>
.seat{
	display: flex;
	justify-content: center;
	align-items: center;
}
.seat > table,th,td{
	width: 300px;
	padding: 1rem;
	border-collapse: collapse;
	border: 1px solid #333;
}
.seat > th{
	background-color: rgba(255,255,255,0.5);
}
</style>
</head>

<body>
<%@ include file="topmenu.jsp" %>
<section>
	<h2 align="center">빠른예매_좌석선택</h2>
	<div class="seat">
	<table>

			<tr>
				<%if(seat != null){ %>
					<td>선택좌석 = 
					<%for(int i = 0; i < seat.length; i++) {%>
					<%=seat[i] %>
					<%} %>
					번</td>
				<%} %>
			</tr>
		<tr>			
			<td colspan="5" align="center">
			<input type="button" value="메인으로" onclick="window.location.href='index.jsp'"></td>									
		</tr>
	</table>
	</div>
</section>
<%@ include file="footer.jsp" %>
</body>
</html>