<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="DBPKG.DAO"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
String strReferer = request.getHeader("referer");
if(strReferer == null){ 
//비정상적인 URL 접근차단을 위해 request.getHeader("referer") 메소드를 사용하였습니다.
//로그인한 회원의 회원가입페이지 URL 접근을 제한합니다.
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

  String u_no = "";
  
  Connection conn = null;
  PreparedStatement ps = null;
  ResultSet rs = null;
  
  
  try{
	  conn = DAO.getConnection();
	  String sql = "SELECT MAX(u_no)+1 u_no FROM MUSER";
	  ps = conn.prepareStatement(sql);
	  rs = ps.executeQuery();
	  if(rs.next()) {
		  u_no = rs.getString("u_no"); //MAX 회원번호 +1 을 u_no 에 담아온다.
	  }
	  conn.close();
	  ps.close();
	  rs.close();
  }catch(Exception e) {  
	  e.printStackTrace(); 
  }

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/user.css">
<link rel="stylesheet" href="css/jquery-ui.css">
  <script src="script/jquery-1.12.4.js"></script>
  <script src="script/jquery-ui.js"></script>
  <script>
  $( function() {//#은 id 값을 의미한다.
    $( "#birthday" ).datepicker({
      changeMonth: true,
      changeYear: true
    });
  
  } );
  </script>
  
</head>
<body onload="document.frm.u_id.focus()">
<%@ include file="topmenu.jsp" %>
<%
if(session_no != null){
%>
	<script>
	location="index.jsp";	
	</script>
<%	return;
}	
%>
  <div class="top"><h1>Join Member</h1></div>
  <section>
    <form name="frm" action="userJoinPro.jsp" method="post">
      <input type="hidden" name="u_no" value="<%=u_no%>" readonly> 
    
    <div class="join">
    <table >
      <tr>
      <td>
      <input style="width:75%" type="text" name="u_id" placeholder="아이디" required>
      <input style="width:20%; float:right; cursor:pointer;" type="button" onclick="fn_dbCheckId()" name="dbCheckId" value="check ID">
      <input type="hidden" name="idDuplication" value="0"></td>
      <!-- 중복체크 확인을 위한 hidden 변수 -->
      </tr> 
      <tr>
      <td><input type="password" name="u_pw" placeholder="비밀번호" required></td>
      </tr>
      <tr>
      <td><input type="password" name="u_pw2" placeholder="비밀번호 확인" required></td>
      </tr> 
      <tr>
      <td><input type="email" name="u_mail" placeholder="e-mail" required></td>
      </tr>
      
      <tr>
	      <td>
	      <input type="text" name="u_birth" id="birthday" placeholder="생년월일" required>
	      </td>
      </tr>   
      <tr>
      <td><input type="text" name="u_name" placeholder="이름" required maxlength="3" ></td>
      </tr>   
      <tr>
	      <td style="text-align:center">
	      Male<input style="width:10%" type="radio" name="u_gender" value="M">
	      Female<input style="width:10%" type="radio" name="u_gender" value="F">
	      </td>
      </tr>    
      <tr>
      <td><input type="text" name="u_phone" placeholder="phone" required>
      </td>
      </tr>
      <%
      	java.util.Date date = new java.util.Date();
        SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
        String strdate = simpleDate.format(date);
      %>  
      <tr>
      <td style="text-align:center"><input type="text" name="u_regdate" value="<%= strdate%>" readonly></td>
      </tr>
    </table>
    </div>
          <input type="submit" onclick="fn_checkAll();return false;" value="회원가입">
          <input type="reset" value="취소">
    </form>
  </section>
<%@include file="footer.jsp" %>
</body>
<script src="script/check.js"></script>

</html>