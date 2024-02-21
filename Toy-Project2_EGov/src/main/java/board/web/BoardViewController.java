package board.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import board.service.BoardService;
import board.service.BoardVO;
import board.service.PageVO;

@Controller
public class BoardViewController {

	/*@Resource(name = "boardService")*/
	@Autowired
	private BoardService boardService;
	
	
	/***
	 * 게시판 호출
	 */
	@RequestMapping(value = "/board.do")
	public String selectBoard(PageVO pageVO, Model model) {
		
		try{
			/* 초기 조회 시 페이지 번호 1로 고정 */
			pageVO.setPageNum(1);

			/* 한 페이지에 출력될 페이지 수 */
			pageVO.setCurrentPrintPage(3);
			
			/* 한 페이지에 출력될 게시물 수 */
			pageVO.setCurrentPrintBoardList(10);
			
			/* 게시글 조회 */
			List<BoardVO> result = boardService.selectBoard(pageVO);
			
			/* 게시물 총 개수 */
			int totalBoardList = boardService.selectBoardCnt();
			
			/* 전체 페이지 수(소수점 값이 있다면 올림 처리) */
			pageVO.setTotalPage((int) Math.ceil((double) totalBoardList / pageVO.getCurrentPrintBoardList()));
			
			/* 시작 페이지 번호 */
			pageVO.setStartPage(Math.max(1, Math.min(pageVO.getPageNum(), pageVO.getTotalPage() - pageVO.getCurrentPrintPage() + 1)));

			/* 끝 페이지 번호 */
			pageVO.setEndPage(Math.min(pageVO.getTotalPage(), pageVO.getStartPage() + pageVO.getCurrentPrintPage() - 1));

			model.addAttribute("currentPrintPage", pageVO.getCurrentPrintPage());
			model.addAttribute("result", result);
			model.addAttribute("totalBoardList", totalBoardList);
			model.addAttribute("totalPage", pageVO.getTotalPage());
			model.addAttribute("startPage", pageVO.getStartPage());
			model.addAttribute("endPage", pageVO.getEndPage());
		
		}catch(Exception e) {
			System.out.println("board error -> " + e.getMessage());
		}
		
		return "board/board";
	}
	
	
	/***
	 * 게시글 작성 jsp 호출
	 */
	@RequestMapping(value = "/boardWrite.do")
	public String boardWrite() {
		
		return "board/boardWrite";
	}
	
	
	/***
	 * 게시글 상세 조회 호출
	 */
	@RequestMapping(value = "/boardModify.do")
	public String selectDBoard(BoardVO boardVO, Model model, HttpSession session) {
		
		try{
			/* 세션 처리 코드 추가 */
			String sessionID = (String) session.getAttribute("sessionID");
			
			/* 게시글 상세 조회 코드 추가 */
			BoardVO result = boardService.selectDBoard(boardVO);
			
			if(!sessionID.equals(result.getUserId())) {
				/* 조회수 처리 코드 추가 */
				int hits = boardService.updateHits(result);
			}

			model.addAttribute("result", result);
			
			// 세션이 있다면 뷰 리턴 후 비교 처리
			if(sessionID != "" || sessionID != null) {
				model.addAttribute("sessionID", sessionID);
			}
			
		}catch(Exception e) {
			System.out.println("boardModify error -> " + e.getMessage());
			
		}
		
		return "board/boardModify";
	}
}
