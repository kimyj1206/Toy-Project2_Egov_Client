<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo:wght@700&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/user/findID.css'/>" />
<script src="<c:url value='/js/user/findID.js'/>"></script>
<title>사용자 아이디 찾기</title>
</head>
<body>
	<h2>사용자 로그인 아이디 찾기</h2>

	<!-- 이메일 인증 클릭 시 -->
	<div class="form-check">
		<label class="form-check-label" for="flexRadioDefault1">
			이메일로 인증하기
			<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1" onclick="checkBtn()" checked />
		</label>
	</div>

	<div class="emailGrp" id="email_content" style="display: block">
		<div>
			<label for="name">이름</label>
			<input type="text" id="name" />
		</div>
		<div>
			<label for="email">이메일</label>
			<input type="email" id="email" />
		</div>
	</div>
	
	
	<!-- 핸드폰 번호 인증 클릭 시 -->
	<div class="form-check">
		<label class="form-check-label" for="flexRadioDefault2">
			핸드폰 번호로 인증하기
			<input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" onclick="checkBtn()" />
		</label>
	</div>
	
	<div class="telGrp" id="tel_content" style="display: none">
		<div>
			<label for="name2">이름</label>
			<input type="text" id="name2" />
		</div>
		<div>
			<label for="phone">핸드폰 번호</label>
			<input type="tel" id="phone" />
		</div>
	</div>
	
	<div class="btn">
		<button type="button" class="btn btn-outline-primary" onclick="info()">인증하기</button>
	</div>
	
	<!-- 이메일 인증 결과 -->
	<div style="display:none" id="idResult">
		<h2>사용자 이메일로 아이디 찾기 결과</h2>
		<div>
			<p>입력하신 정보로 검색된 아이디는 <input type="text" id="id1" style="text-align:center" readonly> 입니다.</p>
		</div>
		<div class="btn_location">
			<button type="button" class="btn btn-primary" onclick="btn_location()">로그인</button>
		</div>
	</div>
	
	<!-- 핸드폰 인증 결과 -->
	<div style="display:none" id="phoneResult">
		<h2>사용자 핸드폰으로 아이디 찾기 결과</h2>
		<div>
			<p>입력하신 정보로 검색된 아이디는 <input type="text" id="id2" style="text-align:center" readonly> 입니다.</p>
		</div>
		<div class="btn_location">
			<button type="button" class="btn btn-primary" onclick="btn_location()">로그인</button>
		</div>
	</div>
</body>
</html>