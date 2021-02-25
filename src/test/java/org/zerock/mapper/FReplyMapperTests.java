package org.zerock.mapper;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.fail;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.freply.FReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class FReplyMapperTests {
	
	private Long[] board_noArr = {1L, 2L, 3L, 4L, 5L};
	
	@Setter(onMethod_ = @Autowired)
	private FReplyMapper mapper; 
	
	@Test
	public void testMapper() {
		assertNotNull(mapper);
	}
	
	@Test
	public void testCreate2() {
		FReplyVO vo = new FReplyVO();
		vo.setBoard_no(1L); // FREEBOARD 테이블에 있는 값으로 넣으세요. 
		vo.setReply("뽐뽐");
		vo.setReplyer("BOM");
		
		mapper.insertSelectKey(vo);
		
		try {
			vo.setBoard_no(6L); // tbl_board 테이블에 없는 값
			mapper.insertSelectKey(vo);
			fail();
		} catch (Exception e) {

		}
	}

	@Test
	public void testRead() {
		Long no = 1L;
		
		FReplyVO vo = mapper.read(no);
		
		assertEquals("댓글 테스트Create2", vo.getReply());//실제 있는 data로 입력해야함_댓글조회
	}
		
	@Test
	public void testDelete() {
		Long no = 3L;
		mapper.delete(no);
	}
	
	@Test
	public void testUpdate() {
		FReplyVO vo = new FReplyVO();
		vo.setNo(2L);
		vo.setReply("up수정된 댓글");
		mapper.update(vo);
		
		vo = mapper.read(2L);
		
		assertEquals("up수정된 댓글", vo.getReply());
	}
	@Test
	public void testGetList() {
		log.info(mapper.getList(5L));
	}

//	@Test // 책 383쪽
//	public void testCreate() {
//		IntStream.rangeClosed(1, 10).forEach(i -> {
//			log.info(i + ", " + (i % 5));
//			
//			FReplyVO vo = new FReplyVO();
//			vo.setBoard_no(board_noArr[i % 5]);
//			vo.setReply("댓글 테스트Create" + i);
//			vo.setReplyer("replyer" + i);
//			
//			mapper.insertSelectKey(vo);
//		});
//			
//	}
	
}






