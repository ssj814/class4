package com.example.dto;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("Listt")
@Data
public class CookingTipListupDTO {
	private int bno;
    private String title;
    private String content;
    private String writer;
    private Date regdate;
    private int viewcnt;
}
