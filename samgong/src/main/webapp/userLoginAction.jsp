<%@page import="java.io.Console"%>
<%@page import="DBPKG.DAO"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
  request.setCharacterEncoding("UTF-8");
  
  String u_id1 = request.getParameter("u_id");
  String u_pw1 = request.getParameter("u_pw");
  int u_no = -1;
  
  Connection conn = null;
  PreparedStatement ps = null;
  ResultSet rs = null;
  
  try{
	  conn = DAO.getConnection();
	  String sql = "SELECT u_id, u_pw, u_no FROM MUSER WHERE u_id=? AND u_pw=?";
	  ps = conn.prepareStatement(sql);
	  ps.setString(1, u_id1);
	  ps.setString(2, u_pw1);
	  rs = ps.executeQuery();
	  if(rs.next()) {
		  u_no = rs.getInt("u_no");
		  session.setAttribute("u_no", u_no);
	  }
	  conn.close();
	  ps.close();
	  rs.close();
  }catch (Exception e) {}
  
  if(u_no == -1) {
	  %>
	  <script>
	    alert("존재하지 않는 아이디또는 비밀번호입니다.");
	    location.href="userLogin.jsp"
	  </script>
	  <%
  }else {
	  %>
	  <script>
	    alert("로그인이 되셨습니다..");
	    location.href="userLogin.jsp"
	  </script>
	  <%
  }
%>