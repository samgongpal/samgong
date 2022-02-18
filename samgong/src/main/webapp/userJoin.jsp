<%@page import="DBPKG.DAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
  int Y = 0;
  int M = 0;
  int D = 0;
  int max_no = 0;
  
  Connection conn = null;
  PreparedStatement ps = null;
  ResultSet rs = null;
  
  
  try{
	  conn = DAO.getConnection();
	  String sql = "SELECT MAX(u_no) FROM MUSER";
	  ps = conn.prepareStatement(sql);
	  rs = ps.executeQuery();
	  if(rs.next()) {
		  max_no = rs.getInt(1);
	  }
	  conn.close();
	  ps.close();
	  rs.close();
  }catch(Exception e) {}
  max_no += 1;
  System.out.print(max_no);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 
</head>
<body>
  <section>
    <form name="frm" onsubmit="return checkAll()" action="" method="post">
    <table>
      <input type="hidden" name="u_no" value=<%= max_no%>>
      <tr><th>아이디 : </th><td><input type="text" name="u_id" id="id" onkeydown="inputIdChk()">
                              <button type="button" onclick="fn_dbCheckId()" name="dbCheckId" class="checkId">중복확인</button>
                              <input type="hidden" name="idDuplication" value="idUncheck"></td>
      </tr>
      
      <tr><th>비밀번호 : </th><td><input type="text" name="u_pw"></td>
      </tr>
      
      <tr><th>이메일 : </th><td><input type="email" name="u_mail"></td>
      </tr>
      
      <tr><th>생년월일 : </th><td><select name="u_birth1"><%for(Y = 2022; Y >= 1950; Y --) {%>
                                                             <option value="<%= Y%>"><%= Y%>
                                                       <%} %></select>
                               <select name="u_birth2"><%for(M = 1; M < 13; M ++) {%>
                                                             <option value="<%= M%>"><%= M%>
                                                       <%} %></select>
                               <select name="u_birth3"><%for(D = 1; D < 32; D ++) {%>
                                                             <option value="<%= D%>"><%= D%>
                                                       <%} %></select>
                           </td>
      </tr>
      
      <tr><th>이름 : </th><td><input type="text" name="u_name"></td>
      </tr>
      
      <tr><th>성별 : </th><td><input type="radio" name="u_gender" value="M" checked="checked">남&nbsp;
                             <input type="radio" name="u_gender" value="F" >여
                        </td>
      </tr>
      
      <%java.util.Date date = new java.util.Date();
        SimpleDateFormat simpleDate = new SimpleDateFormat("yyyyMMdd");
        String strdate = simpleDate.format(date);
      %>
      <tr><th>가입일 : </th><td><input type="text" name="u_regdte" value=<%= strdate%> readonly="readonly"></td>
      </tr>
      
      <tr><th>휴대폰번호 : </th><td><input type="text" name="u_phone1" value="010" readonly="readonly">
                                 -<input type="text" name="u_phone2" maxlength="4">
                                 -<input type="text" name="u_phone3" maxlength="4">
                            </td>
      </tr>
      
      <tr><td colspan="2">
          <input type="submit" value="회원가입">
          <input type="button" value="취소" onclick="window.location.href='userLogin.jsp'">
          </td>
      </tr>
    </table>
    </form>
  </section>
<%@include file="footer.jsp" %>
</body>
<script type="text/javascript" src="script/check.js"></script>
</html>