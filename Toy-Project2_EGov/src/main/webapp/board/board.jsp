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
<link rel="stylesheet" type="text/css" href="css/board/board.css">
<title>게시판</title>
</head>
<%
	String sessionId = (String) session.getAttribute("sessionID");

	if(sessionId == null || sessionId == "") {
		response.sendRedirect("/authLogin.do");
	}
%>
<script>
	function boardWirte() {
		location.href = '/boardWrite.do';
	}

	function loginGo() {
		location.href = '/authLogin.do';
	}
	
	function logout() {
		location.href = '/main.do';
	}

	/* 페이징 */
	$(document).ready(function() {
		$(".pageNum:contains('1')").addClass("active");
		
		var clickedPageNum;

		$(".pageNum").click(function(e) {
			
			$(".page-link").removeClass("active");
			$(this).addClass("active");
			
			clickedPageNum = $(this).text();

			fetchPageData(clickedPageNum);
		})
		
		/* prev */
		$(".prev").click(function(e) {
			var currentPageNum = $(".active").text();

			if(currentPageNum != "" && currentPageNum > 1) {
				var previousPageNum = currentPageNum - 1;

	            $(".page-link").removeClass("active");
	            $(".pageNum:contains(" + previousPageNum + ")").addClass("active");
	            
	            fetchPageData(previousPageNum);
			} else {
				alert('첫 페이지입니다.');
			}
		})
		
		/* next */
		$(".next").click(function(e) {
			var currentPageNum = $(".active").text();

			var nextPageNum = Number(currentPageNum) + 1;

			if(nextPageNum <= ${totalPage}) {
	            $(".page-link").removeClass("active");
	            $(".pageNum:contains(" + nextPageNum + ")").addClass("active");
	            
	            fetchPageData(nextPageNum);
			} else {
				alert('마지막 페이지입니다.');
			}
		})
		
		
		function fetchPageData(pageNum) {
			$.ajax({
				type: 'get',
				url: 'pageLocation.do?pageNum=' + pageNum,
				dataType: 'json',
				contentType: 'application/json',
				success: function(resultMap) {

					$(".next").on('click', function() {
						var refStart = resultMap.refreshStartPage;
						var refEnd = resultMap.refreshEndPage;
						var totalPage = ${totalPage};
						var currentPage = resultMap.pageNum;
						var nextPageNum = currentPage + 1;

						// 현재 페이지가 끝 페이지일 때만 동작
						if (currentPage == refEnd) {
							var newStart = Math.min(refStart + 3, totalPage);
							var newEnd = Math.min(refEnd + 3, totalPage);

							// 새로운 페이지 번호로 갱신
							$(".pageNum").each(function(index) {
								var pageNum = newStart + index;

								if (pageNum <= totalPage) {
									$(this).text(pageNum);
									$(this).show();
								} else {
									$(this).hide();
								}
							});

							// refreshStartPage와 refreshEndPage 값도 갱신
							resultMap.refreshStartPage = newStart;
							resultMap.refreshEndPage = newEnd;
							/* console.log(resultMap); */
							$(".page-link").removeClass("active");
							$(".pageNum:contains(" + nextPageNum + ")").addClass("active");
						}
					});
					
					$(".prev").on('click', function() {
					    var currentPageNum = resultMap.pageNum;
					    var prevPageNum = Math.max(currentPageNum - 1, 1); // 이전 페이지
					    var newStart = Math.max(prevPageNum - 1, 1); // 새로운 시작 페이지
					    var newEnd = newStart + 1; // 새로운 끝 페이지

					    // 새로운 페이지 번호로 갱신
					    $(".pageNum").each(function(index) {
					        var pageNum = newStart + index;

					        if (pageNum <= ${totalPage}) {
					            $(this).text(pageNum);
					            $(this).show();
					        } else {
					            $(this).hide();
					        }
					    });
					    
					    $(".page-link").removeClass("active");
					    $(".pageNum:contains(" + prevPageNum + ")").addClass("active");
					});

					// 기존 테이블의 행을 지움 -> 이걸 안하면 원래의 테이블 밑으로 결과가 추가됨
			        $("tbody").empty();

			        // 검색 결과를 반복해서 테이블에 추가
			        $.each(resultMap.listResult, function(index, listResult) {
			            // 문자열 날짜를 JS 날짜 형태로 변환
			            var date = new Date(listResult.rdate);

			            // 표시할 날짜 형식 지정
			            var formattedDate = date.getFullYear() + '-' + 
			                ('0' + (date.getMonth() + 1)).slice(-2) + '-' + 
			                ('0' + date.getDate()).slice(-2);

			            // 테이블 행 구성
			            var row = "<tr>" +
			                "<td>" + listResult.idx + "</td>" +
			                "<td><a href='boardModify.do?Idx=" + listResult.idx + "'>" + listResult.title + "</a></td>" +
			                "<td>" + (listResult.anony === '1' ? listResult.userId : '익명') + "</td>" +
			                "<td>" + formattedDate + "</td>" +
			                "<td>" + listResult.hits + "</td>" +
			                "</tr>";

			            // 테이블에 행 추가
			            $("tbody").append(row);
			        });
				},
				error: function(xhr, status, error) {
					console.log("code : " + xhr.status + "\n" + "message : " + xhr.responseText + "\n" + "error : " + error);
					alert('시스템 에러 발생하였습니다. 관리자에게 연락해주세요.');
				}
			});
		}
		
	});
	
	function search() {
		var param = $("#searchContent").val();
		var searchGubun = $("#search_gubun option:selected").val();
		var sortGubun = $("#sort_gubun option:selected").val();

		$.ajax({
			type: 'get',
			url: 'search.do?keyword=' + param + '&searchGubun=' + searchGubun + '&sortGubun=' + sortGubun, 
			dataType: 'json',
			contentType: 'application/json',
			success: function(response) {
			    if (response.searchYN) {
			        // 기존 테이블의 행을 지움 -> 이걸 안하면 원래의 테이블 밑으로 검색 결과가 추가됨
			        $("tbody").empty();

			        // 검색 결과를 반복해서 테이블에 추가
			        $.each(response.searchResult, function(index, searchResult) {
			            // 문자열 날짜를 JS 날짜 형태로 변환
			            var date = new Date(searchResult.rdate);

			            // 표시할 날짜 형식 지정
			            var formattedDate = date.getFullYear() + '-' + 
			                ('0' + (date.getMonth() + 1)).slice(-2) + '-' + 
			                ('0' + date.getDate()).slice(-2);

			            // 테이블 행 구성
			            var row = "<tr>" +
			                "<td>" + searchResult.idx + "</td>" +
			                "<td><a href='boardModify.do?Idx=" + searchResult.idx + "'>" + searchResult.title + "</a></td>" +
			                "<td>" + (searchResult.anony === '1' ? searchResult.userId : '익명') + "</td>" +
			                "<td>" + formattedDate + "</td>" +
			                "<td>" + searchResult.hits + "</td>" +
			                "</tr>";

			            // 테이블에 행 추가
			            $("tbody").append(row);
			        });
			    } else {
			       alert('입력하신 검색어를 포함한 게시물이 없습니다.');
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
	<h1>게시판</h1>
	<div class="user-info">
		<a href="/userInfo.do?ID=${sessionScope.sessionID}"><span id="user-id">${sessionScope.sessionID} 님!</span></a>
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
        <button type="button" onclick="search()">검색</button>
    </div>


	<div class="sort">
		<select class="sort_gubun" id="sort_gubun">
			<option value="recent" selected>-- 최신순 --</option>
			<option value="past">과거순</option>
		</select>
	</div>
		
	<table class="table table-bordered">
	  	<thead>
		    <tr>
			    <th width="13%">글 번호</th>
				<th width="40%">제목</th>
				<th width="17%">작성자</th>
				<th width="17%">등록일</th>
				<th width="13%">조회수</th>
		    </tr>
	  	</thead>
	  	
	  	<tbody class="table-group-divider">
			<c:if test="${!response.searchYN}">
			    <c:forEach items="${result}" var="result">
			    	<tr>
				      <td>${result.idx}</td>
				      <td><a href="boardModify.do?Idx=${result.idx}">${result.title}</a></td>
				      <c:choose>
				      	<c:when test="${result.anony eq '1'}">
				      		<td>${result.userId}</td>
				      	</c:when>
				      	<c:when test="${result.anony eq '2'}">
				      		<td>익명</td>
				      	</c:when>
				      </c:choose>
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
			<li class="page-item">
				<a class="page-link prev">&lt;</a>
			</li>

			<c:forEach var="page" begin="${startPage}" end="${endPage}" step="1">
	        	<li class="page-item">
	            	<a class="page-link pageNum">${page}</a>
	            </li>
	        </c:forEach>

			<%-- 다음 --%>
			<li class="page-item">
				<a class="page-link next">&gt;</a>
			</li>

		</ul>
	</nav>
</body>
</html>