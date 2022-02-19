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
<%@ include file="topmenu.jsp" %> 
<%
  //수정(2022.2월18일.MOM) session 으로 받은 u_no 변수명 중복으로 오류방지를 위해 이름 변경합니다.
  if(session_no == null || session_no.equals("")){ //로그인 하지 않은 유저가 수정화면에 접근했을때 *있을수없는일 
  %>
	<script>
	alert("비정상적인 접근입니다!");
	location="index.jsp";
	</script>    
  <%
  	return;
  }
  
  
  /*Object obj1 = session.getAttribute("u_no");
  int num = (int)obj1; //obj,u_no가 중복되어 obj1,num으로 변경*/
  
  Connection conn = null;
  PreparedStatement ps = null;
  ResultSet rs = null;
  
  String u_name = "";
  String u_pw = "";
  String u_mail = "";
  String u_phone = "";
  
  try{
	  conn = DAO.getConnection();
	  String sql = "SELECT u_name, u_pw, u_mail, u_phone FROM MUSER WHERE u_no="+session_no;
	  ps = conn.prepareStatement(sql);
	  rs = ps.executeQuery();
	  if(rs.next()) {
		  u_name = rs.getString("u_name");
		  u_pw = rs.getString("u_pw");
		  u_mail = rs.getString("u_mail");
		  u_phone = rs.getString("u_phone");
	  }
  }catch(Exception e) {
	  e.printStackTrace();  
  }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userModify</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/user.css">
</head>
<body>

  <section>
    <form action="userModifyPro.jsp" method="post">
    <input type="hidden" name="u_no" value="<%=session_no %>">
    <!-- u_no 값을 hidden 으로 같이 보내줍니다. -->
    <h3><%=u_name %>님 회원정보 수정</h3>
    <div class="join">
    <table>
      <tr>
	      <td>
	      <input type="password" name="u_pw" value="<%= u_pw%>" required>
	      <!-- required = 꼭작성해야하는 속성 -->
	      </td>
      </tr>
      <tr>
	      <td>
	      <input type="email" name="u_mail" value="<%= u_mail%>" required>
	      </td>
      </tr>
      <tr>
	      <td>
	      <input type="text" name="u_phone" value="<%= u_phone%>" required>
	      </td>
      </tr>
    </table>
      </div>
	      <input type="submit" value="수정">
	      <input type="button" value="취소" onclick="window.location.href='index.jsp'">
    </form>
  </section>
  <%@include file="footer.jsp" %>
</body>
</html>