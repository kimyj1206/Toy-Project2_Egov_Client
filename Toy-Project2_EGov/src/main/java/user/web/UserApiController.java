package user.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import user.service.UserService;
import user.service.UserVO;

@RestController
@RequestMapping("/api/v1/members")
public class UserApiController {
	
	/* @Resource(name = "userService") */
	@Autowired
	private UserService userService;
	
	/***
	 * 회원가입 시 아이디 중복 체크
	 */
	@RequestMapping(value = "/duplicate-check/{id}.do", method = RequestMethod.POST)
	public Map<String, Object> duplicatedID(@PathVariable("id") String id) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			int result = userService.duplicatedID(id);

			if(result == 0) {
				resultMap.put("success", "사용 가능한 아이디입니다.");
			} else {
				resultMap.put("fail", "이미 사용 중인 아이디입니다.");
			}
		}catch(Exception e) {
			System.out.println("duplicatedID error -> " + e.getMessage());
		}

		return resultMap;
	}
	
	
	/***
	 * 회원가입
	 */
	@RequestMapping(value = "/signup.do", method = RequestMethod.POST)
	public Map<String, Object> insertJoin(@RequestBody UserVO userVO) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			String result = userService.insertJoin(userVO);
			
			if(result == null) {
				resultMap.put("success", "회원가입이 성공했습니다.");
			}else {
				resultMap.put("fail", "회원가입이 실패했습니다.");
			}
			
		} catch(Exception e) {
			System.out.println("insertJoin error -> " + e.getMessage());
		}
		return resultMap;
	}
	
	
	/***
	 * 로그인
	 */
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public Map<String, Object> selectLogin(@RequestBody UserVO userVO, HttpServletRequest request) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			int result = userService.selectLogin(userVO);
			
			if(result == 1) {
				/* session 생성 */
				HttpSession session = request.getSession();
				
				/* 저장 */
				session.setAttribute("sessionID", userVO.getId());
				System.out.println("sessionID -> " + session.getAttribute("sessionID"));
				
				/* 세션 타임아웃 지정 */
				session.setMaxInactiveInterval(60*30);
				
				resultMap.put("success", "로그인 성공했습니다.");
			} else {
				resultMap.put("fail", "로그인 실패했습니다.");
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
	@RequestMapping(value = "/find.do", method = RequestMethod.POST)
	public Map<String, Object> findId(@RequestBody UserVO userVO, Model model) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			// 핸드폰 번호 필드 비어있으면 이메일 값이므로 실행			
			if(userVO.getPhone() == null || userVO.getPhone() == "") {
				UserVO result = userService.findIdCheckEmail(userVO);
				
				if(result != null) {
					resultMap.put("success", "입력하신 정보에 맞는 사용자를 찾았습니다.");
				}else {
					resultMap.put("fail", "입력하신 정보에 맞는 사용자가 없습니다.");
				}
				
				resultMap.put("userId", result);
			}else {
				UserVO result = userService.findIdCheckPhone(userVO);
				
				if(result != null) {
					resultMap.put("success", "입력하신 정보에 맞는 사용자를 찾았습니다.");
				}else {
					resultMap.put("fail", "입력하신 정보에 맞는 사용자가 없습니다.");
				}
				
				resultMap.put("userId", result);
			}
			
		}catch(Exception e) {
			System.out.println("findId error -> " + e.getMessage());
		}

		return resultMap;
	}

	
	/***
	 * 비밀번호 초기화 전 아이디 찾기
	 */
	@RequestMapping(value = "/validate/{id}.do", method = RequestMethod.GET)
	public Map<String, Object> idCheck(@PathVariable("id") String id) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			int userId = userService.idCheck(id);
			
			if(userId == 1) {
				resultMap.put("success", "입력하신 정보에 맞는 사용자를 찾았습니다.");
			}else {
				resultMap.put("fail", "입력하신 정보에 맞는 사용자가 없습니다.");
			}
			
		}catch(Exception e) {
			System.out.println("idCheck error -> " + e.getMessage());
		}
		return resultMap;
	}
	
	
	/***
	 * 비밀번호 초기화
	 */
	@RequestMapping(value = "/reset-pw.do", method = RequestMethod.POST)
	public Map<String, Object> pwReset(@RequestBody UserVO userVO) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			int result = userService.pwReset(userVO);
			
			if(result == 1) {
				resultMap.put("success", "비밀번호 변경이 완료되었습니다.");
			}else {
				resultMap.put("fail", "비밀번호 변경이 실패했습니다.");
			}
			
		}catch(Exception e) {
			System.out.println("pwReset error -> " + e.getMessage());
		}
		return resultMap;
	}
	
	
	/***
	 * 유효 회원 검증
	 */
	@RequestMapping(value = "/mypage/validate-pw.do", method = RequestMethod.POST)
	public Map<String, Object> pwCheck(@RequestBody UserVO userVO) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			int result = userService.selectPwCheck(userVO);
			
			if(result == 1) {
				// 유효한 회원이 존재
				resultMap.put("success", "유효한 회원입니다.");
			}else {
				resultMap.put("fail", "유효하지 않은 회원입니다.");
			}
			
		}catch(Exception e) {
			System.out.println("pwCheck error -> " + e.getMessage());
		}
		return resultMap;
	}
	
	
	/***
	 * 회원 정보 수정
	 */
	@RequestMapping(value = "/mypage/update.do", method = RequestMethod.POST)
	public Map<String, Object> userInfoUpdate(@RequestBody UserVO userVO) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			int result = userService.updateUserInfo(userVO);
			
			if(result == 1) {
				// 유효한 회원이 존재
				resultMap.put("success", "회원 정보 수정 완료됐습니다.");
			} else {
				resultMap.put("fail", "회원 정보 수정 실패했습니다.");
			}
			
		}catch(Exception e) {
			System.out.println("userInfoUpdate error -> " + e.getMessage());
		}
		return resultMap;
	}

	
	/***
	 * 회원 탈퇴
	 */
	@RequestMapping(value = "/mypage/delete.do", method = RequestMethod.POST)
	public Map<String, Object> userleave(@RequestBody UserVO userVO) {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			int result = userService.deleteLeaveUser(userVO);
			
			if(result == 1) {
				resultMap.put("success", "회원 탈퇴가 정상적으로 처리되었습니다.");
			} else {
				resultMap.put("fail", "회원 탈퇴 실패했습니다.");
			}
			
		}catch(Exception e) {
			System.out.println("userleave error -> " + e.getMessage());
		}
		
		return resultMap;
	}

}
