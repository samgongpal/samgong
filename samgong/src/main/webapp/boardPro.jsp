<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="DBPKG.DAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="certificated.jsp" %> 
<%
String strReferer = request.getHeader("referer");
if(strReferer == null){ 
//비정상적인 URL 접근차단을 위해 request.getHeader("referer") 메소드를 사용하였습니다.
%>
	<script>
	alert("정상적인 경로를 통해 다시 접근해 주십시오.");
	location="index.jsp";
	</script>
<%
	return;
}
if(check_id == null || check_no == null){
%>
	<script>
	location="index.jsp";
	</script>
<%
	return;
}
/* N = new 새글 작성 , M = modify 수정 , D = delete 삭제 * 구분을 위한 변수입니다. */
String GUBUN = request.getParameter("GUBUN");

/* [QnA] 와 관리자를 구분하기위한 제목에 들어갈 변수 입니다. */
String title = request.getParameter("title");

String q_no = request.getParameter("q_no");
String q_select = request.getParameter("q_select");
String q_title = request.getParameter("q_title");
String q_con = request.getParameter("q_con");
String q_date = request.getParameter("q_date");

/* 답글작성 확인변수 입니다. */
String q_hit = (check_id.equals("samgongpal"))?"1":"0";

/* qna 글수정 관리자(답변) 회원(수정)*/
String modify = (check_id.equals("samgongpal"))?"답변":"수정";

q_select = (q_select == null)?"":q_select;

int result = 0;

try{
	
	//1. 연결
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	String sql = "";
	
	conn = DAO.getConnection();
	if(GUBUN.equals("N")){ //새글 작성
		q_con = q_con.replace("\r\n","<br>"); //게시글 줄바꿈 저장
					
		sql = " INSERT INTO qna VALUES(?,?,?,?,SYSDATE)";
				
		ps = conn.prepareStatement(sql);
		/* 2022년 3월 20일 ora-01861 데이터형식 불일치 에러 수정함 - yunamom */
		ps.setString(1, q_no);
		ps.setString(2, q_select + title + q_title);
		ps.setString(3, q_con);
		ps.setString(4, q_hit);
					
	}else if(GUBUN.equals("M")){ //수정
		q_con = q_con.replace("\r\n","<br>");
				
		sql = " UPDATE qna SET ";
		sql+= " q_title = ?, ";
		sql+= " q_con = ?, ";
		sql+= " q_hit = ? ";
		sql+= " WHERE q_no = "+q_no;
		ps = conn.prepareStatement(sql);	
		ps.setString(1, title + q_title);
		ps.setString(2, q_con);	
		ps.setString(3, q_hit);	
		
	}else{ //삭제
					
		sql = " DELETE FROM qna ";
		sql+= " WHERE q_no = "+q_no;
		ps = conn.prepareStatement(sql);
	}		
	/* 2. 명령문보내기 */
	
	result = ps.executeUpdate();
	
	ps.close();
	conn.close(); 
		 
}catch (Exception e) {
	e.printStackTrace(); 
}
if(result == 1 && GUBUN.equals("N")){
%>
	<script>
	alert("저장 완료!");
	location="boardHome.jsp";
	</script>
<%
}else if(result == 1 && GUBUN.equals("M")){
%>
	<script>
	alert("<%=modify%> 완료!");
	location="boardHome.jsp";
	</script>
<%
}else if(result == 1 && GUBUN.equals("D")){
%>
	<script>
	alert("삭제 완료!");
	location="boardHome.jsp";
	</script>
<%
}else{
%>
	<script>
	alert("저장 실패! \n 관리자에게 문의해주세요.");
	location="index.jsp";
	</script>
<%}%>