package board.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import board.service.BoardService;
import board.service.BoardVO;
import board.service.PageVO;
import board.service.SearchVO;

import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/api/v1/boards")
public class BoardApiController {
	
	/*@Resource(name = "boardService")*/
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private MultipartResolver multipartResolver;
	
	
	/***
	 * 게시물 검색 
	 */
	@RequestMapping(value = "/search.do", method = RequestMethod.GET)
	public Map<String, Object> search(@RequestParam("keyword") String keyword,
									  @RequestParam("searchGubun") String searchGubun,
									  @RequestParam("sortGubun") String sortGubun,
									  @RequestParam("pageNum") int pageNum,
									  @RequestParam("sizeGubun") int sizeGubun,
									  PageVO pageVO,
									  SearchVO searchVO,
									  Model model) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try{
			Map<String, Object> map = new HashMap<>();

			/* 한 페이지에 출력될 페이지 수 */
	        pageVO.setCurrentPrintPage(3);

			/* 한 페이지에 출력될 게시물 수 10개 */
			pageVO.setCurrentPrintBoardList(sizeGubun);
			
			map.put("keyword", keyword);
			map.put("searchGubun", searchGubun);
			map.put("sortGubun", sortGubun);
			
			int searchCnt = boardService.selectSearchKeywordCnt(map);
			
			/* 검색어 포함된 페이지 수(소수점 값이 있다면 올림 처리) */
			pageVO.setTotalPage((int) Math.ceil((double) searchCnt / pageVO.getCurrentPrintBoardList()));
			
			/* 시작 페이지 번호 */
			int startPage = ((pageNum - 1) / pageVO.getCurrentPrintPage()) * pageVO.getCurrentPrintPage() + 1;

			/* 끝 페이지 번호 */
			int endPage = Math.min(startPage + pageVO.getCurrentPrintPage() - 1, pageVO.getTotalPage());
			
			/* map에 검색어, 검색구분, 정렬순, 페이지 값(1)을 넣음 */
			Map<String, Object> param = new HashMap<>();
			
			param.put("keyword", keyword);
			param.put("searchGubun", searchGubun);
			param.put("sortGubun", sortGubun);
			param.put("pageNum", pageNum);
			param.put("currentPrintBoardList", pageVO.getCurrentPrintBoardList());
			
			/* 검색어 조회 */
			List<BoardVO> searchResult = boardService.selectSearchKeyword(param);

			/* 검색어가 없을 경우 searchResult에 빈 값이 들어감 */
			if(searchResult.isEmpty()) {
				resultMap.put("searchYN", false);
			}else {
				resultMap.put("searchYN", true);
				resultMap.put("searchResult", searchResult);
			}
			
			resultMap.put("startPage", startPage);
			resultMap.put("endPage", endPage);
			resultMap.put("pageNum", pageNum);
			resultMap.put("sizeGubun", sizeGubun);
			resultMap.put("searchCnt", searchCnt);
			
		} catch(Exception e) {
			System.out.println("search error -> " + e.getMessage());
		}
		
		return resultMap;
	}
	
	
	/***
	 * 게시글 작성
	 */
	@RequestMapping(value = "/create.do", method = RequestMethod.POST)
	public Map<String, String> insertBoard(@RequestPart(name = "data") BoardVO boardVO,
										   @RequestPart(name = "fileList", required = false) List<MultipartFile> fileList,
										   HttpSession session,
										   BindingResult error) {
	
		Map<String, String> resultMap = new HashMap<>();
		
		String sessionID = (String) session.getAttribute("sessionID");

		try {
			if(!sessionID.equals("") || !sessionID.equals(null)) {
				int result = boardService.insertBoard(boardVO, fileList);
				
				if(result == 1) {
					resultMap.put("success", "게시글 저장 성공했습니다.");
				} else {
					resultMap.put("fail", "게시글 저장 실패했습니다.");
				}
			}
 		} catch(Exception e) {
			System.out.println("insertBoard error -> " + e.getMessage());
			
		}
		return resultMap;
	}
	
	
	/***
	 * 게시글 수정
	 */
	@RequestMapping(value = "/update.do", method = RequestMethod.POST)
	public Map<String, String> updateBoard(@RequestBody BoardVO boardVO) {
		
		Map<String, String> resultMap = new HashMap<>();
		
		try {
			int result = boardService.updateBoard(boardVO);
			
			if(result == 1) {
				resultMap.put("success", "게시글 수정 성공했습니다.");
			} else {
				resultMap.put("fail", "게시글 수정 실패했습니다.");
			}
			
		} catch(Exception e) {
			System.out.println("updateBoard error -> " + e.getMessage());
		}
		return resultMap;
	}
	
	
	/***
	 * 게시글 삭제
	 */
	@RequestMapping(value = "/delete.do", method = RequestMethod.POST)
	public Map<String, String> deleteBoard(@RequestBody BoardVO boardVO) {
		
		Map<String, String> resultMap = new HashMap<>();
		
		try {
			int result = boardService.deleteBoard(boardVO.getIdx());
			
			if(result == 1) {
				resultMap.put("success", "게시글 삭제 성공했습니다.");
			} else {
				resultMap.put("fail", "게시글 삭제 실패했습니다.");
			}
			
		} catch(Exception e) {
			System.out.println("deleteBoard error -> " + e.getMessage());
		}
		return resultMap;
	}
}