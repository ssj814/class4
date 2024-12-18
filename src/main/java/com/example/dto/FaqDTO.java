package com.example.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("FaqDTO")
public class FaqDTO {
	
	private int faq_qna_id; 
	private String question;
	private String answer;
	private String questioner;
	private Date faq_qna_date;
	private String category;
	private int is_secret;

}
