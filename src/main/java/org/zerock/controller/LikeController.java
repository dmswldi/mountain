package org.zerock.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.member.MemberVO;
import org.zerock.domain.restaurant.LikeVO;
import org.zerock.service.like.LikeService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/restaurant/*")
@AllArgsConstructor
@Log4j
public class LikeController {
	private LikeService likeSvc;

	@PostMapping(value = "/like")
	public String like(LikeVO like, HttpSession session) {
		
		int resLike = likeSvc.getLike(like.getUserno(), like.getResno());
		int resDislike = likeSvc.getDislike(like.getUserno(), like.getResno());

		if (resLike >= 1 || resDislike >= 1) {
			likeSvc.likeRemove(like.getUserno(), like.getResno());
			likeSvc.likeInsert(like);
			likeSvc.likeUpdate(like.getResno());
		} else {
			likeSvc.likeInsert(like);
			likeSvc.likeUpdate(like.getResno());
		}
		return "redirect:/restaurant/list";
	}
	
	/* MOUNTAIN.get.jsp에서 ajax 사용 */
	@PostMapping("/like2")
	@ResponseBody
	public String like(LikeVO like) {
		int resLike = likeSvc.getLike(like.getUserno(), like.getResno());
		int resDislike = likeSvc.getDislike(like.getUserno(), like.getResno());

		if (resLike >= 1 || resDislike >= 1) {
			likeSvc.likeRemove(like.getUserno(), like.getResno());
			likeSvc.likeInsert(like);
			likeSvc.likeUpdate(like.getResno());
		} else {
			likeSvc.likeInsert(like);
			likeSvc.likeUpdate(like.getResno());
		}
		
		return "ssuccess";
	}
}
