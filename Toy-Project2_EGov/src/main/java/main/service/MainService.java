package main.service;

import java.util.Map;

public interface MainService {
	/*
	 * Insert 회원가입
	 * @param mainVO
	 * @throws Exception
	 */
	public String insertJoin(MainVO mainVO) throws Exception;
	
	/*
	 * Select 로그인
	 * @param mainVO
	 * @throws Exception
	 */
	public int selectLogin(MainVO mainVO) throws Exception;
	
	/*
	 * Select 아이디 중복 체크
	 * @return
	 * @throws Exception
	 */
	public int duplicatedID(String id) throws Exception;
	
	/*
	 * Select 이메일로 아이디 찾기
	 * @return
	 * @throws Exception
	 */
	public MainVO authFindIdCheckEmail(MainVO mainVO) throws Exception;
	
	/*
	 * Select 핸드폰으로 아이디 찾기
	 * @return
	 * @throws Exception
	 */
	public MainVO authFindIdCheckPhone(MainVO mainVO) throws Exception;

	/*
	 * Select 비밀번호 찾기 전 아이디 찾기
	 * @return
	 * @throws Exception
	 */
	public int authIdCheck(String id) throws Exception;
	
	/*
	 * Update 비밀번호 초기화
	 * @return
	 * @throws Exception
	 */
	public int authPwReset(MainVO mainVO) throws Exception;

	/*
	 * Select 회원 조회
	 * @return
	 * @throws Exception
	 */
	public MainVO selectUser(String id) throws Exception;
	
	/*
	 * Select 유효 회원 검증
	 * @return
	 * @throws Exception
	 */
	public int SelectPwCheck(MainVO mainVO) throws Exception;
	
	/*
	 * Update 회원 정보 수정
	 * @return
	 * @throws Exception
	 */
	public int updateUserInfo(MainVO mainVO) throws Exception;
	
	/*
	 * Delete 회원 탈퇴
	 * @return
	 * @throws Exception
	 */
	public int deleteLeaveUser(MainVO mainVO) throws Exception;
}
