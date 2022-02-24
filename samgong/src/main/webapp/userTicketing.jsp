<%@page import="java.util.ArrayList"%>
<%@page import="DBPKG.DAO"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	  String sql = "SELECT T.t_address, M.m_name, R.r_count, R.r_date, R.r_no FROM RESERVATION R, MOVIE M, THEATER T WHERE R.u_no= ? AND M.m_no = R.m_no AND T.t_no = R.t_no"; 
	  ps = conn.prepareStatement(sql);
	  ps.setInt(1, Ticketing_no);
	  rs = ps.executeQuery();
	  while(rs.next()) {
		  String[] Ticketing = new String[5];
		  Ticketing[0] = rs.getString(1);
		  Ticketing[1] = rs.getString(2);
		  Ticketing[2] = rs.getInt(3) + "";
		  String date1  = rs.getString(4);
		  String date2 = date1.substring(0, 10);
		  Ticketing[3] = date2;
		  Ticketing[4] = rs.getInt(5) + "";
		  userTicket.add(Ticketing);
	  }
	  conn.close();
	  ps.close();
	  rs.close();
  }catch(Exception e) {
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
</head>
<body>
<%@ include file="topmenu.jsp" %>
  <section>
    <%if(userTicket.size() > 0) {%>
    <h2>예매정보</h2>
    <table>
      <tr>
      <td>영화관</td><td>영화제목</td><td>인원</td><td>날짜</td>
      </tr>
      
      <%for(int i = 0; i < userTicket.size(); i ++) {%>
        <tr>
          <%String[] Ticketing = userTicket.get(i);%>
          <td><%= Ticketing[0]%></td>
          <td><%= Ticketing[1]%></td>
          <td><%= Ticketing[2]%></td>
          <td><%= Ticketing[3]%></td>
          <td><input type="submit" value="예매취소">
              <input type="hidden" value=<%= Ticketing[4]%>></td>
        </tr>
      <%} %>
      <tr>
      <td colspan="4"><button type="button" onclick="location.href='index.jsp'">돌아가기</button></td>
      </tr>
    </table>
    <%}else {%>
      <h2>예매내역이 없습니다.</h2>
      <button type="button" onclick="location.href='ticketList.jsp'">예매하러가기</button>
      <button type="button" onclick="location.href='index.jsp'">취소</button>
    <%} %>
  </section>
<%@include file="footer.jsp" %>
</body>
</html>