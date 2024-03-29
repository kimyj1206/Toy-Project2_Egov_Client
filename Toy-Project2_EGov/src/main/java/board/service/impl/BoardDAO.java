package board.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import board.service.BoardVO;
import board.service.PageVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("boardDAO")
public class BoardDAO extends EgovAbstractDAO {

	/*
	 * Insert
	 */
	public String insertBoard(BoardVO boardVO) throws Exception {
		
		return (String) insert("board.insertBoard", boardVO);
	}

	/*
	 * Select
	 */
	public List<BoardVO> selectBoard(PageVO pageVO) {

		return (List<BoardVO>) list("board.selectBoard", pageVO);
	}

	/*
	 * Select
	 */
	public BoardVO selectDBoard(int idx) {

		return (BoardVO) select("board.selectDBoard", idx);
	}

	/*
	 * Update
	 */
	public int updateBoard(BoardVO boardVO) {
		
		return update("board.updateBoard", boardVO);
	}

	/*
	 * Delete
	 */
	public int deleteBoard(int idx) {

		return delete("board.deleteBoard", idx);
	}

	/*
	 * Update
	 */
	public int updateHits(BoardVO boardVO) {

		return update("board.updateHits", boardVO);
	}

	/*
	 * Select
	 */
	public int selectBoardCnt() {

		return (int) select("board.selectBoardCnt");
	}

	/*
	 * Select
	 */
	public List<BoardVO> selectSearchKeyword(Map<String, Object> param) {

		return (List<BoardVO>) list("board.selectSearchKeyword", param);
	}

	/*
	 * Select
	 */
	public List<BoardVO> selectBoardPrintList(Map<String, Integer> list) {

		return (List<BoardVO>) list("board.selectBoardPrintList", list);
	}

	/*
	 * Select
	 */
	public int selectSearchKeywordCnt(Map<String, Object> map) {
		
		return (int) select("board.selectSearchKeywordCnt", map);
	}
}
