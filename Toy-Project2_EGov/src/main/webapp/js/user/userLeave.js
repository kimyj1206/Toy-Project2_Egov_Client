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