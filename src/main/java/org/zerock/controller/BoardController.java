package org.zerock.controller;

import java.lang.ProcessBuilder.Redirect;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import oracle.net.aso.a;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	private BoardService service;

	@GetMapping("/list")
	public void list(Model model, Criteria cri) {
		log.info("list "+cri);
		model.addAttribute("list",service.getList(cri));
		//model.addAttribute("pageMaker",new PageDTO(cri, 123));
		
		int total = service.getTotal(cri);
		
		log.info("total : "+total);
		model.addAttribute("pageMaker",new PageDTO(cri, total));
	}
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno") Long bno, Model model ,@ModelAttribute("cri") Criteria cri) {
		/*get 메서드에 bno값을 좀더 명시적으로 처리하는 @RequestParam을 이용해서 지정합니다 (파라미터이름과 변수이름을 기준으로 동작하기에 생략해도 무방)
		 * 게시물 전달을위해 Model을 param으로 지정함*/
		log.info("/get or modify");
		model.addAttribute("board",service.get(bno));
	}
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr ,@ModelAttribute("cri") Criteria cri) {
		log.info("modify :" + board);
		
		if(service.modify(board)) {
			rttr.addFlashAttribute("result","success");
		}	
		return "redirect:/board/list"+cri.getListLink();
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("remove...."+bno);
		System.out.println("삭제 되는 글 번호"+bno);
		//그 번호에 맞는 첨부파일리스트를 불러옴
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		System.out.println(service.remove(bno));
		if(service.remove(bno)) {
			//deleteAttachFiles
			
			deleteFiles(attachList);
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/board/list"+cri.getListLink();
	}
	@GetMapping("/register")
	public void register(BoardVO board) {
	
	}
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {

		System.out.println("======================================================");
		System.out.println("register: " + board);

		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach->System.out.println(attach));
			}
		System.out.println("======================================================");
		service.register(board);

		rttr.addFlashAttribute("result", board.getBno());

		return "redirect:/board/list";
	}
	@GetMapping(value ="/getAttachList",
				produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		log.info("getAttachList" + bno);
		System.out.println("getAttachList" + bno);
		return new ResponseEntity<>(service.getAttachList(bno),HttpStatus.OK);
		
	}
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		log.info("delete attach files...................");
		log.info(attachList);
		
		attachList.forEach(attach->{
			try {
				Path file = Paths.get("C:\\upload\\"+attach.getUploadPath()+attach.getUuid()+"_"+attach.getFileName());
				
				Files.deleteIfExists(file);
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_"+attach.getUploadPath()+"_"+attach.getFileName());
					
					Files.delete(thumNail);
				}
						
			} catch (Exception e) {
				log.error("delete file error" + e.getMessage());
			}//end catch
			
		});//end foreach
		
	}
	
}
