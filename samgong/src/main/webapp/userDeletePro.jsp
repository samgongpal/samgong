<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="DBPKG.DAO"%>
<%@page import="java.sql.*"%>
<%@page import="com.Cookies" %>
<%@ include file="certificated.jsp" %>
<%
  request.setCharacterEncoding("UTF-8");

  int Delete_no1 = Integer.parseInt(check_no);
    
  String u_id = request.getParameter("u_id");
  String u_pw = request.getParameter("u_pw");
  
  Connection conn = null;
  PreparedStatement ps = null;
  ResultSet rs = null;
  
  String u_id1 = "";
  String u_pw1 = "";
  
  try{
	  conn = DAO.getConnection();
	  String sql = "SELECT u_id, u_pw FROM MUSER WHERE u_no=?";
	  ps = conn.prepareStatement(sql);
	  ps.setInt(1, Delete_no1);
	  rs = ps.executeQuery();
	  if(rs.next()) {
		  u_id1 = rs.getString("u_id");
		  u_pw1 = rs.getString("u_pw");
	  }
	  conn.close();
	  ps.close();
	  rs.close();
	  
	  if(u_id1.equals(u_id) && u_pw1.equals(u_pw)) {
		  conn = DAO.getConnection();
		  sql = "DELETE FROM MUSER WHERE u_no =?";
		  ps = conn.prepareStatement(sql);
		  ps.setInt(1, Delete_no1);
		  ps.executeUpdate();
		  session.removeAttribute("session_no");
		  session.removeAttribute("session_id");
		  response.addCookie(Cookies.createCookie("CookieUserId","","/",0));
		  response.addCookie(Cookies.createCookie("CookieUserPw","","/",0));
		  // 세션 & 쿠키값 제거
		  conn.close();
		  ps.close();
		  %>
		  <script>
		    alert("회원탈퇴가 완료되었습니다.");
		    location="index.jsp";
		  </script>
		  <%
	  }else {
		  %>
		  <script>
		    alert("아이디 또는 비밀번호가 잘못입력되었습니다.")
		    location="userDelete.jsp";
		  </script>
		  <%
	  }	  
  }catch(Exception e) {
	  e.printStackTrace();
  }
%>