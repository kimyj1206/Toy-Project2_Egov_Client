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