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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/user.css">
</head>
<body>
<%@ include file="topmenu.jsp" %>
  <section>
    <form action="userDeletePro.jsp" method="post">
    <h2>회원 탈퇴</h2>
    <table>
      <tr>
      <td><input type="password" name="u_pw" maxlength="10" placeholder="비밀번호" required></td>
      </tr>
      
      <tr>
      <td><input type="password" name="u_pw" maxlength="10" placeholder="비밀번호" required></td>
      </tr>
      
      <tr>
      <td colspan="2"><input type="submit" value="탈퇴">
                      <input type="button" value="취소" onclick="window.location.href='userPage.jsp'"><td>
      </tr>
    </table>
    </form>
  </section>
<%@include file="footer.jsp" %>
</body>
</html>