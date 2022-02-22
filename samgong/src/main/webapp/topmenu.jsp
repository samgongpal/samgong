<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("UTF-8");
   String session_no = (String)session.getAttribute("session_no");
   // String 으로 변수 타입을 수정하였습니다. 변수명 중복으로 변경합니다.
  
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Insert title here</title>
</head>
<body>
 
<header style="background-image:url('img/main.webp')">
  <h1><a href="index.jsp" >삼공시네마</a>
  </h1>

  <p>C U L T U R E P L E X</p>
</header>

<nav role="navigation">
  <ul id="main-menu">
    <li><a href="#">영화</a>
      <ul id="sub-menu">
        <li><a href="movieList.jsp" aria-label="subemnu">현재상영작</a></li>
        <li><a href="#" aria-label="subemnu">개봉예정작</a></li>
      </ul>
    </li>
    <li><a href="#" onclick="alert('준비중입니다.')">극장</a>
      <ul id="sub-menu">
        <li><a href="#" aria-label="subemnu">극장리스트</a></li>
        <li><a href="movieScreen.jsp" aria-label="subemnu">상영관정보</a></li>
      </ul>
    </li>
    <li><a href="ticketList.jsp">예매</a>
      <ul id="sub-menu">
        <li><a href="ticketList.jsp" aria-label="subemnu">빠른예매</a></li>
      </ul>
    </li>
    <li><a href="qnaBoardList.jsp">고객센터</a>
      <ul id="sub-menu">
        <li><a href="qnaBoardList.jsp" aria-label="subemnu">FAQ</a></li>
      </ul>
    </li>
    <%if(session_no == null || session_no.equals("")) {%>
   <li><a href="userJoin.jsp">회원가입</a></li>
   <li><a href="userLogin.jsp">로그인</a></li>
    <%}else {%>
  <li><a href="userModify.jsp">마이페이지</a></li>
  <li><a href="userLogout.jsp">로그아웃</a></li>
    <%} %>   
   
  </ul>
</nav>

</body>
</html>