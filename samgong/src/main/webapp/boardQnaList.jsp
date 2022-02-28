<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DBPKG.DAO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
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
//총 게시물수


int lastpage = (int)Math.ceil((double)total/listNo);

int rowNo = total - index;      

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
<title>QnA</title>
</head>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/board.css">

<body>
<%@ include file="topmenu.jsp" %>
<section>
<div class="top" style="text-align:left"><h1>QnA</h1></div>
<!-- 사이드 메뉴입니다. -->
<%@ include file="boardSide.jsp" %>
<div class="leftcolumn">
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
			String q_hit = rs.getString("q_hit");%>
		<tr>
			<td><%=rowNo%></td>
			<td class="cursor" onClick="location='boardQnaList.jsp?view=<%=viewPage%>&q_no=<%=rs.getInt("q_no") %>'">
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
	%>		
	<a href="boardQnaList.jsp?view=<%=i%>"><%=i%></a>
	<%}%>
	</div>
</div>
</section>
<%@include file="footer.jsp" %>
</body>
<script src="script/check.js"></script>
</html>