package com.example.dto;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Alias("TrainerDTO")
public class TrainerDTO {

	private int trainer_id; // db에서 시퀀스로 처리
	private String name;
	private String nickname;
	private String center_name;
	private String center_address1;
	private String center_address2;
	private String intro;
	private String lesson_area1;
	private String gender;
	private String center_postcode;
	private String field;
	private String content;
	private String img_url;
	private String img_name;
	private String certificate_type;
	private String certificate;
	private String lesson_area2;
	private String lesson_program;
	private String reg_date;


}