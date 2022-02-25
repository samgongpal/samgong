<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ page import="DBPKG.DAO" %>
  <%@ page import="java.sql.*" %>
<%
Connection conn = DAO.getConnection();

Statement stmt = conn.createStatement();

String hi = request.getParameter("hi");

String sql = "insert into samgong values ("+hi+")";

int result = stmt.executeUpdate(sql);

if(result > 0){
	%>
	<script>
	alert("테스트");
	location="index.jsp";
	
	</script>
	
	<%
}else{
	%>
	<script>
	alert("에러");
	location="index.jsp";
	
	</script>
<%
}
%>