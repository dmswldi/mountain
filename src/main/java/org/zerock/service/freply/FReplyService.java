package org.zerock.service.freply;

import java.util.List;

import org.zerock.domain.freeboard.FCriteria;
import org.zerock.domain.freply.FReplyVO;

public interface FReplyService {
	public int register(FReplyVO vo);
	
	public FReplyVO read(Long rno);
	
	public int modify(FReplyVO vo);
	
	public int remove(Long no);
	
	public List<FReplyVO> getList(Long board_no);
	public int getTotal(Long board_no);
}
