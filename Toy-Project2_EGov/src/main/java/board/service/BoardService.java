package board.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

public interface BoardService {

	/***
	 * 게시글 저장
	 */
	public int insertBoard(BoardVO boardVO, List<MultipartFile> fileList) throws Exception;
	
	/***
	 * 게시글 조회
	 */
	public List<BoardVO> selectBoard(PageVO pageVO) throws Exception;
	
	/***
	 * 게시글 상세 조회
	 */
	public BoardVO selectDBoard(int idx) throws Exception;
	
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
	public List<BoardVO> selectSearchKeyword(Map<String, Object> param) throws Exception;
	
	/**
	 * 게시물 범위 계산 및 리스트 리턴
	 */
	public List<BoardVO> selectBoardPrintList(Map<String, Integer> list) throws Exception;
	
	/***
	 * 검색어 포함 게시물 개수 조회
	 */
	public int selectSearchKeywordCnt(Map<String, Object> map) throws Exception;
	
	/**
	 * 첨부파일 저장할 디렉터리 생성
	 */
	public String createDirectory(String uuid, MultipartFile file) throws Exception;
}
