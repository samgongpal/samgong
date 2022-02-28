<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String check_no = (String)session.getAttribute("session_no");
String check_id = (String)session.getAttribute("session_id");

//유저의 로그인여부를 확인할수있는 변수생성
%>