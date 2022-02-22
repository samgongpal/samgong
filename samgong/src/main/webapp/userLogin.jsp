<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String strReferer = request.getHeader("referer");
if(strReferer == null){ 
//비정상적인 URL 접근차단을 위해 request.getHeader("referer") 메소드를 사용하였습니다.
//로그인한 회원이 주소창에 URL 로 접근하는것을 차단
%>
	<script>
	location="index.jsp";
	</script>
<%
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/user.css">

</head>
<body onload="document.frm.u_id.focus()">
<%@ include file="topmenu.jsp" %>
  <section>
  <div class="top"><h1>Login</h1></div>
    <form name="frm" action="userLoginPro.jsp"  method="post">
    <div class="login">
    <table>
      <tr>
      <td><input type="text" name="u_id" maxlength="10" placeholder="아이디" required></td>
      </tr>
      
      <tr>
      <td><input type="password" name="u_pw" maxlength="10" placeholder="비밀번호" required></td>
      </tr>
      </table>    
       
    </div>
      <div class="button">
      <input type="submit" value="로그인"></div>
      <div class="button">
      <input type="button" value="회원가입" onclick="location='userJoin.jsp'"></div>       
      
    </form>
  </section>
<%@include file="footer.jsp" %>
</body>
<script src="script/check.js"></script>

</html>