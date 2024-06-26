package user.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import user.service.UserService;
import user.service.UserVO;


@Controller
@RequestMapping("/members")
public class UserViewController {
	
	/*@Resource(name = "userService")*/
	@Autowired
	private UserService userService;
	
	/***
	 * 회원가입 jsp 호출
	 */
	@RequestMapping(value = "/join.do", method = RequestMethod.GET)
	public String join() {
		
		return "user/join";
	}
	
	
	/***
	 * 로그인 jsp 호출
	 */
	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String login() {
		
		return "user/login";
	}
	
	
	/***
	 * 아이디 찾기 jsp 호출
	 */
	@RequestMapping(value = "/find-id.do", method = RequestMethod.GET)
	public String findID() {

		return "user/findID";
	}
	
	
	/***
	 * 비밀번호 찾기 jsp 호출
	 */
	@RequestMapping(value = "/reset-pw.do", method = RequestMethod.GET)
	public String findPW() {
		
		return "user/findPW";
	}
	
	
	/***
	 * 회원 정보 jsp 호출
	 */
	@RequestMapping(value = "/mypage.do", method = RequestMethod.GET)
	public String userInfo(@RequestParam("ID") String id, Model model) {
		
		try {
			UserVO result = userService.selectUser(id);
			
			model.addAttribute("result", result);
			
		}catch(Exception e) {
			System.out.println("userInfo error -> " + e.getMessage());
		}
		
		return "user/userInfo";
	}
	
	
	/***
	 * 회원 탈퇴 jsp 호출
	 */
	@RequestMapping(value = "/mypage/delete.do", method = RequestMethod.GET)
	public String userLeave(@RequestParam("ID") String id, Model model) {
		
		try {
			UserVO result = userService.selectUser(id);
			
			model.addAttribute("result", result);
			
		}catch(Exception e) {
			System.out.println("userLeave error -> " + e.getMessage());
		}
		
		return "user/userLeave";
	}

}
