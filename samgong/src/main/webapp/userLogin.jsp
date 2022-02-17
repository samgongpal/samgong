<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<%@ include file="topmenu.jsp" %>
  <section>
    <form name="frm" onsubmit="return checkAll()" action="userLoginAction.jsp"  method="post">
    <table>
      <tr>
      <td><input type="text" name="u_id" maxlength="10" placeholder="아이디"></td>
      </tr>
      
      <tr>
      <td><input type="password" name="u_pw" maxlength="10" placeholder="비밀번호"></td>
      </tr>
      
      <tr>
        <td colspan="2">
          <input type="submit" value="로그인">
          <input type="button" value="회원가입" onclick="window.location.href='#'">
        </td>
      </tr>
    </table>
    </form>
  </section>
</body>
<script type="text/javascript" src="script/check.js"></script>
</html>