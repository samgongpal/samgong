<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Insert title here</title>
</head>
<body>
 
<header>
  <h1><a href="index.jsp">삼공시네마</a></h1>

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
      </ul>
    </li>
    <li><a href="#" onclick="alert('로그인해주세요.')">예매</a>
      <ul id="sub-menu">
        <li><a href="#" aria-label="subemnu">빠른예매</a></li>
      </ul>
    </li>
    <li><a href="#" onclick="alert('준비중입니다.')">고객센터</a>
      <ul id="sub-menu">
        <li><a href="#" aria-label="subemnu">FAQ</a></li>
      </ul>
    </li>
    <li><a href="#" onclick="alert('준비중입니다.')">회원가입</a></li>
    <li><a href="#" onclick="alert('준비중입니다.')">로그인</a></li>
  </ul>
</nav>

</body>
</html>