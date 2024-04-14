<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo:wght@700&display=swap" rel="stylesheet">
<title>메인</title>
<style>
	 body {
	 	text-align: center;
	 	font-family: 'Nanum Myeongjo', serif;
	 }
	 h2 {
	 	color: #8c8c8c;
	 	padding: 20px 0 30px 0;
	 }
	 .d-grid {
	 	display: flex;
	    justify-content: center;
	    align-items: center;
	    height: 70vh;
	 }
	 .btn {
		margin: 15px 0 15px 0;
		color: #505050;
	 }
</style>
</head>
<script>
	function user() {
		location.href = '/members/login.do';
	}
	
	function notice() {
		location.href = '/boards.do';
	}
	
	function git() {
		window.open("about:blank").location.href = 'https://github.com/kimyj1206/kimyj1206';
	}
</script>

<body>
	<h2>이동할 페이지를 선택해주세요.</h2>
	
	<div class="d-grid gap-2 col-6 mx-auto">
  		<button class="btn btn-info" type="button" onclick="user()">로그인 및 회원가입</button>
  		<!-- <button class="btn btn-info" type="button" onclick="notice()">게시판</button> -->
  		<button class="btn btn-info" type="button" onclick="">채팅방</button>
  		<button class="btn btn-info" type="button" onclick="">SMS 전송</button>
  		<button class="btn btn-info" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">더보기</button>
	</div>
	
	
	<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
  		<div class="offcanvas-header">
    		<h5 class="offcanvas-title" id="offcanvasRightLabel">기타</h5>
    		<button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  		</div>
  		<div class="offcanvas-body">
    		<button class="btn btn-info" type="button" onclick="git()">개발자 Github</button>
  		</div>
	</div>
	
</body>
</html>