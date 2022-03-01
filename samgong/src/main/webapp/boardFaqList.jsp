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

String no = request.getParameter("Q"); //제목을 클릭했을때 넘어오는 게시물번호
int faq_no = (no == null)? -1 : Integer.parseInt(no);
//게시물 제목을 클릭했을때 내용을 불러오기위한 게시물번호 입니다.


int listNo = 5; //한페이지에 나오는 게시물 갯수

String view = request.getParameter("V"); //현재 페이지 번호 입니다.

int viewPage = (view == null)? 1 :Integer.parseInt(view);
//첫페이지

int index = (viewPage-1)*listNo; //불러올 데이터의 LIMIT index,pageView

Connection conn = DAO.getConnection();
String count = " SELECT count(*) total FROM qna WHERE q_title NOT LIKE '%[%' ";
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
       sql+= " FROM qna WHERE q_title NOT LIKE '%[%' "; //공지사항을 제외한 게시물
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
<script>
function fn_boardDelete(q_no){ //게시물 삭제 컨펌
	if(confirm("정말 삭제하시겠습니까?")){
		location="boardPro.jsp?GUBUN=D&q_no="+q_no;		
	}
}
</script>
<body>
<%@ include file="topmenu.jsp" %>
<section>
<div class="top" style="text-align:left"><h1>∙ FAQ</h1></div>
<!-- 사이드 메뉴입니다. -->
<%@ include file="boardSide.jsp" %>
<div class="leftcolumn">

<div class="board">
	<table>
	<colgroup>
		<col width="7%"/>
		<col width="70%"/>
		<col width="*"/>
	</colgroup>	
		<tr>
			<th>No.</th>
			<th>제목</th>
			<th><%if(check_id != null && check_id.equals("samgongpal")){%>
			<button type="button"onclick="location='boardWrite.jsp'">글쓰기</button>
			<%}else{%>등록일<%}%></th>
		</tr>
		<%while(rs.next()) {
		int q_no = rs.getInt("q_no");
		String q_title = rs.getString("q_title");
		String q_date = rs.getString("q_date");
		String q_con = rs.getString("q_con");
		String q_hit = rs.getString("q_hit");
		%>
		<tr>
			<td><%=rowNo%></td>
			<td><a href="boardFaqList.jsp?V=<%=viewPage%>&Q=<%=q_no%>">
			<%=q_title%></a>
			</td>	
			<td style="text-align:center"><%=q_date%></td>
		</tr>
		<%rowNo--;			
		if(faq_no == q_no){%>
		<tr><td colspan="3" style="background-color: rgba(255,255,255,0.5);">
			[삼공시네마]<br><%=q_con%> <!-- 제목을 눌렀을때 글 내용이 보여집니다. -->
		<%if(check_id != null && check_id.equals("samgongpal")){%>
		<div style="text-align:center;">
		<button type="button" 
		onclick="location='boardModify.jsp?q_no=<%=q_no%>'">수정</button>
		<button type="button" onclick="fn_boardDelete('<%=q_no%>')">삭제</button>
		<!--  삭제 를 클릭했을때 함수가 실행되면서 q_no 값을 보내준다. -->
		</div><%}%>
		</td></tr>		
		<%}	
	}%>
	</table>
</div>
<div class="view">
	<%
	for(int i=1; i<=lastpage; i++){
	//페이지 화면 2가지 방법으로 작성할수 있습니다. 
	//	out.print("<a href='boardFaqList.jsp?view="+i+"'>"+i+"</a> ");
	%>		
	<a href="boardFaqList.jsp?V=<%=i%>"><%=i%></a>
	<%}%>
	</div>
</div>
</section>
<%@include file="footer.jsp" %>
</body>
<script src="script/check.js"></script>
</html>