<%@page import="java.util.ArrayList"%>
<%@page import="DBPKG.DAO"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="certificated.jsp" %> 
<%
  //수정(2022.2월18일.MOM) session 으로 받은 u_no 변수명 중복으로 오류방지를 위해 이름 변경합니다.
  //수정(2022.2월20일.MOM) 유저번호의 여부를 확인할수있는 certificated.jsp 를 생성하였습니다.
  if(check_no == null || check_no.equals("")){ //로그인 하지 않은 유저가 수정화면에 접근했을때 *있을수없는일 
  %>
	<script>
	alert("비정상적인 접근입니다!");
	location="index.jsp";
	</script>    
  <%
  	return;
  }
  
  int Ticketing_no = Integer.parseInt(check_no);
  
  Connection conn = null;
  PreparedStatement ps = null;
  ResultSet rs = null;
  
  ArrayList<String[]> userTicket = new ArrayList<String[]>();
  
  try{
	  conn = DAO.getConnection();
	 String sql = "SELECT R.r_no, M.m_name, T.t_address, R.r_count ";
	         sql+= "FROM MOVIE M, THEATER T, RESERVATION R WHERE r.u_no = ? AND R.t_no = T.t_no AND r.m_no = M.m_no ORDER BY r_no";
	
	
	  ps = conn.prepareStatement(sql);
	  ps.setInt(1, Ticketing_no);
	  rs = ps.executeQuery();
	  while(rs.next()) {
		  String[] Ticketing = new String[4];
		  Ticketing[0] = rs.getInt(1) + "";
		  Ticketing[1] = rs.getString(2);
		  Ticketing[2] = rs.getString(3);
		  Ticketing[3] = rs.getInt(4) + "";
		  userTicket.add(Ticketing);
	  }
	  conn.close();
	  ps.close();
	  rs.close();
  }catch(Exception e) {
	  e.printStackTrace();
	  e.printStackTrace();
  }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userTicketing</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/user.css">
<style>
.page{
	display: flex;
	justify-content: center;
	align-items: center;
}
.page > table,th,td{
	padding: 1rem;
	border: 1px solid #333;
	border-collapse: collapse;
}
.page > th{
	background-color: rgba(255,255,255,0.5);
}
</style>
</head>
<body>
<%@ include file="topmenu.jsp" %>
<div class="top"><h1>∙ 예매정보 ∙</h1></div>
  <section>
    <%if(userTicket.size() > 0) {%>
    <form action="userTicketingPro.jsp">
    <div class="page">
	<div class="pageWrap">
    <div class="pageBox1">마이페이지</div>
    <div class="pageBox">
   		<div class="pageBox2">
		    <div>영화제목  영화관  인원</div>
		    <%for(int i = 0; i < userTicket.size(); i ++) {%>
 
        	<%String[] Ticketing = userTicket.get(i);%>
        	<div class="page">
       		<div><%= Ticketing[1]%></div>
        	<div><%= Ticketing[2]%></div>
        	<div><%= Ticketing[3]%></div>
        	</div>
        	<div>
			<input type="button" value="삭제" onclick="location.href='userTicketingPro.jsp?r_no=<%= Ticketing[0]%>'">
       		</div>
      		<%} %>
     		<div>
     		<button type="button" onclick="location.href='index.jsp'">돌아가기</button></td>
			</div>
   		</div>
     	<div class="pageBox3" >
      		<h3>삼공시네마</h3>
      		<p>Samgong center</p>
      		<p>10:30 ~ 18:30</p>
    	</div>   
	</div>
	</div>
    
</div>
    </form>
    <%}else {%>
      <h2>예매내역이 없습니다.</h2>
      <button type="button" onclick="location.href='ticketList.jsp'">예매하러가기</button>
      <button type="button" onclick="location.href='index.jsp'">취소</button>
    <%} %>
  </section>
<%@include file="footer.jsp" %>
</body>
</html>