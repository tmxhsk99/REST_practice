package org.zerock.mapper;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.service.BoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {
	@Setter(onMethod_ = {@Autowired})
	private BoardService service;
	
	@Test
	public void testExist() {
		//boardService 객체가 제대로 주입가능한지 확인하는 코드 
		log.info(service);
		assertNotNull(service);
	}
	@Test
	public void testGetList() {
	 //service.getList().forEach(board -> log.info(board));
		service.getList(new Criteria(2,10)).forEach(board -> log.info(board));
	}
	@Test
	public void testGet() {
		log.info(service.get(1741L));
		
	}
	@Test
	public void testUpdate() {
		BoardVO board =service.get(1743L);
		if(board == null) {
			return;
		}
		board.setTitle("제목 수정합니다.");
		log.info("modify result :"+ service.modify(board));
	}
	@Test
	public void testDelete() {
		//게시물 번호의 존재 여브를 확인하고 테스트 할것 
		log.info("REMOVE RESULT:"+ service.remove(16892L));
	}
}
