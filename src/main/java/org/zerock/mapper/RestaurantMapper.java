package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.restaurant.Rcriteria;
import org.zerock.domain.restaurant.RestaurantVO;

public interface RestaurantMapper {
	
	public void insertSelectKey(RestaurantVO restaurant);
	
	public List<RestaurantVO> getList();
	
	public List<RestaurantVO> getListPaging(Rcriteria cri);
	
	public int delete(Long no);
	
	public int update(RestaurantVO restaurant);
	
	public RestaurantVO read(Long no);
	
	public int getTotalCnt(Rcriteria cri);
	
	public int deleteLikeResno(Long no);

	public List<RestaurantVO> getListPaging2(Rcriteria cri);
	
}
