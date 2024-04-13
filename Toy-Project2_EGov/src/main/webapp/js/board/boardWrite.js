	/** 게시글 작성 */
	function btnSubmit() {
		$.ajax({
			type : "POST",
			url : "/api/v1/boards/create.do",
			data : JSON.stringify({
				"title": $("#title").val(),
				"content": $("#content").val(),
				"userId": "${sessionScope.sessionID}",
				"anony": $("#anony").val(),
				"hits": $("#hits").val()
			}),
			dataType : "json",
			contentType: 'application/json',
			success : function(data) {
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
	
	
	/** 파일 추가 */
	$(document).on('click', '.addFiles', function() {
		let fileCnt = $('.file').length;
		
		fileCnt++;
		
		// 첨부파일 3개 제한
		if(fileCnt > 2) {
			alert('첨부파일은 최대 3개만 등록 가능합니다.');
		}else {
			$('.files').after('<div><input type="file" name="file" class="file"></div');
		}
	})
	
	/** 파일 삭제 */
	$(document).on('click', '.removeFiles', function() {
		$('.file').last().remove();
	})