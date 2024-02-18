package main.web;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import main.service.MainService;
import main.service.MainVO;

@Controller
public class MainViewController {

	// MainService 이름을 가진 Impl 클래스를 찾음
	/*@Resource(name = "mainService")*/
	@Autowired
	private MainService mainService;
	
	
	/***
	 * main jsp 호출
	 */
	@RequestMapping(value = "/main.do")
	public String main() {
		
		return "main/main";
	}
	
	
	/***
	 * 회원가입 jsp 호출
	 */
	@RequestMapping(value = "/authJoin.do")
	public String authJoin() {
		
		return "auth/join";
	}
	
	
	/***
	 * 로그인 jsp 호출
	 */
	@RequestMapping(value = "/authLogin.do")
	public String authLogin() {
		
		return "auth/login";
	}
	
	
	/***
	 * 아이디 찾기 jsp 호출
	 */
	@RequestMapping(value = "/authFindId.do", method = RequestMethod.GET)
	public String findID() {

		return "auth/findID";
	}
	
	
	/***
	 * 비밀번호 찾기 jsp 호출
	 */
	@RequestMapping(value = "/authFindPw.do", method = RequestMethod.GET)
	public String findPW() {
		
		return "auth/findPW";
	}
	
	
	/***
	 * 회원 정보 jsp 호출
	 */
	@RequestMapping(value = "/userInfo.do")
	public String userInfo(@RequestParam("ID") String id, Model model) {
		
		try {
			MainVO result = mainService.selectUser(id);
			
			model.addAttribute("result", result);
		}catch(Exception e) {
			System.out.println("userInfo error -> " + e.getMessage());
		}
		
		return "auth/userInfo";
	}
	
	
	/***
	 * 회원 탈퇴 jsp 호출
	 */
	@RequestMapping(value = "/userLeave.do")
	public String userLeave(@RequestParam("id") String id, Model model) {
		
		try {
			MainVO result = mainService.selectUser(id);
			
			model.addAttribute("result", result);
		}catch(Exception e) {
			System.out.println("userLeave error -> " + e.getMessage());
		}
		
		return "auth/userLeave";
	}
}
