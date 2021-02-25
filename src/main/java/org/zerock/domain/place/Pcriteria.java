package org.zerock.domain.place;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class Pcriteria {
	private int pageNo;
	private int amount;
	private String type;
	private String keyword;

	public Pcriteria() {
		this(1, 4);
	}

	public Pcriteria(int pageNo, int amount) {
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
