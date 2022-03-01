<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DBPKG.DAO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ include file="certificated.jsp" %> 
<%
String strReferer = request.getHeader("referer");
if(strReferer == null){ 
%>
	<script>
	location="index.jsp";
	</script>
<%
	return;
}
String no = request.getParameter("Q"); //제목을 클릭했을때 넘어오는 게시물번호
int faq_no = (no == null)? -1 : Integer.parseInt(no);
//게시물 제목을 클릭했을때 내용을 불러오기위한 게시물번호 입니다.

String search = request.getParameter("S"); // 고객센터메인 검색에서 넘어오는 변수
String title = (search == null || search.equals(""))?"공지":search;
String caption = (title.equals("공지"))?" 공지/뉴스 ":" 검색 결과 ";


Connection conn = DAO.getConnection();

String sql = " SELECT * FROM ";
	sql+= " (SELECT A.*,FLOOR((ROWNUM-1)/5+1)page, ";
	sql+= " ROWNUM FROM(SELECT ";
	sql+= " q_no, ";
	sql+= " q_title, ";
	sql+= " q_con, ";
	sql+= " q_hit, ";
	sql+= " TO_CHAR(q_date,'YYYY/MM/DD')q_date ";
	sql+= " FROM qna WHERE q_title LIKE '%"+title+"%' ";
	sql+= " AND q_title NOT LIKE '[QnA]%'"; //공지 게시물
	sql+= " ORDER BY q_no DESC)A) ";
	sql+= " WHERE page = "+1;
//최신글 5개
PreparedStatement pstmt = conn.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>∙ 삼공시네마 고객센터 ∙</title>
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
<div class="top" style="text-align:left"><h1>∙ Customer Center</h1></div>
<!-- 사이드 메뉴입니다. -->
<%@ include file="boardSide.jsp" %>
<div class="leftcolumn">

<div class="board">
<div class="boardWrap">
	<div class="home">
    <form name="frm" method="post" action="boardHome.jsp"> 
    <div class="searchBox">
      	<input type="text" name="S" placeholder="검색어를 입력해 주세요." 
      	required pattern="[가-힣a-zA-Z]+" title="(한글),(영문)">
 		<button type="submit">검색</button>
 	</div>
    </form>    
    </div>
</div>
</div>

<div class="board">
   <table style="margin-top:50px;">
   <caption><h2>∙<%=caption%>∙</h2></caption>
	<colgroup>
		<col width="80%"/>
		<col width="*"/>
	</colgroup>	
		<tr>
			<th>제목</th>
			<th>등록일</th>
		</tr>
		<%while(rs.next()) {
		int q_no = rs.getInt("q_no");
		String q_title = rs.getString("q_title");
		String q_date = rs.getString("q_date");
		String q_con = rs.getString("q_con");
		String q_hit = rs.getString("q_hit");
		%>
		<tr>
			<td><a href="boardHome.jsp?V=1&Q=<%=q_no%>&S=<%=title%>"><%=q_title%></a></td>	
			<td style="text-align:center"><%=q_date%></td>
		</tr>
		<%if(faq_no == q_no){%>
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

</div>
</section>
<%@ include file="footer.jsp" %>
</body>
</html>