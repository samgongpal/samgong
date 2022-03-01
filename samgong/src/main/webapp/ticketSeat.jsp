<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="DBPKG.DAO"%>
<%@page import="java.sql.*"%>
<%@include file="certificated.jsp" %>




<!-- 해야 할 일
좌석번호 1-25번까지(default=0 선택 시=1)

좌석선택 후 저장할 때 몇번좌석 골랐는지 체크해서 체크된 좌석은 값을 1로 바꾸고,
다음 예매할 때 값이 1인 좌석은 못고르게하기. -->

<%
	request.setCharacterEncoding("UTF-8");

	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	String m_no = request.getParameter("m_no");
	String u_no = request.getParameter("u_no");
	String t_no = request.getParameter("t_no");
	String r_no = request.getParameter("r_no");
	String r_count = request.getParameter("r_count");

	
	ArrayList<String[]> seatList = new ArrayList<String[]>();
	ArrayList<String[]> reservList = new ArrayList<String[]>();
	
	try{
		//1. 연결
		conn = DAO.getConnection();
		String sql = "SELECT * FROM seat";
		//2. 명령문보내기
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();
		
		while(rs.next()){
			String[] seat = new String[28];
			for(int i = 0; i < 25; i++){
				String s = "seat";
				s = s + (i + 1);
				seat[0] = rs.getInt(s) + "";
				seatList.add(seat);
			}
		}
		rs.close();
		ps.close();
		conn.close();
		
		//1. 연결
		conn = DAO.getConnection();
		String sql2 = "SELECT * FROM reservation";
		//2. 명령문보내기
		ps = conn.prepareStatement(sql2);
		rs = ps.executeQuery();
		
		while(rs.next()){
			String[] reserv = new String[6];
			reserv[0] = rs.getInt("r_no")+ 1 + "";
			reserv[1] = rs.getInt("r_count") + "";
			reservList.add(reserv);
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
<title>좌석선택</title>
<link rel="stylesheet" href="css/style.css">

<style>
section{
	font-size: 1.2rem;
}
.ticket{	
	max-height: 500px;
	/* overflow: */
	margin-top: 100px;
}
.ticketBox{
	width: 100%;
	background-color: white;
	border-radius: 2rem;
}
.ticketHead{
	text-align: center;
}
.ticketList{
	padding: 15px;
	cursor: pointer;
}
.ticketList:hover{
	background: #c2c4c4;
}
@media screen and (min-width: 700px) {
	.ticket{
		display: flex;
		justify-content: center;
		align-items: center;
	}
}
</style>
</head>

<body>
<%@ include file="topmenu.jsp" %>

<div align="center">
	<h2>빠른예매_좌석선택</h2>
	<form name="form" action="ticketSeatPro.jsp?m_no=<%=m_no%>&u_no=<%=session_no%>&t_no=<%=t_no %>" method="post">
		<table border="1">
			<%int n = 0; %>
			<%String[] seat = seatList.get(n); %>
			<%for(int i = 0; i < 5; i++){ %>
				<tr>
				<%for(int j = 0; j < 5; j++) { %>
					<td width="50px" height="50px" align="center">
					<input type="checkbox" name="seat" value=<%=n + 1 %>></td>
				<% n++;
				}%>
				</tr>
			<%}%>
			<tr>			
				<td colspan="5" align="center"><input type="submit" value="선택완료"></td>									
			</tr>
		</table>
	</form>
</div>


<%@ include file="footer.jsp" %>
</body>
</html>