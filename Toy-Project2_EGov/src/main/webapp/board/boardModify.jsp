<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<link rel="stylesheet" type="text/css" href="../css/board/boardModify.css">
<title>게시글 조회</title>
</head>

<script src="../js/board/boardModify.js"></script>

<body>
	<h1>게시글 조회</h1>
	
	<div>      
		<div class="input-group">
			<span class="input-group-text">작성자</span>
			
			<c:choose>
				<c:when test="${result.anony eq '1'}">
  					<input type="text" name="id" id="id" aria-label="First name" class="form-control" readonly value="${result.id}" />
  				</c:when>
  				<c:when test="${result.anony eq '2'}">
					<input type="text" aria-label="First name" class="form-control" class="anony" readonly value="익명" />
				</c:when>
  			</c:choose>
  			
  			<span class="input-group-text">작성일자</span>
 			<input type="text" aria-label="Last name" class="form-control" readonly value="<fmt:formatDate pattern="yyyy-MM-dd" value="${result.rdate}" />">
		</div>
		
		<div class="form-floating">
		  	<textarea class="form-control" id="title" name="title" required>${result.title}</textarea>
		  	<label for="title" class="requiredEle" id="label">제목</label>
		</div>
		
		<div class="form-floating">
	 		<textarea class="form-control" id="content" name="content" required style="height: 150px;">${result.content}</textarea>
	  		<label for="content" class="requiredEle" id="label">내용</label>
		</div>
		
		<c:if test="${sessionID == result.id}">
			<div class="form-check">	
	  			<select class="form-select" name="anony" id="anony">
				  <option value="1" selected>아이디 게시</option>
				  <option value="2">익명 게시</option>
				</select>
			</div>
		</c:if>
		
		<!-- 첨부 파일이 여부에 따라서 파일 리스트 or 첨부 파일 없음 문구 노출되게 -->
		<div class="fileList">
			<span>첨부파일</span>
		</div>

		<input type="text" name="idx" id="idx" hidden value="${result.idx}" />
		<input type="text" name="hits" id="hits" hidden value="${result.hits}" />
	</div>
	
	<c:if test="${sessionID == result.id}">
		<div class="btn_submit">
			<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal1">수정하기</button>
			<!-- 수정 modal -->
			<div class="modal fade" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title fs-5" id="exampleModalLabel">게시물 수정하기</h1>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">해당 게시물을 수정하시겠습니까?</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
							<button type="button" class="btn btn-primary" onclick="btnUpdate()">수정하기</button>
						</div>
					</div>
				</div>
			</div>
			
			<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">삭제하기</button>
			<!-- 삭제 modal -->
			<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h1 class="modal-title fs-5" id="exampleModalLabel">게시물 삭제하기</h1>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">해당 게시물을 삭제하시겠습니까?</div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			        <button type="button" class="btn btn-primary" onclick="btnDelete()">삭제하기</button>
			      </div>
			    </div>
			  </div>
			</div>
			
			<button type="button" class="btn btn-primary btn-back" onclick="history.go(-1)">목록으로</button>
		</div>
	</c:if>
</body>
</html>