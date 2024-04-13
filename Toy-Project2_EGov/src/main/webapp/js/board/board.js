	function boardWirte() {
		location.href = '/boards/write.do';
	}

	function loginGo() {
		location.href = '/members/login.do';
	}
	
	function logout() {
		location.href = '/index.do';
	}

	
	$(document).ready(function() {
		const urlParams = new URLSearchParams(window.location.search);
		const pageNum = urlParams.get("pageNum");
		
		$(".pageNum:contains(" + pageNum + ")").addClass("active");
		

	    // 페이징 버튼 클릭 이벤트 처리
		$(document).on("click", ".searchPageNum", function() {
	        let searchPageNum = $(this).text();
	        search(searchPageNum);
	    }); 
	    
	    // 이전 페이지 버튼 클릭 이벤트 처리
		$(document).on("click", ".searchPrev", function() {
	        let currentPage = parseInt($(".active .searchPageNum").text());
	        search(currentPage - 1);
	    });

	    // 다음 페이지 버튼 클릭 이벤트 처리
		$(document).on("click", ".searchNext", function() {
	        let currentPage = parseInt($(".active .searchPageNum").text());
	        search(currentPage + 1);
	    });
		 
	});
	

	function search(pageNum) {

		let keyword = $("#searchContent").val();
		let searchGubun = $("#search_gubun option:selected").val();
		let sortGubun = $("#sort_gubun option:selected").val();
		let sizeGubun = $("#size_gubun option:selected").val();

		$.ajax({
			type: 'GET',
			url: '/api/v1/boards/search.do?keyword=' + keyword + '&searchGubun=' + searchGubun + '&sortGubun=' + sortGubun + '&pageNum=' + pageNum + '&sizeGubun=' + sizeGubun, 
			dataType: 'json',
			contentType: 'application/json',
			success: function(resultMap) {
				console.log(resultMap);
			    if (resultMap.searchYN) {
			    	
			        // 기존 테이블의 행 지움 -> 이걸 안하면 원래의 테이블 밑으로 검색 결과가 추가됨
			        $("tbody").empty();
			        
			        // 검색 결과를 반복해서 테이블에 추가
			        $.each(resultMap.searchResult, function(index, searchResult) {
			            // 문자열 날짜를 JS 날짜 형태로 변환
			        	let date = new Date(searchResult.rdate);

			            // 표시할 날짜 형식 지정
			        	let formattedDate = date.getFullYear() + '-' + 
			                ('0' + (date.getMonth() + 1)).slice(-2) + '-' + 
			                ('0' + date.getDate()).slice(-2);

			            // 테이블 행 구성
			        	let row = "<tr>" +
			                "<td>" + searchResult.idx + "</td>" +
			                "<td><a href='/boards/detail.do?Idx=" + searchResult.idx + "'>" + searchResult.title + "</a></td>" +
			                "<td>" + (searchResult.anony === '1' ? searchResult.userId : '익명') + "</td>" +
			                "<td>" + formattedDate + "</td>" +
			                "<td>" + searchResult.hits + "</td>" +
			                "</tr>";

			            // 테이블에 행 추가
			            $("tbody").append(row);
			        });
			        

			        
			        let pageNum = resultMap.pageNum;
	                let startPage = resultMap.startPage;
	                let endPage = resultMap.endPage;
	                let pagination = document.querySelector('.pageGroup ul.pagination');

	                // 기존에 있던 페이지 번호 요소들 지움
	                pagination.innerHTML = '';

	                if (pageNum > 1) {
	                    pagination.innerHTML += '<li class="page-item">' +
	                        '<a class="page-link searchPrev">이전</a>' +
	                        '</li>';
	                }

	                for (let i = startPage; i <= endPage; i++) {
	                    if (i == pageNum) {
	                        pagination.innerHTML += '<li class="page-item active">' +
	                            '<a class="page-link searchPageNum">' + i + '</a>' +
	                            '</li>';
	                    } else {
	                        pagination.innerHTML += '<li class="page-item">' +
	                            '<a class="page-link searchPageNum">' + i + '</a>' +
	                            '</li>';
	                    }
	                }

	                if (pageNum < endPage) {
	                    pagination.innerHTML += '<li class="page-item">' +
	                        '<a class="page-link searchNext">다음</a>' +
	                        '</li>';
	                }
	                
	                
	                
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
