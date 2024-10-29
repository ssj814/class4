package com.example.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("NoticeDTO")
public class NoticeDTO {
	private int postid;
	private String title;
	private String content;
	private String writer;
	private String createdate;
	private int viewcount;
	private String category;
	private String popup;

}
