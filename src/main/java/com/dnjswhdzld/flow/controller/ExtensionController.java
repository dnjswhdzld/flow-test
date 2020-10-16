package com.dnjswhdzld.flow.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dnjswhdzld.flow.service.ExtensionService;
import com.dnjswhdzld.flow.vo.ExtensionVO;

@Controller
public class ExtensionController {
	
	@Autowired
	private ExtensionService extensionService;
	
	// 확장자 셋팅 페이지
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "extension")
	public String getExtension(ExtensionVO evo, Model model) {
		Map<String, Object> map = extensionService.extensionList(); 
		List<ExtensionVO> defaultExtensionList = new ArrayList<ExtensionVO>();
		List<ExtensionVO> customExtensionList = new ArrayList<ExtensionVO>();
		defaultExtensionList = (List<ExtensionVO>) map.get("defaultExtensionList"); 
		customExtensionList = (List<ExtensionVO>) map.get("customExtensionList"); 
		
		model.addAttribute("defaultExtensionList",defaultExtensionList);
		model.addAttribute("customExtensionList",customExtensionList);
		return "extension";
	}
	
	// 커스텀 확장자 생성
	@RequestMapping(value = "insertExtension")
	public String insertExtension(ExtensionVO evo) {
		try {
			extensionService.extensionInsert(evo);
		} catch (NullPointerException e) {
			e.printStackTrace();
		}
		return "extension";
	}
	
	// 고정 확장자 체크
	@RequestMapping(value = "updateDefaultExtension")
	public String updateDefaultExtion(ExtensionVO evo) {
		try {
			extensionService.defaultExtensionUpdate(evo);
		} catch (NullPointerException e) {
			e.printStackTrace();
		}
		return "extension";
	}
	
	// 확장자 삭제
	@RequestMapping(value = "deleteExtension")
	public String deleteExtension(ExtensionVO evo) {
		try {
			extensionService.extensionDelete(evo);
		} catch (NullPointerException e) {
			e.printStackTrace();
		}
		return "extension";
	}
	
	// 확장자 불러오기
	@ResponseBody
	@RequestMapping(value = "selectExtension")
	public List<ExtensionVO> selectExtension() {
		List<ExtensionVO> extensionList = extensionService.extensionTotalList();
		return extensionList;
		
		// 서버에서 처리하는 로직
//		List<ExtensionVO> extensionList = extensionService.extensionTotalList();
//		if (evo.getExtension_name() != null) {
//			try {
//				for (ExtensionVO extension : extensionList) {
//					if (extension.getExtension_name().equals(evo.getExtension_name())) {
//						return "fail";
//					}
//				}
//			} catch (NullPointerException e) {
//				e.printStackTrace();
//				return "fail";
//			}
//		}
//		return "success";
	}
	
}
