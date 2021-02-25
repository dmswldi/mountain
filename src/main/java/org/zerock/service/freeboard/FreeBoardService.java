package org.zerock.service.freeboard;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.zerock.domain.freeboard.FCriteria;
import org.zerock.domain.freeboard.FreeBoardVO;
import org.zerock.domain.member.MemberVO;

public interface FreeBoardService {

	public void register(FreeBoardVO vo);

	public List<FreeBoardVO> getList(FCriteria cri);//paging처리를 위한 code
	public int getTotal(FCriteria cri);

	public FreeBoardVO get(Long no);
	
	public boolean remove(Long no);

	public boolean modify(FreeBoardVO vo);
	


}
