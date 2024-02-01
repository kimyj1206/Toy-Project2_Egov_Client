package board.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import board.service.BoardService;
import board.service.BoardVO;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Resource(name = "boardDAO")
	private BoardDAO boardDAO;
	
	/***
	 * 게시글 저장
	 */
	@Override
	public String insertBoard(BoardVO boardVO) throws Exception {
		
		return boardDAO.insertBoard(boardVO);
	}

	/***
	 * 게시글 조회
	 */
	@Override
	public List<BoardVO> selectBoard(BoardVO boardVO) throws Exception {
		
		return boardDAO.selectBoard(boardVO);
	}

	/***
	 * 게시글 상세 조회
	 */
	@Override
	public BoardVO selectDBoard(BoardVO boardVO) throws Exception {
		
		return boardDAO.selectDBoard(boardVO);
	}

	/***
	 * 게시글 수정
	 */
	@Override
	public int updateBoard(BoardVO boardVO) throws Exception {
		
		return boardDAO.updateBoard(boardVO);
	}

	/***
	 * 게시글 삭제
	 */
	@Override
	public int deleteBoard(int idx) throws Exception {

		return boardDAO.deleteBoard(idx);
	}

	/***
	 * 게시글 조회수
	 */
	@Override
	public int updateHits(BoardVO boardVO) throws Exception {
		
		boardVO.setHits(boardVO.getHits() + 1);
		
		return boardDAO.updateHits(boardVO);
	}

	/***
	 * 게시글 총 개수 조회
	 */
	@Override
	public int selectBoardCnt() throws Exception {
		
		return boardDAO.selectBoardCnt();
	}

	/***
	 * 게시글 검색
	 */
	@Override
	public List<BoardVO> selectSearchKeyword(Map<String, String> param) throws Exception {

		return boardDAO.selectSearchKeyword(param);
	}

	/**
	 * 게시물 범위 계산 및 리스트 리턴
	 */
	@Override
	public List<BoardVO> selectBoardPrintList(Map<String, Integer> list) throws Exception {

		return boardDAO.selectBoardPrintList(list);
	}

}
