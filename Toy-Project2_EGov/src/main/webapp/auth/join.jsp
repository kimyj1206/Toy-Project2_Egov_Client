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
<title>회원가입</title>
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
	.join {
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
	.join_id,
	.join_pw,
	.join_name,
	.join_phone,
	.join_email {
	  margin-top: 20px;
	  width: 80%;
	}
	.join_id input,
	.join_pw input,
	.join_name input,
	.join_phone input,
	.join_email input {
	  width: 100%;
	  height: 45px;
	  border-radius: 30px;
	  margin-top: 10px;
	  padding: 0px 20px;
	  border: 1px solid lightgray;
	  outline: none;
	}
	.id_container {
	  display: flex;
	  align-items: center;
	}
	.checkIdbtn {
	  margin-left: 10px;
	  white-space: nowrap;
	}
	.join_gender {
	  display: flex;
	  align-items: center;
	  margin-top: 10px;
	  padding: 15px;
	}
	.join_gender label {
	  margin-right: 50px;
	}
	.submit {
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
	.requiredEle::after {
	    content: '*';
	    color: #ff0000;
	}
</style>
</head>
<script>
	/* 아이디 중복 체크 */
	function duplicatedID () {
		var joinID = $("#id").val();

		$.ajax({
			type: 'post',
			data: JSON.stringify({
				"id": joinID
			}),
			url: 'duplicatedID.do',
			dataType: 'json',
			contentType: 'application/json',
			success: function(data) {
				if(data.success) {
					alert(joinID + ' 는 사용 가능한 아이디입니다.');
					$("#id").data("value", true);
				}else {
					alert(joinID + ' 는 사용 불가능한 아이디입니다. 다른 아이디로 변경해주세요.');
					$("#id").val("");
				}
			},
			error: function() {
				alert('시스템 에러 발생하였습니다. 관리자에게 연락해주세요.');
			}
		});
		/* 폼 전송 후 새로 페이지 로드 막음 */
		event.preventDefault();
	}
	
	/* 회원가입 폼 전송 */
	function joinSubmit() {
		if($("#id").data("value") == true) {
			$.ajax({
				type : "post",
				data : JSON.stringify({
					"id": $("#id").val(),
					"password": $("#password").val(),
					"name": $("#name").val(),
					"phone": $("#phone").val(),
					"email": $("#email").val(),
					"gender": $("#gender :checked").val()
				}),
				url : "joinSave.do",
				dataType : "json",
				contentType: 'application/json',
				success: function(data) {
					if(data.success) {
						alert('회원가입이 완료되었습니다.');
						location = 'authLogin.do';
					}else {
						alert('회원가입에 실패했습니다.');
					}
				},
				error: function() {
					alert('시스템 에러 발생하였습니다. 관리자에게 연락해주세요.');
				}
			});
		}else {
			alert('유효하지 않는 필드가 포함되어 있습니다. 다시 작성해주세요.');
		}
	}	
</script>
<body>	
	<div class="wrap">
    	<div class="join">
			<h2>회원가입</h2>
            <div class="join_id">
                <h4 class="requiredEle">ID</h4>
                <div class="id_container">
                	<input type="text" name="id" id="id" class="inp" placeholder="아이디를 입력해주세요." required />
                	<button class="btn btn-warning checkIdbtn" onclick="duplicatedID()" data-value="false">중복 체크</button>
            	</div>
            </div>
            
            <div class="join_pw">
                <h4 class="requiredEle">Password</h4>
                <input type="password" name="password" id="password" class="inp" placeholder="비밀번호를 입력해주세요." required />
            </div>
            
            <div class="join_name">
                <h4 class="requiredEle">Name</h4>
                <input type="text" name="name" id="name" class="inp" placeholder="이름을 입력해주세요." required />
            </div>
            
            <div class="join_phone">
                <h4 class="requiredEle">Phone</h4>
                <input type="tel" name="phone" id="phone" class="inp" placeholder="010-0000-0000" required />
            </div>
            
            <div class="join_email">
                <h4 class="requiredEle">Email</h4>
	            <input type="email" name="email" id="email" class="inp" placeholder="example@example.com" required />
			</div>
            
           	<div class="join_gender" id="gender">
	            <label><input type="radio" class="gender" name="gender" value="M">남자</label>
                <label><input type="radio" class="gender" name="gender" value="F">여자</label>
                <label><input type="radio" class="gender" name="gender" value="N" checked>선택안함</label>
			</div>      
            <div class="submit">
               <button type="button" onclick="joinSubmit()">회원가입</button>
            </div>
        </div>
    </div>
</body>
</html>