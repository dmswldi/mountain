package org.zerock.domain.freply;

import java.util.Date;

import lombok.Data;

@Data
public class FReplyVO {
	private Long no;
	private Long board_no; //FreeBoard 원글의 no
	
	private String reply;
	private String replyer;
	private Date regdate;
	private Date updateDate;
	
}
