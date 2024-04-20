	/** 게시글 작성 */
	function btnSubmit() {
		
		const formData = new FormData;
		
		const data = {
			"title": $("#title").val(),
			"content": $("#content").val(),
			"id": $("#id").val(),
			"anony": $("#anony").val(),
			"hits": $("#hits").val()
		};
		
		const _data = new Blob([JSON.stringify(data)], {type: "application/json"});
		formData.append("data", _data);
		
		let uploadFileList = $("input[name='uploadFiles']");
		
		for(let i = 0; i < uploadFileList.length; i++) {
			let fileList = uploadFileList[i].files;
			
			for(let j = 0; j < fileList.length; j++) {
				let file = fileList[j];
				formData.append("fileList", file);
			}
		}

		$.ajax({
			type : "POST",
			url : "/api/v1/boards/create.do",
			contentType: false,
			processData: false,
			data : formData,
			success : function(data) {
				if(data.success) {
					alert(data.success);
					location = "/boards/list.do?pageNum=1";
				} else {
					alert(data.fail);
				}
			},
			error: function(xhr, status, error) {
				/*console.log("code : " + xhr.status + "\n" + "message : " + xhr.responseText + "\n" + "error : " + error);*/
				alert('시스템 에러 발생하였습니다. 관리자에게 연락해주세요.');
			}
		});
	}
	
	
	/** 파일 추가 */
	$(document).on('click', '.addFiles', function() {
		let fileCnt = $('.file').length + 1;

		// 첨부파일 3개 제한
		if(fileCnt >= 3) {
			alert('첨부파일은 최대 3개만 등록 가능합니다.');
		}else {
			let fileId = "fileList" + (fileCnt + 1);
		    let fileListHtml = '<div><input type="file" name="uploadFiles" id="' + fileId + '" class="file"></div>';
		    
		    $('.files').after(fileListHtml);
		}
	})
	
	/** 파일 삭제 */
	$(document).on('click', '.removeFiles', function() {
		$('.file').last().remove();
	})