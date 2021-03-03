package com.myboard.web.board.service;

import org.junit.jupiter.api.Test;
import org.mybatis.spring.boot.test.autoconfigure.MybatisTest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.context.SpringBootTest;

@AutoConfigureTestDatabase(replace = Replace.NONE)
@SpringBootTest
class BoardServiceTest {
	
	@Autowired
	private BoardService service;
	
	@Test
	void testGetView() {
		System.out.println(service.getView(1));
	}

}
