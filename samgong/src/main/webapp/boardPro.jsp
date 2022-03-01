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
String GUBUN = request.getParameter("GUBUN");
// N = new 새글 작성 , M = modify 수정 , D = delete 삭제 * 구분을 위한 변수입니다. *
String title = request.getParameter("title");
//[QnA] 와 관리자를 구분하기위한 제목에 들어갈 변수 입니다.

String q_no = request.getParameter("q_no");
String q_title = request.getParameter("q_title");
String q_con = request.getParameter("q_con");
String q_hit = (check_id.equals("samgongpal"))?"1":"0";
String q_date = request.getParameter("q_date");


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
				
		String sql2= " ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD' ";

		Statement stmt = conn.createStatement();
		stmt.executeUpdate(sql2);
					
		sql = " INSERT INTO qna VALUES(?,?,?,?,?)";
				
		ps = conn.prepareStatement(sql);
				 
		/*ora-01861: literal does not match format string (날짜형식 맞지않아서 에러남)
		ec2서버 오라클 date 타입 INSERT 적용할때 에러가 나서 날짜데이터 수정후에 다시 작성하겠습니다.
		2022 년 2월 23일(yunamom) ALTER SESSION SET 으로 date format 을 한후 insert 하는걸로 에러수정함
		더좋은방법을 찾으면 차후 수정하겠습니다.
		*/ 
		ps.setString(1, q_no);
		ps.setString(2, title + q_title);
		ps.setString(3, q_con);
		ps.setString(4, q_hit);
		ps.setString(5, q_date);	  
					
		stmt.close();
					
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
	//2. 명령문보내기
	
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
	alert("수정 완료!");
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