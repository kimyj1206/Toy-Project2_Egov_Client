<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<link rel="stylesheet" type="text/css" href="../css/auth/userLeave.css">
<title>회원 탈퇴</title>
</head>
<script>
	function agreeChecked() {
		
		var isChecked = document.getElementById('inlineCheckbox1');
		
		if(isChecked) {
			$("#leaveCheck").show();
		}
	}

	function userLeave() {
		$.ajax({
			type: 'post',
			url: 'api/v1/mypage/delete',
			data: JSON.stringify({
				"id": $("#id").val(),
				"password": $("#password").val()
			}),
			dataType: 'json',
			contentType: 'application/json',
			success: function(data) {
				if(data.success) {
					alert(data.success);
					location.href = '/index.do';
				}else {
					alert(data.fail);
					$("#password").val("");
				}
			},
			error: function(xhr, status, error) {
				console.log("code : " + xhr.status + "\n" + "message : " + xhr.responseText + "\n" + "error : " + error);
				alert('시스템 에러 발생하였습니다. 관리자에게 연락해주세요.');
			}
		})
	}
</script>
<body>
	<h1 class="title">회원 탈퇴</h1>
	
	<div class="vertical-center">
		<button type="button" class="btn btn-primary modalCheck" data-bs-toggle="modal" data-bs-target="#staticBackdrop">안내사항 확인</button>
	
		<!-- Modal -->
		<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="staticBackdropLabel">탈퇴 전 유의사항</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
			  <div class="modal-dialog modal-dialog-scrollable">
				회원 탈퇴를 진행하기 전에 아래 사항을 반드시 확인해 주세요.<br><br>
				사용하고 계신 아이디는 탈퇴할 경우 <em style="color: red">복구가 불가능</em>합니다.<br><br>
				단, 회원 탈퇴 후에도 작성하신 게시물은 그대로 남아 있습니다.<br><br>
				삭제를 원하신다면 반드시 탈퇴 전 삭제 바랍니다.<br><br>
				탈퇴 후 계정에 대한 정보 및 데이터는 확인하거나 복구할 수 없습니다.<br><br>
				만족하지 못한 부분은 언제든 개선점을 남겨주세요.<br><br>
				해당 서비스를 이용해 주셔서 진심으로 감사드립니다.
			  </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" style="margin: 0 auto">Close</button>
		      </div>
		    </div>
		  </div>
		</div>
	
		<div class="form-check form-check-inline">
	  		<input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="" onclick="agreeChecked()">
	  		<label class="form-check-label" for="inlineCheckbox1">모든 내용에 대해 숙지 및 동의하며, 이후 발생하는 불이익은 본인에게 있습니다.</label>
		</div>
	</div>
	<hr>
	
	<div class="leaveCheck" id="leaveCheck">
		<div class="inputId">
			<h4 class="requiredEle">ID</h4>
			<input type="text" name="id" id="id" value="${result.id}" required readonly />
		</div>
			
		<div class="inputPw">
			<h4 class="requiredEle">Password</h4>
			<input type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요." required />
		</div>
		
		<p>로그인 페이지로 이동하려면? <a href="/members/login.do">로그인</a></p>
		
		<div class="submit">
	        <button type="button" onclick="userLeave()">탈퇴하기</button>
	    </div>
	</div>
</body>
</html>