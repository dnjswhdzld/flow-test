package com.dnjswhdzld.flow.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dnjswhdzld.flow.vo.BoardVO;

@Repository
public class BoardDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public void boardInsert(BoardVO bvo) {
		sqlSessionTemplate.insert("BoardDAO.boardInsert",bvo);
	}
	
	public List<BoardVO> selectBoard(){
		return sqlSessionTemplate.selectList("BoardDAO.boardSelect");
	}
}
