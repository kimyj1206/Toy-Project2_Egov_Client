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
	
	function info() {
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
				url: '/api/v1/members/find.do',
				success: function(data) {
					if(data.success) {
						alert(data.success);
						$("#idResult").show();
						$("#id1").val(data.id.id);
						$("#phoneResult").hide();
					}else {
						/* 조건에 맞는 아이디가 없다면 팝업 노출 */
						alert(data.fail);
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
				url: '/api/v1/members/find.do',
				success: function(data) {
					if(data.success) {
						alert(data.success);
						$("#phoneResult").show();
						$("#id2").val(data.id.id);
						$("#idResult").hide();
					}else {
						/* 조건에 맞는 아이디가 없다면 팝업 노출 */
						alert(data.fail);
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
		location.href = '/members/login.do';
	}