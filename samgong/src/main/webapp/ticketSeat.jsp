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

	String m_no = request.getParameter("m_no"); //영화번호 
	String u_no = request.getParameter("u_no"); //회원번호 
	String t_no = request.getParameter("t_no"); //상영관번호 
	String r_no = request.getParameter("r_no"); //예약번호
	String r_count = request.getParameter("r_count"); //예약인원수

	
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
<title>∙ 좌석선택 ∙</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/ticket.css">
<style>
.seatWrap{
	margin: 50px;
}
.seat{
	display: flex;
	justify-content: center;
	align-items: center;
}
input[type=checkbox] + label{
	display: inline-block;
	margin-left: 10px;
	width: 80px;
	height: 80px;
	border: 2px solid #a9a49d;
	border-radius: 0.8rem;
	cursor: pointer;
}
input[type=checkbox] + label:hover{
	background-color: rgba(255,255,255,0.5);
}
input[type=checkbox]:checked + label{
	background-color: #a9a49d;
}
input[type=checkbox]{
	display: none;
}

</style>
</head>
<script>
function fn_submit(){
	var f = document.frm;
	if(f.seat.value == null){
		alert("좌석을 선택해주세요.");
		return false;
	}
	f.submit();
}
</script>
<body>
<%@ include file="topmenu.jsp" %>
<section>
<div class="top"><h1>∙ 좌석선택 ∙</h1></div>
	<form name="frm" action="ticketSeatPro.jsp?m_no=<%=m_no%>&u_no=<%=session_no%>&t_no=<%=t_no %>" method="post">
	<div class="seatWrap">
			<%int n = 0; %>
			<%String[] seat = seatList.get(n); %>
			<%for(int i = 0; i < 4; i++){ %>
				<div class="seat">
				<%for(int j = 0; j < 6; j++) { 
				String check = "chk"+n; n++;
				//id 값을 다르게 적용해야 중복체크&효과 를 줄수있어서 변수를 생성하였습니다.
				%>
					<div>
					<input type="checkbox" id="<%=check %>" name="seat" value=<%=n + 1 %>>
					<label for="<%=check %>"></label>
					</div>
				<%}%>
				</div>
			<%}%>
	</div>
		<div style="text-align:center">
		<input type="submit" onclick="fn_submit(); return false;" value="선택완료">						
		<button type="reset" onclick="history.back()">뒤로가기</button>	
		</div>		
	</form>
</section>
<%@ include file="footer.jsp" %>
</body>
</html>