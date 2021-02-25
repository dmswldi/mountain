package org.zerock.service.freply;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.freply.FReplyVO;
import org.zerock.mapper.FReplyMapper;
import org.zerock.mapper.FreeBoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class FReplyServiceImpl implements FReplyService {

	@Setter(onMethod_ = @Autowired)
	private FReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private FreeBoardMapper boardMapper;

	
	@Override
	public int register(FReplyVO vo) { 
		return mapper.insertSelectKey(vo);
	}
	
	@Override
	public FReplyVO read(Long no) {
		return mapper.read(no);
	}

	@Override
	public int modify(FReplyVO vo) {
		return mapper.update(vo);
	}

	@Override
	public int remove(Long no) { 
		return mapper.delete(no);
	}

	@Override
	public List<FReplyVO> getList(Long board_no) {
		return mapper.getList(board_no);
	}
	@Override
	public int getTotal(Long board_no) {
		return mapper.getTotalCount(board_no);
	}

}
