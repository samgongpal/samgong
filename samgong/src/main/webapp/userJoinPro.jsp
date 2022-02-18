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
  
  Connection conn = null;
  PreparedStatement ps = null;
  ResultSet rs = null;
  
  int cnt = -1;
  
  try{
	  conn = DAO.getConnection();
	  String sql = "SELECT COUNT(*)cnt FROM MUSER WHERE u_id=? OR u_mail=?";
	  
	  ps = conn.prepareStatement(sql);
	  ps.setString(1, u_id);
	  ps.setString(2, u_mail);
	  rs = ps.executeQuery();
	  rs.next();
	  cnt = rs.getInt("cnt"); //중복여부 체크
	  conn.close();
	  ps.close();
	  rs.close();
	  
	  if(cnt > 0){
	%>
		<script>
		alert("중복된 아이디입니다.");
		history.back();
		</script>
	<%
	  }else{

		  conn = DAO.getConnection();
		  		 sql = " INSERT INTO muser ";
		         sql+= " (u_no,u_id,u_pw,u_birth,u_regdate) ";
		         sql+= " VALUES(?,?,?,?,?) ";
		  ps = conn.prepareStatement(sql);
		  ps.setInt(1, Integer.parseInt(u_no));
		  ps.setString(2, u_id);
		  ps.setString(3, u_pw);
		  ps.setString(4, u_regdate);
		  ps.setString(5, u_regdate);
		 
		  int result = ps.executeUpdate();		  
		  conn.close();
		  ps.close();
		  %>
			<script>
				alert("가입을 축하드립니다.");
				location="index.jsp";
			</script>
			<%
	  }
	
  }catch(Exception e) {
	  e.printStackTrace();
  }
%>