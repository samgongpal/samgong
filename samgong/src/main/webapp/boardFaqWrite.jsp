<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DBPKG.DAO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="certificated.jsp" %> 
<%
String strReferer = request.getHeader("referer");
if(strReferer == null){ 
//비정상적인 URL 접근차단을 위해 request.getHeader("referer") 메소드를 사용하였습니다.
%>
	<script>
	location="index.jsp";
	</script>
<%
	return;
}

if(!check_id.equals("samgongpal") || check_no == null || check_no.equals("")){ 
	//관리자만 작성할수있는 페이지
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
<title>∙ FQA write ∙</title>
</head>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/board.css">

<body>
<%@ include file="topmenu.jsp" %>

<section>
<div class="top"><h1>∙ FAQ 작성 ∙</h1></div>
<div class="board">
	<form name="frm" method="post" action="boardFaqSave.jsp">
	<table class="table">		
	<colgroup>
		<col width="*"/>
	</colgroup>	
		<tr>
			<td style="text-align:left">
			<input size="30" type="text" name="q_title" required
			placeholder="제목을 입력하세요."></td>
		</tr>			
		<tr>
			<td style="text-align:left">
			<textarea name="q_con" rows="10" cols="30" placeholder="내용을 입력하세요."></textarea>
			<!-- rows 세로 cols 가로 -->
			</td>
		</tr>
		<tr>
			<td style="text-align:left"> 삼공팔 </td>
		</tr>
		
	</table>
		<div class="view">
			<button type="submit" onclick="fn_submit();return false;">저장</button>
			<!-- 오류가났을때 submit 멈추기위해 자바스크립트를 작성해준다. -->
			<button type="reset" onclick="location='boardFaqList.jsp'">취소</button>
		</div>
	</form>
</div>
</section>
<%@include file="footer.jsp" %>
</body>
<script src="script/check.js"></script>
</html>