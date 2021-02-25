package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.freply.FReplyVO;




public interface FReplyMapper {
	public int insertSelectKey(FReplyVO vo);
	public FReplyVO read(Long no);
	public int delete(Long no);
	public int update(FReplyVO reply);
	public List<FReplyVO> getList(Long board_no);
	public int getTotalCount(Long board_no);
}
