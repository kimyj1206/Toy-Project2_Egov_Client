package board.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import board.service.BoardVO;
import board.service.PageVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("boardDAO")
public class BoardDAO extends EgovAbstractDAO {

	/**
	 * INSERT
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public int insertBoard(BoardVO boardVO) throws Exception {
		
		return (int) insert("board.insertBoard", boardVO);
	}
	
	/**
	 * INSERT
	 * @param file
	 * @return
	 * @throws Exception
	 */
	public int insertFile(MultipartFile file) throws Exception {
		
		return /*(int) insert("board.insertFile", file)*/ 0;
	}
	
	

	/**
	 * SELECT
	 * @param pageVO
	 * @return
	 */
	public List<BoardVO> selectBoard(PageVO pageVO) {

		return (List<BoardVO>) list("board.selectBoard", pageVO);
	}

	/**
	 * SELECT
	 * @param idx
	 * @return
	 */
	public BoardVO selectDBoard(int idx) {

		return (BoardVO) select("board.selectDBoard", idx);
	}

	/**
	 * UPDATE
	 * @param boardVO
	 * @return
	 */
	public int updateBoard(BoardVO boardVO) {
		
		return update("board.updateBoard", boardVO);
	}

	/**
	 * DELETE
	 * @param idx
	 * @return
	 */
	public int deleteBoard(int idx) {

		return delete("board.deleteBoard", idx);
	}

	/**
	 * UPDATE
	 * @param boardVO
	 * @return
	 */
	public int updateHits(BoardVO boardVO) {

		return update("board.updateHits", boardVO);
	}

	/**
	 * SELECT
	 * @return
	 */
	public int selectBoardCnt() {

		return (int) select("board.selectBoardCnt");
	}

	/**
	 * SELECT
	 * @param param
	 * @return
	 */
	public List<BoardVO> selectSearchKeyword(Map<String, Object> param) {

		return (List<BoardVO>) list("board.selectSearchKeyword", param);
	}

	/**
	 * SELECT
	 * @param list
	 * @return
	 */
	public List<BoardVO> selectBoardPrintList(Map<String, Integer> list) {

		return (List<BoardVO>) list("board.selectBoardPrintList", list);
	}

	/**
	 * SELECT
	 * @param map
	 * @return
	 */
	public int selectSearchKeywordCnt(Map<String, Object> map) {
		
		return (int) select("board.selectSearchKeywordCnt", map);
	}
}
