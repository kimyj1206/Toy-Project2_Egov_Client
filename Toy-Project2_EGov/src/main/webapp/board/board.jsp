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
<title>게시판</title>
<style>
	* {
		margin: 0;
    	padding: 0;
		text-align: center;
		font-family: 'Nanum Myeongjo', serif;
	}
	h1 {
		padding: 20px;
	}
	.btn_group {
		position: fixed;
		top: 15px;
  		right: 20px;
		padding-bottom: 20px;
	}
	.btnGroup {
		background-color: #5AC8C8;
	    color: white;
	    border-radius: 5px;
	    outline: none;
	    border: 0;
	    padding: 8px;
	}
	a {
		text-decoration: none;
		color: #464646;
		font-weight: bold;
	}
	.user-info {
    	position: fixed;
    	top: 15px;
    	left: 20px;
    	display: flex;
    	align-items: center;
	}
	#user-id {
   	 	margin-left: 15px;
   	 	font-size: 18px;
    	font-weight: bold;
    	color: #0000FF;
	}
	.search {
	  width: 400px;
	  height: 40px;
	  float: right;
	  margin: 0 18px 8px 0;
	  display: flex;
  	  align-items: center;
	}
	.search_gubun {
	  margin-right: 10px;
	}
	.sort {
	  width: 400px;
	  height: 40px;
	  float: right;
	  display: flex;
  	  align-items: center;
	}
	.sort_gubun {
	  margin-left: 220px;
	}
	.search input {
	  width: 60%;
	  height: 30px;
	  font-size: 18px;
	  border: none;
	  border-bottom: 1px black solid;
	  margin-right: 10px;
	}
	.search button {
	  font-size: 18px;
	  border: none;
	  background-color: #FFCC00;
	  width: 80px;
	  height: 30px;
	  border-radius: 11px;
	  color: #333333;
	  cursor: pointer;
	}
	select {
	  width: 170px;
	  height: 30px;
  	  -moz-appearance: none;
  	  -webkit-appearance: none;
  	  appearance: none;
  	  font-size: 1rem;
  	  font-weight: 400;
  	  line-height: 1.5;
  	  color: #444;
  	  background-color: #fff;
  	  border: 1px solid #aaa;
  	  border-radius: .3em;
  	  box-shadow: 0 1px 0 1px rgba(0,0,0,.04);
	}
	select:hover {
	  border-color: #888;
	}
	select:focus {
	  border-color: #aaa;
	  box-shadow: 0 0 1px 3px rgba(59, 153, 252, .7);
	  box-shadow: 0 0 0 3px -moz-mac-focusring;
	  color: #222;
	  outline: none;
	}
	select:disabled {
  	  opacity: 0.5;
	}
	.pageGroup {
	  margin-top: 40px; 
	}
	.page-link.active {
	  color: #CCFFFF;
	}
</style>
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
			    }else {
			       alert('입력하신 검색어를 포함한 게시물이 없습니다.');
			    }
			},
			error: function(xhr, status, error) {
				console.log("code : " + xhr.status + "\n" + "message : " + xhr.responseText + "\n" + "error : " + error);
				alert('시스템 에러 발생하였습니다. 관리자에게 연락해주세요.');
			}
		});
	}

	/* 페이징 */
	$(document).ready(function() {
		var clickedPageNum;
		
		/* page number */
		$(".pageBtn").click(function(e) {
			
			$(".page-link").removeClass("active");
			$(this).addClass("active");
			
			e.preventDefault(); // 페이지 이동 방지
			
			clickedPageNum = $(this).text();

			fetchMainData();
		});
		
		/* previous */
		$(".previous").click(function(e) {
			var currentPageNum = $(".active").text();

			if(currentPageNum != "" && currentPageNum > 1) {
				var previousPageNum = currentPageNum - 1;
				
				// 이전 페이지 클릭 시 .active 클래스 설정
	            $(".page-link").removeClass("active");
	            $(".pageBtn:contains(" + previousPageNum + ")").addClass("active");
				
				fetchSideData(previousPageNum);
			}else {
				alert('첫 페이지입니다.');
			}
		});
		
		/* next */
		$(".next").click(function(e) {
			var currentPageNum = $(".active").text();

			if(currentPageNum != "" && currentPageNum > 1) {
				var nextPageNum = currentPageNum + 1;
				
				// 이전 페이지 클릭 시 .active 클래스 설정
	            $(".page-link").removeClass("active");
	            $(".pageBtn:contains(" + previousPageNum + ")").addClass("active");
				
				// 1 페이지에서 다음 클릭 시 4 5 6 이 보이게 하도록 설정
				
			}else {
				alert('마지막 페이지입니다.');
			}
		});
		
		function fetchMainData() {
			$.ajax({
				type: 'get',
				url: 'pageLocation.do?pageNum=' + clickedPageNum,
				dataType: 'json',
				contentType: 'application/json',
				success: function(resultMap) {
					// 기존 테이블의 행을 지움 -> 이걸 안하면 원래의 테이블 밑으로 검색 결과가 추가됨
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
		
		
		function fetchSideData(previousPageNum) {
			$.ajax({
				type: 'get',
				url: 'pageLocation.do?pageNum=' + previousPageNum,
				dataType: 'json',
				contentType: 'application/json',
				success: function(resultMap) {
					// 기존 테이블의 행을 지움 -> 이걸 안하면 원래의 테이블 밑으로 검색 결과가 추가됨
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
				<a class="page-link previous">&lt;</a>
			</li>

						
			<c:choose>
				<%-- 한 페이지에 출력되는 페이지 수(3)보다 총 페이지 수가 더 많을 경우 > 1부터 3까지만 --%>
			    <c:when test="${totalPage >= currentPrintPage}">
			        <c:forEach var="page" begin="1" end="${currentPrintPage}" step="1">
			            <li class="page-item">
			            	<a class="page-link pageBtn">${page}</a>
			            </li>
			        </c:forEach>
			    </c:when>
			    <%-- 총 페이지 수보다 한 페이지에 출력되는 페이지 수(3)가 더 많을 경우 > 1부터 ~ --%>
			    <c:when test="${totalPage <= currentPrintPage}">
			        <c:forEach var="page" begin="${startPage}" end="${endPage}" step="1">
			            <li class="page-item">
			            	<a class="page-link">${page}</a>
			            </li>
			        </c:forEach>
			    </c:when>
			</c:choose>


			<%-- 다음 --%>
			<li class="page-item">
				<a class="page-link next">&gt;</a>
			</li>

		</ul>
	</nav>
</body>
</html>