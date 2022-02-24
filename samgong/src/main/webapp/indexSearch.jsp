<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DBPKG.DAO" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("UTF-8");

String m_name = request.getParameter("m_name");


Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;
//select m_name from movie where m_name like '언%' order by m_sdate desc;

try{
	  conn = DAO.getConnection();
	  String sql = " SELECT m_no ";
	         sql+= " FROM movie ";
	         sql+= " WHERE m_name LIKE '%"+m_name+"%' ";
	         sql+= " UNION ALL "; //select 문 결과를 합쳐줍니다.
	         sql+= " SELECT count(*) ";
	         sql+= " FROM movie ";
	         sql+= " WHERE m_name LIKE '%"+m_name+"%' ";
	       
	  ps = conn.prepareStatement(sql);
	  rs = ps.executeQuery();
	  int m_no = 0;  

	  ArrayList<String> list = new ArrayList<String>();
	  
	  while(rs.next()){
		m_no = Integer.parseInt(rs.getString("m_no"));
		list.add(m_no+"");
		// 영화 검색 결과를 어레이 리스트에 담은뒤
	 }
	  session.setAttribute("session_movie_no",list);
	  //세션값으로 보내줍니다.
	  
	  if(m_no > 0){
		  %>
		  <script>
		  location = "movieList.jsp?search=1";	  
		  </script>		  
		  <%
	  }else{
		  %>
		  <script>
		  location = "index.jsp";	  
		  </script>
		  <%
	  }
}catch(Exception e) {
	e.printStackTrace(); 
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삼공시네마</title>
</head>
<body>

</body>
</html>