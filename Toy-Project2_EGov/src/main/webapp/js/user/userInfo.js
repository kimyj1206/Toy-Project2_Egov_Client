	function userCheck() {
		/* 비밀번호 체크로 회원 검증 */
		$.ajax({
			type: 'POST',
			url: '/api/v1/members/mypage/validate-pw.do',
			data: JSON.stringify({
				"id": $("#id").val(),
				"password": $("#password").val() 
			}),
			dataType: 'json',
			contentType: 'application/json',
			success: function(data) {
				if(data.success) {
					alert(data.success);
					$("#password").data("value", true);
					$("#password").attr("readonly", true);
				} else {
					alert(data.fail);
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
				type: 'POST',
				url: '/api/v1/members/mypage/update.do',
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
						alert(data.success);
						location.href = "/members/login.do";
					} else {
						alert(data.fail);
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