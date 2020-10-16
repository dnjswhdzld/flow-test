package com.dnjswhdzld.flow.service;

import java.util.List;
import java.util.Map;

import com.dnjswhdzld.flow.vo.ExtensionVO;

public interface ExtensionService {
	
	void defaultExtensionUpdate(ExtensionVO evo);
	void extensionInsert(ExtensionVO evo);
	void extensionDelete(ExtensionVO evo);
	Map<String,Object> extensionList();
	List<ExtensionVO> extensionTotalList();
	
	
	
}
