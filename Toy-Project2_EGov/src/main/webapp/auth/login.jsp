<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link rel="stylesheet" type="text/css" href="../css/auth/login.css">
<title>로그인</title>
</head>
<script>
	function loginSubmit() {	
		$.ajax({
			type: "post",
			data: JSON.stringify({
				"id": $("#id").val(),
				"password": $("#password").val()
			}),
			url: "/api/v1/members/login.do",
			dataType: "json",
			contentType: 'application/json',
			success: function(data) {
				if(data.success) {
					alert(data.success);
					location = "/boards/list.do?pageNum=1";
				} else {
					alert(data.fail);
				}
			},
			error: function(xhr, status, error) {
				console.log("code : " + xhr.status + "\n" + "message : " + xhr.responseText + "\n" + "error : " + error);
				alert('시스템 에러 발생하였습니다. 관리자에게 연락해주세요.');
			}
		});
	}
</script>
<body>	
	<div class="wrap">
        <form class="login" id="frm">
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
        </form>
    </div>
</body>
</html>