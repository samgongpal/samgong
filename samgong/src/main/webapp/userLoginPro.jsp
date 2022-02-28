<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="DBPKG.DAO"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*" %>
<%@ page import="com.Cookies" %>
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
String idcheck = request.getParameter("idcheck");
String pwcheck = request.getParameter("pwcheck");
//아이디/비번 기억하기 체크박스 쿠키


request.setCharacterEncoding("UTF-8");
  
String id = request.getParameter("u_id");
String pw = request.getParameter("u_pw");
  
if(id == null || pw == null || id.equals("") || pw.equals("")){
%>
	<script>
	alert("아이디 & 비밀번호를 확인해주세요.");
	location="userLogin.jsp";
	</script>
<%
	return;
}

  String u_id = "";
  String u_pw = "";
  String u_no = ""; //변수를 int -> String 으로 수정하였습니다.
  String u_name = ""; //유저의 이름을 담을 변수
  
  Connection conn = null;
  PreparedStatement ps = null;
  ResultSet rs = null;
  
  try{
	  conn = DAO.getConnection();
	  String sql = "SELECT u_id, u_pw, u_no, u_name FROM MUSER WHERE u_id=? AND u_pw=?";
	  ps = conn.prepareStatement(sql);
	  ps.setString(1, id);
	  ps.setString(2, pw);
	  rs = ps.executeQuery();
	  if(rs.next()) {
		  u_id = rs.getString("u_id");
		  u_pw = rs.getString("u_pw");
		  u_no = rs.getString("u_no");
		  u_name = rs.getString("u_name");
		 
	  }
	  conn.close();
	  ps.close();
	  rs.close();
  }catch (Exception e) {
	  e.printStackTrace(); 
  }
if(id.equals(u_id) && pw.equals(u_pw)) {
	session.setAttribute("session_no",u_no); 
	session.setAttribute("session_id",u_id); 
	
	  /* 수정 (2022 2월 18일 yunamom) 
	  session 으로 받은 u_no -> session_no 수정합니다. */
	session.setMaxInactiveInterval(30*60);
	/*세션 유지시간을 설정합니다. 60*30 = 30분*/
	  
	if(idcheck != null){ //아이디 기억하기를 선택했다는 의미 
		response.addCookie(Cookies.createCookie("CookieUserId",u_id,"/",-1));		
			/*
			Cookies.createCookie(쿠키명,쿠키값,적용폴더,유지시간);
			/ 는 모든폴더를 의미한다.
			*/
	}else{
		response.addCookie(Cookies.createCookie("CookieUserId","","/",0));			
	}
	if(pwcheck != null){
		response.addCookie(Cookies.createCookie("CookieUserPw",u_pw,"/",-1));				
	}else{
		response.addCookie(Cookies.createCookie("CookieUserPw","","/",0));		
	}
%>
	  <script>
	    alert("고객님 환영합니다.");
	    location="index.jsp";
	  </script>
<%
  }else if(u_id.equals("samgongpal")){
%>
	  <script>
	    alert("관리자님 환영합니다.");
	    location="index.jsp";
	  </script>
<%
  }else{
%>
	  <script>
	    alert("존재하지 않는 아이디또는 비밀번호입니다.");
	    location="userLogin.jsp";
	  </script>
<%
  }
%>