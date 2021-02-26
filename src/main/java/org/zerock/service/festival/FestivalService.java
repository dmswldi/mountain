package org.zerock.service.festival;

import java.util.List;
import org.zerock.domain.mountain.MnameVO;
import org.zerock.domain.mountain.MountainVO;
import org.zerock.domain.festival.Fcriteria;
import org.zerock.domain.festival.FestivalVO;

public interface FestivalService {
	
	public void register(FestivalVO festival);
	
	public FestivalVO read(int no);
	
	public List<FestivalVO> getList();
	
	public List<FestivalVO> getList(Fcriteria cri);
	
	public boolean remove(int no);
	
	public boolean modify(FestivalVO festival);

	public FestivalVO get(int no);
	
	public int getTotal(Fcriteria cri);
	
	public MountainVO mountainLoc(Long mountain_no);
		
	
	
}