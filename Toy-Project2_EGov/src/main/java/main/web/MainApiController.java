package main.web;



import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import main.service.MainService;
import main.service.MainVO;

@RestController
public class MainApiController {
		
	// MainService 이름을 가진 Impl 클래스를 찾음
	/* @Resource(name = "mainService") */
	@Autowired
	private MainService mainService;
	
	
	/***
	 * 회원가입 아이디 중복 체크
	 */
	@RequestMapping(value = "/duplicatedID.do")
	public Map<String, Object> duplicatedID(@RequestBody MainVO mainVO) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			int result = mainService.duplicatedID(mainVO.getId());

			if(result == 0) {
				resultMap.put("success", "available ID.");
			} else {
				resultMap.put("fail", "already in use.");
			}
		}catch(Exception e) {
			System.out.println("duplicatedID error -> " + e.getMessage());
		}

		return resultMap;
	}
	
	
	/***
	 * 회원가입
	 */
	@RequestMapping(value = "/joinSave.do", method = RequestMethod.POST)
	public Map<String, Object> insertJoin(@RequestBody MainVO mainVO) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			String result = mainService.insertJoin(mainVO);
			
			if(result == null) {
				resultMap.put("success", "Success sign up.");
			}else {
				resultMap.put("fail", "Fail sign up. Please try again.");
			}
			
		} catch(Exception e) {
			System.out.println("insertJoin error -> " + e.getMessage());
		}
		return resultMap;
	}
	
	
	/***
	 * 로그인
	 */
	@RequestMapping(value = "/loginCheck.do", method = RequestMethod.POST)
	public Map<String, Object> selectLogin(@RequestBody MainVO mainVO, HttpServletRequest request) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			int result = mainService.selectLogin(mainVO);
			
			if(result == 1) {
				/* session 생성 */
				HttpSession session = request.getSession();
				
				/* 저장 */
				session.setAttribute("sessionID", mainVO.getId());
				System.out.println("sessionID -> " + session.getAttribute("sessionID"));
				
				/* 세션 타임아웃 지정 */
				session.setMaxInactiveInterval(60*30);
				
				resultMap.put("success", "Success login.");
			} else {
				resultMap.put("fail", "Fail login. Please try again.");
			}
		} catch(Exception e) {
			System.out.println("selectLogin error -> " + e.getMessage());
		}
		return resultMap;
	}
	
	
	/***
	 * 아이디 찾기
	 * @RequestBody Annotation 인식 못 함 -> jackson 라이브러리 설정 - dispatcher와 pom 설정 추가
	 */
	@RequestMapping(value = "/authFindIdCheck.do", method = RequestMethod.POST)
	public Map<String, Object> authFindIdCheck(@RequestBody MainVO mainVO, Model model) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			// 핸드폰 번호 필드 비어있으면 이메일 값이므로 실행			
			if(mainVO.getPhone() == null || mainVO.getPhone() == "") {
				MainVO result = mainService.authFindIdCheckEmail(mainVO);
				
				if(result != null) {
					resultMap.put("success", "Success found user.");
				}else {
					resultMap.put("fail", "Fail not found user. Please try again.");
				}
				
				resultMap.put("userId", result);
			}else {
				MainVO result = mainService.authFindIdCheckPhone(mainVO);
				
				if(result != null) {
					resultMap.put("success", "Success found user.");
				}else {
					resultMap.put("fail", "Fail not found user. Please try again.");
				}
				
				resultMap.put("userId", result);
			}
			
		}catch(Exception e) {
			System.out.println("authFindIdCheck error -> " + e.getMessage());
		}

		return resultMap;
	}

	
	/***
	 * 비밀번호 초기화 전 아이디 찾기
	 */
	@RequestMapping(value = "/authIdCheck.do", method = RequestMethod.POST)
	public Map<String, Object> authIdCheck(@RequestBody MainVO mainVO) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			int idCheck = mainService.authIdCheck(mainVO.getId());
			
			if(idCheck == 1) {
				resultMap.put("success", "Success found user.");
			}else {
				resultMap.put("fail", "Fail not found user. Please try again.");
			}
			
		}catch(Exception e) {
			System.out.println("authIdCheck error -> " + e.getMessage());
		}
		return resultMap;
	}
	
	
	/***
	 * 비밀번호 초기화
	 */
	@RequestMapping(value = "/authPwReset.do", method = RequestMethod.POST)
	public Map<String, Object> authPwReset(@RequestBody MainVO mainVO) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			int result = mainService.authPwReset(mainVO);
			
			if(result == 1) {
				resultMap.put("success", "Success found user.");
			}else {
				resultMap.put("fail", "Fail not found user. Please try again.");
			}
			
		}catch(Exception e) {
			System.out.println("authPwReset error -> " + e.getMessage());
		}
		return resultMap;
	}
	
	
	/***
	 * 유효 회원 검증
	 */
	@RequestMapping(value = "/authPwCheck.do")
	public Map<String, Object> authPwCheck(@RequestBody MainVO mainVO) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			int result = mainService.SelectPwCheck(mainVO);
			
			if(result == 1) {
				// 유효한 회원이 존재
				resultMap.put("success", "Success found user.");
			}else {
				resultMap.put("fail", "Fail not found user. Please try again.");
			}
			
		}catch(Exception e) {
			System.out.println("authPwCheck error -> " + e.getMessage());
		}
		return resultMap;
	}
	
	
	/***
	 * 회원 정보 수정
	 */
	@RequestMapping(value = "/authUserInfoUpdate.do")
	public Map<String, Object> authUserInfoUpdate(@RequestBody MainVO mainVO) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			int result = mainService.updateUserInfo(mainVO);
			
			if(result == 1) {
				// 유효한 회원이 존재
				resultMap.put("success", "Success updated user.");
			} else {
				resultMap.put("fail", "Fail not update user. Please try again.");
			}
			
		}catch(Exception e) {
			System.out.println("authUserInfoUpdate error -> " + e.getMessage());
		}
		return resultMap;
	}

	
	/***
	 * 회원 탈퇴
	 */
	@RequestMapping(value = "/leave.do")
	public Map<String, Object> authUserleave(@RequestBody MainVO mainVO) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			
			int result = mainService.deleteLeaveUser(mainVO);
			
			if(result == 1) {
				resultMap.put("success", "Success deleted user.");
			} else {
				resultMap.put("fail", "Fail not delete user. Please try again.");
			}
			
		}catch(Exception e) {
			System.out.println("leave error -> " + e.getMessage());
		}
		
		return resultMap;
	}
}
