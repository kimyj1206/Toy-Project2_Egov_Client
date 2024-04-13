	/* 아이디 중복 체크 */
	function duplicatedID () {
		var userId = $("#id").val();

		$.ajax({
			type: 'post',
			url: '/api/v1/members/duplicate-check/' + userId + '.do',
			dataType: 'json',
			contentType: 'application/json',
			success: function(data) {
				if(data.success) {
					alert(userId + '은/는 ' + data.success);
					$("#id").data("value", true);
				}else {
					alert(userId + '은/는 ' + data.fail);
					$("#id").val("");
				}
			},
			error: function(xhr, status, error) {
				console.log("code : " + xhr.status + "\n" + "message : " + xhr.responseText + "\n" + "error : " + error);
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
				url : "/api/v1/members/signup.do",
				dataType : "json",
				contentType: 'application/json',
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
			});
		} else {
			alert('유효하지 않는 필드가 포함되어 있습니다. 다시 작성해주세요.');
		}
	}