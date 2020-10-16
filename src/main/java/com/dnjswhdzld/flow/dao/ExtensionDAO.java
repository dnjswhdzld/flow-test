package com.dnjswhdzld.flow.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dnjswhdzld.flow.vo.ExtensionVO;

@Repository
public class ExtensionDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;  
	
	public void extensionDefaultUpdate(ExtensionVO evo) {
		sqlSessionTemplate.update("ExtensionDAO.extensionDefaultUpdate",evo);
	}
	
	public void extensionInsert(ExtensionVO evo) {
		sqlSessionTemplate.insert("ExtensionDAO.extensionInsert",evo);
	}
	
	public void extensionDelete(ExtensionVO evo) {
		sqlSessionTemplate.delete("ExtensionDAO.extensionDelete",evo);
	}
	public List<ExtensionVO> extensionList(){
		return sqlSessionTemplate.selectList("ExtensionDAO.extensionSelect");
	}
}
