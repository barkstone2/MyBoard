package com.myboard.web.board.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.context.SpringBootTest;

import com.myboard.web.board.entity.BoardDTO;

@AutoConfigureTestDatabase(replace = Replace.NONE)
@SpringBootTest
class BoardServiceTest {
	
	@Autowired
	private BoardService service;
	
	@Test
	void testInsert() {
		String title = "testTitle";
		String content = "testContent";
		String writer = "testWriter";
		String pwd = "1234";
		BoardDTO dto = new BoardDTO();
		dto.setTitle(title);
		dto.setContent(content);
		dto.setWriter(writer);
		dto.setPwd(pwd);
		int result = service.insert(dto);
		assertTrue(result>0);
	}
	
	
	@Test
	void testGetView() {
		int no = 2; // AutoIncrement
		BoardDTO dto = service.getView(no);
		assertNotNull(dto);
		assertEquals(dto.getNo(), no);
		assertEquals(dto.getTitle(), "testTitle");
		assertEquals(dto.getContent(), "testContent");
		assertEquals(dto.getWriter(), "testWriter");
		assertEquals(dto.getPwd(), "1234");
		
	}
	
	
	
			
	

	

	
	
	
}
