package org.zerock.domain.restaurant;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class Rcriteria {
	private int pageNo;
	private int amount;
	private String type;
	private String keyword;
	private Long userno;

	public Rcriteria() {
		this(1, 4);
	}

	public Rcriteria(int pageNo, int amount) {
		this.pageNo = pageNo;
		this.amount = amount;
	}

	public String[] getTypeArr() {
		if (this.type == null) {
			return new String[] {};
		} else {
			return type.split("");
		}
	}
}
