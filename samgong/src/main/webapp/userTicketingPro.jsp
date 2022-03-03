<%@page import="DBPKG.DAO"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="certificated.jsp" %> 
<%
  request.setCharacterEncoding("UTF-8");
  int TicketD = Integer.parseInt(request.getParameter("r_no"));
  
  Connection conn = null;
  PreparedStatement ps = null;
  try{
	  conn = DAO.getConnection();
	  String sql = "DELETE FROM RESERVATION WHERE r_no =?";
	  ps = conn.prepareStatement(sql);
	  ps.setInt(1, TicketD);
	  ps.executeUpdate();
  }catch(Exception e) {}
%>
<script>
  alert("취소가 완료되었습니다.");
  location.href="userPage.jsp";
</script>