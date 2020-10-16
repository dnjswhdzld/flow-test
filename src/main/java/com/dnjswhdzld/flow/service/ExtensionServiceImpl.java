package com.dnjswhdzld.flow.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dnjswhdzld.flow.dao.ExtensionDAO;
import com.dnjswhdzld.flow.vo.ExtensionVO;

@Service
public class ExtensionServiceImpl implements ExtensionService{

	@Autowired
	private ExtensionDAO extensionDAO;
	
	// 고정 확장자
	@Override
	public void defaultExtensionUpdate(ExtensionVO evo) {
		extensionDAO.extensionDefaultUpdate(evo);
	}
	
	// 커스텀 확장자
	@Override
	public void extensionInsert(ExtensionVO evo) {
		extensionDAO.extensionInsert(evo);
	}
	
	// 커스텀 확장자 삭제
	@Override
	public void extensionDelete(ExtensionVO evo) {
		extensionDAO.extensionDelete(evo);
	}
	
	// 확장자 리스트
	@Override
	public Map<String, Object> extensionList() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<ExtensionVO> extensionList = extensionDAO.extensionList();
		List<ExtensionVO> defaultExtensionList = new ArrayList<ExtensionVO>();
		List<ExtensionVO> customExtensionList = new ArrayList<ExtensionVO>();
		
		for (ExtensionVO extensionVO : extensionList) {
			try {
				if (extensionVO.getExtension_type().equals("D")) {
					defaultExtensionList.add(extensionVO);
				} else if (extensionVO.getExtension_type().equals("C")) {
					customExtensionList.add(extensionVO);
				}
			} catch (NullPointerException e) {
				e.printStackTrace();
			}
		}
		map.put("defaultExtensionList", defaultExtensionList);
		map.put("customExtensionList", customExtensionList);
		return map;
	}

	@Override
	public List<ExtensionVO> extensionTotalList() {
		List<ExtensionVO> extensionList = extensionDAO.extensionList();
		return extensionList;
	}

	


	
	
}
