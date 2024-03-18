package main.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class IndexController {
	
	/***
	 * index jsp 호출
	 */
	@RequestMapping(value = "/index.do", method = RequestMethod.GET)
	public String index() {
		
		return "main/index";
	}
}
