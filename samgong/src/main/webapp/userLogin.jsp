<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.Cookies" %>
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
String cookie_id = "";
String cookie_pw = "";
String check_id = "";
String check_pw = "";
Cookies cookies = new Cookies(request); //쿠키 객체화 
if(cookies.exists("CookieUserId") && !cookies.getValue("CookieUserId").equals("")){
//쿠키 변수의 존재유무를 확인합니다.
	cookie_id = cookies.getValue("CookieUserId");
	check_id = "checked";
}else{
	cookie_id = "";	
	check_id = "";
}
if(cookies.exists("CookieUserPw") && !cookies.getValue("CookieUserPw").equals("")){
	//쿠키 변수의 존재유무를 확인합니다.
	cookie_pw = cookies.getValue("CookieUserPw");
	check_pw = "checked";
}else{
	cookie_pw = "";
	check_pw = "";
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
      <td><input type="text" name="u_id" maxlength="10" placeholder="아이디" value="<%=cookie_id%>" required></td>
      </tr>
      
      <tr>
      <td><input type="password" name="u_pw" maxlength="10" placeholder="비밀번호" value="<%=cookie_pw%>" required></td>
      </tr>
      </table>       
    </div>
    <!-- 쿠키 박스 -->
    <div style="display:flex; justify-content:center;">
	  <div style="width:350px; margin-top:-20px; text-align: left;">
		<input type="checkbox" name="idcheck" value="1" <%=check_id %>>ID
		<input type="checkbox" name="pwcheck" value="1" <%=check_pw %>>PW remember
	  </div>
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