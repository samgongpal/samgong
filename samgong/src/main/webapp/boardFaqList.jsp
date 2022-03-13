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

/* 제목을 클릭했을때 넘어오는 게시물번호 */
String no = request.getParameter("Q"); 


/* 게시물 제목을 클릭했을때 내용을 불러오기위한 게시물번호 입니다. */
int faq_no = (no == null)? -1 : Integer.parseInt(no);


/* 한 페이지의 게시물 수 */
int pageSize = 5;


/* 한 블럭( range : 범위 ) 의 페이지 수 */
int rangeSize = 5; 


/* 현재 페이지 번호 입니다. */
String view = request.getParameter("V"); 


/* 현재 페이지 */
int viewPage = (view == null)? 1 :Integer.parseInt(view);


/* 시작 index */
int index = (viewPage-1)*pageSize;


Connection conn = DAO.getConnection();
String count = " SELECT count(*) total FROM qna WHERE q_title NOT LIKE '%[%' ";
PreparedStatement pstmt = conn.prepareStatement(count);
ResultSet rscnt = pstmt.executeQuery();
rscnt.next();
/* 총 게시글 수 */
int total = rscnt.getInt("total");


/* 마지막 페이지 */
int endPage = (int)Math.ceil((double)total/pageSize);


/* 게시물 행번호 */
int rowNo = total - index; 


/* ( range : 범위 ) */
int Range = (viewPage % rangeSize == 0)?viewPage/rangeSize:(viewPage/rangeSize)+1;


/* 이전 버튼 블럭( range : 범위 ) */
int startRange = (Range-1)*rangeSize+1;


/* 다음 버튼 블럭( range : 범위 ) */
int endRange = startRange + rangeSize-1;


/* 마지막 블락에서 총페이지수를 넘어가면 끝 페이지를 마지막 페이지 숫자로 넣어줍니다. */
endRange = (endRange >= endPage) ? endPage : endRange;



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
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/board.css">
<style>
table,th,td{
	border-collapse: collapse;
}
a{
	text-decoration: none;
}
</style>
</head>

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
	String startStyle = "";
	String startURL = "boardFaqList.jsp?V="+(startRange-1)+"";
	if(startRange == 1){
		startStyle = "color:#5d5e5e";
		startURL = "#";
	}
	%>
	<a href="<%=startURL %>" style="<%=startStyle %>">이전</a>
	<% 
	for(int i=startRange; i<=endRange; i++){
		String style = (viewPage == i)?"text-decoration:underline":"";
	%>		
	<a href="boardFaqList.jsp?V=<%=i%>" style="<%=style%>"><%=i%></a>
	<% 
	}
	String endStyle = "";
	String endURL = "boardFaqList.jsp?V="+(endRange+1)+"";
	if(endRange >= endPage){
		endStyle = "color:#5d5e5e";
		endURL = "#";
	}
	%>
	<a href="<%=endURL%>" style="<%=endStyle %>">다음</a>	
	</div>
</div>
</section>
<%@include file="footer.jsp" %>
</body>
<script src="script/check.js"></script>
</html>