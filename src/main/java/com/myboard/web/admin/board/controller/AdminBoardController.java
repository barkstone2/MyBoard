package com.myboard.web.admin.board.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.myboard.web.admin.board.service.AdminBoardService;
import com.myboard.web.board.category.service.CategoryService;
import com.myboard.web.board.entity.BoardDTO;
import com.myboard.web.board.entity.BoardViewDTO;
import com.myboard.web.board.file.entity.FileDto;
import com.myboard.web.board.file.service.FileService;
import com.myboard.web.board.recommend.service.RecommendService;
import com.myboard.web.board.service.BoardService;

@Controller
@RequestMapping("/admin/board/")
public class AdminBoardController {
	
	@Autowired
	private BoardService boardService;
	@Autowired
	private FileService fileService;
	@Autowired
	private RecommendService recommendService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private AdminBoardService adminBoardService; 
	
	
	@GetMapping("list")
	public String list(
			@RequestParam(required = false, name="p", defaultValue = "1") int page, 
			@RequestParam(required = false, name = "s_op", defaultValue = "") String searchOption,
			@RequestParam(required = false, name = "s_d", defaultValue = "") String searchData,
			@RequestParam(required = false, name = "ctg", defaultValue = "전체") String category,
			@RequestParam(required = false, name = "ctgp", defaultValue = "1") int categoryPage,
						Model model) {
		
		int conPerPage = 10; // 페이지 당 개시글 수(limit)
		int pageNavLength = 5; // 페이징 번호 범위
	
		int totalCategoryCount = categoryService.getTotalCount();
		model.addAttribute("totalCategoryCount", totalCategoryCount);
		
		List<String> categoryList = categoryService.getList();
		model.addAttribute("categoryList", categoryList);
		
		Map<String, Integer> pager = boardService.getPager(conPerPage, pageNavLength, page, searchOption, searchData, category);
		model.addAttribute("pager", pager);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("searchData", searchData);
		model.addAttribute("category", category);
		model.addAttribute("categoryPage", categoryPage);
		
		List<BoardViewDTO> list = boardService.getViewList(pager.get("offSet"), conPerPage, searchOption, searchData, category);
		model.addAttribute("list", list);
		return "admin.board.list";
	}
	
	@PostMapping("chanctg")
	public String changeCategory(String ctgVal, int[] nos, Model model) {
		
		String msg = "카테고리 수정 성공";
		String reUrl = "/admin/board/list";
		
		int result = adminBoardService.updateCategory(ctgVal, nos);
		if(result==nos.length) {
		}else {
			msg = "카테고리 수정 실패";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("reUrl", reUrl);
		
		return "util.message";
	}
	
	@PostMapping("delsel")
	public String delsel(int[] nos, Model model) {
		
		String msg = "게시글 삭제 성공";
		String reUrl = "/admin/board/list";
		
		int result = adminBoardService.deletePosts(nos);
		if(result==nos.length) {
		}else {
			msg = "게시글 삭제 실패";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("reUrl", reUrl);
		
		return "util.message";
	}
	
	@GetMapping("view")
	public String view(int no, Model model) {
		BoardDTO dto = boardService.getView(no);
		model.addAttribute("dto", dto);
		
		FileDto fileDto = fileService.getFile(dto.getFileNo());
		model.addAttribute("fileDto", fileDto);
		
		return "/board/view";
	}
	
}
