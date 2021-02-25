package org.zerock.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.admin.Acriteria;
import org.zerock.domain.admin.AdminMemberVO;
import org.zerock.domain.admin.ApageDTO;
import org.zerock.domain.admin.VisitVO;
import org.zerock.domain.member.MemberVO;
import org.zerock.service.admin.AdminMemberService;
import org.zerock.service.visit.VisitService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor // 생성자 자동생성
@RequestMapping("/admin/*")
@Log4j
public class AdminController {
	
	private VisitService visitSvc;
	private AdminMemberService memberSvc;
	
	@GetMapping("/index")
	public String index(RedirectAttributes rttr, HttpSession session, Model model) {
		MemberVO user = (MemberVO) session.getAttribute("authUser");
		try {
			if(user.getManager() == 0 || user == null) {
				rttr.addFlashAttribute("message2", "관리자만이용 가능합니다");
				return "redirect:/index.jsp";
			} 
			} catch (NullPointerException e) {
				e.printStackTrace();
				rttr.addFlashAttribute("message2", "관리자만이용 가능합니다");
				return "redirect:/index.jsp";
			}
		
         int today = visitSvc.getToday();
         int total = visitSvc.getTotal();
         int memberCnt = memberSvc.getMemberCnt();
         log.info("*****************today*****" + today);
         log.info("*****************total*****" + total);
         model.addAttribute("today", today);
         model.addAttribute("total", total);
         model.addAttribute("memberCnt", memberCnt);
		
			return "/admin/index";
		}
	
	@GetMapping("/memberlist")
	public String list(Model model, @ModelAttribute("cri") Acriteria cri, RedirectAttributes rttr, HttpSession session) {
	    MemberVO user = (MemberVO) session.getAttribute("authUser");
	    try {
			if(user.getManager() == 0 || user == null) {
				rttr.addFlashAttribute("message2", "관리자만이용 가능합니다");
				return "redirect:/index.jsp";
			} 
			} catch (NullPointerException e) {
				e.printStackTrace();
				rttr.addFlashAttribute("message2", "관리자만이용 가능합니다");
				return "redirect:/index.jsp";
			}
		List<AdminMemberVO> mlist = memberSvc.getList(cri);
		 int total = memberSvc.getTotal(cri);
		ApageDTO memberDto = new ApageDTO(cri, total);
		model.addAttribute("memberList", mlist);
	    model.addAttribute("page", memberDto);
	    
	    return "/admin/memberlist";
		}
	
	@GetMapping("/adminlist")
	public String adminlist(Model model, @ModelAttribute("cri") Acriteria cri, RedirectAttributes rttr, HttpSession session) {
		  MemberVO user = (MemberVO) session.getAttribute("authUser");
		    try {
				if(user.getManager() == 0 || user == null) {
					rttr.addFlashAttribute("message2", "관리자만이용 가능합니다");
					return "redirect:/index.jsp";
				} 
				} catch (NullPointerException e) {
					e.printStackTrace();
					rttr.addFlashAttribute("message2", "관리자만이용 가능합니다");
					return "redirect:/index.jsp";
				}
		List<AdminMemberVO> alist = memberSvc.getAdminList(cri);
		 int total = memberSvc.getAdminCnt();
		ApageDTO adminDto = new ApageDTO(cri, total);
		model.addAttribute("adminList", alist);
	    model.addAttribute("page", adminDto);

	    return "/admin/adminlist";
		}
	
	@PostMapping(value="/adminchange")
	public String adminChange(RedirectAttributes rttr, HttpSession session, @RequestParam(value="chbox[]") List<String> checkArr) {
		MemberVO user = (MemberVO) session.getAttribute("authUser");
		try {
			if(user.getManager() == 0 || user == null) {
				rttr.addFlashAttribute("message2", "관리자만이용 가능합니다");
				return "redirect:/index.jsp";
			} 
			} catch (NullPointerException e) {
				e.printStackTrace();
				rttr.addFlashAttribute("message2", "관리자만이용 가능합니다");
				return "redirect:/index.jsp";
			}
		log.info(checkArr);
		if(user.getManager() == 1 && user.getId().equals("admin")) {
			for(String i : checkArr) {
				Long no = Long.parseLong(i);
				log.info(no);
				memberSvc.managerChange(no);
			}

			}
		
		return "redirect:/admin/adminlist";
	}
	
	@PostMapping(value="/generalchange")
	public String generalChange(RedirectAttributes rttr, HttpSession session, @RequestParam(value="chbox[]") List<String> checkArr) {
		MemberVO user = (MemberVO) session.getAttribute("authUser");
		log.info(checkArr);
		try {
			if(user.getManager() == 0 || user == null) {
				rttr.addFlashAttribute("message2", "관리자만이용 가능합니다");
				return "redirect:/index.jsp";
			} 
			} catch (NullPointerException e) {
				e.printStackTrace();
				rttr.addFlashAttribute("message2", "관리자만이용 가능합니다");
				return "redirect:/index.jsp";
			}
		if(user.getManager() == 1 && user.getId().equals("admin")) {
			for(String i : checkArr) {
				Long no = Long.parseLong(i);
				log.info(no);
				memberSvc.generalMemberChange(no);
			}

			}
		
		return "redirect:/admin/adminlist";
	}
}