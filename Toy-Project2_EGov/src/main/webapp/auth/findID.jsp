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
<title>사용자 아이디 찾기</title>
</head>
<style>
	* {
		font-family: 'Nanum Myeongjo', serif;
	}
	h2 {
		text-align: center;
		padding: 30px;
	}
	.form-check, .emailGrp, .telGrp {
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	.emailGrp, .telGrp {
		display: none;
		margin: 20px 0;
	}
	.emailGrp div, .telGrp div, .form-check div {
		display: flex;
		flex-direction: row;
		align-items: center;
		justify-content: center;
		margin: 10px 0;
	}
	.emailGrp label, .telGrp label, .form-check label {
		margin-right: 10px;
	}
	.btn {
    	display: flex;
    	align-items: center;
    	justify-content: center;
	}
	#idResult {
		margin: 35px auto;
		text-align: center;
	}
	#phoneResult {
		margin: 35px auto;
		text-align: center;
	}
	.btn-primary {
		margin: 35px auto;
		text-align: center;
	}
</style>
<script>
	function checkBtn() {
		var btnEmail = document.getElementById("flexRadioDefault1");
		var btnTel = document.getElementById("flexRadioDefault2");
		var contentEmail = document.getElementById("email_content");
		var contentTel = document.getElementById("tel_content");
		
		if(btnEmail.checked) {
			contentEmail.style.display = "block";
			contentTel.style.display = "none";
			$("#name").val("");
			$("#email").val("");
		} else if(btnTel.checked){
			contentEmail.style.display = "none";
			contentTel.style.display = "block";
			$("#name2").val("");
			$("#phone").val("");
		};
	}
	
	function authInfo() {
		var btnEmail = document.getElementById("flexRadioDefault1");
		var btnTel = document.getElementById("flexRadioDefault2");

		if(btnEmail.checked) {
			/* 이메일로 인증 시 해당 값을 가져와서 db 조회 */
			$.ajax({
				type: 'post',
				data: JSON.stringify({
					"name": $("#name").val(),
					"email": $("#email").val()
			}), // JSON 문자열로 변환
				dataType: 'json',
				contentType: 'application/json',
				url: 'authFindIdCheck.do',
				success: function(data) {
					
					if(data.success) {
						$("#idResult").show();
						$("#id1").val(data.userId.id);
						$("#phoneResult").hide();
					}else {
						/* 조건에 맞는 아이디가 없다면 팝업 노출 */
						alert('입력하신 정보로 가입된 아이디가 없습니다.');
						$("#name").val("");
						$("#email").val("");
					}
				},
				error: function(xhr, status, error) {
					console.log("code : " + xhr.status + "\n" + "message : " + xhr.responseText + "\n" + "error : " + error);
					alert('시스템 에러 발생하였습니다. 관리자에게 연락해주세요.');
				}
			})
		}else if(btnTel.checked) {
			/* 핸드폰 번호로 인증 시 해당 값을 가져와서 db 조회 */
			$.ajax({
				type: 'post',
				data: JSON.stringify({
					"name": $("#name2").val(),
					"phone": $("#phone").val()
				}),
				dataType: 'json',
				contentType: 'application/json',
				url: 'authFindIdCheck.do',
				success: function(data) {
					
					if(data.success) {
						$("#phoneResult").show();
						$("#id2").val(data.userId.id);
						$("#idResult").hide();
					}else {
						/* 조건에 맞는 아이디가 없다면 팝업 노출 */
						alert('입력하신 정보로 가입된 아이디가 없습니다.');
						$("#name2").val("");
						$("#phone").val("");
					}
				},
				error: function(xhr, status, error) {
					console.log("code : " + xhr.status + "\n" + "message : " + xhr.responseText + "\n" + "error : " + error);
					alert('시스템 에러 발생하였습니다. 관리자에게 연락해주세요.');
				}
			})
		}
	}
	
	function btn_location() {
		location.href = '/authLogin.do';
	}
</script>
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
		<button type="button" class="btn btn-outline-primary" onclick="authInfo()">인증하기</button>
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