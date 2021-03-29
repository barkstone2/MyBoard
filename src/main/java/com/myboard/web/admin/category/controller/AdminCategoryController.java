package com.myboard.web.admin.category.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.myboard.web.board.category.service.CategoryService;

@Controller
@RequestMapping("/admin/category/")
public class AdminCategoryController {
	
	@Autowired
	private CategoryService categoryService;
	
	@GetMapping("list")
	public String list(Model model) {
		
		List<String> categoryList = categoryService.getList();
		model.addAttribute("categoryList", categoryList);
		
		return "admin.category.list";
	}
}
