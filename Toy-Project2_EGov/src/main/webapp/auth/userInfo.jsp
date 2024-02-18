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
<title>회원 정보</title>
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
	.infoUpdate {
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
	.inputId,
	.inputPw,
	.inputName,
	.inputTel,
	.inputEmail {
	  margin-top: 20px;
	  width: 80%;
	}
	.inputId input,
	.inputPw input,
	.inputName input,
	.inputTel input,
	.inputEmail input {
	  width: 100%;
	  height: 45px;
	  border-radius: 30px;
	  margin-top: 4px;
	  padding: 0px 20px;
	  border: 1px solid lightgray;
	  outline: none;
	}
	.pwContainer {
	  display: flex;
	  align-items: center;
	}
	.userCheck {
	  margin-left: 10px;
	  white-space: nowrap;
	}
	.inputGender {
	  display: flex;
	  align-items: center;
	  margin-top: 10px;
	  padding: 15px;
	}
	.inputGender label {
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
	.arrow-link {
	  text-decoration: none;
	  color: #333333;
	  display: flex;
	  align-items: center;
	  margin-top: 10px;
	}
	.arrow {
	  margin-left: 3px;
	}
</style>
</head>
<script>
	function userCheck() {
		/* 비밀번호 체크로 회원 검증 */
		$.ajax({
			type: 'post',
			url: 'authPwCheck.do',
			data: JSON.stringify({
				"id": $("#id").val(),
				"password": $("#password").val() 
			}),
			dataType: 'json',
			contentType: 'application/json',
			success: function(data) {
				if(data.success) {
					alert('유효한 회원입니다.')
					$("#password").data("value", true);
					$("#password").attr("readonly", true);
				}else {
					alert('비밀번호가 틀렸습니다. 다시 입력해주세요.');
					$("#password").val("");
				}
			},
			error: function(xhr, status, error, msg) {
				console.log("code : " + xhr.status + "\n" + "message : " + xhr.responseText + "\n" + "error : " + error);
				alert('시스템 에러 발생하였습니다. 관리자에게 연락해주세요.');
			}
		});
	}
	
	function userInfoUpdate() {
		/* 비밀번호 체크 실행했다면 update 진행 */
		if($("#password").data("value") == true) {
			$.ajax({
				type: 'post',
				url: 'authUserInfoUpdate.do',
				data: JSON.stringify({
					"id": $("#id").val(),
					"password": $("#password").val(),
					"name": $("#name").val(),
					"phone": $("#phone").val(),
					"email": $("#email").val(),
					"gender": $("#gender :checked").val()
				}),
				dataType: 'json',
				contentType: 'application/json',
				success: function(data) {
					if(data.success) {
						alert("회원 정보 수정되었습니다.\n로그인 페이지로 이동합니다.");
						location.href = "authLogin.do";
					}else {
						alert("회원 정보 수정 실패했습니다.\n입력 값을 확인해주세요.");
					}
				},
				error: function(xhr, status, error) {
					console.log("code : " + xhr.status + "\n" + "message : " + xhr.responseText + "\n" + "error : " + error);
					alert('시스템 에러 발생하였습니다. 관리자에게 연락해주세요.');
				}
			});
		}else {
			alert('회원 체크 버튼을 클릭해 회원 검증을 해주세요.');
		}
	}
</script>
<body>
	<div class="wrap">
		<div class="infoUpdate">
			<h2>회원 정보 수정</h2>
			
			<a href="/userLeave.do?id=${result.id}" class="arrow-link">회원탈퇴<span class="arrow">&gt;</span></a>
			
	        <div class="inputId">
	        	<h4 class="requiredEle">ID</h4>
	            <input type="text" name="id" id="id" class="inp" placeholder="" value="${result.id}" required readonly />
	         </div>
	         
	         <div class="inputPw">
	             <h4 class="requiredEle">Password</h4>
	             <div class="pwContainer">
	             	<input type="password" name="password" id="password" class="inp" placeholder="비밀번호를 입력해주세요." required />
	             	<button class="btn btn-warning userCheck" onclick="userCheck()" data-value="false">회원 체크</button>
	             </div> 
	         </div>
	         
	         <div class="inputName">
	             <h4 class="requiredEle">Name</h4>
	             <input type="text" name="name" id="name" class="inp" placeholder="이름을 입력해주세요." value = "${result.name}" required />
	         </div>
	         
	         <div class="inputTel">
	             <h4 class="requiredEle">Phone</h4>
	             <input type="tel" name="phone" id="phone" class="inp" placeholder="010-0000-0000" value="${result.phone}" required />
	         </div>
	         
	         <div class="inputEmail">
	             <h4 class="requiredEle">Email</h4>
	          	 <input type="email" name="email" id="email" class="inp" placeholder="example@example.com" value="${result.email}" required />
			</div>
	         
	        <div class="inputGender" id="gender">
	        	<c:choose>
	        		<c:when test="${result.gender eq 'M'}">
	        			<label><input type="radio" class="gender" name="gender" value="M" checked>남자</label>
	        			<label><input type="radio" class="gender" name="gender" value="F">여자</label>
	        			<label><input type="radio" class="gender" name="gender" value="N">선택안함</label>
	        		</c:when>
	        		<c:when test="${result.gender eq 'F'}">
	        			<label><input type="radio" class="gender" name="gender" value="M">남자</label>
	        			<label><input type="radio" class="gender" name="gender" value="F" checked>여자</label>
	        			<label><input type="radio" class="gender" name="gender" value="N">선택안함</label>
	        		</c:when>
	        		<c:when test="${result.gender eq 'N'}">
	        			<label><input type="radio" class="gender" name="gender" value="M">남자</label>
	        			<label><input type="radio" class="gender" name="gender" value="F">여자</label>
	        			<label><input type="radio" class="gender" name="gender" value="N" checked>선택안함</label>
	        		</c:when>
	       		</c:choose>
			</div>      
	        <div class="submit">
	        	<button type="button" onclick="userInfoUpdate()">수정하기</button>
	        </div>
        </div>
	</div>

</body>
</html>