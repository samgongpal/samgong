<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="DBPKG.DAO"%>
<%@page import="java.sql.*"%>
<%
  request.setCharacterEncoding("UTF-8");
  
  String u_no = request.getParameter("u_no");
  //hidden 으로 보내진 u_no  
  String u_pw = request.getParameter("u_pw");
  String u_mail = request.getParameter("u_mail");
  String u_phone = request.getParameter("u_phone");
  
  //유효성체크
  if(u_no == null || u_pw == null || u_mail == null){
  %>
	  <script>
	  alert("회원정보를 확인해주세요!");
	  history.back();
	  </script>
  <%
  	return;
  }
  
  
  Connection conn = null;
  PreparedStatement ps = null;
  ResultSet rs = null;
  
  try {
	  conn = DAO.getConnection();
	  String sql = "UPDATE MUSER SET u_pw=?, u_mail=?, u_phone=? WHERE u_no=?";
	  ps = conn.prepareStatement(sql);
	  ps.setString(1, u_pw);
	  ps.setString(2, u_mail);
	  ps.setString(3, u_phone);
	  ps.setString(4, u_no);
	  
	  ps.executeUpdate();
	  
	  conn.close();
	  ps.close();
  }catch(Exception e) {
	  e.printStackTrace(); 
  }
%>
<script>
  alert("수정이 완료되었습니다.");
  location.href = "index.jsp";
</script>