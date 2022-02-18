<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
  session.removeAttribute("session_no"); //세션값을 삭제합니다.
%>
<script>
  alert("로그아웃합니다.");
  location="index.jsp";
</script>