package org.zerock.mapper;


import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.zerock.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
// Java Config
// @ContextConfiguration(classes = { org.zerock.config.PersistenceConfig.class
// })
@Log4j
public class ReplyMapperTests {

	// 테스트 전에 해당 번호의 게시물이 존재하는지 반드시 확인할 것
	private Long[] bnoArr = { 16899L, 16898L, 16897L, 16896L, 16895L };

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;

	@Test
	public void testCreate() {

		IntStream.rangeClosed(1, 10).forEach(i -> {

			ReplyVO vo = new ReplyVO();

			// 게시물의 번호
			vo.setBno(bnoArr[i % 5]);
			vo.setReply("댓글 테스트 " + i);
			vo.setReplyer("replyer" + i);

			mapper.insert(vo);
		});

	}
	
	@Test
	public void testMapper() {

		log.info(mapper);
	}

}
