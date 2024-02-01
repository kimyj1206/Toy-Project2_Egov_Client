package main.service.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import main.service.MainVO;

@Repository("mainDAO")
public class MainDAO extends EgovAbstractDAO {

	/*
	 * Insert
	 */
	public String insertJoin(MainVO mainVO) throws Exception {
		return (String) insert("auth.insertJoin", mainVO);
	}

	/*
	 * Select
	 */
	public int selectLogin(MainVO mainVO) {

		return (int) select("auth.selectLogin", mainVO);
	}

	/*
	 * Select
	 */
	public int duplicatedID(String id) {

		return (int) select("auth.duplicatedID", id);
	}

	/*
	 * Select
	 */
	public MainVO authFindIdCheckEmail(MainVO mainVO) {
		
		return (MainVO) select("auth.authFindIdCheckEmail", mainVO);
	}

	/*
	 * Select
	 */
	public MainVO authFindIdCheckPhone(MainVO mainVO) {

		return (MainVO) select("auth.authFindIdCheckPhone", mainVO);
	}

	/*
	 * Select
	 */
	public int authIdCheck(String id) {

		return (int) select("auth.authIdCheck", id);
	}

	/*
	 * Update
	 */
	public int authPwReset(MainVO mainVO) {
		
		return update("auth.authPwReset", mainVO);
	}

	/*
	 * Select
	 */
	public MainVO selectUser(String id) {
		
		return (MainVO) select("auth.selectUser", id);
	}

	/*
	 * Select
	 */
	public int SelectPwCheck(MainVO mainVO) {

		return (int) select("auth.SelectPwCheck", mainVO);
	}

	/*
	 * Update
	 */
	public int updateUserInfo(MainVO mainVO) {

		return update("auth.updateUserInfo", mainVO);
	}

	/*
	 * Delete
	 */
	public int deleteLeaveUser(MainVO mainVO) {
		
		return delete("auth.deleteLeaveUser", mainVO);
	}

}
