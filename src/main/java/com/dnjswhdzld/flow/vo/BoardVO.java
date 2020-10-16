package com.dnjswhdzld.flow.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class BoardVO {
	private int flowboard_seq;
	private String flowboard_title;
	private String flowboard_content;
	private Date flowboard_date;
	private String flowboard_filename;
	private String flowboard_filepath;
	private String flowboard_size;
	private MultipartFile upload_file;
	
	public MultipartFile getUpload_file() {
		return upload_file;
	}
	public void setUpload_file(MultipartFile upload_file) {
		this.upload_file = upload_file;
	}
	private String flowboard_db_path;
	public int getFlowboard_seq() {
		return flowboard_seq;
	}
	public void setFlowboard_seq(int flowboard_seq) {
		this.flowboard_seq = flowboard_seq;
	}
	public String getFlowboard_title() {
		return flowboard_title;
	}
	public void setFlowboard_title(String flowboard_title) {
		this.flowboard_title = flowboard_title;
	}
	public String getFlowboard_content() {
		return flowboard_content;
	}
	public void setFlowboard_content(String flowboard_content) {
		this.flowboard_content = flowboard_content;
	}
	public Date getFlowboard_date() {
		return flowboard_date;
	}
	public void setFlowboard_date(Date flowboard_date) {
		this.flowboard_date = flowboard_date;
	}
	public String getFlowboard_filepath() {
		return flowboard_filepath;
	}
	public void setFlowboard_filepath(String flowboard_filepath) {
		this.flowboard_filepath = flowboard_filepath;
	}
	public String getFlowboard_size() {
		return flowboard_size;
	}
	public void setFlowboard_size(String flowboard_size) {
		this.flowboard_size = flowboard_size;
	}
	public String getFlowboard_db_path() {
		return flowboard_db_path;
	}
	public void setFlowboard_db_path(String flowboard_db_path) {
		this.flowboard_db_path = flowboard_db_path;
	}
	public String getFlowboard_filename() {
		return flowboard_filename;
	}
	public void setFlowboard_filename(String flowboard_filename) {
		this.flowboard_filename = flowboard_filename;
	}
	
}
