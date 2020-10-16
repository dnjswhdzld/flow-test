package com.dnjswhdzld.flow.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dnjswhdzld.flow.dao.BoardDAO;
import com.dnjswhdzld.flow.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardDAO boardDAO;
	
	@Override
	public void insertBoard(BoardVO bvo) {
		boardDAO.boardInsert(bvo);
	}

	@Override
	public List<BoardVO> selectBoard() {
		return boardDAO.selectBoard();
	}
	
}
