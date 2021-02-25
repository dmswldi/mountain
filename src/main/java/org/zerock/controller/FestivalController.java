package org.zerock.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.festival.Fcriteria;
import org.zerock.domain.festival.FestivalVO;
import org.zerock.domain.festival.FpageDTO;
import org.zerock.domain.mountain.MCriteria;
import org.zerock.domain.mountain.MountainVO;
import org.zerock.service.festival.FestivalService;
import org.zerock.service.file.FileUpService;
import org.zerock.service.mountain.MountainService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/festival/*")
@AllArgsConstructor
@Log4j
public class FestivalController {

	private FestivalService service;
	// mname, no 가져올려고 사용
	private MountainService mountainService;
	private FileUpService fileUpSvc;
	
	
	/* MOUNTAIN.get.jsp에서 ajax 사용 */
	@PostMapping("/list2")
	@ResponseBody
	public List<FestivalVO> list(Fcriteria cri) {
	      List<FestivalVO> list = service.getList(cri);
	      return list;
	}
	
	// 등록
	@PostMapping("/register")
	public String register(FestivalVO festival,@RequestParam String mountain_no, RedirectAttributes rttr, MultipartFile file) {
		//  RedirectAttributes에서 제공하는 메소드: addFlashAttribute() -> 리다이렉트 이후 소멸
		System.out.println(mountain_no);
		service.register(festival);
		
		
//	임시mountainService.register(festival);
		/*
		//FileUpload
        if(file !=null) {
		   festival.setFilename(festival.getNo() +"_" +file.getOriginalFilename());
		   service.modify(festival);
		   fileUpSvc.write(file, festival.getFilename());
        }
		*/
		/*2021.02.23 추가
		MemberVO user = (MemberVO) session.getAttribute("authUser");
		
		festival.setFilename("");
		if (user.getManager() == 1) {
			service.register(festival);
			if(file != null) {
				festival.setFilename("festival_"+festival.getNo()+"_"+file.getOriginalFilename());
				service.modify(festival);
				try {
					fileUpSvc.transfer(file, festival.getFilename());
					} catch (Exception e) {
						e.printStackTrace();
					}
			}
			*/
		
		
		//FileUpload 21.02.23 추가
        if(file !=null) {
		   festival.setFilename(festival.getNo() +"_" +file.getOriginalFilename());
		   service.modify(festival);
		   try {
			fileUpSvc.transfer(file, festival.getFilename());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        }
		
		
			
		rttr.addFlashAttribute("result", festival.getNo());
		rttr.addFlashAttribute("message", festival.getNo() + "등록 완료!");
	
		
		return "redirect:/festival/list";
	}
	
	@GetMapping("/register")
	public void register(@ModelAttribute("cri") MCriteria mcri, Fcriteria cri, Model model) {
		
		List<FestivalVO> flist = service.getList(cri);
		List<MountainVO> list = mountainService.getList(mcri);
		model.addAttribute("flist",flist);
		model.addAttribute("list",list);
	}
	
	// 리스트
	// 목록으로 돌아올 때 404 오류 뜰때
	@GetMapping("/list")
	public void list(Model model, @ModelAttribute("cri")Fcriteria cri,@ModelAttribute("mcri")MCriteria mcri, @ModelAttribute("mvo") MountainVO mvo) {
		//FpageDTO dto = new FpageDTO(cri, total);
		
	List<FestivalVO> list = service.getList(cri);
		
		int total = service.getTotal(cri);
		
		FpageDTO dto = new FpageDTO(cri, total);
		log.info("**********cri**********" + cri);
		 
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", dto);
				
		/*
		 * model.addAttribute("list", service.getList());
		 * 
		 * log.info("list");
		 */
	}
	
	// get => no/ modify
		@GetMapping({"/get", "/modify"})
		public void get(@RequestParam("no") int no, @RequestParam String mname, Model model,@ModelAttribute("cri")Fcriteria cri) {
			log.info("/get or modify");
			MountainVO mvo = service.mountainLoc(mname);
			//MountainVO mvo = service.mountainLoc(mloc);
			FestivalVO vo =service.get(no);	
			//service.get(no)
			model.addAttribute("festival",vo);
			model.addAttribute("mountain",mvo);
		}
	
	// 수정
	@PostMapping("/modify")
	public String modify(FestivalVO festival, @ModelAttribute("cri")Fcriteria cri, RedirectAttributes rttr,  MultipartFile file) {
		//servicel.modify() 수정여부 ==>boolean으로 처리?
		log.info("modify: " + festival);
		
		if(service.modify(festival)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
        
		boolean count = service.modify(festival);
		
		if(count) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/festival/list";
	
	}
	
	
	
	// 삭제
	// 삭제는 반드시 post 방식
	@PostMapping("/remove")
	public String remove(@RequestParam("no")int no, @ModelAttribute("cri")Fcriteria cri,RedirectAttributes rttr) {
		
		log.info("remove: " +no);
		
		
		if(service.remove(no)) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("message", "글 삭제");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		return "redirect:/festival/list";
	}
	
	
	
}
