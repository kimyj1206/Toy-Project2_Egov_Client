package main.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import main.service.MainService;
import main.service.MainVO;

// Controller와 연결됨
@Service("mainService")
public class MainServiceImpl implements MainService {

	@Resource(name = "mainDAO")
	private MainDAO mainDAO;
	
	/*
	 * 회원가입 
	 */
	@Override
	public String insertJoin(MainVO mainVO) throws Exception {
		
		return mainDAO.insertJoin(mainVO);
	}

	/*
	 * 로그인
	 */
	@Override
	public int selectLogin(MainVO mainVO) throws Exception {

		return mainDAO.selectLogin(mainVO);
	}

	/*
	 * 아이디 중복체크
	 */
	@Override
	public int duplicatedID(String id) throws Exception {

		return mainDAO.duplicatedID(id);
	}

	/*
	 * 이메일로 아이디 찾기
	 */
	@Override
	public MainVO authFindIdCheckEmail(MainVO mainVO) throws Exception {
		
		return mainDAO.authFindIdCheckEmail(mainVO);
	}

	/*
	 * 핸드폰으로 아이디 찾기
	 */
	@Override
	public MainVO authFindIdCheckPhone(MainVO mainVO) throws Exception {

		return mainDAO.authFindIdCheckPhone(mainVO);
	}

	/*
	 * 비밀번호 초기화 전 아이디 찾기
	 */
	@Override
	public int authIdCheck(String id) throws Exception {
		
		return mainDAO.authIdCheck(id);
	}

	/*
	 * 비밀번호 초기화
	 */
	@Override
	public int authPwReset(MainVO mainVO) throws Exception {
		
		return mainDAO.authPwReset(mainVO);
	}

	/*
	 * 회원 조회
	 */
	@Override
	public MainVO selectUser(String id) throws Exception {
		
		return mainDAO.selectUser(id);
	}

	/*
	 * 유효 회원 검증
	 */
	@Override
	public int SelectPwCheck(MainVO mainVO) throws Exception {
		
		return mainDAO.SelectPwCheck(mainVO);
	}

	/*
	 * 회원 정보 수정
	 */
	@Override
	public int updateUserInfo(MainVO mainVO) throws Exception {

		return mainDAO.updateUserInfo(mainVO);
	}

	/*
	 * 회원 탈퇴
	 */
	@Override
	public int deleteLeaveUser(MainVO mainVO) throws Exception {
		
		return mainDAO.deleteLeaveUser(mainVO);
	}	
}
