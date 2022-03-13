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
if(check_id == null || check_no == null || check_id.equals("") || check_no.equals("")){
%>
	<script>
	alert("회원 전용 게시판 입니다.\n로그인 페이지로 이동합니다.");
	location="userLogin.jsp";
	</script>
<%
	return;
}

/* 제목을 클릭했을때 넘어오는 게시물번호 */
String no = request.getParameter("Q"); 


/* 게시물 제목을 클릭했을때 내용을 불러오기위한 게시물번호 입니다. */
int faq_no = (no == null)? -1 : Integer.parseInt(no);


/* 관리자에게는 모든 QnA 글이 보이게합니다. */
String modify = (check_id.equals("samgongpal")) ? "답변" : "수정";
String check = (check_id.equals("samgongpal"))?"":check_id;



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
String count = " SELECT count(*) total FROM qna WHERE q_title LIKE '[QnA]"+check+"%' ";
PreparedStatement pstmt = conn.prepareStatement(count);
ResultSet rscnt = pstmt.executeQuery();
rscnt.next();


/* 총 게시글 수 */
int total = rscnt.getInt("total");


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>∙ 삼공시네마 QnA ∙</title>
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
<div class="top" style="text-align:left"><h1>∙ QnA</h1></div>
<!-- 사이드 메뉴입니다. -->
<%@ include file="boardSide.jsp" %>
<div class="leftcolumn">

<div class="board">
<%
if(total == 0){
%>
	<div>
	<h3>문의 글이 없습니다. 글을 작성해주세요.</h3>
	<button type="button" onclick="location='boardWrite.jsp' ">∙ QnA 작성 ∙</button>
	</div>
<%
}else{
	

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
       sql+= " FROM qna WHERE q_title LIKE '[QnA]"+check+"%' "; 
       //[QnA]회원아이디 로 시작하는게시물 을 불러옵니다. *타회원과의 중복 출력을 방지 
       sql+= " ORDER BY q_no DESC)A) ";
       sql+= " WHERE page = "+viewPage;   
pstmt = conn.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery();
%>
	<table>
	<colgroup>
		<col width="7%"/>
		<col width="70%"/>
		<col width="*"/>
	</colgroup>	
		<tr>
			<th>No.</th>
			<th>제목</th>
			<th><button type="button"onclick="location='boardWrite.jsp'">
			글쓰기</button></th>
		</tr>
		<%while(rs.next()) {
		int q_no = rs.getInt("q_no");
		String q_title = rs.getString("q_title");
		String q_date = rs.getString("q_date");
		String q_con = rs.getString("q_con");
		int q_hit = rs.getInt("q_hit");
		
		/* [QnA] 옆에 회원아이디를 출력하지 않도록 합니다. */
		q_title = q_title.replace(check,"");
		%>
		<tr>
			<td><%=rowNo%></td>
			<td><a href="boardQnaList.jsp?V=<%=viewPage%>&Q=<%=q_no%>">
			<%=q_title%></a>
			</td>	
			<td style="text-align:center"><%=q_date%></td>
		</tr>
		<%rowNo--;		
		if(faq_no == q_no){%>
		<tr><td colspan="3" style="background-color: rgba(255,255,255,0.5);">
		[QnA]<br><%=q_con%> <!-- 제목을 눌렀을때 글 내용이 보여집니다. -->
		
		<%if(check.equals(check_id) && q_hit == 0 || check_id.equals("samgongpal")){%>
		<div style="text-align:center;">
		<button type="button" 
		onclick="location='boardModify.jsp?q_no=<%=q_no%>'"><%=modify %></button>
		<button type="button" onclick="fn_boardDelete('<%=q_no%>')">삭제</button>
		<!--  삭제 를 클릭했을때 함수가 실행되면서 q_no 값을 보내준다. -->
		</div>
		<%}if(check.equals(check_id) && q_hit > 0){ 
			
			/* q_hit 값이 0 이상이면 관리자가 답변 완료 하였으므로 수정할수없게 한다. */ 
			
		%>
			<div style="text-align:center;">			
			<button type="button" onclick="fn_boardDelete('<%=q_no%>')">삭제</button>
			<!--  삭제 를 클릭했을때 함수가 실행되면서 q_no 값을 보내준다. -->
			</div>
		<%}%>
		</td></tr>		
	<%}%>		
<%}%>
	</table>
</div>
<div class="view">
	<%
	String startStyle = "";
	String startURL = "boardQnaList.jsp?V="+(startRange-1)+"";
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
	<a href="boardQnaList.jsp?V=<%=i%>" style="<%=style%>"><%=i%></a>
	<% 
	}
	String endStyle = "";
	String endURL = "boardQnaList.jsp?V="+(endRange+1)+"";
	if(endRange >= endPage){
		endStyle = "color:#5d5e5e";
		endURL = "#";
	}
	%>
	<a href="<%=endURL%>" style="<%=endStyle %>">다음</a>	
	</div>
<%}%>
</div>
</section>
<%@include file="footer.jsp" %>
</body>
<script src="script/check.js"></script>
</html>