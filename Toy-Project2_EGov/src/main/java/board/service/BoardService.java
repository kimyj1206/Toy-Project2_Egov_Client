package board.service;

import java.util.List;
import java.util.Map;

public interface BoardService {

	/***
	 * 게시글 저장
	 */
	public String insertBoard(BoardVO boardVO) throws Exception;
	
	/***
	 * 게시글 조회
	 */
	public List<BoardVO> selectBoard(PageVO pageVO) throws Exception;
	
	/***
	 * 게시글 상세 조회
	 */
	public BoardVO selectDBoard(BoardVO boardVO) throws Exception;
	
	/***
	 * 게시글 수정
	 */
	public int updateBoard(BoardVO boardVO) throws Exception;
	
	/***
	 * 게시글 삭제
	 */
	public int deleteBoard(int idx) throws Exception;
	
	/***
	 * 게시글 조회수
	 */
	public int updateHits(BoardVO boardVO) throws Exception;
	
	/***
	 * 게시글 총 개수 조회
	 */
	public int selectBoardCnt() throws Exception;
	
	/***
	 * 게시글 검색
	 */
	public List<BoardVO> selectSearchKeyword(Map<String, String> param) throws Exception;
	
	/**
	 * 게시물 범위 계산 및 리스트 리턴
	 */
	public List<BoardVO> selectBoardPrintList(Map<String, Integer> list) throws Exception;
}
