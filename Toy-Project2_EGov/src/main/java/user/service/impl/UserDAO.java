package user.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import user.service.UserVO;

@Repository("userDAO")
public class UserDAO extends EgovAbstractDAO {
	
	/*
	 * Insert
	 */
	public String insertJoin(UserVO userVO) throws Exception {
		return (String) insert("user.insertJoin", userVO);
	}

	/*
	 * Select
	 */
	public int selectLogin(UserVO userVO) {

		return (int) select("user.selectLogin", userVO);
	}

	/*
	 * Select
	 */
	public int duplicatedID(String id) {

		return (int) select("user.duplicatedID", id);
	}

	/*
	 * Select
	 */
	public UserVO authFindIdCheckEmail(UserVO userVO) {
		
		return (UserVO) select("user.authFindIdCheckEmail", userVO);
	}

	/*
	 * Select
	 */
	public UserVO authFindIdCheckPhone(UserVO userVO) {

		return (UserVO) select("user.authFindIdCheckPhone", userVO);
	}

	/*
	 * Select
	 */
	public int authIdCheck(String id) {

		return (int) select("user.authIdCheck", id);
	}

	/*
	 * Update
	 */
	public int authPwReset(UserVO userVO) {
		
		return update("user.authPwReset", userVO);
	}

	/*
	 * Select
	 */
	public UserVO selectUser(String id) {
		
		return (UserVO) select("user.selectUser", id);
	}

	/*
	 * Select
	 */
	public int SelectPwCheck(UserVO userVO) {

		return (int) select("user.SelectPwCheck", userVO);
	}

	/*
	 * Update
	 */
	public int updateUserInfo(UserVO userVO) {

		return update("user.updateUserInfo", userVO);
	}

	/*
	 * Delete
	 */
	public int deleteLeaveUser(UserVO userVO) {
		
		return delete("user.deleteLeaveUser", userVO);
	}

}
