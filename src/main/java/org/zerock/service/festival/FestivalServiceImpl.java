package org.zerock.service.festival;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.festival.Fcriteria;
import org.zerock.domain.festival.FestivalVO;
import org.zerock.domain.mountain.MountainVO;
import org.zerock.mapper.FestivalMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class FestivalServiceImpl implements FestivalService{

	private FestivalMapper mapper;
	
	@Override
	public void register(FestivalVO festival) {
		mapper.insertSelectKey(festival);
		
	}

	@Override
	public FestivalVO read(int no) {
		return mapper.read(no);
	}

	@Override
	public List<FestivalVO> getList() {
		
		return mapper.getList();
	}

	@Override
	public boolean remove(int no) {
		
		log.info("remove... :" + no);
		return mapper.delete(no) ==1;
	}

	@Override
	public boolean modify(FestivalVO festival) {
		
		return (int) mapper.update(festival) ==1;
	}

	@Override
	public FestivalVO get(int no) {
		log.info("get..."+no);
		return mapper.get(no);
	}

	@Override
	public List<FestivalVO> getList(Fcriteria cri) {
		return mapper.getListPaging(cri);
	}

	@Override
	public int getTotal(Fcriteria cri) {
	
		return mapper.getTotalCount(cri);
	}

	@Override
	public MountainVO mountainLoc(String mname) {
		return mapper.mountainLoc(mname);
	}

	

	

	

	
	
	
	
}