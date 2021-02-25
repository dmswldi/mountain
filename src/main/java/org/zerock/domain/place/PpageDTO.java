package org.zerock.domain.place;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PpageDTO {
	private int startPage;
	private int endPage;

	private boolean prev;
	private boolean next;

	private int total;

	private Pcriteria cri;

	public PpageDTO(Pcriteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int) Math.ceil(cri.getPageNo() / 4.0) * 4;
		this.startPage = endPage - 3;
		
		int realEnd = (int) Math.ceil(total * 1.0 / cri.getAmount());
		
		endPage = Math.min(realEnd, endPage);
		
		this.prev = this.startPage > 1;
		this.next = endPage < realEnd;
	}
}
