package org.zerock.domain.mountain;

import lombok.Data;

@Data
public class MCriteria {

	private int curPage;
	private int amount;
	
	private String keyword;
	
	public MCriteria() {
		this(1, 8);// 3 * 3 정렬
	}

	public MCriteria(int curPage, int amount) {
	    this.curPage = curPage;
	    this.amount = amount;
	}
	
}
