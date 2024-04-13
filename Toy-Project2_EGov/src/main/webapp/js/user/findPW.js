	/* 비밀번호 초기화 전 아이디 찾기 */
	function idCheck() {
		var userId = $("#id").val();
		
		$.ajax({
			type: 'get',
			url: '/api/v1/members/validate/' + userId + '.do',
			dataType: 'json',
			contentType: 'application/json',
			success: function(data) {
				if(data.success) {
					alert(data.success);
					$("#pwResult").show();					
				} else {
					alert(data.fail);
				}
			},
			error: function(xhr, status, error) {
				console.log("code : " + xhr.status + "\n" + "message : " + xhr.responseText + "\n" + "error : " + error);
				alert('시스템 에러 발생하였습니다. 관리자에게 연락해주세요.');
			}
		})
	}

	/* 비밀번호 초기화 */
	function resetPw() {
		$.ajax({
			type: 'post',
			data: JSON.stringify({
				"id": $("#id").val(),
				"password": $("#password").val()
			}),
			dataType: 'json',
			contentType: 'application/json',
			url: '/api/v1/members/reset-pw.do',
			success: function(data) {
				if(data.success) {
					alert(data.success);
					location = '/members/login.do';
				} else {
					alert(data.fail);
				}
			},
			error: function(xhr, status, error) {
				console.log("code : " + xhr.status + "\n" + "message : " + xhr.responseText + "\n" + "error : " + error);
				alert('시스템 에러 발생하였습니다. 관리자에게 연락해주세요.');
			}
		})
	}