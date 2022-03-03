<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삼공팔 Screen</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/movie.css">
</head>
<style>
.screen img{
	text-align: center;
	width: 100%;
	border-radius: 1rem;
}
.screenwrite{
	text-align: center;
}
</style>
<body>
<%@ include file="topmenu.jsp" %>
<section>
<div class="top"></div>
<div class="screenwrapper">
<div class="screen"><img src="img/logo.jpg"></div>
</div>
<div class="screenwrite">
<h1>삼공팔 Screen</h1>
</div>
<div>
관람료 영화별 상이<br>
상영지점 삼공팔 3개 지점(월별상이)<br>
상영회사 1일 1~2회<br>
상영기간 영화 별 상이<br>
상영지점을 꼭 확인하세요<br>
초지동점, 중앙동점, 사동점<br>
꼭 알아두세요<br>
극장 별 상영 일정이 상이 하오니 예매 전 시간표 참고 부탁드립니다.<br>
영화에 따라 기준요금이 상이합니다.<br>
성인, 청소년 요금의 구분이 없이 동일합니다.<br>
[삼공팔] 쿠폰을 제외한 티켓 예매시 할인 및 쿠폰 적용이 불가합니다.<br>
상영 극장 및 일정은 사정에 의해 변경될 수 있습니다.<br>
</div>



</section>
<%@include file="footer.jsp" %>
</body>
</html>