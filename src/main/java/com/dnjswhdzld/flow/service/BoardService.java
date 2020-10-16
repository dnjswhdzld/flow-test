package com.dnjswhdzld.flow.service;

import java.util.List;

import com.dnjswhdzld.flow.vo.BoardVO;

public interface BoardService {
	
	void insertBoard(BoardVO bvo);
	List<BoardVO> selectBoard();
}
