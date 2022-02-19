<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="DBPKG.DAO"%>
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
%>
<%
  request.setCharacterEncoding("UTF-8");
  String u_no = request.getParameter("u_no");
  String u_id = request.getParameter("u_id");
  String u_pw = request.getParameter("u_pw");
  String u_mail = request.getParameter("u_mail");  
  String u_birth = request.getParameter("u_birth");
  String u_name = request.getParameter("u_name");
  String u_gender = request.getParameter("u_gender");
  String u_regdate = request.getParameter("u_regdate");
  String u_phone = request.getParameter("u_phone");
  
  Connection conn = null;
  PreparedStatement ps = null;
  ResultSet rs = null;
  int result = -1;
  try{
		  conn = DAO.getConnection();
		  String sql = " INSERT INTO muser ";
		         sql+= " (u_no,u_id,u_pw,u_mail,u_name,u_gender,u_phone) ";
		         sql+= " VALUES(?,?,?,?,?,?,?) ";
		  ps = conn.prepareStatement(sql);
		  
		  ps.setInt(1, Integer.parseInt(u_no));
		  ps.setString(2, u_id);
		  ps.setString(3, u_pw);
		  ps.setString(4, u_mail);
		  /*ora-01861: literal does not match format string (날짜형식 맞지않아서 에러남)
		  date 타입 INSERT 적용할때 에러가 나서 날짜데이터 수정후에 다시 작성하겠습니다.
		  */
		  ps.setString(5, u_name);
		  ps.setString(6, u_gender);
		  ps.setString(7, u_phone);
			 
		  result = ps.executeUpdate();		  
		  conn.close();
		  ps.close();
  }catch(Exception e) {
	  e.printStackTrace();
}
if(result > 0){
%>
	<script>
	alert("가입을 축하드립니다.");
	location="index.jsp";
	</script>
<%
}else{
%>
	<script>
	alert("가입안됨 ");
	location="index.jsp";
	</script>
<%
}
%>