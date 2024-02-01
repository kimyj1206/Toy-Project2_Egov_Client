package board.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import board.service.BoardService;
import board.service.BoardVO;

@Controller
public class BoardViewController {

	@Resource(name = "boardService")
	private BoardService boardService;
	
	
	/***
	 * 게시판 호출
	 */
	@RequestMapping(value = "/board.do")
	public String selectBoard(BoardVO boardVO, Model model) throws Exception {
		
		try{
			/* 초기 조회 시 페이지 번호 1로 고정 */
			boardVO.setPageNum(1);
			
			/* 한 페이지에 출력될 페이지 수 */
			boardVO.setCurrentPrintPage(3);
			
			/* 한 페이지에 출력될 게시물 수 */
			boardVO.setCurrentPrintBoardList(10);
			
			/* 게시글 조회 */
			List<BoardVO> result = boardService.selectBoard(boardVO);
			
			/* 게시물 총 개수 */
			int totalBoardList = boardService.selectBoardCnt();
			
			/* 전체 페이지 수(소수점 값이 있다면 올림 처리) */
			int totalPage = (int) Math.ceil((double) totalBoardList / boardVO.getCurrentPrintBoardList());
			
			/* 시작 페이지 번호 계산 */
			int startPage = Math.max(1, Math.min(boardVO.getPageNum(), totalPage - boardVO.getCurrentPrintPage() + 1));
			
			/* 끝 페이지 번호 계산 */
			int endPage = Math.min(totalPage, startPage + boardVO.getCurrentPrintPage() - 1);
			
			model.addAttribute("totalBoardList", totalBoardList);
			model.addAttribute("totalPage", totalPage);
			model.addAttribute("startPage", startPage);
			model.addAttribute("endPage", endPage);
			model.addAttribute("currentPrintPage", boardVO.getCurrentPrintPage());
			
			model.addAttribute("result", result);
			
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
	public String selectDBoard(BoardVO boardVO, Model model, HttpSession session) throws Exception {
		
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
