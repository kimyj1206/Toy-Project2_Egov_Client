package board.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import board.service.BoardService;
import board.service.BoardVO;
import board.service.PageVO;

import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/api/v1/boards")
public class BoardApiController {
	
	/*@Resource(name = "boardService")*/
	@Autowired
	private BoardService boardService;
	
	
	/***
	 * 페이징
	 */
	@RequestMapping(value = "/page.do", method = RequestMethod.GET)
	public Map<String, Object> pageLocation(@RequestParam(name = "pageNum", defaultValue = "1") int pageNum,
											PageVO pageVO,
											Model model) {
		
		Map<String, Object> resultMap = new HashMap<>();

		try {
			Map<String, Integer> map = new HashMap<>();

			/* 한 페이지에 출력될 페이지 수 */
	        pageVO.setCurrentPrintPage(3);

			/* 한 페이지에 출력될 게시물 수 10개 */
			pageVO.setCurrentPrintBoardList(10);
			
			/* 전체 페이지 수(소수점 값이 있다면 올림 처리) */
			pageVO.setTotalPage((int) Math.ceil((double) boardService.selectBoardCnt() / pageVO.getCurrentPrintBoardList()));
			
			/* 시작 페이지 번호 */
			int startPage = ((pageNum - 1) / pageVO.getCurrentPrintPage()) * pageVO.getCurrentPrintPage() + 1;

			/* 끝 페이지 번호 */
			int endPage = Math.min(startPage + pageVO.getCurrentPrintPage() - 1, pageVO.getTotalPage());

	        map.put("pageNum", pageNum);
	        map.put("currentPrintBoardList", pageVO.getCurrentPrintBoardList());
	        
			/* 출력될 게시물 범위 계산(rownum 이용), 리스트 가져오기 */
			List<BoardVO> listResult = boardService.selectBoardPrintList(map);

			resultMap.put("listResult", listResult);
			resultMap.put("refreshStartPage", startPage);
			resultMap.put("refreshEndPage", endPage);
			resultMap.put("pageNum", pageNum);
			
		}catch(Exception e) {
			System.out.println("pageLocation error -> " + e.getMessage());
		}

		return resultMap;
	}
	
	
	/***
	 * 게시물 검색 
	 */
	@RequestMapping(value = "/search.do", method = RequestMethod.GET)
	public Map<String, Object> search(@RequestParam("keyword") String keyword,
									  @RequestParam("searchGubun") String searchGubun,
									  @RequestParam("sortGubun") String sortGubun,
									  Model model) {
		
		Map<String, Object> response = new HashMap<>();
		
		try{
			/* map에 검색어, 검색구분, 정렬순을 넣음 */
			Map<String, String> param = new HashMap<>();
			param.put("keyword", keyword);
			param.put("searchGubun", searchGubun);
			param.put("sortGubun", sortGubun);
			
			/* 검색어 조회 */
			List<BoardVO> searchResult = boardService.selectSearchKeyword(param);

			/* 검색어가 없을 경우 searchResult에 빈 값이 들어감 */
			if(searchResult.isEmpty()) {
				 response.put("searchYN", false);
			}else {
				response.put("searchYN", true);
				response.put("searchResult", searchResult);
			}
			
		}catch(Exception e) {
			System.out.println("search error -> " + e.getMessage());
		}
		
		return response;
	}
	
	
	/***
	 * 게시글 작성
	 */
	@RequestMapping(value = "/create.do", method = RequestMethod.POST)
	public Map<String, Object> insertBoard(@RequestBody BoardVO boardVO, HttpSession session) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			String sessionID = (String) session.getAttribute("sessionID");
			
			if(!sessionID.equals("") || !sessionID.equals(null)) {
				String result = boardService.insertBoard(boardVO);
				
				if(result == null) {
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
	 * 게시글 수정 호출
	 */
	@RequestMapping(value = "/update.do", method = RequestMethod.POST)
	public Map<String, Object> updateBoard(@RequestBody BoardVO boardVO) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			int result = boardService.updateBoard(boardVO);
			
			if(result == 1) {
				resultMap.put("success", "게시글 수정 성공했습니다.");
			} else {
				resultMap.put("fail", "게시글 수정 실패했습니다.");
			}
			
		}catch(Exception e) {
			System.out.println("updateBoard error -> " + e.getMessage());
		}
		return resultMap;
	}
	
	
	/***
	 * 게시글 삭제 호출
	 */
	@RequestMapping(value = "/delete.do", method = RequestMethod.POST)
	public Map<String, Object> deleteBoard(@RequestBody BoardVO boardVO) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			int result = boardService.deleteBoard(boardVO.getIdx());
			
			if(result == 1) {
				resultMap.put("success", "게시글 삭제 성공했습니다.");
			} else {
				resultMap.put("fail", "게시글 삭제 실패했습니다.");
			}
			
		}catch(Exception e) {
			System.out.println("deleteBoard error -> " + e.getMessage());
		}
		return resultMap;
	}
}