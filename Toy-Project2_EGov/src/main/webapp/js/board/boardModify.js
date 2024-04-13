	/** 게시글 수정 */
	function btnUpdate() {
		$.ajax({
			type: "post",
			url: "/api/v1/boards/update.do",
			data: JSON.stringify({
				"title": $("#title").val(),
				"content": $("#content").val(),
				"userId": "${result.userId}",
				"anony": $("#anony").val(),
				"hits": $("#hits").val(),
				"idx": "${result.idx}"
			}),
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
	
	/** 게시글 삭제 */
	function btnDelete() {
		$.ajax({
			type: "post",
			url: "/api/v1/boards/delete.do",
			data: JSON.stringify({
				"title": $("#title").val(),
				"content": $("#content").val(),
				"userId": "${result.userId}",
				"anony": $("#anony").val(),
				"hits": $("#hits").val(),
				"idx": "${result.idx}"
			}),
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