<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DBPKG.DAO" %>
<%@ page import="java.sql.*" %>
<%@page import="java.text.SimpleDateFormat"%>
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

if(check_no == null || check_id == null || !check_id.equals("samgongpal")){ 
	//관리자만 작성할수있는 페이지
%>
	<script>
	location="index.jsp";
	</script>    
<%
	return;
}

String q_no = "";

Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;


try{
	  conn = DAO.getConnection();
	  String sql = "SELECT MAX(q_no)+1 q_no FROM qna";
	  ps = conn.prepareStatement(sql);
	  rs = ps.executeQuery();
	  if(rs.next()) {
		  q_no = rs.getString("q_no"); //MAX 게시물번호 +1 을 u_no 에 담아온다.
	  }
	  conn.close();
	  ps.close();
	  rs.close();
}catch(Exception e) {  
	  e.printStackTrace(); 
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
<style>
table{
	width:750px;
}
input,textarea{
	width:100%;
	padding:10px;
	font-size:15px;
	opacity: 0.8;
	border-radius: 0.5rem;
	border: 0;
}
textarea{
	min-height:300px;
}
@media screen and (max-width: 750px) {
    
    table{
    	width: 450px;
    }
}
</style>
<body onload="document.frm.q_title.focus()">
<%@ include file="topmenu.jsp" %>

<section>
<div class="top"><h1>∙ FAQ 작성 ∙</h1></div>
<div class="board">
	<form name="frm" method="post" action="boardFaqSave.jsp">
	<%
      	java.util.Date date = new java.util.Date();
        SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
        String strdate = simpleDate.format(date);
    %> 
	<input type="hidden" name="q_date" value="<%= strdate%>"> 
	<input type="hidden" name="q_no" value="<%=q_no %>">
	<input type="hidden" name="q_hit" value="0">
	<input type="hidden" name="GUBUN" value="N">
	<table>
		<tr>
			<td style="text-align:left">
			<input type="text" name="q_title" required
			placeholder="제목을 입력하세요."></td>
		</tr>			
		<tr>
			<td style="text-align:left">
			<textarea name="q_con" placeholder="내용을 입력하세요." required></textarea>
			</td>
		</tr>
		<tr>
			<td style="text-align:left"> 삼공팔</td>
		</tr>
		<tr>
			<td style="text-align:left"><%= strdate%></td>
		</tr>
	</table>
		<div class="view">
			<button type="submit" onclick="fn_submit();return false;">저장</button>
		</div>
			<!-- 오류가났을때 submit 멈추기위해 자바스크립트를 작성해준다. -->
		<div class="view">
			<button type="reset" onclick="location='boardFaqList.jsp'">취소</button>
		</div>
	</form>
</div>
</section>
<%@include file="footer.jsp" %>
</body>
<script src="script/check.js"></script>
</html>