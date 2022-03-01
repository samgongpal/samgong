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

if(check_no == null || check_id == null){ 
%>
	<script>
	location="index.jsp";
	</script>    
<%
	return;
}

String q_no = request.getParameter("q_no");
String q_title = "";
String q_con = "";
int q_hit = 0;
String q_date = "";
Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;

try{
	  conn = DAO.getConnection();
	  String sql = " SELECT ";
	         sql+= " q_title, ";
	         sql+= " q_con, ";
	         sql+= " q_hit, ";
	         sql+= " TO_CHAR(q_date,'YYYY/MM/DD') q_date ";
	         sql+= " FROM qna WHERE q_no="+q_no;
	  ps = conn.prepareStatement(sql);
	  rs = ps.executeQuery();
	  if(rs.next()) {
		  q_title = rs.getString("q_title");
		  q_con = rs.getString("q_con");
		  q_hit = rs.getInt("q_hit");
		  q_date = rs.getString("q_date");
	  }
	  conn.close();
	  ps.close();
	  rs.close();
}catch(Exception e) {  
	  e.printStackTrace(); 
}


String name = "";
String title = "";
// 게시글 작성은 관리자 or QnA 에서 넘어오는 회원이므로 관리자 외에는 이름 앞에 [QnA]를 붙여서 구분합니다.
String caption = "";
String editTitle = (q_hit == 0)?"- [답변 완료]":"";
String line = "\n- - - - - - - - - - - - - - - - - - - -";
String editContent = (q_hit == 0)?line+"\n\n[삼공 시네마] 1:1 문의글의 답변 입니다.\n\n":"";

switch(check_id){
case("samgongpal"): 
	name = "삼공팔";
	caption = "관리자 write";
	
	break;
default: 
	name = check_id;
	title = "[QnA]["+check_id+"] ";
	caption = "QnA write";
	break;
}

q_con = q_con.replace("<br>","\r\n"); //게시물 줄바꿈

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>∙ <%=caption %> ∙</title>
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
<div class="top"><h1>∙ <%=caption %> ∙</h1></div>
<div class="board">
	<form name="frm" method="post" action="boardPro.jsp">
	
	<input type="hidden" name="q_date" value="<%= q_date%>"> 
	<input type="hidden" name="q_no" value="<%=q_no%>">
	<input type="hidden" name="GUBUN" value="M">
	<!-- N = 새글 작성 , M = 수정 , D = 삭제 구분을 위한 GUBUN변수* -->
	<input type="hidden" name="title" value="<%=title %>">
	
	<table>
		<tr>
			<td style="text-align:left">
			<input type="text" name="q_title" required
			placeholder="제목을 입력하세요." value="<%=q_title%> <%=editTitle%>"></td>
		</tr>			
		<tr>
			<td style="text-align:left">
			<textarea name="q_con" placeholder="내용을 입력하세요." required><%=q_con%> <%=editContent%></textarea>
			</td>
		</tr>
		<tr>
			<td style="text-align:left"><%=name %></td>
		</tr>
		<tr>
			<td style="text-align:left"><%=q_date%></td>
		</tr>
	</table>
		<div class="view">
			<button type="submit" onclick="fn_submit();return false;">저장</button>
			<!-- 오류가났을때 submit 멈추기위해 자바스크립트를 작성해준다. -->
			<button type="reset" onclick="history.back()">취소</button>
		</div>
	</form>
</div>
</section>
<%@include file="footer.jsp" %>
</body>
<script src="script/check.js"></script>
</html>