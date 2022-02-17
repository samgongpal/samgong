<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
  Object obj = session.getAttribute("u_no");
  int u_no = -1;
  session.setAttribute("u_no", u_no);
%>
<script>
  alert("로그아웃합니다.");
  location.href="index.jsp";
</script>