package org.zerock.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.member.MemberVO;
import org.zerock.domain.place.Pcriteria;
import org.zerock.domain.place.PlaceVO;
import org.zerock.domain.place.PpageDTO;
import org.zerock.service.file.FileUpService;
import org.zerock.service.place.PlaceService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/place/*")
@AllArgsConstructor
@Log4j
public class PlaceController {
	private PlaceService service;
	private FileUpService fileUpSvc;

	@GetMapping("/list")
	public void list(Model model, @ModelAttribute("cri") Pcriteria cri) {
		List<PlaceVO> list = service.getList(cri);
		int total = service.getTotal(cri);
		PpageDTO dto = new PpageDTO(cri, total);
		log.info("*****************" + list + "********************");
		model.addAttribute("list", list);
		model.addAttribute("page", dto);

	}

	/* MOUNTAIN.get.jsp에서 ajax 사용 */
	@PostMapping("/list2")
	public ResponseEntity<List<PlaceVO>> list(Pcriteria cri){
		List<PlaceVO> list = service.getList(cri);
		return new ResponseEntity<>(list , HttpStatus.OK);
	}
	
	@PostMapping("/register")
	public String register(PlaceVO place, MultipartFile file, RedirectAttributes rttr, HttpSession session) throws Exception {
		
		MemberVO user = (MemberVO) session.getAttribute("authUser");
		
		place.setFilename("");
		if (user.getManager() == 1) {
			service.register(place);
			if(file != null  && file.getSize() > 0) {
				place.setFilename("place_"+place.getNo()+"_"+file.getOriginalFilename());
				service.modify(place);
				try {
					fileUpSvc.transfer(file, place.getFilename());
					} catch (Exception e) {
						e.printStackTrace();
					}
			}
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("message", place.getNo() + "번 글이 등록되었습니다");
		}

		return "redirect:/place/list";
	}


	@GetMapping("/register")
	public String register(RedirectAttributes rttr, HttpSession session) {
		MemberVO user = (MemberVO) session.getAttribute("authUser");
		try {
		if(user.getManager() == 0 || user == null) {
			rttr.addFlashAttribute("message2", "관리자만이용 가능합니다");
			return "redirect:/place/list";
		}
		} catch (NullPointerException e) {
			e.printStackTrace();
			rttr.addFlashAttribute("message2", "관리자만이용 가능합니다");
			return "redirect:/place/list";
		}
		return "/place/register";
	}

	@GetMapping("/remove")
	public String remove(RedirectAttributes rttr) {
		rttr.addFlashAttribute("message2", "페이지가 존재하지 않습니다");
		return "redirect:/place/list";
	}

	
	@GetMapping("/modify")
	public String get(Long no, Model model, @ModelAttribute("cri") Pcriteria cri,RedirectAttributes rttr, HttpSession session) {
		MemberVO user = (MemberVO) session.getAttribute("authUser");
		try {
		if(user.getManager() == 0 || user == null) {
			rttr.addFlashAttribute("message2", "관리자만이용 가능합니다");
			return "redirect:/place/list";
		}
		} catch (NullPointerException e) {
			e.printStackTrace();
			rttr.addFlashAttribute("message2", "관리자만이용 가능합니다");
			return "redirect:/place/list";
		}
		PlaceVO vo = service.read(no);
		log.info("********* modify get *************" + vo.getFilename() + "*******************");
		model.addAttribute("place", vo);
		return "/place/modify";
	}

	@PostMapping("/remove")
	public String remove(Long no, RedirectAttributes rttr, Pcriteria cri, HttpSession session) throws Exception {
		MemberVO user = (MemberVO) session.getAttribute("authUser");
		if (user.getManager() == 1) {
			service.remove(no);

			}
			rttr.addAttribute("pageNo", cri.getPageNo());
			rttr.addAttribute("amount", cri.getAmount());
			rttr.addAttribute("type", cri.getType());
			rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/place/list";
	}

	@PostMapping("/modify")
	public String modify(PlaceVO place, RedirectAttributes rttr, Pcriteria cri, HttpSession session,
			 MultipartFile file) throws Exception {
		PlaceVO vo = new PlaceVO();
		vo = service.read(place.getNo());
		log.info(place);
		log.info("****************    filename   **********" + file.getOriginalFilename() + "******************************");
		log.info("****************    vo.filename   **********" + vo.getFilename() + "******************************");
		MemberVO user = (MemberVO) session.getAttribute("authUser");
		if (user.getManager() == 1) {
			place.setFilename(vo.getFilename());
			service.modify(place);
			if(file != null && file.getSize() > 0) {
				place.setFilename("place_"+place.getNo()+"_"+file.getOriginalFilename());
				service.modify(place);
				rttr.addFlashAttribute("result", "success");
				rttr.addFlashAttribute("message", place.getNo() + "번 글이 수정되었습니다");
				try {
					fileUpSvc.transfer(file, place.getFilename());
					} catch (Exception e) {
						e.printStackTrace();
					}
			}
			
				rttr.addFlashAttribute("result", "success");
				rttr.addFlashAttribute("message", place.getNo() + "번 글이 수정되었습니다");

		}
		rttr.addAttribute("pageNo", cri.getPageNo());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());

		return "redirect:/place/list";
	}

}
