package com.myboard.web.util.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/util/")
public class UtilController {
	
	@GetMapping("message")
	public String message(String msg, String reUrl, Model model) {
		
		model.addAttribute("msg", msg);
		model.addAttribute("reUrl", reUrl);
		
		return "util.message";
	}
	
	
}
