package board.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import board.service.BoardService;
import board.service.BoardVO;
import board.service.PageVO;

@Controller
@RequestMapping("/boards")
public class BoardViewController {

	/*@Resource(name = "boardService")*/
	@Autowired
	private BoardService boardService;
	
	
	/***
	 * 게시판 jsp 호출 및 페이징
	 */
	@RequestMapping(value = "/list.do", method = RequestMethod.GET)
	public String selectBoard(@RequestParam("pageNum") int pageNum,
													   PageVO pageVO,
													   Model model) {
		
		try{
			// 한 페이지에 출력될 페이지 수 
			pageVO.setCurrentPrintPage(3);
			
			// 한 페이지에 출력될 게시물 수 
			pageVO.setCurrentPrintBoardList(10);
			
			// 게시글 조회 
			List<BoardVO> result = boardService.selectBoard(pageVO);
			
			// 게시물 총 개수 
			int totalBoardList = boardService.selectBoardCnt();
			
			// 전체 페이지 수(소수점 값이 있다면 올림 처리) 
			pageVO.setTotalPage((int) Math.ceil((double) totalBoardList / pageVO.getCurrentPrintBoardList()));
			
			// 시작 페이지 번호
			pageVO.setStartPage(Math.max(1, Math.min(pageVO.getPageNum(), pageVO.getTotalPage() - pageVO.getCurrentPrintPage() + 1)));

			// 끝 페이지 번호
			pageVO.setEndPage(Math.min(pageVO.getTotalPage(), pageVO.getStartPage() + pageVO.getCurrentPrintPage() - 1));

			model.addAttribute("currentPrintPage", pageVO.getCurrentPrintPage());
			model.addAttribute("result", result);
			model.addAttribute("totalBoardList", totalBoardList);
			model.addAttribute("totalPage", pageVO.getTotalPage());
			model.addAttribute("startPage", pageVO.getStartPage());
			model.addAttribute("endPage", pageVO.getEndPage());
			model.addAttribute("pageNum", pageNum);
			
		}catch(Exception e) {
			System.out.println("selectBoard error -> " + e.getMessage());
		}
		
		return "board/board";
	}
	

	/***
	 * 게시글 작성 jsp 호출
	 */
	@RequestMapping(value = "/write.do", method = RequestMethod.GET)
	public String boardWrite() {
		
		return "board/boardWrite";
	}
	
	
	/***
	 * 게시글 상세 조회 호출
	 */
	@RequestMapping(value = "/detail.do", method = RequestMethod.GET)
	public String selectDBoard(@RequestParam("Idx") int idx,
												BoardVO boardVO,
												Model model,
												HttpSession session) {
		
		try{
			/* 세션 처리 코드 추가 */
			String sessionID = (String) session.getAttribute("sessionID");
			
			/* 게시글 상세 조회 코드 추가 */
			BoardVO result = boardService.selectDBoard(idx);
			
			if(!sessionID.equals(result.getId())) {
				/* 조회수 처리 코드 추가 */
				boardService.updateHits(result);
			}

			model.addAttribute("result", result);
			
			// 세션이 있다면 뷰 리턴 후 비교 처리
			if(sessionID != "" || sessionID != null) {
				model.addAttribute("sessionID", sessionID);
			}
			
		}catch(Exception e) {
			System.out.println("selectDBoard error -> " + e.getMessage());
			
		}
		
		return "board/boardModify";
	}
}
