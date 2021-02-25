package org.zerock.service.restaurant;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.restaurant.Rcriteria;
import org.zerock.domain.restaurant.RestaurantVO;
import org.zerock.mapper.RestaurantMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class RestaurantServiceImpl implements RestaurantService{
	
	private RestaurantMapper mapper;
	
	@Override
	public void register(RestaurantVO restaurant) {
		mapper.insertSelectKey(restaurant);
	}

	@Override
	public RestaurantVO read(Long no) {
		return mapper.read(no);
	}

	@Override
	public boolean modify(RestaurantVO restaurant) {
		return mapper.update(restaurant) == 1;
	}

	@Override
	public boolean remove(Long no) {
		return mapper.delete(no) == 1 && mapper.deleteLikeResno(no) == 1;
	}

	@Override
	public List<RestaurantVO> getList(Rcriteria cri) {
//		return mapper.getListPaging(cri);
		return mapper.getListPaging2(cri);
	}

	@Override
	public int getTotal(Rcriteria cri) {
		return mapper.getTotalCnt(cri);
	}

}
