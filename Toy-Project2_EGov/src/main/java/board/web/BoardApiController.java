package board.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

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
public class BoardApiController {
	
	@Resource(name = "boardService")
	private BoardService boardService;
	
	
	/***
	 * 페이징
	 */
	@RequestMapping(value = "/pageLocation.do", method = RequestMethod.GET)
	public Map<String, Object> pageLocation(@RequestParam(name = "pageNum", defaultValue = "1") int pageNum,
											BoardVO boardVO,
											PageVO pageVO,
											Model model) {
		
		Map<String, Object> resultMap = new HashMap<>();
		System.out.println(pageNum);
		try {
			Map<String, Integer> map = new HashMap<>();

			map.put("pageNum", pageNum);
			model.addAttribute("pageNumber", pageNum);
			
			/* 한 페이지에 출력될 게시물 수 10개 */
			boardVO.setCurrentPrintBoardList(10);

			map.put("currentPrintBoardList", boardVO.getCurrentPrintBoardList());
			
			/* 출력될 게시물 범위 계산(rownum 이용) 및 리스트 가져오기 */
			List<BoardVO> listResult = boardService.selectBoardPrintList(map);

			resultMap.put("listResult", listResult);

		}catch(Exception e) {
			resultMap.put("error", e.getMessage());
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
	@RequestMapping(value = "/boardSave.do", method = RequestMethod.POST)
	public String insertBoard(@RequestBody BoardVO boardVO, HttpSession session) {
		
		String msg = "";
		
		try {
			String sessionID = (String) session.getAttribute("sessionID");
			
			if(!sessionID.equals("") || !sessionID.equals(null)) {
				String result = boardService.insertBoard(boardVO);
				
				if(result == null) {
					msg = "ok";
				}
			}
		} catch(Exception e) {
			System.out.println("boardSave error -> " + e.getMessage());
			
		}
		return msg;
	}
	
	
	/***
	 * 게시글 수정 호출
	 */
	@RequestMapping(value = "/updateBoard.do", method = RequestMethod.POST)
	public String updateBoard(@RequestBody BoardVO boardVO) {
		
		String msg = "";
		
		try {
			int result = boardService.updateBoard(boardVO);
			
			if(result == 1) {
				msg = "ok";
			}
			
		}catch(Exception e) {
			System.out.println("updateBoard error -> " + e.getMessage());
		}
		return msg;
	}
	
	
	/***
	 * 게시글 삭제 호출
	 */
	@RequestMapping(value = "/deleteBoard.do", method = RequestMethod.POST)
	public String deleteBoard(@RequestBody BoardVO boardVO) {
		
		String msg = "";
		
		try {
			int result = boardService.deleteBoard(boardVO.getIdx());
			
			if(result == 1) {
				msg = "ok";
			}
		}catch(Exception e) {
			System.out.println("deleteBoard error -> " + e.getMessage());
		}
		return msg;
	}
}