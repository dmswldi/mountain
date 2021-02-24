package org.zerock.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.member.MemberVO;
import org.zerock.domain.mountain.MCriteria;
import org.zerock.domain.mountain.MPageDTO;
import org.zerock.domain.mountain.MountainVO;
import org.zerock.service.file.FileUpService;
import org.zerock.service.mountain.MountainService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@RequestMapping("/*")
public class MountainController {

	private MountainService service;
	
	private FileUpService fileupSvc;
	
	
	@GetMapping("/register")
	public String register(HttpSession session) {// 주소 api
		Object user = session.getAttribute("authUser");
		
		// only manager
		if(user != null && ((MemberVO) user).getManager() == 1 ) {
			return "/register";
		}
		session.setAttribute("available", "notPermitted");
		return "redirect:/list";
	}
	
	@PostMapping("/register")
	public String register(MountainVO mountain, Model model, RedirectAttributes rttr, 
			HttpSession session, MultipartFile file) {
		Object user = session.getAttribute("authUser");
		
		// only manager
		if(user != null && ((MemberVO) user).getManager() == 1 ) {
			if(service.existMname(mountain.getMname())) {// 같은 산 이름이 존재
				model.addAttribute("result", "notUnique");
				model.addAttribute("mountain", mountain);
				return "/register";
			} 
			
			if (!mountain.getMname().matches("^[가-힣]+산$")) {
				model.addAttribute("result", "wrongPattern");
				model.addAttribute("mountain", mountain);
				return "/register";
			} 
			
			service.register(mountain);// no 얻어서 파일 이름 지정 위해
			
			// image upload
			if(file != null && file.getSize() > 0) {
				mountain.setFilename("mountain_" + mountain.getNo() + "_" + file.getOriginalFilename());
				service.modify(mountain);
				
				try {
					fileupSvc.transfer(file, mountain.getFilename());
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			rttr.addFlashAttribute("result", "regSuccess");
			
		} else {// not manager
			session.setAttribute("available", "notPermitted");
		}
		
		return "redirect:/list";
	}

	@GetMapping("/get")
	public void get(@RequestParam("no") Long no,
			@ModelAttribute("cri") MCriteria cri, Model model) {// @RequestParam("no") 매개변수 매핑
		
		MountainVO mountain = service.get(no);
		model.addAttribute("mountain", mountain);
		// /views/get.jsp			
	}
	
	@PostMapping(value = "/modify")// @RequestBody !!!!!!!!!!!
	public ResponseEntity<String> modify(MountainVO mountain, 
			HttpSession session, MultipartFile file){// req의 body가 자바 객체로 변환
		Object user = session.getAttribute("authUser");
		/*
		List<MultipartFile> list = request.getFiles("file");
		for(MultipartFile file : list) {
			System.out.println("what: " + file);
		}*/
		
		// only manager
		if(user != null && ((MemberVO) user).getManager() == 1 ) {
			
			if (service.modify(mountain)) {
				
				// image re-upload
				if(file != null && file.getSize() > 0) {
					// 이전 이미지 삭제 필요
					// List<MultipartFile> fileList = request.getFiles("file");
					//MultipartFile file = request.getFiles("file").get(0);
					
					mountain.setFilename("mountain_" + mountain.getNo() + "_" + file.getOriginalFilename());
					service.modify(mountain);
					
					try {
						fileupSvc.transfer(file, mountain.getFilename());
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				
				session.setAttribute("result", "modSuccess");
				return new ResponseEntity<>(HttpStatus.OK);
			} 
		}
		
		return new ResponseEntity<>("notPermitted", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value = "/check",
				 consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<String> duplicateCheck(@RequestBody String mname) {
		if(service.existMname(mname)) {// 같은 산 이름이 존재
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@DeleteMapping("/remove")
	public ResponseEntity<String> remove(@RequestParam Long no, HttpSession session){
		Object user = session.getAttribute("authUser");
		
		// only manager
		if(user != null && ((MemberVO) user).getManager() == 1 ) {
			if (service.remove(no)) {
				session.setAttribute("result", "delSuccess");
				return new ResponseEntity<>(HttpStatus.OK);
			} 
		}
		
		return new ResponseEntity<>("notPermitted", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping("/list")
	public void list(@ModelAttribute("cri") MCriteria cri, Model model) {
		int total = service.getTotal(cri);
		model.addAttribute("pages", new MPageDTO(total, cri));
		
		List<MountainVO> list = service.getList(cri);
		model.addAttribute("list", list);
		// /views/list.jsp
	}
	
}
