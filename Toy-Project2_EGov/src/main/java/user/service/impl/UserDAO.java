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
	public UserVO findIdCheckEmail(UserVO userVO) {
		
		return (UserVO) select("user.findIdCheckEmail", userVO);
	}

	/*
	 * Select
	 */
	public UserVO findIdCheckPhone(UserVO userVO) {

		return (UserVO) select("user.findIdCheckPhone", userVO);
	}

	/*
	 * Select
	 */
	public int idCheck(String id) {

		return (int) select("user.idCheck", id);
	}

	/*
	 * Update
	 */
	public int pwReset(UserVO userVO) {
		
		return update("user.pwReset", userVO);
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
	public int selectPwCheck(UserVO userVO) {

		return (int) select("user.selectPwCheck", userVO);
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
