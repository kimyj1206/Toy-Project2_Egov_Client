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
<link rel="stylesheet" type="text/css" href="<c:url value='/css/user/login.css'/>" />
<script src="<c:url value='/js/user/login.js'/>"></script>
<title>로그인</title>
</head>
<body>	
	<div class="wrap">
        <div class="login">
            <h2>로그인</h2>
            <div class="login_id">
                <h4>ID</h4>
                <input type="text" name="id" id="id" placeholder="아이디를 입력해주세요.">
            </div>
            
            <div class="login_pw">
                <h4>Password</h4>
                <input type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요.">
            </div>
            
            <div class="login_etc">
                <div class="find_id">
                	<a href="/members/find-id.do">아이디 찾기</a>
            	</div>
            	<div class="find_pw">
                	<a href="/members/reset-pw.do">비밀번호 찾기</a>
            	</div>
                <div class="join">
                	<a href="/members/join.do">회원가입</a>
            	</div>
            </div>
            
            <div class="submit">
                <button type="button" onclick="loginSubmit()">로그인</button>
            </div>
        </div>
    </div>
</body>
</html>