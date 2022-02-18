<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/user.css">
</head>
<body>
<%@ include file="topmenu.jsp" %>
  <section>
    <form name="frm" onsubmit="return checkAll()" action="userLoginAction.jsp"  method="post">
    <h2>Login</h2>
    <div class="login">
    <table>
      <tr>
      <td><input type="text" name="u_id" maxlength="10" placeholder="아이디"></td>
      </tr>
      
      <tr>
      <td><input type="password" name="u_pw" maxlength="10" placeholder="비밀번호"></td>
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
<script type="text/javascript" src="script/check.js"></script>
</html>