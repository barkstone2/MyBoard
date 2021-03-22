package com.myboard.web.util.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/util/")
public class UtilController {
	
	public String message(Model model) {
		
		return "message";
	}
	
	
}
