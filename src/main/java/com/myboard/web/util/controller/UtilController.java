package com.myboard.web.util.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

@Controller("/util/")
public class UtilController {
	
	public String message(Model model) {
		
		return "message";
	}
}
