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
<title>로그인</title>
<style>
	 * {
	  margin: 0;
	  padding: 0;
	  box-sizing: border-box;
	  font-family: 'Nanum Myeongjo', serif;
	}
	a {
	  text-decoration: none;
	  color: black;
	}
	li {
	  list-style: none;
	}
	.wrap {
	  width: 100%;
	  height: 100vh;
	  display: flex;
	  align-items: center;
	  justify-content: center;
	}
	.login {
	  width: 30%;
	  height: 600px;
	  background: white;
	  border-radius: 20px;
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  flex-direction: column;
	}
	h2 {
	  color: #5AC8C8;
	  font-size: 2em;
	}
	.login_id {
	  margin-top: 20px;
	  width: 80%;
	}
	.login_id input {
	  width: 100%;
	  height: 50px;
	  border-radius: 30px;
	  margin-top: 10px;
	  padding: 0px 20px;
	  border: 1px solid lightgray;
	  outline: none;
	}
	.login_pw {
	  margin-top: 20px;
	  width: 80%;
	}
	.login_pw input {
	  width: 100%;
	  height: 50px;
	  border-radius: 30px;
	  margin-top: 10px;
	  padding: 0px 20px;
	  border: 1px solid lightgray;
	  outline: none;
	}
	.login_etc {
	  padding: 10px;
	  width: 80%;
	  font-size: 14px;
	  display: flex;
	  justify-content: space-between;
	  align-items: center;
	  font-weight: bold;
	}
	.submit {
	  margin-top: 40px;
	  width: 80%;
	}
	.submit button {
	  width: 100%;
	  height: 50px;
	  border: 0;
	  outline: none;
	  border-radius: 40px;
	  background: #5AC8C8;
	  color: white;
	  font-size: 1.2em;
	  letter-spacing: 2px;
	}
</style>
</head>
<script>
	function loginSubmit() {	
		$.ajax({
			type: "post",
			data: JSON.stringify({
				"id": $("#id").val(),
				"password": $("#password").val()
			}),
			url: "loginCheck.do",
			dataType: "json",
			contentType: 'application/json',
			success: function(result) {
				
				if(result == "1") {
					alert("로그인 완료되었습니다.");
					location = "board.do";
				} else {
					alert("입력하신 로그인 정보가 틀립니다.");
				}
			},
			error: function() {
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
                	<a href="/authFindId.do">아이디 찾기</a>
            	</div>
            	<div class="find_pw">
                	<a href="/authFindPw.do">비밀번호 찾기</a>
            	</div>
                <div class="join">
                	<a href="/authJoin.do">회원가입</a>
            	</div>
            </div>
            
            <div class="submit">
                <button type="button" onclick="loginSubmit()">로그인</button>
            </div>
        </form>
    </div>
</body>
</html>