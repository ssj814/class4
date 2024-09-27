package com.example.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter
@ToString
public class TrainerDTO {
	private int trainer_id; //db에서 시퀀스로 처리
	private String name;
	private String nickname;
	private String gender;
	private String field;
	private String center_name;
	private String center_postcode;
	private String center_address1;
	private String center_address2;
	private String intro;
	private String content;
	private String img_url;
	private String img_name;
	private String certificate_type;
	private String certificate;
	private String lesson_area1;
	private String lesson_area2;
	private String lesson_program;
	private String reg_date;
	
	public TrainerDTO(String name, String nickname, String gender, String field, String center_name,
			String center_postcode, String center_address1, String center_address2, String intro, String content,
			String img_url, String img_name, String certificate_type, String certificate, String lesson_area1,
			String lesson_area2, String lesson_program, String reg_date) {
		super();
		this.name = name;
		this.nickname = nickname;
		this.gender = gender;
		this.field = field;
		this.center_name = center_name;
		this.center_postcode = center_postcode;
		this.center_address1 = center_address1;
		this.center_address2 = center_address2;
		this.intro = intro;
		this.content = content;
		this.img_url = img_url;
		this.img_name = img_name;
		this.certificate_type = certificate_type;
		this.certificate = certificate;
		this.lesson_area1 = lesson_area1;
		this.lesson_area2 = lesson_area2;
		this.lesson_program = lesson_program;
		this.reg_date = reg_date;
	}
	
	
	
}