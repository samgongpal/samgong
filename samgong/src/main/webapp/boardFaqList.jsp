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

request.setCharacterEncoding("UTF-8");

String no = request.getParameter("q_no"); //제목을 클릭했을때 넘어오는 게시물번호
int q_no = (no == null)? -1 : Integer.parseInt(no);
//게시물 제목을 클릭했을때 내용을 불러오기위한 게시물번호 입니다.


int listNo = 5; //한페이지에 나오는 게시물 갯수
String view = request.getParameter("view");

int viewPage = (view == null)? 1 :Integer.parseInt(view);
//첫페이지

int index = (viewPage-1)*listNo; //불러올 데이터의 LIMIT index,pageView

Connection conn = DAO.getConnection();
String count = " SELECT count(*) total FROM qna";
PreparedStatement pstmt = conn.prepareStatement(count);
ResultSet rscnt = pstmt.executeQuery();
rscnt.next();
int total = rscnt.getInt("total");

/*
설명)
한 화면에 보여지는 게시물 갯수가 10개씩 이라고 할경우
19/10 -> 1.9 -> ceil(1.9) -> 2.0
29/10 -> 2.9 -> ceil(2.9) 0> 3.0

소숫점을 얻기위해 total 이라는 변수를 나누기 처리 할때 double 을 넣어준다.
실수(double)에는 for 문을 적용할수 없기때문에 (int)를 추가해준다.

*/
int lastpage = (int)Math.ceil((double)total/listNo);

int rowNo = total - index; 
// 제목 옆에 나올 게시물(행 번호) 번호  중요*

//listNo = 5 한페이지당 보여주는 게시물의 수

/*String sql = " SELECT * FROM(";
       sql+= " SELECT A.*,FLOOR((ROWNUM - 1)/"+(listNo+1)+")page, rownum FROM(";
       sql+= " SELECT ";
       sql+= " q_title, ";
       sql+= " q_con, ";
       sql+= " q_hit, ";
       sql+= " TO_CHAR(q_date,'YYYY/MM/DD')q_date ";
       sql+= " FROM qna ";
       sql+= " ORDER BY q_no DESC)A )";
       sql+= " WHERE page = "+viewPage;*/
       

String sql = " SELECT * FROM ";
       sql+= " (SELECT A.*,FLOOR((ROWNUM-1)/5+1)page, ";
       sql+= " ROWNUM FROM(SELECT ";
       sql+= " q_no, ";
       sql+= " q_title, ";
       sql+= " q_con, ";
       sql+= " q_hit, ";
       sql+= " TO_CHAR(q_date,'YYYY/MM/DD')q_date ";
       sql+= " FROM qna ";
       sql+= " ORDER BY q_no DESC)A) ";
       sql+= " WHERE page = "+viewPage;   
pstmt = conn.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>∙ 삼공시네마 FAQ ∙</title>
</head>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/board.css">
<style>
.view{
	display: flex;
	justify-content: center;
	width: 100%;	
}
.view a{
	padding: 2rem;
	font-size: 15px;
	color: #333;
}
.view a:hover{
	color: white;
}


</style>
<body>
<%@ include file="topmenu.jsp" %>
<section>
<div class="top" style="text-align:left"><h1>FAQ</h1></div>
<!-- 사이드 메뉴입니다. -->
<%@ include file="boardSide.jsp" %>
<div class="leftcolumn">
<%
if(check_id != null && check_id.equals("samgongpal")){
%>
	<div class="write"><button style="text-align:right" type="button" 
	onclick="location='boardFaqWrite.jsp'">글쓰기</button></div>
<%}%>
<div class="board">
	<table>
	<colgroup>
		<col width="8%"/>
		<col width="75%"/>
		<col width="*"/>
	</colgroup>	
		<tr>
			<th>No.</th>
			<th>제목</th>
			<th>등록일</th>
		</tr>
		<%while(rs.next()) {
		String q_title = rs.getString("q_title");
		String q_date = rs.getString("q_date");
		String q_con = rs.getString("q_con");
		String q_hit = rs.getString("q_hit");	
		%>
		<tr>
			<td><%=rowNo%></td>
			<td class="cursor" onClick="location='boardFaqList.jsp?view=<%=viewPage%>&q_no=<%=rs.getInt("q_no") %>'">
			<%=q_title%></td>	
			<td><%=q_date%></td>
		</tr>
		<%	rowNo--;
			if(q_no == rs.getInt("q_no")){
			%>
			<tr>
				<td colspan="3" style="background-color: white;">
				<%=q_con%>
				</td>
			</tr>		
			<%
			}
		}%>
	</table>

</div>
<div class="view">
	<%
	for(int i=1; i<=lastpage; i++){
	//페이지 화면 2가지 방법으로 작성할수 있습니다. 
	//	out.print("<a href='boardFaqList.jsp?view="+i+"'>"+i+"</a> ");
	%>		
	<a href="boardFaqList.jsp?view=<%=i%>"><%=i%></a>
	<% 
	}	
	%>
	</div>
</div>
</section>
<%@include file="footer.jsp" %>
</body>
<script src="script/check.js"></script>
</html>