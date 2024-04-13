package user.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import user.service.UserService;
import user.service.UserVO;

@Service("userService")
public class UserServiceImpl implements UserService {
	
	@Resource(name = "userDAO")
	private UserDAO userDAO;
	
	/*
	 * 회원가입 
	 */
	@Override
	public String insertJoin(UserVO userVO) throws Exception {
		
		return userDAO.insertJoin(userVO);
	}

	/*
	 * 로그인
	 */
	@Override
	public int selectLogin(UserVO userVO) throws Exception {

		return userDAO.selectLogin(userVO);
	}

	/*
	 * 아이디 중복체크
	 */
	@Override
	public int duplicatedID(String id) throws Exception {

		return userDAO.duplicatedID(id);
	}

	/*
	 * 이메일로 아이디 찾기
	 */
	@Override
	public UserVO findIdCheckEmail(UserVO userVO) throws Exception {
		
		return userDAO.findIdCheckEmail(userVO);
	}

	/*
	 * 핸드폰으로 아이디 찾기
	 */
	@Override
	public UserVO findIdCheckPhone(UserVO userVO) throws Exception {

		return userDAO.findIdCheckPhone(userVO);
	}

	/*
	 * 비밀번호 초기화 전 아이디 찾기
	 */
	@Override
	public int idCheck(String id) throws Exception {
		
		return userDAO.idCheck(id);
	}

	/*
	 * 비밀번호 초기화
	 */
	@Override
	public int pwReset(UserVO userVO) throws Exception {
		
		return userDAO.pwReset(userVO);
	}

	/*
	 * 회원 조회
	 */
	@Override
	public UserVO selectUser(String id) throws Exception {
		
		return userDAO.selectUser(id);
	}

	/*
	 * 유효 회원 검증
	 */
	@Override
	public int selectPwCheck(UserVO userVO) throws Exception {
		
		return userDAO.selectPwCheck(userVO);
	}

	/*
	 * 회원 정보 수정
	 */
	@Override
	public int updateUserInfo(UserVO userVO) throws Exception {

		return userDAO.updateUserInfo(userVO);
	}

	/*
	 * 회원 탈퇴
	 */
	@Override
	public int deleteLeaveUser(UserVO userVO) throws Exception {
		
		return userDAO.deleteLeaveUser(userVO);
	}

}
