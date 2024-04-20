package board.service.impl;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import board.service.BoardService;
import board.service.BoardVO;
import board.service.PageVO;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Resource(name = "boardDAO")
	private BoardDAO boardDAO;
	
	/***
	 * 게시글 저장
	 */
	@Override
	@Transactional
	public int insertBoard(BoardVO boardVO, List<MultipartFile> fileList) throws Exception {
		
		// 첨부 파일이 있다면 저장하기 전에 디렉터리 여부 확인 후 디렉터리 생성
		if(fileList != null || fileList.size() > 0) {
			for(MultipartFile file : fileList) {
				
				int extenIndex = file.getOriginalFilename().lastIndexOf("."); // 각 파일 확장자 인덱스 번호 추출
				String fileExtension = file.getOriginalFilename().substring(extenIndex); // 각 파일의 확장자만 추출
				
				String uuid = UUID.randomUUID().toString() + fileExtension; // 원본 파일명 대신 업로드할 때는 uuid.pdf 등으로 업로드 함
				
				String fileFullPath = createDirectory(uuid, file);
				

				/*System.out.println("원본 파일명 : " + file.getOriginalFilename());
				System.out.println("암호화 파일명 : " + uuid);
				System.out.println("파일 확장자명 : " + fileExtension);
				System.out.println("파일 사이즈 : " + file.getSize());
				System.out.println("파일 경로 : " + fileFullPath);*/

				
				/*boardDAO.insertFile(file);*/
			}
		}
		
		return /*boardDAO.insertBoard(boardVO)*/ 0;
	}

	/***
	 * 게시글 조회
	 */
	@Override
	public List<BoardVO> selectBoard(PageVO pageVO) throws Exception {
		
		return boardDAO.selectBoard(pageVO);
	}

	/***
	 * 게시글 상세 조회
	 */
	@Override
	public BoardVO selectDBoard(int idx) throws Exception {
		
		return boardDAO.selectDBoard(idx);
	}

	/***
	 * 게시글 수정
	 */
	@Override
	@Transactional
	public int updateBoard(BoardVO boardVO) throws Exception {
		
		return boardDAO.updateBoard(boardVO);
	}

	/***
	 * 게시글 삭제
	 */
	@Override
	@Transactional
	public int deleteBoard(int idx) throws Exception {

		return boardDAO.deleteBoard(idx);
	}

	/***
	 * 게시글 조회수
	 */
	@Override
	@Transactional
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
	@Transactional
	public List<BoardVO> selectSearchKeyword(Map<String, Object> param) throws Exception {

		return boardDAO.selectSearchKeyword(param);
	}

	/**
	 * 게시물 범위 계산 및 리스트 리턴
	 */
	@Override
	public List<BoardVO> selectBoardPrintList(Map<String, Integer> list) throws Exception {

		return boardDAO.selectBoardPrintList(list);
	}

	/***
	 * 검색어 포함 게시물 개수 조회
	 */
	@Override
	public int selectSearchKeywordCnt(Map<String, Object> map) throws Exception {

		return boardDAO.selectSearchKeywordCnt(map);
	}

	/**
	 * 첨부파일 저장할 디렉터리 생성
	 * @throws IOException 
	 * @throws IllegalStateException 
	 */
	@Override
	public String createDirectory(String uuid, MultipartFile file) throws IllegalStateException, IOException {
		
		LocalDate currentDate = LocalDate.now();
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
		String dateString = currentDate.format(formatter); // 폴더 생성 시 현재 날짜의 폴더를 생성하기 위함
		
		// 기본 경로
		String baseDirectory = "C:\\static\\upload";
		
		// 파일 업로드 시 폴더 경로
		String fileDirectoryPath = baseDirectory + "/" + dateString;
		
		File uploadFile = new File(fileDirectoryPath, uuid);
		
		// exists() -> 파일이나 디렉터리 존재 여부 반환
		if(!uploadFile.exists()) {
			// 지정 경로에 폴더 없을 시 부모 폴더를 생성함
			uploadFile.mkdirs();
			
			// 해당 경로에 업로드할 폴더를 저장함
			file.transferTo(uploadFile);
		}
		
		return fileDirectoryPath;
	}
	

}
