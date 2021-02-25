package org.zerock.domain.restaurant;


import lombok.Data;

@Data
public class RestaurantVO {
	private Long no;
	private Long mountain_no;
	private String rname;
	private String rloc;
	private String contact;
	private String menu;
	private String description;
	private String filename;
	private String mname;
	private Long likecnt;
	private Long dislikecnt;
	private Integer likeClick;
	private Integer dislikeClick;

}
