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
<link rel="stylesheet" type="text/css" href="../css/board/boardWrite.css">
<title>게시글 작성</title>
</head>
<script>
	function btnSubmit() {
		$.ajax({
			type : "post",
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
					location = "/boards/list.do";
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
</script>
<body>
	<h1>게시글 작성</h1>
	
	<form id="frm">
		<div class="form-floating">
		  	<textarea class="form-control" placeholder="제목을 입력해주세요." id="title" name="title" required></textarea>
		  	<label for="title" class="requiredEle">제목</label>
		</div>
		
		<div class="form-floating">
	 		<textarea class="form-control" placeholder="내용을 입력해주세요." id="content" style="height: 100px" name="content" required></textarea>
	  		<label for="content" class="requiredEle">내용</label>
		</div>
		
		<div class="files">
			<span class="form-floating">
	            <input type="file" name="file1">
	        </span>
	        
	        <span class="form-floating">
	            <input type="file" name="file2">
	        </span>
		</div>
       
		<div class="anony-check">	
  			<select class="form-select" name="anony" id="anony">
			  <option value="1" selected>아이디 게시</option>
			  <option value="2">익명 게시</option>
			</select>
		</div>
		
		<div>
			<input type="hidden" id="hits" name="hits" value="0" />
			<input type="hidden" id="userId" name="userId" value="${sessionScope.sessionID}" />
		</div>
	</form>
	
	<div class="btn_group">
		<button type="button" class="btn btn-primary btnSave" onclick="btnSubmit()">저장하기</button>
		<button type="button" class="btn btn-primary btnBack" onclick="history.go(-1)">목록으로</button>
	</div>
</body>
</html>