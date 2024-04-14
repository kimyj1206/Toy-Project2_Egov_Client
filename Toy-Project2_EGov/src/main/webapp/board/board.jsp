<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="javax.servlet.http.HttpSession" %>
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
<link rel="stylesheet" type="text/css" href="../css/board/board.css">
<title>게시판</title>
</head>
<%
	String sessionId = (String) session.getAttribute("sessionID");

	if(sessionId == null || sessionId == "") {
		response.sendRedirect("/members/login.do");
	}
%>
<script>
	var totalPage = ${totalPage};
</script>

<script src="../js/board/board.js"></script>

<body>
	<h1>게시판</h1>
	<div class="user-info">
		<a href="/members/mypage.do?ID=${sessionScope.sessionID}"><span id="user-id">${sessionScope.sessionID} 님!</span></a>
    </div>
	
	<div class="btn_group">
		<button type="button" class="btnGroup" onclick="boardWirte()">글 작성하기</button>
		<button type="button" class="btnGroup" onclick="loginGo()">로그인하기</button>
		<button type="button" class="btnGroup" onclick="logout()">로그아웃하기</button>
	</div>
	
    <div class="search">
		<select class="search_gubun" id="search_gubun">
			<option value="all" selected>-- 제목+내용 --</option>
			<option value="title">제목</option>
			<option value="content">내용</option>
		</select>
    
        <input type="text" name="searchContent" id="searchContent" placeholder="검색어를 입력하세요.">
        <button type="button" id="searchBtn" onclick="search(1)">검색</button>
    </div>


	<div class="sort">
		<select class="sort_gubun" id="sort_gubun">
			<option value="recent" selected>-- 최신순 --</option>
			<option value="past">과거순</option>
		</select>
	</div>
		
	<div class="size">
		<select class="size_gubun" id="size_gubun">
			<option value="10" selected>-- 10개씩 출력 --</option>
			<option value="20">20개씩 출력</option>
			<option value="30">30개씩 출력</option>
		</select>
	</div>	
		
	<table class="table table-bordered">
	  	<thead>
		    <tr>
			    <th width="13%">글 번호</th>
				<th width="34%">제목</th>
				<th width="15%">작성자</th>
				<th width="8%">첨부파일</th>
				<th width="17%">등록일</th>
				<th width="13%">조회수</th>
		    </tr>
	  	</thead>
	  	
	  	<tbody class="table-group-divider">
	  	
	  		<c:if test="${totalBoardList == 0}">
	    		<tr>
	    			<td colspan="6" style="text-align: center;">등록된 게시물이 없습니다.</td>
	    		</tr>
	    	</c:if>
	  	
			<c:if test="${!response.searchYN}">
			    <c:forEach items="${result}" var="result">
			    	<tr>
				      <td>${result.idx}</td>
				      <td><a href="/boards/detail.do?Idx=${result.idx}">${result.title}</a></td>
				      <c:choose>
				      	<c:when test="${result.anony eq '1'}">
				      		<td>${result.id}</td>
				      	</c:when>
				      	<c:when test="${result.anony eq '2'}">
				      		<td>익명</td>
				      	</c:when>
				      </c:choose>
				      <td>Y</td>
				      <td><fmt:formatDate pattern="yyyy-MM-dd" value="${result.rdate}" /></td>
				      <td>${result.hits}</td>
			    	</tr>
			    </c:forEach>
	    	</c:if>
	  	</tbody>
	</table>

	<nav aria-label="Page navigation example" class="pageGroup">
		<ul class="pagination justify-content-center">
			<%-- 이전 --%>
			<c:if test="${pageNum > 1}">
				<li class="page-item">
					<a class="page-link" href="/boards/list.do?pageNum=${pageNum -1}">이전</a>
				</li>
			</c:if>
			
	        <c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
	        	<li class="page-item">
	            	<a class="page-link pageNum" href="/boards/list.do?pageNum=${i}">${i}</a>
	            </li>
	        </c:forEach>

			<%-- 다음 --%>
			<c:if test="${pageNum < totalPage}">
				<li class="page-item">
					<a class="page-link" href="/boards/list.do?pageNum=${pageNum +1}">다음</a>
				</li>
			</c:if>
		</ul>
	</nav>
</body>
</html>