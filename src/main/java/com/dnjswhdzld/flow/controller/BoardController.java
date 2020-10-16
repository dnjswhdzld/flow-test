package com.dnjswhdzld.flow.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.dnjswhdzld.flow.service.BoardService;
import com.dnjswhdzld.flow.vo.BoardVO;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	// 파일 업로드
	@RequestMapping(value = "board")
	public String getBoard(BoardVO bvo) {
		
		return "board";
	}
	
	// 파일 업로드 게시글 저장
	@RequestMapping(value = "insertBoard")
	public String insertBoard(BoardVO bvo) {
		boardService.insertBoard(bvo);
		return "board";
	}
	
	// 파일 업로드 파일저장
	@RequestMapping(value = "fileUpload")
	public String fileUpload(BoardVO bvo) throws IOException{
		MultipartFile uploadFile = bvo.getUpload_file();
		if (!uploadFile.isEmpty()) {
			String file_path = "/usr/local/tomcat/webapps/Flowtest/uploadfile/"+uploadFile.getOriginalFilename();
			File destdir = new File(file_path);
			if(!destdir.exists()) {
				destdir.mkdirs();
			}
			uploadFile.transferTo(new File(file_path));
		}
		return "board";
	}
	
	// 파일 리스트
	@RequestMapping(value = "boardlist")
	public String getBoardList(BoardVO bvo, Model model) {
		
		List<BoardVO> boardList = boardService.selectBoard();
		model.addAttribute("boardList",boardList);
		return "boardlist";
	}
}
