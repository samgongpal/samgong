<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="DBPKG.DAO"%>
<%@page import="java.sql.*"%>
<%@include file="certificated.jsp" %>

<%
	request.setCharacterEncoding("UTF-8");

	int r_count2 = 0;
	int r_no2 = 2;
	//String r_no = request.getParameter("r_no");
	//String r_count = request.getParameter("r_count");
	String u_no = request.getParameter("u_no");
	String m_no = request.getParameter("m_no");
	String t_no = request.getParameter("t_no");
	String[] seat = request.getParameterValues("seat");
	/* 데이터가 잘들어갔는지 확인할수있는 변수 - yunamom 2022년3월20일 */
	int result = 0;
	
 	for(int i = 0; i < seat.length; i++){
		System.out.println(seat[i]);
		r_count2++;
	}
 	String r_count = r_count2 + "";
 	
	Connection conn = null;
	PreparedStatement ps = null;
	
	try{
		conn = DAO.getConnection();
		String sql = " INSERT INTO RESERVATION ";
		       sql+= " (r_no, r_count, m_no, u_no, t_no) ";
		       sql+= " VALUES(RES_DEPT.NEXTVAL, ?, ?, ?, ?) ";
		ps = conn.prepareStatement(sql);
		ps.setString(1, r_count);
		ps.setString(2, m_no);
		ps.setString(3, u_no);
		ps.setString(4, t_no);
		result = ps.executeUpdate();
		
		conn.close();
		ps.close();
		
	}catch(Exception e){
		  e.printStackTrace();
	}

if(result == 1){
%>
	<script>
	alert("예매가 완료되었습니다 :D");
	location="userTicketing.jsp";
	</script>
<%
}else{
%>
	<script>
	alert("예매 실패! \n 관리자에게 문의해주세요.");
	location="index.jsp";
	</script>
<%
}
%>