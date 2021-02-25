package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.festival.Fcriteria;
import org.zerock.domain.festival.FestivalVO;
import org.zerock.domain.mountain.MnameVO;
import org.zerock.domain.mountain.MountainVO;


public interface FestivalMapper {
	// 게시물 리스트 
	public List<FestivalVO> getList();
    public List<FestivalVO> getListPaging(Fcriteria cri);
	
	// 게시물 작성
	public void insert(FestivalVO festival);
	public void insertSelectKey(FestivalVO festival);
	
 
	// 게시글 상세보기 = 
	public FestivalVO read(int no);
	
	// 게시글 삭제
	// 삭제가 완료되면 1, 아니면 0으로 출력하고자 메서드=int로 지정
	public int delete(int no);
	
	
	// 게시글 수정 
	public int update(FestivalVO festival);


	public FestivalVO get(int no);


	public int getTotalCount(Fcriteria cri);

	public MountainVO mountainLoc(String mname);

	
	

	

	
}
