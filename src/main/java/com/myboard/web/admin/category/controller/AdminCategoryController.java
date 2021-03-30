package com.myboard.web.admin.category.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.myboard.web.admin.category.service.AdminCategoryService;
import com.myboard.web.board.category.service.CategoryService;

@Controller
@RequestMapping("/admin/category/")
public class AdminCategoryController {
	
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private AdminCategoryService adminCategoryService;
	
	@GetMapping("list")
	public String list(Model model) {
		
		List<String> categoryList = categoryService.getList();
		model.addAttribute("categoryList", categoryList);
		
		return "admin.category.list";
	}
	
	@PostMapping("modify")
	public void modify(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) throws IOException {
		ObjectMapper mapper = new ObjectMapper();
		List<Map<String, Map<String, String>>> list = mapper.readValue(data, new TypeReference<List<Map<String, Map<String, String>>>>(){});
		
		List<Map<String,String>> modList = new ArrayList<>();
		List<Map<String,String>> addList = new ArrayList<>();
		for(Map<String, Map<String, String>> temp : list) {
			if(temp.containsKey("mod")) modList.add(temp.get("mod"));
			if(temp.containsKey("add")) addList.add(temp.get("add"));
		}
		
		if(addList.size()>0) {
			for(Map<String, String> temp : addList) {
				String name = temp.get("name");
				String preOrder = temp.get("preOrder");
				adminCategoryService.insert(name, preOrder);
			}
		}
		
		if(modList.size()>0) {
			for(Map<String, String> temp : modList) {
				String name = temp.get("name");
				String preOrder = temp.get("preOrder");
				adminCategoryService.update(name, preOrder);
			}
		}
		
		response.getWriter().write("저장되었습니다.");
	}
	
	@PostMapping("delete")
	public void delete(String names, HttpServletResponse response) throws IOException {
		
		String[] nameArray = names.split(",");
		int result = adminCategoryService.delete(nameArray);
		if(result > 0) {
			response.getWriter().write("삭제되었습니다.");
		}else {
			response.getWriter().write("삭제 실패");
		}
		
	}
	

}
