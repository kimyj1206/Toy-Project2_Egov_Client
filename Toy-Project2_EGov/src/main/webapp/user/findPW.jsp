<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
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
<link rel="stylesheet" type="text/css" href="/css/user/findPW.css">
<script src="<c:url value='/js/user/findPW.js'/>"></script>
<title>사용자 비밀번호 찾기</title>
</head>
<body>
	<h2>사용자 로그인 비밀번호 찾기</h2>
	
	<div class="findId">
		<label for="id">아이디</label>
		<input type="text" id="id" placeholder="아이디를 입력해주세요." />
	</div>
	
	<p>아이디가 기억나지 않는다면? <a href="/members/find-id.do">아이디 찾기</a></p>
	
	<div class="btnPw">
		<button type="button" class="btn btn-outline-primary" onclick="idCheck()">확인</button>
	</div>
	
	<div id="pwResult" style="display:none">
		<h2>사용자 로그인 비밀번호 초기화</h2>
		<div>
			<label for="password">비밀번호</label>
			<input type="text" name="password" id="password" placeholder="비밀번호를 입력해주세요." />
		</div>
		
		<div class="btnPw">
			<button type="button" class="btn btn-info" onclick="resetPw()">초기화</button>
		</div>
	</div>
</body>
</html>