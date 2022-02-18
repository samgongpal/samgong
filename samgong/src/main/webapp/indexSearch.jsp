<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DBPKG.DAO" %>
<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("UTF-8");

String m_name = request.getParameter("m_name");


Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;
//select m_name from movie where m_name like '언%' order by m_sdate desc;

try{
	  conn = DAO.getConnection();
	  String sql = " SELECT count(*)cnt ";
	         sql+= " FROM movie WHERE m_name LIKE '%"+m_name+"%'";
	  ps = conn.prepareStatement(sql);
	  rs = ps.executeQuery();
	  rs.next();
	  int cnt = rs.getInt("cnt");
	  if(cnt > 0){
		  %>
		  <script>
		  alert("영화가있습니다.");
		  history.back();		  
		  </script>		  
		  <%
	  }else{
		  %>
		  <script>
		  alert("검색결과가 없습니다.");
		  history.back();	  
		  </script>		  
		  <%
	  }
}catch(Exception e) {
	
}
%>